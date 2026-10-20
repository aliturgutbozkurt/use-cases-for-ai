#import "/template.typ": *

#show: doc => setup_book(title: "Ders 50: İmza Testi (Sign-Off Test): Hata (Bug) ile Geliştirme (Enhancement) Ayrımı", doc)

#lesson_header(
  50,
  "İmza Testi (Sign-Off Test): Hata (Bug) ile Geliştirme (Enhancement) Ayrımı",
  "The Sign-Off Test: Distinguishing Genuine Bugs from Scope Enhancements",
  "Değişiklik Talepleri, Hatalar (Bugs) ve Mevcut (Brownfield) Sistemler",
  "Change Requests, Bugs, and Brownfield Systems"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 İMZA TESTİ (THE SIGN-OFF CLASSIFICATION TEST)               │
└─────────────────────────────────────────────────────────────────────────────┘
  
  Müşteri Şikâyeti Geldi: "Sistem bana kalan ödünç hakkımı göstermiyor!"
  
  ❓ İMZA TESTİ SORUSU:
  "Paydaş, şu anki şartnameyi imzalarken tam olarak bunu mu kastetmişti?"
                        │
         ┌──────────────┴──────────────┐
         ▼                             ▼
       [ EVET ]                      [ HAYIR ]
  "Evet, paydaş o gün öyle      "Hayır! Şartname asla böyle
   istemişti ama şimdi yeni      bir eksikliği onaylamazdı,
   bir şey istiyor!"             unutulmuş veya yanlış yazılmış!"
         │                             │
         ▼                             ▼
  ✨ GELİŞTİRME (ENHANCEMENT)    🐛 HATA (BUG REPORT)
  - Yeni bir istek!             - Şartname veya kod kusurludur!
  - Yeni önceliklendirme gerekir - Derhal şartnamede düzeltilir!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir marangoza masa yaptırdınız. Masayı teslim alırken 'Ahşap ayaklı 4 kişilik meşe masa' sözleşmesini imzaladınız. 2 ay sonra 'Ben bu masanın mermer olmasını istiyordum' derseniz marangoza kızamazsınız; bu yeni bir istektir (Enhancement)! Ama masanın bir bacağı kısaysa ve sallanıyorsa bu bir hatadır (Bug)! İmza testi, sözleşmeye bakıp kimin haklı olduğunu saniyeler içinde anlar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[You commission a carpenter to build a dining table and sign a contract for 'Solid Oak Table, 4 seats'. Two months later you declare: 'I actually wanted white Italian marble!' The carpenter didn't make a mistake; that is an Enhancement request! But if the table arrived with 3 legs and wobbles, that is a Bug! The sign-off test inspects original intent to classify the discrepancy instantly.]
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
      İmza Testinin (The Sign-Off Test) Hukuki ve Mimari Gücü: Kurumsal yazılım geliştirmede geliştiriciler ile ürün sahipleri arasındaki en büyük sürtünme 'Bu bir bug mı yoksa yeni bir geliştirme mi?' tartışmasıdır. Hatalar garanti kapsamında bedelsiz ve derhal çözülürken, geliştirmeler yeni bütçe ve sprint planlaması gerektirir. Martinelli bu karmaşayı tek bir zarif soruyla çözer: 'Bir paydaş, şu an ne istediğini biliyorken, eski şartnameyi imzalar mıydı?' Eğer cevap 'Evet, o tarihte bunu istiyorduk ama şimdi fikrimiz değişti' ise, bu açıkça bir Değişiklik/Geliştirmedir (Enhancement). Eğer cevap 'Hayır, o şartname zaten bizim asıl niyetimizi yanlış ifade etmiş veya eksik bırakmış' ise, bu tartışmasız bir Hatadır (Bug). Bu test sınıflandırmayı duygu ve polemikten çıkarıp objektif bir sözleşme analizine dönüştürür.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Sign-Off Classification Test: The eternal debate between product owners and engineering leads centers on classifying discrepancies as either defects or scope changes. Defects typically carry contractual SLA penalties and zero additional billing, whereas scope changes require backlog refinement. Martinelli resolves this dispute via the Sign-Off Test: 'Would a stakeholder have signed off the old specification, knowing what they want now?' If yes, the specification captured true historical consensus, and the customer has since evolved their requirements. That is an Enhancement. If no, the specification either misstated stakeholder intent or omitted a crucial invariant. That is a Bug. This test converts an adversarial dispute into an objective specification reconciliation.]
    ]
  )
]

#java25_box[
```java
// Java 25: İmza Testine Göre İş Akışının Otomatik Yönlendirilmesi
package com.maang.aiup.signoff;

public class SignOffClassificationDemo {
    public enum WorkType { BUG, ENHANCEMENT }

    public record DiscrepancyReport(String description, boolean wouldStakeholderHaveSignedOldSpec) {
        public WorkType classify() {
            // İmza Testi Mantığı
            return wouldStakeholderHaveSignedOldSpec ? WorkType.ENHANCEMENT : WorkType.BUG;
        }
    }

    void main() {
        var report1 = new DiscrepancyReport("Üye ödünç geçmişinde kitap ISBN'i görünmüyor", true);
        var report2 = new DiscrepancyReport("Ödünç limiti 5 olmasına rağmen sistem 6. kitaba izin veriyor", false);

        System.out.println("Rapor 1 Sınıflandırması: " + report1.classify() + " (Yeni istek)");
        System.out.println("Rapor 2 Sınıflandırması: " + report2.classify() + " (Kritik iş kuralı hatası)");
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
      Müşteri 'bu bir bug' dedi diye şartnameye bakmadan hemen koda müdahale etmeyin; imza testini uygulayın, işin geliştirme mi hata mı olduğunu tespit edin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not rush to patch code simply because a client labels an issue as a 'critical bug'. Apply the sign-off test to classify intent accurately before touching specifications.]
    ]
  )
]

#takeaways_box((
    ("İmza testi: Paydaş şu anki aklıyla eski şartnameyi imzalar mıydı?", "The sign-off test: Would a stakeholder have signed off the old spec, knowing what they want now?"),
    ("Cevap 'Evet' ise bu yeni bir geliştirmedir (Enhancement); 'Hayır' ise bir hatadır (Bug).", "If yes, it represents an enhancement; if no, it is a genuine defect."),
    ("Sınıflandırma testi mühendisler ile ürün sahipleri arasındaki polemiği tamamen bitirir.", "The test eliminates subjective arguments between engineering and product management."),
))
