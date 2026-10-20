#import "/template.typ": *

#show: doc => setup_book(title: "Ders 30: Baştan Sona Örnek Analizi: 'Borrow Book' (Kitap Ödünç Al) Master Şartnamesi", doc)

#lesson_header(
  30,
  "Baştan Sona Örnek Analizi: 'Borrow Book' (Kitap Ödünç Al) Master Şartnamesi",
  "End-to-End Walkthrough: Deconstructing the 'Borrow Book' Master Spec",
  "Ana Şartname Şablonu & Alan Alan Derinlemesine İnceleme",
  "The Master Specification Template & Field Breakdown"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 MASTER ÖRNEK: UC-002 BORROW BOOK MİMARİSİ                   │
└─────────────────────────────────────────────────────────────────────────────┘
  BAŞARI AKIŞI (HAPPY PATH):
  1. Arama Yap ──▶ 2. Detay Gör ──▶ 3. Ödünç İste ──▶ [ 4. Kopya Var mı? (BR-004) ]
                                                            │ (HAYIR) ──▶ A1: No Copies
                                                            ▼ (EVET)
                                                      [ 5. Limit Uygun mu? (BR-005) ]
                                                            │ (HAYIR) ──▶ A2: Limit Reached
                                                            ▼ (EVET)
                                                      [ 6. Borç Yok mu? (BR-006) ]
                                                            │ (HAYIR) ──▶ A3: Overdue Loans
                                                            ▼ (EVET)
  9. Onay Göster ◀── 8. Stoğu Düş ◀── 7. Ödünç Kaydet (28 Gün Vade)

  🎯 KAPALI DÖNGÜ RİTMİ:
  Her doğrulama adımı (4, 5, 6) tam olarak BİR alternatif akışa (A1, A2, A3) bağlanır!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bu ders, bir yarış arabasının motorunu tamamen söküp parçalarını yere dizmeye benzer. 'Kitap Ödünç Al' şartnamesi, bir use case'in nasıl kusursuz yazılacağının şaheseridir: 1. adımda başlar, 9. adımda biter. 4, 5 ve 6. adımlarda 3 tane bekçi köpeği (doğrulama) oturur. Bir sorun çıkarsa köpek havlar ve seni A1, A2 veya A3 odasına yönlendirir. Sorun yoksa 28 gün vadeli kitabını alır, mutlu bir şekilde evine gidersin. Hiçbir adım havada kalmaz, hiçbir ipin ucu açıkta bırakılmaz!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[This lesson disassembles a Formula-1 engine bolt by bolt. The canonical 'Borrow Book' specification is the gold standard of modern requirements engineering. Steps 1 to 9 march forward rhythmically. Steps 4, 5, and 6 serve as security checkpoints. If a checkpoint fails, the flow diverts cleanly to alternative branches A1, A2, or A3. If clear, the loan is committed for exactly 28 days. Every branch closes cleanly; zero dangling logic.]
    ]
  )
]

#deep_dive_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("115e59"), size: 9pt)[🇹🇷 AIUP & MAANG DERİNLEMESİNE ANALİZ]\
      #v(3pt)
      Borrow Book Şartnamesinin 5 Kusursuz Mimari Özelliği: Kitapta yer alan 'UC-002: Borrow Book' şartnamesi incelendiğinde her satırın arkasındaki derin mantık görülür: 1) Doğrulama ve Akış Simetrisi: 4, 5 ve 6. adımlar birer 'System validates' adımıdır. Her doğrulama adımı arkasında bir iş kuralına (BR-004, BR-005, BR-006) dayanır ve başarısızlık durumunda tam olarak bir alternatif akışa (A1, A2, A3) dallanır. 'Peki ya olmazsa?' sorusunun cevabı anında bulunur. 2) Varlık Modeli Uyumu: Metindeki 'member', 'book', 'copy', 'loan', 'reservation' kelimelerinin tamamı `docs/entity_model.md` dosyasında önceden tanımlanmıştır; use case içinde kolon tipi tartışılmaz. 3) Somut Rakamlar: '28 days' ve '5 open loans' ifadeleri mevcuttur; çünkü bunlar paydaşın onaylayacağı kesin iş rakamlarıdır. 4) Referansla Devretme (Handoff by Reference): A1 akışında kitap yoksa rezervasyon adımı için diğer use case'e link verilir: `(UC-005 Reserve Book)`. 5) Asgari Garanti: Başarısızlık sonkoşulu 'Hiçbir ödünç kaydı açılmaz ve stok değişmez' diyerek veritabanı rollback şartını belirler.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Architectural Forensics of the 'Borrow Book' Specification: Deconstructing the canonical spec reveals five structural virtues: 1) Validation-to-Flow Symmetry: Steps 4 through 6 are assertions of business rules (BR-004, BR-005, BR-006). Each assertion pairs with exactly one alternative flow (A1, A2, A3) detailing systemic recovery. 2) Entity Vocabulary Alignment: The nouns 'member', 'book', 'copy', 'loan', and 'reservation' exist verbatim in `docs/entity_model.md`. The spec never defines column schemas. 3) Concrete Business Quantities: Observable constraints like '28 days' and 'at most 5 loans' are stated numerically for stakeholder sign-off. Internal date-math algorithms are omitted. 4) Handoff by Reference: In flow A1, reservation creation delegates to `(UC-005 Reserve Book)` rather than embedding child flows inline. 5) Transactional Postconditions: The failure guarantee explicitly asserts that no partial loan is persisted and inventory counts remain unchanged, dictating `\@Transactional` boundaries to the AI generator.]
    ]
  )
]

#java25_box[
```java
// Java 25: 'Borrow Book' Master Şartnamesinin Birebir Java 25 Uygulaması
package com.maang.aiup.master;

import java.time.LocalDate;

public class MasterBorrowBookService {
    public record BorrowRequest(String memberId, String bookCopyId) {}
    public record LoanReceipt(String loanId, String memberId, String copyId, LocalDate dueDate) {}

    // Dışarıdan enjekte edilen bağımlılıklar (Hexagonal Outbound Ports)
    public interface BookInventoryPort {
        boolean isAvailable(String copyId); // BR-004
        void decrementStock(String copyId);
    }

    public interface MemberPort {
        int getActiveLoanCount(String memberId); // BR-005
        boolean hasOverdueLoans(String memberId); // BR-006
    }

    public interface LoanPersistencePort {
        String recordLoan(String memberId, String copyId, LocalDate dueDate);
    }

    private final BookInventoryPort inventory;
    private final MemberPort members;
    private final LoanPersistencePort loans;

    public MasterBorrowBookService(BookInventoryPort inv, MemberPort mem, LoanPersistencePort lns) {
        this.inventory = inv;
        this.members = mem;
        this.loans = lns;
    }

    public LoanReceipt borrowBook(BorrowRequest req) {
        // Step 4: System validates copy is available (BR-004 / A1)
        if (!inventory.isAvailable(req.bookCopyId())) {
            throw new IllegalStateException("A1: Kitap kopyası mevcut değil.");
        }
        // Step 5: System validates loan limit (BR-005 / A2)
        if (members.getActiveLoanCount(req.memberId()) >= 5) {
            throw new IllegalStateException("A2: Maksimum 5 ödünç limitine ulaşıldı.");
        }
        // Step 6: System validates no overdue loans (BR-006 / A3)
        if (members.hasOverdueLoans(req.memberId())) {
            throw new IllegalStateException("A3: Gecikmiş borçlar varken ödünç alınamaz.");
        }

        // Step 7: System records loan with due date 28 days from today
        LocalDate dueDate = LocalDate.now().plusDays(28);
        String loanId = loans.recordLoan(req.memberId(), req.bookCopyId(), dueDate);

        // Step 8: System decreases available copies by one
        inventory.decrementStock(req.bookCopyId());

        // Step 9: System confirms loan and delivers goal
        return new LoanReceipt(loanId, req.memberId(), req.bookCopyId(), dueDate);
    }

    void main() {
        System.out.println("Master Use Case (Borrow Book) mimari servisi hazır.");
    }
}
```
]

#warning_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("9f1239"), size: 9pt)[🇹🇷 MÜLAKAT TUZAĞI VE AI HALÜSİNASYONU]\
      #v(3pt)
      Borrow Book şartnamesinde '28 gün' yazmak yerine 'Sistem kütüphane kurallarına göre vade belirler' yazarsanız yapay zekayı belirsizliğe itersiniz. AI gider 14 gün yapar, testler patlar. Rakamları net yazın!
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Replacing 'due date 28 days from today' with 'system calculates appropriate due date' invites chaos. The AI might generate a 14-day default, breaking downstream acceptance assertions. State business quantities concretely.]
    ]
  )
]

#takeaways_box((
    ("Her 'validates' adımı arkasında bir iş kuralı taşır ve bir alternatif akışa dallanır.", "Every validation step rests on a business rule and links to an alternative flow."),
    ("Kullanılan tüm isimler varlık modelinde mevcuttur; şema ve kolon detayları şartnamede yazılmaz.", "All nouns exist in the entity model; database schema details are never inlined."),
    ("28 gün ve 5 kitap gibi gözlemlenebilir sayılar şartnamede kesin olarak belirtilir.", "Observable quantities (28 days, 5 loans) are stated with numerical precision."),
))
