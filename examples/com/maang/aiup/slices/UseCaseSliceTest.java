package com.maang.aiup.slices;

import java.time.LocalDate;
import java.util.Objects;

/**
 * AI UNIFIED PROCESS (AIUP) - TEST-PROTECTED SLICE HARNESS
 * Demonstrates:
 *   - Principle 10: Build the system in slices
 *   - Principle 14: Tests carry the truth
 *   - Slice 1 (Basic Flow alone)
 *   - Slice 2 (Alternative Flow A1: No Copies Available)
 *   - Slice 3 (Alternative Flow A2: Loan Limit Reached)
 */
public class UseCaseSliceTest {

    // Şartname Sözleşmesi Modelleri
    public record SliceContext(int availableCopies, int currentLoans, boolean hasOverdue) {}

    public sealed interface SliceResult permits SliceResult.Success, SliceResult.HandedOff, SliceResult.Blocked {
        record Success(String loanId, LocalDate dueDate) implements SliceResult {}
        record HandedOff(String targetUseCase, String reason) implements SliceResult {}
        record Blocked(String ruleId, String message) implements SliceResult {}
    }

    // --- SİSTEM İCRASI (SYSTEM UNDER TEST) ---
    public static class BorrowSliceRunner {
        public static SliceResult executeSlice(SliceContext ctx) {
            // Validasyon 1: Kopya mevcudiyeti (BR-004) -> A1
            if (ctx.availableCopies() <= 0) {
                return new SliceResult.HandedOff("UC-005 Reserve Book", "Stok yok, rezervasyona devredildi.");
            }
            // Validasyon 2: Ödünç limiti (BR-005) -> A2
            if (ctx.currentLoans() >= 5) {
                return new SliceResult.Blocked("BR-005", "Ödünç limiti dolu (5 adet).");
            }
            // Validasyon 3: Gecikmiş borç (BR-006) -> A3
            if (ctx.hasOverdue()) {
                return new SliceResult.Blocked("BR-006", "Gecikmiş borç mevcut.");
            }

            // Temel Başarı Yolu (Slice 1):
            return new SliceResult.Success("LOAN-" + System.currentTimeMillis(), LocalDate.now().plusDays(28));
        }
    }

    public static void main(String[] args) {
        System.out.println("🧪 AIUP Use-Case Slice Testleri Başlatılıyor...\n");

        // TEST 1: Slice 1 - Temel Akış Doğrulaması (Main Success Scenario)
        System.out.println("▶ Test 1: Slice 1 (Temel Akış)");
        var ctx1 = new SliceContext(3, 2, false);
        var res1 = BorrowSliceRunner.executeSlice(ctx1);
        assert res1 instanceof SliceResult.Success : "Slice 1 başarısız!";
        if (res1 instanceof SliceResult.Success s) {
            assert s.dueDate().isEqual(LocalDate.now().plusDays(28)) : "Vade tam 28 gün olmalı!";
            System.out.println("   ✅ Slice 1 Geçti: Ödünç verildi. Vade: " + s.dueDate());
        }

        // TEST 2: Slice 2 - Alternatif Akış A1 (Kopya Yok & Rezervasyona Devir)
        System.out.println("\n▶ Test 2: Slice 2 (Alternatif Akış A1)");
        var ctx2 = new SliceContext(0, 1, false);
        var res2 = BorrowSliceRunner.executeSlice(ctx2);
        assert res2 instanceof SliceResult.HandedOff : "Slice 2 rezervasyona devretmeliydi!";
        if (res2 instanceof SliceResult.HandedOff h) {
            assert Objects.equals(h.targetUseCase(), "UC-005 Reserve Book");
            System.out.println("   ✅ Slice 2 Geçti: " + h.targetUseCase() + " devri sağlandı.");
        }

        // TEST 3: Slice 3 - Alternatif Akış A2 (Ödünç Limiti Aşıldı)
        System.out.println("\n▶ Test 3: Slice 3 (Alternatif Akış A2)");
        var ctx3 = new SliceContext(2, 5, false);
        var res3 = BorrowSliceRunner.executeSlice(ctx3);
        assert res3 instanceof SliceResult.Blocked : "Slice 3 işlemi engellemeliydi!";
        if (res3 instanceof SliceResult.Blocked b) {
            assert Objects.equals(b.ruleId(), "BR-005");
            System.out.println("   ✅ Slice 3 Geçti: " + b.ruleId() + " kuralı ihlali engellendi.");
        }

        System.out.println("\n🎉 Tüm Dilim (Slice) Testleri 100% Başarıyla Geçti!");
    }
}
