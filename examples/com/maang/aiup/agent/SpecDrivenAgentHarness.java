package com.maang.aiup.agent;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * AI UNIFIED PROCESS (AIUP) - SPEC-DRIVEN AGENT LINTER & HARNESS
 * Simulates the deterministic `/spec-review` command and linter.
 *
 * Enforces:
 *   - Zone 3 Blocklist (Banned words: JWT, SQL, bcrypt, SMTP, regex, HTTP verbs)
 *   - The 'validates' vs 'checks whether' rule
 *   - Step count bounds (3 to 9 steps)
 *   - Mechanical traceability interfaces (FR -> UC -> Flow -> BR)
 */
public class SpecDrivenAgentHarness {

    // Zone 3 Yasaklı Mekanizma Kara Listesi (Kelimeler ve Regex Desenleri)
    public static final List<String> BLOCKLIST_PATTERNS = List.of(
        "\\bJWT\\b", "\\bBCRYPT\\b", "\\bHASH\\b", "\\bSALT\\b", "\\bSHA\\b",
        "\\bSELECT\\s+.+\\s+FROM\\b", "\\bINSERT\\s+INTO\\b", "\\bUPDATE\\s+.+\\s+SET\\b",
        "\\bDELETE\\s+FROM\\b", "\\bHTTP\\b", "\\bPOST\\s+/", "\\bGET\\s+/", "\\bPUT\\s+/",
        "\\bSMTP\\b", "\\bEMAIL SERVER\\b", "\\bCONTROLLER\\b", "\\bEXCEPTION\\b"
    );

    public record AuditReport(
        String useCaseId,
        boolean isApproved,
        List<String> fatalErrors,
        List<String> advisoryNotes
    ) {}

    public static class SpecLinter {
        public static AuditReport audit(String useCaseId, String rawMarkdown) {
            var fatalErrors = new ArrayList<String>();
            var advisoryNotes = new ArrayList<String>();

            // 1. Zone 3 Kara Liste Kontrolü
            String upper = rawMarkdown.toUpperCase();
            for (String patternStr : BLOCKLIST_PATTERNS) {
                var pattern = java.util.regex.Pattern.compile(patternStr, java.util.regex.Pattern.CASE_INSENSITIVE);
                if (pattern.matcher(rawMarkdown).find()) {
                    fatalErrors.add("Zone 3 İhlali (Mekanizma Sızıntısı): Şartnamede yasaklı mekanizma deseni '" + patternStr + "' tespit edildi!");
                }
            }

            // 2. 'checks whether' Dilbilgisi Kontrolü
            if (upper.contains("CHECKS WHETHER") || upper.contains("KONTROL EDER")) {
                fatalErrors.add("Kural İhlali: 'checks whether' yerine kesin başarı bildiren 'validates that' kullanılmalıdır!");
            }

            // 3. Adım Sayısı Kontrolü
            long stepCount = rawMarkdown.lines()
                .filter(line -> line.trim().matches("^[0-9]+\\..*"))
                .count();

            if (stepCount < 3) {
                advisoryNotes.add("Uyarı: Ana senaryo çok kısa (" + stepCount + " adım). Validasyonlar veya durum değişimleri eksik olabilir.");
            } else if (stepCount > 9) {
                fatalErrors.add("Boyut İhlali: Ana senaryo " + stepCount + " adım! Cockburn kuralı: 3-9 adım arasında olmalıdır.");
            }

            // 4. Traceability (Gereksinim Kataloğu Bağlantısı)
            if (!rawMarkdown.contains("Requirements:") && !rawMarkdown.contains("FR-")) {
                fatalErrors.add("İzlenebilirlik İhlali: Şartname en az bir FR-XXX gereksinimine bağlanmalıdır!");
            }

            boolean approved = fatalErrors.isEmpty();
            return new AuditReport(useCaseId, approved, fatalErrors, advisoryNotes);
        }
    }

    public static void main(String[] args) {
        System.out.println("🤖 AIUP /spec-review Linter Motoru Çalıştırılıyor...\n");

        // TEST SPEC A: Hatalı Şartname (Zone 3 sızıntısı ve checks whether dolu)
        String dirtySpec = """
            # Use Case: UC-002 Borrow Book
            Requirements: FR-012
            1. User opens React view.
            2. System checks whether user token is valid with JWT.
            3. System runs SQL SELECT * FROM books.
            4. System maps entity to DTO.
            """;

        System.out.println("▶ 1. Hatalı Şartname İnceleniyor...");
        var reportA = SpecLinter.audit("UC-002", dirtySpec);
        System.out.println("   Durum: " + (reportA.isApproved() ? "✅ ONAYLANDI" : "❌ REDDEDİLDİ"));
        reportA.fatalErrors().forEach(err -> System.out.println("   🚨 " + err));

        // TEST SPEC B: Temiz AIUP Şartnamesi (Zone 1 somut, Zone 3 sessiz)
        String cleanSpec = """
            # Use Case: UC-002 Borrow Book
            Requirements: [FR-012, FR-013, NFR-002](../requirements.md)
            1. Member searches the catalog and selects the book.
            2. System shows book details, ISBN, and available copies.
            3. Member requests to borrow the book.
            4. System validates that a copy is available (BR-004).
            5. System validates that member has not reached loan limit (BR-005).
            6. System records the loan with a due date 28 days from today.
            7. System confirms the loan and displays the due date.
            """;

        System.out.println("\n▶ 2. Temiz AIUP Şartnamesi İnceleniyor...");
        var reportB = SpecLinter.audit("UC-002", cleanSpec);
        System.out.println("   Durum: " + (reportB.isApproved() ? "✅ ONAYLANDI (Approved for /implement)" : "❌ REDDEDİLDİ"));
        reportB.fatalErrors().forEach(err -> System.out.println("   🚨 " + err));

        assert !reportA.isApproved() : "Kirli şartname reddedilmeliydi!";
        assert reportB.isApproved() : "Temiz şartname onaylanmalıydı!";
        System.out.println("\n🎉 AIUP Spec-Driven Linter Testi Başarıyla Tamamlandı!");
    }
}
