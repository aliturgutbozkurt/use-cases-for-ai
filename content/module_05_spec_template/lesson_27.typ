#import "/template.typ": *

#show: doc => setup_book(title: "Ders 27: Ana Başarı Senaryosu (Happy Path): 3 ila 9 Adımlı Altın Ritim ve Denge", doc)

#lesson_header(
  27,
  "Ana Başarı Senaryosu (Happy Path): 3 ila 9 Adımlı Altın Ritim ve Denge",
  "Main Success Scenario: The 3-to-9 Step Golden Rhythm",
  "Ana Şartname Şablonu & Alan Alan Derinlemesine İnceleme",
  "The Master Specification Template & Field Breakdown"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 ANA BAŞARI SENARYOSUNUN 3-9 ADIMLI ALTIN RİTMİ              │
└─────────────────────────────────────────────────────────────────────────────┘
  1. ADIM: Aktör talebini ve verilerini gönderir. (Etkileşim)
  2. ADIM: Sistem varlığı ve seçenekleri gösterir. (Etkileşim)
  3. ADIM: Aktör onaylar / işlemi talep eder. (Etkileşim)
  4. ADIM: Sistem 1. kuralı doğrular (BR-001). (Doğrulama)
  5. ADIM: Sistem 2. kuralı doğrular (BR-002). (Doğrulama)
  6. ADIM: Sistem durumu kaydeder ve stoğu düşer. (Durum Değişimi)
  7. ADIM: Sistem kullanıcıya onay ve makbuz gösterir. (Hedef Teslim Edildi!)

  ⚠️ KURAL:
  - 3 adımdan azsa: Muhtemelen doğrulama ve durum değişimi adımları unutulmuştur!
  - 9 adımdan çoksa: Araya buton tıklamaları ve UI mekanikleri sızmıştır; birleştirin!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Mükemmel bir fıkra veya masal 3 ila 9 cümleden oluşur: Giriş, gelişme ve mutlu son. Eğer masalı 2 cümlede bitirirsen ('Keloğlan yola çıktı, kral oldu') kimse bir şey anlamaz (Çok kısa!). Eğer 25 cümle yapıp Keloğlan'ın her adımda ayağını nasıl kaldırdığını anlatırsan herkes uyuyakalır (Çok uzun!). Use case'in ana senaryosu da 3 ila 9 adımdır: Ne eksik ne fazla; hedefe dümdüz giden en temiz yoldur!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[A classic fairy tale spans 3 to 9 narrative beats: setup, rising action, and resolution. A 2-sentence story ('The prince rode forth and rescued the kingdom') is too abrupt to convey meaning. A 30-sentence story micromanaging how the prince buttoned his left boot puts the audience to sleep. The main success scenario requires 3 to 9 steps: lean, purposeful, and marching straight toward the goal.]
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
      Ana Başarı Senaryosunun (Main Success Scenario) Mühendislik Dinamikleri: Cockburn 20 yılı aşkın tecrübesinde 11 adımdan uzun olup da kısaltıldığında daha iyi hale gelmeyen TEK BİR use case senaryosu bile görmediğini belirtir. 1) 3-9 Adım Kuralı: İnsan beyninin çalışma belleği (working memory) Miller Kanununa göre 7±2 birim bilgiyi tutabilir. Bir paydaş veya mühendis 9 adımdan uzun bir senaryoyu kafasında canlandıramaz; doğrulama zafiyetleri başlar. 2) Adımların Şekli: Senaryoda ASLA if-else veya dallanma olamaz. Her adım MUTLAKA başarılı olur. 'Sistem şifre doğru mu bakar' denmez; 'Sistem şifrenin doğruluğunu onaylar' denir. Başarısızlıklar alternatif akışlara fırlatılır. 3) Adım Birleştirme (Collapsing): Birbiri ardına gelen mikro hareketler ('Kullanıcı adı girer', 'Kullanıcı soyadı girer', 'Kullanıcı tıklar') tek bir adıma indirgenir: '1. Kullanıcı kişisel bilgilerini girer.' Bu kural arayüz mekaniklerinin şartnameyi kirletmesini engeller.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Mechanics of the Main Success Scenario: Cockburn observed that he had never seen a scenario longer than 11 steps that did not dramatically improve when shortened. 1) The 3-to-9 Step Heuristic: Rooted in cognitive science (Miller's \$7 \pm 2\$ working memory limit). Both stakeholders validating the workflow and engineers auditing the generated architecture must hold the sequence in mind simultaneously. If a scenario has fewer than 3 steps, state mutations and validations were omitted. If it exceeds 9 steps, UI mechanical clicks have invariably infiltrated the text. 2) The Uncompromising Happy Path: The main scenario contains zero conditional branching. Every step succeeds unconditionally. Failures are decoupled into named alternative flows. 3) Step Aggregation: Unify fragmented micro-interactions ('Enters first name', 'Enters last name', 'Clicks Next') into an intent-driven bundle: 'User enters personal information.']
    ]
  )
]

#java25_box[
```java
// Java 25: 3-9 Adımlı Ana Senaryoyu Yürüten Temiz Orkestrasyon Metodu
package com.maang.aiup.scenario;

public class MainScenarioOrchestrator {
    public record BorrowCommand(String memberId, String bookId) {}
    public record BorrowReceipt(String transactionId, String dueDate) {}

    // Ana Başarı Senaryosunun 3-9 adımlı temiz icrası:
    public BorrowReceipt executeHappyPath(BorrowCommand cmd) {
        // Step 4: System validates copy availability (BR-004)
        validateAvailability(cmd.bookId());

        // Step 5: System validates loan limit (BR-005)
        validateLoanLimit(cmd.memberId());

        // Step 6: System records loan
        String txnId = persistLoanRecord(cmd.memberId(), cmd.bookId());

        // Step 7: System decrements copy count
        decrementInventory(cmd.bookId());

        // Step 8: System confirms and delivers goal
        return new BorrowReceipt(txnId, "2026-11-17");
    }

    private void validateAvailability(String b) {}
    private void validateLoanLimit(String m) {}
    private String persistLoanRecord(String m, String b) { return "TXN-101"; }
    private void decrementInventory(String b) {}

    void main() {
        var receipt = new MainScenarioOrchestrator().executeHappyPath(new BorrowCommand("M1", "B9"));
        System.out.println("✅ Ana senaryo başarıyla icra edildi: " + receipt);
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
      Ana senaryo adımlarında 'Eğer stok yoksa...' veya 'Kullanıcı dilerse...' gibi koşul cümleleri (if-statements) KESİNLİKLE YASAKTIR! Koşullu her durum Alternatif Akışlar (Alternative Flows) bölümüne aittir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never introduce 'If the item is out of stock...' inside the main success scenario. The main scenario asserts absolute success. All deviations and conditional forks belong exclusively in the Alternative Flows section.]
    ]
  )
]

#takeaways_box((
    ("Ana senaryo 3 ila 9 adımdan oluşur; dallanma içermez, her adım başarıyla tamamlanır.", "The main scenario has 3 to 9 steps, contains zero branches, and succeeds unconditionally."),
    ("9 adımdan uzun senaryolarda ekran detayları sızmıştır; adımları niyet bazında birleştirin.", "Scenarios exceeding 9 steps suffer from UI mechanical leakage; collapse them into intent."),
    ("Son adım mutlaka kullanıcının hedefine ulaştığını ve değerin teslim edildiğini gösterir.", "The final step must unambiguously deliver the user's primary goal."),
))
