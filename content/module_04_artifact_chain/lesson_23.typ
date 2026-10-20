#import "/template.typ": *

#show: doc => setup_book(title: "Ders 23: Arayüz Olarak Kararlı Kimlikler: FR-001'den Koda Mekanik İzlenebilirlik Zinciri", doc)

#lesson_header(
  23,
  "Arayüz Olarak Kararlı Kimlikler: FR-001'den Koda Mekanik İzlenebilirlik Zinciri",
  "Identifiers as Interfaces: Mechanical Traceability from FR-001 to Code",
  "Eser Zinciri (Artifact Chain) & PlantUML Mimarisi",
  "The Artifact Chain & PlantUML Architecture"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 MEKANİK İZLENEBİLİRLİK ZİNCİRİ (TRACEABILITY CHAIN)          │
└─────────────────────────────────────────────────────────────────────────────┘
  FR-005 (Kullanıcı Hikayesi)
     │
     ▼ realizes
  UC-003 (Manage Books Use Case)
     │
     ▼ diverges at
  A2 (Alternatif Akış: Stok Yetersiz)
     │
     ▼ enforces
  UC-003 BR-007 (İş Kuralı: Asgari Rezervasyon Limiti)
     │
     ▼ generates
  BookBorrowService.java (Kaynak Kod Satırı)
     │
     ▼ verifies
  TC-003_A2_Test.java (Otomatik Test Senaryosu)

  🎯 MÜKEMMEL DÜZEN: Bir müşteri "Bu sipariş niye reddedildi?" diye sorduğunda,
  kimse kodun içinde kaybolmaz; kimlik zincirini (FR -> UC -> A2 -> BR) gösterir!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir otomobil fabrikasında her somunun ve her civatanın bir parça kodu (Örn: C-104) vardır. Araba arıza yaptığında tamirci 'Şu vidayı değiştir' demez; 'C-104 parçasını tak' der. Yazılımda da isimler değişkendir ama kimlikler (FR-001, UC-002, BR-004, TC-001) çelikten dökülmüş mühürlerdir! Bu mühürler sayesinde ilk müşteri talebinden en alttaki Java test koduna kadar her şey birbirine mekanik bir zincirle bağlanır.
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[In aeronautical engineering, every bolt and gasket carries a stamped serial code (e.g. PART-881). When an aircraft malfunctions, technicians don't say 'swap that little silver thing'; they reference the exact component code. In software, natural language drifts, but alphanumeric identifiers (FR-001, UC-002, BR-005, TC-003) are immutable interfaces. They bind client intent directly to automated tests with mechanical traceability.]
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
      Kararlı Kimlikler (Stable Identifiers) ve Mekanik Arayüz Mantığı: Geleneksel yazılım süreçlerinde isimlendirme kuralları (naming conventions) sadece bir 'temizlik ve düzen' (hygiene) meselesiydi. AI Unified Process'te ise bu kimlikler birer 'makine arayüzüdür' (interfaces). İnsanlar anlamı kelimelerden çıkarır; yapay zekâ araçları ise ilişkileri kimliklerle kurar. 1) Standart Kimlik Formatı: FR-XXX (Fonksiyonel Gereksinim), NFR-XXX (Fonksiyonel Olmayan), C-XXX (Kısıt), UC-XXX (Use Case), BR-XXX (İş Kuralı), TC-XXX (Test Senaryosu). 2) Yerel Numaralandırma ve Nitelikli Referans (Qualified Citation): BR numaralandırması her use case'in kendi içinde yereldir (`UC-001` dosyasında `BR-001..003`, `UC-002` dosyasında yine `BR-001..003` olabilir). Ancak bir use case dışarıdaki bir kurala atıfta bulunacaksa MUTLAKA nitelikli referans (qualified reference) vermek zorundadır: `UC-001 BR-002`. Başına use case kodu konulmayan çıplak bir `BR-002` sadece kendi dosyasının içinde geçerlidir. 3) Kesintisiz Zincir: Müşteri bir kuralı sorduğunda cevap kodun içinde aranmaz; `FR-005 -> UC-003 -> A2 -> UC-003 BR-007 -> Service.java -> Test.java` kimlik zinciri tek saniyede çıkarılır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Identifiers as Mechanical Interfaces: In legacy development, naming standards were mere aesthetic hygiene. In AIUP, identifiers are machine-parseable interfaces. While humans parse semantics from prose, LLM agent toolchains resolve relational graphs via alphanumeric coordinates. 1) Taxonomy: FR-XXX (Functional Requirement), NFR-XXX (Non-Functional), C-XXX (Constraint), UC-XXX (Use Case), BR-XXX (Business Rule), TC-XXX (Test Case). 2) Local Scope and Qualified Scoping: Business rule identifiers are local to their declaring use case (UC-001 has BR-001 through BR-003; UC-002 also starts at BR-001). Citing a rule across use case boundaries requires strict qualification: `UC-001 BR-002`. An unqualified `BR-002` is only valid within its host file. 3) Mechanical Audit Trails: When compliance audits require explaining an order rejection, the team provides an unbroken chain of identifiers: FR-005 -> UC-003 -> A2 -> UC-003 BR-007 -> code -> test. Nobody decompiles bytecode to discover business logic.]
    ]
  )
]

#java25_box[
```java
// Java 25: Kimlikleri Kod ve Test Açıklamalarında Taşıyan İzlenebilirlik
package com.maang.aiup.traceability;

/**
 * Traces to:
 * - Requirement: FR-012 (Borrow Book Flow)
 * - Use Case: UC-002 (Borrow Book)
 * - Flow: A2 (Loan Limit Reached)
 * - Rule: UC-002 BR-005 (Max 5 open loans)
 */
public class LoanLimitEnforcer {
    public static final String TRACE_RULE = "UC-002 BR-005";
    public static final int MAX_LOANS = 5;

    public static void verifyLimit(int currentLoans) {
        if (currentLoans >= MAX_LOANS) {
            // İstisna mesajı doğrudan kural kimliğini taşır!
            throw new IllegalStateException(TRACE_RULE + ": Maksimum ödünç limitine ulaşıldı.");
        }
    }

    void main() {
        try {
            verifyLimit(5);
        } catch (IllegalStateException e) {
            System.out.println("✅ Mekanik hata yakalandı: " + e.getMessage());
        }
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
      İş kurallarının metnini başka bir use case'in içine kopyalayıp yapıştırmak KESİNLİKLE YASAKTIR! Kural kopyalanırsa zamanla biri güncellenir diğeri unutulur (drift). Kuralı daima ait olduğu use case'den kimliğiyle çağırın: 'UC-002 BR-004'.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Copying and pasting business rule text across specifications is strictly forbidden. Duplicated rules inevitably drift. Always cite external rules using their qualified identifier: `UC-002 BR-004`.]
    ]
  )
]

#takeaways_box((
    ("Kimlikler (FR, UC, BR, TC) birer hijyen değil, makinenin sistemi bağladığı arayüzlerdir.", "Identifiers are not stylistic hygiene; they are mechanical interfaces connecting the chain."),
    ("BR-XXX numaraları use case içinde yereldir; dışarıdan çağrılırken nitelikli yazılır (UC-001 BR-002).", "Business rule IDs are local to a spec; cross-spec citations must be qualified (UC-001 BR-002)."),
    ("İzlenebilirlik zinciri sayesinde bir iş kuralı şartnameden koda ve teste kadar tek bakışta izlenir.", "The traceability chain allows instantaneous traversal from requirement to code and tests."),
))
