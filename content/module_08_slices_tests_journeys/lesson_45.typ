#import "/template.typ": *

#show: doc => setup_book(title: "Ders 45: 14. İlke: Gerçeği Testler Taşır (AIUP Test Piramidi)", doc)

#lesson_header(
  45,
  "14. İlke: Gerçeği Testler Taşır (AIUP Test Piramidi)",
  "Principle 14: Tests Carry the Truth — The AIUP Test Pyramid",
  "Dilimler (Slices), Testler ve İterasyon Döngüsü",
  "Slices, Tests, and the Iteration Loop"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 AIUP TEST PİRAMİDİ VE YENİDEN ÜRETİM KORUMASI                │
└─────────────────────────────────────────────────────────────────────────────┘
  
             ▲
            / \
           /   \      UÇTAN UCA YOLCULUK TESTLERİ (E2E Journey Tests)
          / E2E \     - Kaynak: TC-XXX Dokümanları (docs/test_cases/)
         /------- \   - Kapsam: Birden fazla use case'in ardışık zinciri
        /   INTE-  \
       /   GRATION  \ ENTEGRASYON TESTLERİ (Integration / View Tests)
      /--------------\- Kaynak: UC Şartnamesi (Gerçek UI & Veritabanı ile)
     /      UNIT /    \
    /     VIEW TESTS   \ BİRİM TESTLERİ (Unit Tests per Flow)
   /--------------------\- Kaynak: Her alternatif akış (A1, A2) ve BR kuralları!
  
  🎯 İLKE 14'ÜN ÖZÜ:
  "Kod her an silinip baştan üretilebilir. Kodu güvenle yeniden üretilebilir
   kılan tek şey DIŞARIDAN onu sabitleyen TESTLERDİR!" 
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Lunaparktaki hız trenini (rollercoaster) düşünün: Trenin vagonunu istediğiniz renge boyayabilir, koltuklarını değiştirebilirsiniz. Ama vagonun raydan çıkmasını engelleyen şey altındaki çelik kilitlerdir! Testler o çelik kilitlerdir. AI kodu baştan üretse bile testler trenin raydan çıkıp uçuruma yuvarlanmasını engeller!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of a roller coaster: You can repaint the coaster cars or upgrade the upholstery anytime. But what keeps the car from flying off the tracks at 100 mph are the steel under-friction safety wheels! Automated tests are those steel clamps. Even if an AI completely regenerates the engine, the tests guarantee the car stays on track.]
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
      14. İlke: Gerçeği Testler Taşır (Tests Carry the Truth): Use-Case 3.0'daki en çarpıcı cümle şudur: 'Test senaryoları, bir use case'in anlatısından bile daha önemli olan en kritik parçasıdır; çünkü use case'in ne zaman başarıyla tamamlandığını sadece testler tanımlar!' AI Unified Process bu tavsiyeyi yapısal bir zorunluluğa dönüştürür. 4. İlke 'Test-Protected' (Testle Korunan): Kod her an baştan üretilebilen geçici bir derleme çıktısıdır. Eğer bir sistemin davranışı kodun dışında bir mekanizma tarafından sabitlenmemişse, o sistemi AI ile yeniden üretmek kumar oynamaktır! Test piramidi doğrudan şartname zincirine bağlanır: 1) Birim/Akış Testleri: Şartnamedeki her bir doğrulama adımını ve her bir alternatif akışı (A1, A2) tek tek sınar. 2) Entegrasyon Testleri: Bir use case'in tamamını gerçek arayüz ve servislerle test eder. 3) Yolculuk Testleri (TC-XXX): Birden fazla use case'i bağlayan iş süreçlerini test eder.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Principle 14: Tests Carry the Truth & The AIUP Test Pyramid: Use-Case 3.0 asserts boldly: 'The test cases are the most important part of a use case's description, more important even than the narrative.' In the AI Unified Process, this transitions from agile guidance to absolute architectural necessity. Principle 4 (Test-Protected) establishes that because code can be generated, refactored, or discarded at will, intent must be pinned by artifacts outside the code. The tests freeze observable behavior. The test hierarchy aligns cleanly with the artifact chain: 1) Unit/Flow Tests: Derived directly from the use case validations and alternative flows (BR-XXX). 2) Integration Tests: Drive an entire use case through the presentation layer. 3) Journey Tests (TC-XXX): Verify multi-use-case lifecycles where state transitions cross use case boundaries.]
    ]
  )
]

#java25_box[
```java
// Java 25: Alternatif Akışları Doğrulayan Test-Protected Mimari
package com.maang.aiup.testing;

import java.util.Optional;

public class TestCarriesTruthDemo {
    public record BorrowResult(boolean success, String message) {}

    public static class BorrowValidator {
        public static BorrowResult validate(int availableCopies, int currentLoans, boolean hasOverdue) {
            // BR-004: Kopya kontrolü -> Alternatif A1
            if (availableCopies <= 0) return new BorrowResult(false, "A1: Kopya kalmadı.");
            // BR-005: Limit kontrolü -> Alternatif A2
            if (currentLoans >= 5) return new BorrowResult(false, "A2: Limit aşıldı.");
            // BR-006: Gecikmiş borç -> Alternatif A3
            if (hasOverdue) return new BorrowResult(false, "A3: Gecikmiş borç var.");
            
            return new BorrowResult(true, "Ödünç başarılı.");
        }
    }

    // TEST MOTORU (Şartnamenin bekçisi)
    void main() {
        // Test 1: A1 Akışını sına
        var resA1 = BorrowValidator.validate(0, 1, false);
        assert !resA1.success() && resA1.message().contains("A1") : "A1 Testi Başarısız!";

        // Test 2: A2 Akışını sına
        var resA2 = BorrowValidator.validate(2, 5, false);
        assert !resA2.success() && resA2.message().contains("A2") : "A2 Testi Başarısız!";

        // Test 3: Başarı Yolunu sına
        var resOk = BorrowValidator.validate(2, 2, false);
        assert resOk.success() : "Mutlu Yol Testi Başarısız!";

        System.out.println("✅ Tüm akış testleri geçti! Şartname koruma altındadır.");
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
      Testi yazılmamış bir use case şartnamesi yalnızca bir temenniden ibarettir! Her alternatif akışın en az bir otomatik testi olmak zorundadır.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[A use case without automated test cases is merely a wish. Every alternative flow must have at least one automated assertion guarding it against regression.]
    ]
  )
]

#takeaways_box((
    ("Kod geçicidir, test kalıcıdır: Sistemi güvenle yeniden üretilebilir kılan testlerdir.", "Code is ephemeral; tests are enduring. Automated tests make regeneration safe."),
    ("Şartnamedeki her bir doğrulama (validates) ve alternatif akış (A1, A2) için test yazılır.", "Every validation step and alternative flow in the spec maps to a specific test case."),
    ("Yolculuk testleri (TC-XXX) use case'ler arasındaki durum ve veri akışını denetler.", "Journey tests (TC-XXX) verify cross-use-case boundaries and continuous state progression."),
))
