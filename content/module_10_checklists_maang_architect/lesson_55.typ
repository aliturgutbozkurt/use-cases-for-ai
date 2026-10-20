#import "/template.typ": *

#show: doc => setup_book(title: "Ders 55: 24 Maddelik Şartname Kontrol Listesi: Reviewed ve Approved Eşiği", doc)

#lesson_header(
  55,
  "24 Maddelik Şartname Kontrol Listesi: Reviewed ve Approved Eşiği",
  "The 24-Point Specification Checklist: Gatekeeper for Reviewed & Approved States",
  "Kontrol Listeleri, Yaygın Hatalar ve MAANG Mimar Seviyesi Ustalık",
  "Checklists, Common Mistakes & MAANG Architect Mastery"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 24 MADDELİK ŞARTNAME KONTROL LİSTESİ TABLOSU                 │
└─────────────────────────────────────────────────────────────────────────────┘
  
  ┌──────────────────────────────────────────────┬──────────────────────────┐
  │ KATEGORİ                                     │ MADDELER                 │
  ├──────────────────────────────────────────────┼──────────────────────────┤
  │ 1. Kimlik ve Yapı (Identity & Structure)     │ Maddeler 1 - 6           │
  │    - Aktif fiil öbeği, kebab-case dosya adı, │ Sea-level hedefi,        │
  │      Tetikleyici vs Ön Koşul ayrımı          │ requirements.md bağı     │
  ├──────────────────────────────────────────────┼──────────────────────────┤
  │ 2. Ön ve Son Koşullar (Pre & Postconditions) │ Maddeler 7 - 9           │
  │    - Sistemce zorlanabilir ön koşul,         │ Başarı ve Hata minimum   │
  │      asla akış içinde tekrar test edilmez    │ garantileri dolu!        │
  ├──────────────────────────────────────────────┼──────────────────────────┤
  │ 3. Ana Başarı Senaryosu (Main Flow)          │ Maddeler 10 - 14         │
  │    - 3-9 adım, 'Top Kimde' ilk kelime,       │ 'Validates' kullanımı,   │
  │      UI mekaniği (widget) temizlenmiş!       │ 3 tür adımın dengesi     │
  ├──────────────────────────────────────────────┼──────────────────────────┤
  │ 4. Alternatif Akışlar (Alternative Flows)    │ Maddeler 15 - 18         │
  │    - Her validasyona 1 akış, adıma çıpalı,   │ Açık uçlu akış YASAK!    │
  │      kesin bitiş ('continues' / 'ends')      │ Alt hatalar birleştirildi│
  ├──────────────────────────────────────────────┼──────────────────────────┤
  │ 5. İş Kuralları ve Referanslar               │ Maddeler 19 - 21         │
  │    - BR-XXX eşleşmesi, entity_model bağı,    │ NFR ve Mockup linkleri   │
  ├──────────────────────────────────────────────┼──────────────────────────┤
  │ 6. Üç Okuyucu Testi (The Three-Reader Test)  │ Maddeler 22 - 24         │
  │    - Zone 1 somut veriler, Kara Liste sıfır! │ Seneye stack değişse     │
  │      Paydaş onaylayabilir mi?                │ bu cümle doğru kalır mı? │
  └──────────────────────────────────────────────┴──────────────────────────┘
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir uzay mekiği fırlatılmadan önce astronotların ve mühendislerin elindeki kontrol listesini (checklist) düşünün: 'Oksijen vanası açık mı? Basınç tamam mı? Yakıt kapağı kilitli mi?' Tek bir madde bile işaretlenmezse roket fırlatılmaz! 24 maddelik use case kontrol listesi, kod üretim butonuna basmadan önceki o fırlatma kontrol listesidir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of the pre-launch checklist used by NASA astronauts and flight controllers before a space shuttle liftoff: 'Oxygen valves open? Thruster pressure nominal? Fuel hatch sealed?' If a single checkbox is missed, the launch is aborted! The 24-point specification checklist is the mandatory pre-flight audit before triggering AI code generation!]
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
      24 Maddelik Şartname Kontrol Listesinin Mimarisi: Cockburn'ün klasik geçiş/kalış (pass/fail) testleri ile AI Unified Process'in katı doğrulama kurallarının birleşiminden oluşan bu liste, bir şartname 'Reviewed' ve ardından 'Approved' statüsüne geçmeden önce iki kez koşturulur. Liste 6 ana alana ayrılır: 1) Kimlik ve Yapı: İsim kullanıcının dilinde bir eylem öbeğidir, dosya adı `UC-XXX-\<kebab-name>.md` formatındadır, tek bir deniz seviyesi hedefi anlatır. 2) Ön ve Son Koşullar: Ön koşullar sistem tarafından zorlanabilir durumdadır ve akış içinde asla tekrar `if` ile test edilmez. Başarı ve hata son koşulları boşa çıkarılamaz bir sözleşmedir (no partial data). 3) Ana Akış: 3 ila 9 adımdır, her adımda topun sahibi ilk kelimedir, 'validates' kelimesi başarıyı mühürler, UI tıklama mekanikleri ayıklanmıştır. 4) Alternatif Akışlar: Her doğrulama adımının kesin bir hata akışı vardır; her akış bir adıma çıpalanır (`step 4`) ve mutlaka kesin bir dille sonlanır (`Use case continues at step N.` veya `Use case ends.`). 5) Kurallar ve Referanslar: Her BR kuralı en az bir adımdan referans alır; varlıklar `entity_model.md`'den gelir. 6) Üç Okuyucu Testi: Kara liste (JWT, SQL, bcrypt vb.) sıfır toleransla taranır; paydaş onayı ve 1 yıl sonraki teknoloji bağımsızlığı doğrulanır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The 24-Point Specification Checklist Architecture: Merging Cockburn's classical pass/fail heuristics with the algorithmic verification rules of the AI Unified Process, this 24-point checklist gates specification promotion: executed once prior to 'Reviewed', and once more prior to 'Approved'. It spans six cohesive evaluation domains: 1) Identity & Structure: User-goal naming, strict kebab-case file paths matching `docs/use_cases.puml`, single-sitting sea-level scope, and requirements catalog linkages. 2) Boundary Guarantees: Preconditions must be enforceable assertions established upstream (never re-tested in-flow); failure postconditions must enforce transactional rollbacks (zero orphan state). 3) Scenario Discipline: 3-9 steps, active voice, ball-holder primacy, strict usage of 'validates', and zero UI widget micro-actions. 4) Deviation Robustness: 1-to-1 parity between validations and alternative flows, anchored triggers, and strictly banned open-ended terminations. 5) Referential Integrity: Business rules bi-directionally linked, domain nouns rooted in `docs/entity_model.md`. 6) Three-Reader Audit: Complete absence of Zone 3 blocklist terms, verifiable stakeholder outcomes, and enduring stack portability.]
    ]
  )
]

#java25_box[
```java
// Java 25: 24 Maddelik Şartname Denetim Motoru (Spec Linter Pipeline)
package com.maang.aiup.checklist;

import java.util.List;

public class SpecChecklistAuditor {
    public record SpecCheckResult(int passedCount, int totalCount, List<String> violations) {
        public boolean isApproved() { return violations.isEmpty() && passedCount == totalCount; }
    }

    public static class AuditorEngine {
        public SpecCheckResult auditSpec(String specContent) {
            var violations = new java.util.ArrayList<String>();
            
            // Kontrol 1: Kara liste kelimeleri (Zone 3)
            List<String> blocklist = List.of("JWT", "SQL", "bcrypt", "SELECT", "INSERT", "SMTP");
            for (String forbidden : blocklist) {
                if (specContent.contains(forbidden)) {
                    violations.add("Kural 22 İhlali: Yasaklı Zone 3 kelimesi tespit edildi -> " + forbidden);
                }
            }

            // Kontrol 2: 'checks whether' kullanımı (Kural 13)
            if (specContent.contains("checks whether")) {
                violations.add("Kural 13 İhlali: 'checks whether' yerine 'validates that' kullanılmalıdır.");
            }

            int total = 24;
            int passed = total - violations.size();
            return new SpecCheckResult(passed, total, violations);
        }
    }

    void main() {
        var engine = new AuditorEngine();
        String sampleSpec = "Step 4: System validates that user account is active (BR-001).";
        var result = engine.auditSpec(sampleSpec);

        System.out.println("✅ Şartname Denetim Skoru: " + result.passedCount() + " / " + result.totalCount());
        System.out.println("   Onay Durumu: " + (result.isApproved() ? "APPROVED" : "REJECTED"));
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
      Bir şartnameyi 'küçük bir hata var ama kod üretirken düzeltiriz' diyerek Approved statüsüne geçirmeyin! 24 kuralın tamamı yeşil olmadan kod üretim komutunu (/implement) çalıştırmayın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never promote a spec to 'Approved' with known checklist violations under the assumption that AI will compensate. All 24 criteria must pass cleanly before generation.]
    ]
  )
]

#takeaways_box((
    ("24 maddelik liste şartnameyi Reviewed ve Approved aşamalarına taşıyan kapı bekçisidir.", "The 24-point checklist acts as the definitive gatekeeper for Reviewed and Approved states."),
    ("Liste kimlikten ön koşullara, senaryo ritminden kara liste denetimine 6 alanı kapsar.", "It evaluates 6 domains: identity, pre/postconditions, scenario, branches, rules, and 3 readers."),
    ("Tek bir ihlal bile AI'ın mimariyi yanlış üretmesine yol açabileceği için sıfır toleranslıdır.", "Zero tolerance: a single checklist defect invites prompt hallucination and layer misallocation."),
))
