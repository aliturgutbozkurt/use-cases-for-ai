#import "/template.typ": *

#show: doc => setup_book(title: "Ders 54: Taban Çizgisi İncelemesi (Baseline Review): SE ve RE Ortak Eşleşmesi", doc)

#lesson_header(
  54,
  "Taban Çizgisi İncelemesi (Baseline Review): SE ve RE Ortak Eşleşmesi",
  "The Baseline Review: Software Engineer & Requirements Engineer Joint Pairing",
  "Değişiklik Talepleri, Hatalar (Bugs) ve Mevcut (Brownfield) Sistemler",
  "Change Requests, Bugs, and Brownfield Systems"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 TABAN ÇİZGİSİ İNCELEMESİ: SE + RE ORTAK DENETİMİ             │
└─────────────────────────────────────────────────────────────────────────────┘
  
   YAZILIM MÜHENDİSİ (SE):                 GEREKSİNİM MÜHENDİSİ (RE):
   "Sistemin GERÇEKTE NE YAPTIĞINI bilir!" "Sistemin NE YAPMASI GEREKTİĞİNİ bilir!"
                    │                                    │
                    └─────────────────┬──────────────────┘
                                      │
                                      ▼
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ 🔍 ORTAK TABAN ÇİZGİSİ İNCELEMESİ (BASELINE REVIEW):                    │
  │                                                                         │
  │ 1. SE'nin Yakaladıkları:                                                │
  │    - Kodda kalmış ama artık hiçbir yerin çağırmadığı ölü akışlar.       │
  │    - İkinci bir giriş noktası yüzünden bypass edilen validasyonlar.     │
  │                                                                         │
  │ 2. RE'nin Yakaladıkları:                                                │
  │    - Kodun harfiyen doğru yaptığı ama şirketin 5 yıl önce terk ettiği   │
  │      artık savunulamaz olan saçma iş kuralları!                         │
  │    - Kodun hiç ele almadığı ve kimsenin fark etmediği istisnalar.       │
  └─────────────────────────────────────────────────────────────────────────┘
  🎯 SONUÇ: Tek başına SE transkripsiyon yapar, tek başına RE hayal kurar.
            İkisi bir araya gelince 'ÖLÜMSÜZ TABAN ÇİZGİSİ' (Baseline) doğar!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Eski bir evi tadilata sokacağınızı düşünün: Tesisat ustası (Yazılım Mühendisi) der ki: 'Bu boru patlak, bu kablo hiçbir yere bağlanmıyor!' İç mimar (Gereksinim Mühendisi) der ki: 'Bu duvarı yıkıp salonu büyütmemiz lazım, o oda artık kullanılmıyor!' Tesisatçı tek başına evi anlayamaz, mimar tek başına boruları bilemez. İkisi el ele verince ev saraya dönüşür!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Imagine renovating a 100-year-old mansion: The plumber (Software Engineer) notes: 'This pipe is rusted, and this wire leads nowhere!' The interior architect (Requirements Engineer) says: 'We need to knock down this wall to expand the living room; that pantry is obsolete!' Neither can restore the estate alone. Together, they create a master renovation baseline!]
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
      Taban Çizgisi İncelemesinin (The Baseline Review) Kritik Rolü: Mevcut bir sistemden çıkarılan tersine mühendislik taslakları, koda bakarak yazıldığı için süreçteki 'en az güvenilir' belgelerdir. Bu taslakları güvenilir bir 'Taban Çizgisi' (Spec Baseline) haline getiren şey, iki farklı disiplinden uzmanın bir odaya kapanıp yaptığı ortak incelemedir: 1) Yazılım Mühendisi (SE): Kodun gerçekte ne yaptığını bilir. Artık hiçbir ekranın tetiklemediği ölü kod yollarını, arka kapılardan bypass edilen güvenlik açıklarını ve eski bir sabitten türetilmiş gereksiz kuralları yakalar. 2) Gereksinim Mühendisi (RE): Sistemin ne yapması gerektiğini veya kime soracağını bilir. Kodun harfiyen doğru icra ettiği ama günümüz iş mantığına tamamen aykırı düşen mantıksız akışları, kodun hiç yakalamadığı istisnaları ve şirketin 5 yıl önce bıraktığı terimleri temizler. İnceleme sonucunda uzlaşılamayan her konu (belgelenmemiş ama kullanılan davranışlar, bozulmuş fonksiyonlar) bir Değişiklik Günlüğü'ne (Change Log) yazılır ve paydaş onayına sunulur.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Baseline Review Pairing: A recovered specification draft written from source code inspection is inherently untrustworthy—it describes what was compiled, not what was intended. Elevating these drafts into an authoritative 'Spec Baseline' requires a rigorous joint pairing between two complementary roles: 1) The Software Engineer (SE) understands actual system behavior. They catch obsolete paths nothing invokes, validations bypassed by secondary routes, and fake business rules inferred from legacy constants. 2) The Requirements Engineer (RE) understands business domain intent. They catch flows that are mathematically accurate to the code but indefensible to customers, unhandled failure modes that went unnoticed for years, and deprecated terminology. Neither role can succeed in isolation: an SE alone produces formatted code transcription; an RE alone produces an ungrounded wish list. The reconciled output establishes the spec baseline from which all future development proceeds.]
    ]
  )
]

#java25_box[
```java
// Java 25: Baseline Review Sonrası Temizlenen Taban Çizgisi Modeli
package com.maang.aiup.baseline;

public class BaselineReviewReconciliation {
    // SE ve RE İncelemesinden Geçmiş Uzlaşılmış Varlık
    public record ReconciledLoanRule(
        boolean deadCodeEliminated,
        boolean businessIntentVerified,
        String approvedPolicy
    ) {}

    public static class BaselineReviewAuditor {
        public static ReconciledLoanRule audit(boolean seApproved, boolean reApproved) {
            if (seApproved && reApproved) {
                return new ReconciledLoanRule(true, true, "✅ APPROVED BASELINE: Vade 28 gün, Maksimum 5 kitap.");
            }
            throw new IllegalStateException("❌ İnceleme tamamlanmadı! Her iki uzmanın onayı şarttır.");
        }
    }

    void main() {
        var baseline = BaselineReviewAuditor.audit(true, true);
        System.out.println("Taban Çizgisi İnceleme Sonucu: " + baseline.approvedPolicy());
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
      Taban çizgisi incelemesini tek bir uzmana (sadece yazılımcıya veya sadece analiste) emanet etmeyin; yazılımcı koda aşık olur, analist ise gerçeklerden kopar.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never assign the baseline review to a single person. An engineer transcribes code habits; an analyst invents an ungrounded wish list. Pairing is indispensable.]
    ]
  )
]

#takeaways_box((
    ("Kurtarılan taslak şartnameler, SE ve RE ortak incelemesinden geçerek 'Baseline' olur.", "Recovered specification drafts become an authoritative 'Baseline' via joint SE-RE review."),
    ("Yazılım mühendisi kod gerçekliğini, gereksinim mühendisi ise iş hedeflerini korur.", "The software engineer guards code truth; the requirements engineer guards business intent."),
    ("Uzlaşılamayan davranışlar doğrudan Değişiklik Günlüğü'ne (Change Log) aktarılır.", "Unresolved ambiguities populate the initial change log for formal stakeholder arbitration."),
))
