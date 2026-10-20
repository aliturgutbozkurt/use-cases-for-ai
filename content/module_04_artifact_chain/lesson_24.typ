#import "/template.typ": *

#show: doc => setup_book(title: "Ders 24: Otomatik Doğrulama: /spec-review Komutunun Deterministik ve Danışmanlık Turları", doc)

#lesson_header(
  24,
  "Otomatik Doğrulama: /spec-review Komutunun Deterministik ve Danışmanlık Turları",
  "Automated Validation with /spec-review: Deterministic vs Advisory Passes",
  "Eser Zinciri (Artifact Chain) & PlantUML Mimarisi",
  "The Artifact Chain & PlantUML Architecture"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 /SPEC-REVIEW ÇİFT AŞAMALI OTOMATİK DENETİMİ                 │
└─────────────────────────────────────────────────────────────────────────────┘
  KOD ÜRETİMİ ÖNCESİ ÇALIŞTIRILIR:
                     /spec-review
                          │
         ┌────────────────┴────────────────┐
         ▼                                 ▼
  1. TUR: DETERMINISTIC PASS        2. TUR: ADVISORY PASS (LLM)
  - Tüm FR'lar bir UC'ye bağlı mı? - Çelişkili iş kuralları var mı?
  - UC isimleri puml ile eşit mi?  - Hedef seviyesi çok mu alçak (balık)?
  - Tüm BR referansları çözüldü mü?- Eksik alternatif akış var mı?
  - Kural metni kopyalanmış mı?    - Test edilebilirlik açığı var mı?
         │                                 │
         ▼                                 ▼
  [ BLOKE EDER! CI/CD KIRILIR! ]   [ TAVSİYE VERİR / ASLA BLOKE ETMEZ! ]
  (Matematiksel Kontrat)           (İnsan Yargısına Sunulur)
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Uçağa binmeden önce iki güvenlik kontrolünden geçersin: 1) Deterministik Geçiş (Turnike): Biletini makineye okutursun. Biletin sahte veya başkasının adıneysa turnike KÜT diye kapanır, geçemezsin (Bloke eder!). 2) Danışmanlık Geçişi (Hostes): Hostes sana gülümser ve 'Beyefendi üzerinizdeki ceket bu havada sizi biraz üşütebilir' der (Tavsiye!). Karar senindir, uçağa binmeni engellemez. `/spec-review` aracı da böyledir: Bozuk referans varsa kod üretimini durdurur; kural eksikliği hissederse kulağına fısıldar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Airport security operates in two phases: 1) Deterministic Gate: The automated e-gate scans your passport barcode. If the checksum fails or the name mismatches, the metal barrier locks shut instantly (Blocking). 2) Advisory Gate: A flight attendant observes you boarding and notes: 'Sir, it is raining heavily at our destination; you may want a coat.' (Advisory). `/spec-review` implements this exact dual-pass protocol: syntax and reference mismatches halt the build; heuristic ambiguities are flagged for human review.]
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
      /spec-review Mimarisinin Çift Aşamalı Güvencesi: Herhangi bir use case'i `/implement` komutuyla yapay zekaya kodlattırmadan önce, şartname zincirinin tutarlı olduğunu doğrulamak şarttır. AIUP bu görevi `/spec-review` becerisine (skill) verir. Bu denetim iki bağımsız turda çalışır: 1) Tur 1 - Deterministik Geçiş (Deterministic Pass): Tamamen deterministik kurallarla kod tabanını ve markdown dosyalarını tarar. Her FR-XXX en az bir UC'ye bağlı mı? Diyagramdaki her dosya diskte var mı? Atıfta bulunulan tüm `UC-001 BR-002` referansları gerçekten mevcut mu? Kurallar kopyalanmış mı yoksa linklenmiş mi? Bu aşamada tek bir hata bulunursa CI derlemesi kırılır (Build Failure); AI kod üretemez. 2) Tur 2 - Danışmanlık Geçişi (Advisory Pass): LLM devreye girer ve anlamsal (semantic) analiz yapar. İş kuralları arasında mantıksal bir çelişki var mı? Hedef seviyesi deniz seviyesinden balık seviyesine düşmüş mü? Eksik bir hata akışı (alternative flow) kalmış mı? Bu bulgular asla CI'ı bloke etmez; şartname sahibine (Requirements Engineer) bir tavsiye raporu olarak sunulur. Bu iki aşamalı filtre, AI'a teslim edilen şartnamenin %100 kusursuz ve çelişkisiz olmasını garantiler.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Architecture of the /spec-review Verification Engine: Prior to dispatching specifications to `/implement`, the artifact chain must be audited for referential integrity. The `/spec-review` command executes in two decoupled passes: 1) Pass 1 (Deterministic Structural Audit): An algorithmic static analyzer parses markdown trees without LLM invocation. It verifies that every functional user story maps to at least one use case; that every use case node in `use_cases.puml` possesses a corresponding `.md` file; that all cross-spec citations (`UC-XXX BR-YYY`) resolve to actual declarations; and that no rule text was cloned. A failure here blocks the CI pipeline unconditionally. 2) Pass 2 (Advisory Semantic Audit): An LLM auditor inspects the narrative for cognitive defects: conflicting business logic, underwater goal altitudes, unaddressed failure paths, and untestable assertions. Findings from Pass 2 are advisory: they prompt human engineers to exercise judgment and never halt execution automatically.]
    ]
  )
]

#java25_box[
```java
// Java 25: Deterministik /spec-review Doğrulayıcısının Çekirdek Mantığı
package com.maang.aiup.specreview;

import java.util.Set;

public class SpecReviewDeterministicEngine {
    // Kayıtlı gereksinimler ve bunları gerçekleştiren Use Case'ler
    public record VerificationReport(boolean passed, String errorMessage) {}

    public static VerificationReport verifyTraceability(
        Set<String> catalogFrIds, 
        Set<String> realizedFrIds,
        Set<String> declaredRules,
        Set<String> referencedRules
    ) {
        // 1. Kural: Her FR en az bir Use Case tarafından gerçekleştirilmelidir!
        for (String fr : catalogFrIds) {
            if (!realizedFrIds.contains(fr)) {
                return new VerificationReport(false, "BLOKE EDİCİ HATA: " + fr + " hiçbir use case'e bağlanmamış!");
            }
        }

        // 2. Kural: Referans verilen tüm BR'lar gerçekten var olmalıdır!
        for (String ref : referencedRules) {
            if (!declaredRules.contains(ref)) {
                return new VerificationReport(false, "BLOKE EDİCİ HATA: Çözülemeyen kural referansı -> " + ref);
            }
        }

        return new VerificationReport(true, "✅ Deterministik denetim başarıyla tamamlandı.");
    }

    void main() {
        var frs = Set.of("FR-001", "FR-002");
        var realized = Set.of("FR-001", "FR-002");
        var declared = Set.of("UC-001 BR-001", "UC-002 BR-004");
        var refs = Set.of("UC-001 BR-001");

        var report = verifyTraceability(frs, realized, declared, refs);
        System.out.println(report.errorMessage());
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
      /spec-review raporundaki 'Advisory' (Danışmanlık) uyarılarını görmezden gelip doğrudan koda geçmeyin. 'Bu akışta hata durumu eksik' uyarısı, yarın müşterinin sistemde yaşayacağı gerçek bir patlamanın habercisidir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not dismiss Advisory findings from `/spec-review` casually. A warning regarding 'missing alternative flows' highlights an unhandled business condition that will manifest as unexpected behavior in production.]
    ]
  )
]

#takeaways_box((
    ("/spec-review çift turludur: 1. Tur deterministik ve bloke edicidir, 2. Tur anlamsal tavsiyedir.", "/spec-review operates in two passes: Pass 1 is deterministic/blocking; Pass 2 is advisory."),
    ("Referansı çözülemeyen bir kural veya eksik bağlı bir FR varsa CI derlemesi kırılır.", "Dangling rule citations or orphaned requirements break the CI build deterministically."),
    ("/spec-review asla dökümanları otomatik düzenlemez; sadece raporlar, karar insana aittir.", "/spec-review reports findings without mutating files; decisions remain human-owned."),
))
