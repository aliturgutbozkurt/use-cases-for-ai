#import "/template.typ": *

#show: doc => setup_book(title: "Ders 11: AI-Çağı İlkeleri 13 & 14: Gözlemlenebilir Davranış vs Testler Gerçeği Taşır", doc)

#lesson_header(
  11,
  "AI-Çağı İlkeleri 13 & 14: Gözlemlenebilir Davranış vs Testler Gerçeği Taşır",
  "AI-Era Principles 13 & 14: Observable Behavior vs Tests Carry the Truth",
  "Üç Okuyucu Modeli & Yapay Zekâ Çağının 5 Temel İlkesi",
  "The Three Readers & The 5 AI-Era Principles"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 İLKE 13 & 14: GÖZLEMLENEBİLİR DAVRANIŞ & TEST KORUMASI       │
└─────────────────────────────────────────────────────────────────────────────┘
  İLKE 13: GÖZLEMLENEBİLİR OLANI YAZ, MEKANİZMAYA SESSİZ KAL!
  ✅ YAZ: "Sistem parolanın güvenli saklanmasını sağlar." (Gözlemlenebilir Sonuç)
  ❌ YAZMA: "Sistem parolayı bcrypt ve salt ile hashler." (Mekanizma / Yarın argon2 olabilir!)

  İLKE 14: TESTLER GERÇEĞİ TAŞIR (TESTS CARRY THE TRUTH)
  Use Case Şartnamesi (Niyet) ──▶ [ Test Paketi: TC-001, Unit, Integration ]
                                                 │
  AI Kod Üretir (İImplementation) ◀──────────────┘ (Testler geçene kadar kod kabul edilmez!)
  * Kod her an silinebilir; davranışı sabit tutan tek çapa testlerdir!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      İlke 13: Bankaya gittiğinde veznedara 'Bana paramı ver ama parayı verirken sol elini 45 derece açıyla kaldır, kasayı anahtarla 3 kere çevir' demezsin. Sadece '1000 TL çekmek istiyorum' dersin (Sonuç!). Kasayı nasıl açtığı bankanın iç meselesidir. İlke 14: Veznedarın parayı doğru verip vermediğini anlamak için parayı eline alır sayarsın (Test!). Parayı saymazsan eksik mi verdi sahte mi verdi bilemezsin!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Principle 13: At an ATM, you request '\$100 cash'. You never instruct the machine: 'Spin gear 4 at 120 RPM and trigger hydraulic valve B'. The mechanical implementation is the machine's private affair. Principle 14: When the bills emerge, you count them. Tests are the physical counting of the cash. A use case without automated tests is merely wishful thinking.]
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
      İlke 13 ve 14'ün Sistem Mimarisi Açısından Önemi: 1) İlke 13: Gözlemlenebilir davranış (observable behavior) ile mekanizma (mechanism) arasındaki ayrım, bir şartnamenin ömrünü belirler. Bir kullanıcının veya testin dışarıdan gözlemleyebileceği her şey (ekrandaki kolonlar, hata mesajları, 28 günlük vade gibi kesin sayılar) Zone 1'dir ve yazılmalıdır. Sistemin bunu nasıl başardığı (SQL query, JWT token, bcrypt, Redis cache) Zone 3'tür ve KESİNLİKLE YASAKTIR. Mekanizma sızarsa şartname mimariyi kilitler ve framework yükseltmelerinde çöker. 2) İlke 14: 'Testler gerçeği taşır' (Tests carry the truth). Use-Case 3.0'ın en çarpıcı tespiti: Test senaryoları bir use case'in anlatısından bile daha önemlidir. Çünkü AI çağında kodu yeniden üretmek (regeneration) ancak davranış dışarıdan bir test takımıyla sabitlenmişse güvenlidir. Kod değişir, silinir, baştan yazılır; ancak testler yeşil kaldığı sürece sistemin sözleşmesi korunmuş demektir.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Deep dive on Principles 13 & 14: 1) Principle 13 (Observable vs Mechanism): Replaces decades of ambiguous advice regarding 'the right level of specification detail'. If a stakeholder can verify it or an automated test can assert it, it belongs in the specification (Zone 1). If it describes internal computational wiring (protocols, database schemas, hashing algorithms), it belongs to the implementation skill (Zone 3). Leaking Zone 3 mechanics guarantees that the spec will contradict future framework upgrades. 2) Principle 14 (Tests Carry the Truth): In an automated regeneration lifecycle, source code is volatile. What keeps the system's behavior invariant across LLM rewrites is the test suite. Every use case flow must yield an executable test case; without tests, automated code generation is reckless gambling.]
    ]
  )
]

#java25_box[
```java
// Java 25: Mekanizmadan Bağımsız Davranışsal Test (Tests Carry the Truth)
package com.maang.aiup.principles;

public class ObservableBehaviorTest {
    // Sözleşme: Parola formatı doğrulanır (Mekanizma: regex mi değil mi şartnameye yazılmaz!)
    public interface PasswordValidator {
        boolean isValid(String password);
    }

    // İlke 14: Gerçeği taşıyan test paketi
    public static void runTests(PasswordValidator validator) {
        // Test 1: En az 8 karakter olmalı
        assert !validator.isValid("short") : "8 karakterden kısa parola reddedilmeli!";
        // Test 2: Rakam içermeli
        assert !validator.isValid("NoDigitsHere!") : "Rakam içermeyen parola reddedilmeli!";
        // Test 3: Başarılı parola
        assert validator.isValid("SecureP@ss2026") : "Geçerli parola kabul edilmeli!";

        System.out.println("✅ İlke 14: Tüm davranışsal testler başarıyla geçti!");
    }

    void main() {
        // AI'ın ürettiği implementasyon (İster regex kullansın, ister döngü!)
        PasswordValidator aiGenerated = pwd -> pwd != null && pwd.length() >= 8 && pwd.matches(".*\d.*");
        runTests(aiGenerated);
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
      Şartnameye 'Parola bcrypt ile hashlenir' yazarsanız, yarın kuantum güvenli veya Argon2 algoritmasına geçtiğinizde şartname yalan söylemeye başlar. 'Parola güvenli şekilde saklanır' yazın; algoritma seçimini mimari yapılandırmaya bırakın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[If you write 'password is hashed with bcrypt' in a use case, the moment your team upgrades to Argon2id, the specification becomes a lie. Write 'system securely stores password' and delegate cryptography to the tech stack configuration.]
    ]
  )
]

#takeaways_box((
    ("Paydaşın görebildiği ve testin doğrulayabildiği her şey yazılır; mekanizma asla yazılmaz.", "Specify everything observable and testable; stay completely silent on internal mechanisms."),
    ("Teknolojiler, kütüphaneler ve veri tabanı komutları şartnameye sızarsa sistem kilitlenir.", "Leaking protocols, SQL, and algorithms into specs makes future modernization impossible."),
    ("Testler olmadan AI ile kod üretmek kumar oynamaktır; gerçeği kod değil testler taşır.", "Without automated tests, AI code generation is blind; tests carry the enduring truth."),
))
