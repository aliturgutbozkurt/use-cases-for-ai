package com.maang.aiup.usecase;

import java.time.LocalDate;
import java.util.Objects;
import java.util.Optional;

/**
 * AI UNIFIED PROCESS (AIUP) - SEA-LEVEL USE CASE INTERACTOR
 * Use Case: UC-002 Borrow Book
 * Realizes: FR-012, FR-013, NFR-002
 *
 * Implements modern Java 25 LTS features:
 * - Records for immutable input/output models
 * - Guard clauses corresponding to BR-004, BR-005, BR-006
 * - Decoupled port interfaces for infrastructure independence (Zero Zone 3 leaks)
 */
public class BorrowBookUseCase {

    // --- ZONE 1: Gözlemlenebilir İstek ve Yanıt Sözleşmesi ---
    public record BorrowRequest(String memberId, String isbn) {
        public BorrowRequest {
            Objects.requireNonNull(memberId, "memberId zorunludur");
            Objects.requireNonNull(isbn, "isbn zorunludur");
        }
    }

    public sealed interface BorrowResponse permits BorrowResponse.Success, BorrowResponse.Failed {
        record Success(
            String loanId,
            String memberId,
            String bookTitle,
            LocalDate dueDate,
            int remainingLoanQuota
        ) implements BorrowResponse {}

        record Failed(String errorCode, String userMessage) implements BorrowResponse {}
    }

    // --- ZONE 2: Alan Modeli Arayüzleri (entity_model.md Karşılığı) ---
    public record MemberView(String id, String name, int currentLoans, boolean hasOverdueLoans) {}
    public record BookView(String isbn, String title, int availableCopies) {}

    // Port Arayüzleri (Zone 3 mekanizmaları bu portların arkasında kalır)
    public interface MemberPort {
        Optional<MemberView> findMemberById(String memberId);
    }

    public interface BookPort {
        Optional<BookView> findBookByIsbn(String isbn);
        void decrementAvailableCopies(String isbn);
    }

    public interface LoanPort {
        String recordLoan(String memberId, String isbn, LocalDate dueDate);
    }

    // --- İCRA EDİCİ (INTERACTOR) ---
    private final MemberPort memberPort;
    private final BookPort bookPort;
    private final LoanPort loanPort;

    public BorrowBookUseCase(MemberPort memberPort, BookPort bookPort, LoanPort loanPort) {
        this.memberPort = memberPort;
        this.bookPort = bookPort;
        this.loanPort = loanPort;
    }

    public BorrowResponse execute(BorrowRequest request) {
        // Ön Koşul Doğrulaması (Preconditions)
        var member = memberPort.findMemberById(request.memberId())
            .orElseThrow(() -> new IllegalArgumentException("Üye bulunamadı: " + request.memberId()));

        // Adım 1 & 2: Kitap detaylarını ve kopyalarını al
        var book = bookPort.findBookByIsbn(request.isbn())
            .orElse(null);

        // Adım 4: Sistem kopyanın mevcut olduğunu doğrular (BR-004) -> A1 Akışı
        if (book == null || book.availableCopies() <= 0) {
            return new BorrowResponse.Failed("A1_NO_COPIES", "Tüm kopyalar ödünçtedir. Rezervasyon oluşturabilirsiniz.");
        }

        // Adım 5: Sistem üyenin ödünç limitine ulaşmadığını doğrular (BR-005) -> A2 Akışı
        if (member.currentLoans() >= 5) {
            return new BorrowResponse.Failed("A2_LOAN_LIMIT", "Maksimum ödünç limitine (5 kitap) ulaştınız.");
        }

        // Adım 6: Sistem üyenin gecikmiş borcu olmadığını doğrular (BR-006) -> A3 Akışı
        if (member.hasOverdueLoans()) {
            return new BorrowResponse.Failed("A3_OVERDUE_LOANS", "Gecikmiş borçlarınız nedeniyle işlem engellenmiştir.");
        }

        // Adım 7: Sistem bugünden itibaren 28 gün vadeli ödünç kaydını oluşturur
        LocalDate dueDate = LocalDate.now().plusDays(28);
        String loanId = loanPort.recordLoan(member.id(), book.isbn(), dueDate);

        // Adım 8: Sistem mevcut kopya sayısını bir azaltır
        bookPort.decrementAvailableCopies(book.isbn());

        // Adım 9: Sistem ödüncü onaylar ve vade tarihini üyeye sunar
        int remainingQuota = 5 - (member.currentLoans() + 1);
        return new BorrowResponse.Success(loanId, member.id(), book.title(), dueDate, remainingQuota);
    }

    public static void main(String[] args) {
        System.out.println("🏛️ AIUP Clean Architecture Use Case Başlatılıyor...");

        // Mock Portlar:
        MemberPort memberMock = id -> Optional.of(new MemberView("M-101", "Alice", 2, false));
        BookPort bookMock = new BookPort() {
            private int copies = 3;
            public Optional<BookView> findBookByIsbn(String isbn) {
                return Optional.of(new BookView(isbn, "Writing Use Cases for AI", copies));
            }
            public void decrementAvailableCopies(String isbn) {
                copies--;
                System.out.println("   [BookPort] Stok 1 azaltıldı. Yeni stok: " + copies);
            }
        };
        LoanPort loanMock = (m, b, d) -> "LOAN-" + System.currentTimeMillis();

        var useCase = new BorrowBookUseCase(memberMock, bookMock, loanMock);
        var response = useCase.execute(new BorrowRequest("M-101", "978-3-9526693-0-3"));

        switch (response) {
            case BorrowResponse.Success s -> {
                System.out.println("✅ Mutlu Yol (Main Flow) Başarılı!");
                System.out.println("   -> Ödünç ID  : " + s.loanId());
                System.out.println("   -> Kitap     : " + s.bookTitle());
                System.out.println("   -> Son Vade  : " + s.dueDate() + " (Tam 28 gün)");
                System.out.println("   -> Kalan Hak : " + s.remainingLoanQuota() + " adet");
            }
            case BorrowResponse.Failed f -> {
                System.err.println("❌ Alternatif Akışa Sapıldı: " + f.errorCode() + " - " + f.userMessage());
            }
        }
    }
}
