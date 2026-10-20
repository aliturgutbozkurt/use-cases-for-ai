package com.maang.aiup.rules;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * AI UNIFIED PROCESS (AIUP) - DOMAIN BUSINESS RULES ENGINE
 * Encapsulates the local rules of UC-002 Borrow Book:
 *   - BR-004: Availability (Book must have available copy)
 *   - BR-005: Loan Limit (Member may hold at most 5 active loans)
 *   - BR-006: Overdue Block (Member with overdue loans is blocked)
 *
 * Demonstrates:
 *   - Java 25 Sealed Hierarchies & Pattern Matching
 *   - Local rule namespacing (BR-XXX local to use case)
 *   - Qualified cross-spec citation representation (UC-001 BR-002)
 */
public class BusinessRuleEngine {

    // Kural Kimliği Arayüzü (Yerel ve Nitelikli Ayrımı)
    public record RuleId(String useCaseId, String ruleCode, String ruleName) {
        public static RuleId local(String ruleCode, String name) {
            return new RuleId("UC-002", ruleCode, name);
        }

        public static RuleId qualified(String useCaseId, String ruleCode, String name) {
            return new RuleId(useCaseId, ruleCode, name);
        }

        @Override
        public String toString() {
            return "[" + useCaseId + " " + ruleCode + ": " + ruleName + "]";
        }
    }

    // Doğrulama Sonuç Tipleri (Monadic Result Model)
    public sealed interface RuleEvaluationResult permits RuleEvaluationResult.Passed, RuleEvaluationResult.Violated {
        record Passed(RuleId rule) implements RuleEvaluationResult {}
        record Violated(RuleId rule, String reason) implements RuleEvaluationResult {}
    }

    // Değerlendirilecek Bağlam (Context)
    public record LoanContext(
        String memberId,
        int currentActiveLoans,
        boolean hasOverdueItems,
        int availableCopies
    ) {}

    // 1. KURAL: BR-004 Availability
    public static RuleEvaluationResult evaluateAvailability(LoanContext ctx) {
        var rule = RuleId.local("BR-004", "Availability");
        if (ctx.availableCopies() <= 0) {
            return new RuleEvaluationResult.Violated(rule, "Kitabın rafta ödünç verilebilir kopyası kalmamıştır.");
        }
        return new RuleEvaluationResult.Passed(rule);
    }

    // 2. KURAL: BR-005 Loan Limit (Maksimum 5 kitap)
    public static RuleEvaluationResult evaluateLoanLimit(LoanContext ctx) {
        var rule = RuleId.local("BR-005", "Loan Limit");
        if (ctx.currentActiveLoans() >= 5) {
            return new RuleEvaluationResult.Violated(rule, "Üye maksimum açık ödünç limitine (5 kitap) ulaşmıştır.");
        }
        return new RuleEvaluationResult.Passed(rule);
    }

    // 3. KURAL: BR-006 Overdue Block (Gecikmiş borç blokesi)
    public static RuleEvaluationResult evaluateOverdueBlock(LoanContext ctx) {
        var rule = RuleId.local("BR-006", "Overdue Block");
        if (ctx.hasOverdueItems()) {
            return new RuleEvaluationResult.Violated(rule, "Üyenin gecikmiş borcu bulunmaktadır; ödünç engellendi.");
        }
        return new RuleEvaluationResult.Passed(rule);
    }

    // Tüm Kuralları Baştan Sona Çalıştıran Pipeline
    public static List<RuleEvaluationResult> evaluateAll(LoanContext ctx) {
        return List.of(
            evaluateAvailability(ctx),
            evaluateLoanLimit(ctx),
            evaluateOverdueBlock(ctx)
        );
    }

    public static void main(String[] args) {
        System.out.println("🏛️ AIUP İş Kuralları Motoru (Business Rule Engine) Çalıştırılıyor...");

        // Senaryo 1: Temiz kullanıcı ve uygun stok
        var validCtx = new LoanContext("M-Alice", 3, false, 2);
        System.out.println("\n--- Senaryo 1: Geçerli İstek ---");
        for (var res : evaluateAll(validCtx)) {
            switch (res) {
                case RuleEvaluationResult.Passed p -> System.out.println("  ✅ GEÇTİ: " + p.rule());
                case RuleEvaluationResult.Violated v -> System.out.println("  ❌ İHLAL: " + v.rule() + " -> " + v.reason());
            }
        }

        // Senaryo 2: Gecikmiş borcu ve stoksuzluğu olan kullanıcı
        var invalidCtx = new LoanContext("M-Bob", 5, true, 0);
        System.out.println("\n--- Senaryo 2: Limit Dolu ve Gecikmiş Borç ---");
        for (var res : evaluateAll(invalidCtx)) {
            switch (res) {
                case RuleEvaluationResult.Passed p -> System.out.println("  ✅ GEÇTİ: " + p.rule());
                case RuleEvaluationResult.Violated v -> System.out.println("  🚨 İHLAL: " + v.rule() + " -> " + v.reason());
            }
        }
    }
}
