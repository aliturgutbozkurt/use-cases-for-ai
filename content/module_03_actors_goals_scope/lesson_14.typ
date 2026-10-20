#import "/template.typ": *

#show: doc => setup_book(title: "Ders 14: Üç Adımlı Adli Test: Etkileşim, Doğrulama & Dahili Durum Değişimi", doc)

#lesson_header(
  14,
  "Üç Adımlı Adli Test: Etkileşim, Doğrulama & Dahili Durum Değişimi",
  "The Three-Step Test: Interaction, Validation & Internal State Change",
  "Temel Esaslar: Aktörler, Deniz Seviyesi Hedefler & Paydaş Sözleşmeleri",
  "Core Fundamentals: Actors, Sea-Level Goals & Contracts"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 COCKBURN'ÜN 3 ADIMLI USE CASE ADLİ TESTİ                    │
└─────────────────────────────────────────────────────────────────────────────┘
  Bir use case senaryosundaki HER ADIM mutlaka şu 3 türden biri olmak ZORUNDADIR:

  TÜR 1: ETKİLEŞİM (INTERACTION)
  └──▶ İki aktör arasında bilgi veya talep aktarımı.
       Örnek: "Üye ödünç almak istediği kitabı seçer ve talepte bulunur."

  TÜR 2: DOĞRULAMA (VALIDATION)
  └──▶ Sistemin bir paydaş çıkarını korumak için yaptığı kural kontrolü.
       Örnek: "Sistem üyenin gecikmiş borcu olmadığını doğrular (BR-006)."

  TÜR 3: DURUM DEĞİŞİMİ (STATE CHANGE)
  └──▶ Sistemin kalıcı belleğinde meydana gelen iş değişikliği.
       Örnek: "Sistem ödünç kaydını 28 gün vadeli olarak veritabanına işler."

  ⚠️ ALARM: Eğer bir senaryoda HİÇ doğrulama ve durum değişimi yoksa,
            o bir use case değil; gizli bir 'Ekran Gezintisi'dir (UI Walkthrough)!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir dükkâna gidip alışveriş yapmayı düşünün: 1) Etkileşim: 'Bana şu gömleği ver' dersin (Konuşma). 2) Doğrulama: Satıcı cüzdanındaki parayı kontrol eder, sahte mi değil mi bakar (Kontrol). 3) Durum Değişimi: Parayı kasaya koyar, gömleği torbaya atar (Durum değişti!). Eğer satıcı sadece seninle sohbet edip gömleğin rengini övseydi ama ne paraya baksaydı ne de gömleği verseydi, ortada bir ticaret olmazdı! Yazılım da böyledir: Doğrulama ve durum değişimi yoksa orada gerçek bir iş yoktur!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Buying shoes involves three distinct actions: 1) Interaction: You ask the clerk for size 42. 2) Validation: The clerk inspects inventory to verify stock and checks your credit card for sufficient funds. 3) State Change: The card is charged, and the shoes are registered as sold. If the interaction consisted purely of browsing shoe colors without inventory verification or payment capture, no commercial transaction occurred. Software without validations and state changes is merely idle screen chatter.]
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
      Üç Adımlı Testin Mühendislik ve AI Açısından Önemi: Cockburn'ün en derin keşfi şudur: 'Kullanım senaryoları klavye başındaki ekran akışları değildir; paydaşlar arasındaki kontratın davranışsal koruyucusudur.' Sistem, klavye başında oturmayan paydaşların da çıkarlarını korumak zorundadır (örneğin şirketin parasını kaptırmaması, denetçinin log istemesi, veritabanının tutarlı kalması). Bir use case sadece Etkileşim adımlarından ('Kullanıcı butona tıklar, sistem ekranı açar') ibaretse, geliştiriciye ve AI'a hiçbir iş mantığı verilmemiş demektir! Doğrulamalar (Validation) yazılmazsa AI hiçbir güvenlik kontrolü ve kural motoru üretmez. Cockburn'ün vaka analizi: Bir şirket paydaş çıkarlarını ancak canlıya çıktıktan sonra listelediğinde, bu listenin ilk yıl gelen tüm 'Hata ve Değişiklik Talepleri' ile birebir aynı olduğu görüldü. AI çağında bu 1 yıllık gecikme ilk öğleden sonraya sıkışır: Yazılmayan her doğrulama, üretilmeyen bir güvenlik açığıdır!
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Cockburn's Three-Kind Step Axiom: Every sentence in a scenario must classify into one of three structural types: 1) Interaction between two actors (transmitting intent or payloads). 2) Validation protecting a stakeholder's interest ('System validates that member has no overdue loans'). 3) Internal State Change ('System records loan and decrements inventory'). The three-kind test is the supreme defense against pseudo-specifications that disguise UI navigation as functional requirements. When a spec omits validations and state mutations, an AI agent generates hollow presentation mockups devoid of transactional integrity. Cockburn demonstrated that omitted stakeholder interests accurately forecast a system's entire first-year change request backlog. In the AI era, this backlog manifests instantly on day one.]
    ]
  )
]

#java25_box[
```java
// Java 25: Üç Adımlı Testin Mimarideki Birebir Karşılığı
package com.maang.aiup.stepkinds;

public class ThreeStepTestService {
    // Domain State
    public record BookCopy(String id, boolean isAvailable) {}
    public record LoanRecord(String loanId, String memberId, String copyId, java.time.LocalDate dueDate) {}

    public LoanRecord executeBorrowProcess(String memberId, BookCopy copy) {
        // TÜR 1: Etkileşim (Girdi parametreleri olarak geldi: memberId ve copy)

        // TÜR 2: DOĞRULAMA (Validation - Stakeholder Interest)
        if (!copy.isAvailable()) {
            throw new IllegalStateException("BR-004: Kitap kopyası ödünç verilebilir durumda değil!");
        }

        // TÜR 3: DURUM DEĞİŞİMİ (Internal State Change)
        var updatedCopy = new BookCopy(copy.id(), false); // Stok azaldı
        var loan = new LoanRecord("L-99", memberId, updatedCopy.id(), java.time.LocalDate.now().plusDays(28));

        System.out.println("✅ 3 Adımlı Test Tamamlandı: " + loan);
        return loan;
    }

    void main() {
        var service = new ThreeStepTestService();
        service.executeBorrowProcess("MEM-1", new BookCopy("CPY-1", true));
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
      Bir use case adımı 'Kullanıcı Kaydet butonuna basar' dedikten hemen sonra 'Sistem kullanıcıya ana sayfayı gösterir' diyorsa DURUN! Aradaki doğrulama ve veri tabanına kayıt (durum değişimi) adımları unutulmuştur. AI bu adımları görmezse hiçbir şey kaydetmeyen bomboş bir sayfa üretir!
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[If a step states 'User clicks Submit' followed immediately by 'System displays Success screen', HALT! The validation step and the state mutation step were completely omitted. The AI will generate a hollow screen transition that persists nothing.]
    ]
  )
]

#takeaways_box((
    ("Her senaryo adımı 3 türden biri olmalıdır: Etkileşim, Doğrulama veya Durum Değişimi.", "Every step must strictly be an Interaction, a Validation, or an Internal State Change."),
    ("Sadece etkileşim içeren senaryolar use case değildir; ekran gezintisidir ve iş kurallarını kaybeder.", "Specs containing only interactions are UI walkthroughs that forfeit all business rules."),
    ("Yazılmayan her doğrulama adımı, yapay zekanın üretmeyi unuttuğu bir güvenlik zafiyetidir.", "Every unstated validation step becomes a vulnerability omitted by the AI generator."),
))
