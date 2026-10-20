#import "/template.typ": *

#show: doc => setup_book(title: "Ders 9: AI-Çağı İlkesi 11: Şartname Koddan Daha Uzun Yaşar (The Spec Outlives the Code)", doc)

#lesson_header(
  9,
  "AI-Çağı İlkesi 11: Şartname Koddan Daha Uzun Yaşar (The Spec Outlives the Code)",
  "AI-Era Principle 11: The Specification Outlives the Code",
  "Üç Okuyucu Modeli & Yapay Zekâ Çağının 5 Temel İlkesi",
  "The Three Readers & The 5 AI-Era Principles"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 İLKE 11: ŞARTNAMENİN KALICILIĞI & KODUN GEÇİCİLİĞİ          │
└─────────────────────────────────────────────────────────────────────────────┘
  2024: Spring Boot 3 + JPA ──┐
  2026: Spring Boot 4 + jOOQ ─┼──▶ [ KOD GEÇİCİDİR / BİR ÇIKTIDIR (OUTPUT) ]
  2028: Quarkus / Native ─────┘    (Tek komutla silinir ve baştan üretilir!)
               ▲
               │ ÜRETİR (GENERATES)
  ┌──────────────────────────────────────────────────────────┐
  │  DEĞİŞMEZ VE KALICI VARLIK: USE CASE ŞARTNAMESİ (ASSET)  │
  │  - İş kuralları (BR-XXX) aynı kalır                      │
  │  - Kullanıcı hedefleri ve başarı adımları aynı kalır     │
  │  - Test senaryoları (TC-XXX) aynı kalır                  │
  └──────────────────────────────────────────────────────────┘
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir tiyatro oyununu düşünün: Hamlet oyunu 400 yıldır aynı senaryoyla oynanıyor. Ancak aktörler, kostümler, sahne ışıkları ve tiyatro binası yüzlerce kez değişti! Kod dediğin şey sahnedeki kostümdür; eskiyince çöpe atar yenisini giydirirsin. Use Case şartnamesi ise Shakespeare'in yazdığı ana tiyatro metnidir (Hamlet)! Kostüm değişir ama metin asla ölmez!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Consider Shakespeare's Hamlet: the play has endured for 400 years, while the actors, costumes, stages, and lighting rigs have been replaced thousands of times. Source code is merely the temporary stage costume—it wears out, gets refactored, and is ultimately discarded. The use case specification is the timeless script. Frameworks and syntax will fade, but the core business contract outlives them all.]
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
      Yazılım Mühendisliği 2.0 ve İlke 11'in Derinliği: Martinelli'nin Use-Case 3.0'a eklediği 11. ilke: 'Şartname koddan daha uzun yaşar.' Geleneksel yazılım geliştirmede kod en değerli varlıktı (asset); şartname ise geliştirme bitince bir köşeye atılan geçici bir iskeleydi (scaffolding). AI çağında bu durum 180 derece değişti. Bugün modern bir AI ajanı, elinde kaliteli bir use case ve veri modeli varsa, 10.000 satırlık bir mikroservisi 10 dakikada sıfırdan üretebilir. Ancak o 10.000 satırlık koda bakarak şirketin gerçek iş kurallarını (business intent) geri çıkarmak aylar sürer ve devasa hatalara gebedir. Bu nedenle bir projede kod ve şartname çeliştiğinde, varsayılan kural şudur: 'Şartname doğrudur, kod hatalıdır.' Kod her zaman şartnameye uydurulmak üzere yeniden üretilir.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Principle 11 Architectural Mandate: 'The specification outlives the code.' In legacy paradigms, code was the ultimate store of organizational value; specifications were discarded scaffolding. In modern AI-augmented software engineering, implementation is fungible. Armed with a rigorous use case model and entity dictionary, an LLM agent generates an entire production-grade subsystem in minutes. Conversely, reverse-engineering unstated business invariants from legacy binary bytecodes is agonizing and prone to catastrophic data loss. Therefore, whenever code and specification disagree, the architectural presumption is uncompromising: the code is defective. Code is transient; intent is permanent.]
    ]
  )
]

#java25_box[
```java
// Java 25: 10 Yıl Sonra Bile Geçerliliğini Koruyan Değişmez İş Kuralı Modeli
package com.maang.aiup.principles;

public class Principle11Demo {
    // 2026'da Java 25 ile, 2030'da Java 30 ile derlense de bu kural DEĞİŞMEZ:
    // BR-005: Bir üye aynı anda en fazla 5 açık ödünç kitaba sahip olabilir.
    public static final int MAX_OPEN_LOANS_LIMIT = 5;

    public record MemberLoanProfile(String memberId, int activeLoansCount) {
        public boolean canBorrowMore() {
            return activeLoansCount < MAX_OPEN_LOANS_LIMIT;
        }
    }

    void main() {
        var profile = new MemberLoanProfile("M-77", 4);
        System.out.printf("Üye ID: %s | Yeni kitap alabilir mi? %s (Limit: %d)%n",
            profile.memberId(), profile.canBorrowMore(), MAX_OPEN_LOANS_LIMIT);
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
      Bir kodlama hatasını düzeltmek için doğrudan koda girip 'if (count \< 6)' yazmayın! Bu satırı gören biri kuralın 5 mi 6 mı olduğunu anlayamaz. Önce şartnamedeki BR-005 kuralını güncelleyin, ardından kodu yeniden ürettirin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never patch an operational defect by directly tweaking conditional logic in source files without touching the specification. Unsynchronized code patches cause specification drift, guaranteeing that future automated rebuilds will overwrite your changes.]
    ]
  )
]

#takeaways_box((
    ("Kod bir derleme çıktısıdır; atılabilir, değiştirilebilir ve yeniden üretilebilir.", "Code is now a build artifact: disposable, replaceable, and effortlessly regenerated."),
    ("Use Case şartnamesi kurumun ana entelektüel sermayesidir (asset) ve sistem yaşadıkça korunur.", "The use case specification is the enterprise asset, maintained for the life of the system."),
    ("Kod ile şartname çeliştiğinde her zaman kod hatalı kabul edilir.", "When specification and code disagree, the default axiom is that the code is wrong."),
))
