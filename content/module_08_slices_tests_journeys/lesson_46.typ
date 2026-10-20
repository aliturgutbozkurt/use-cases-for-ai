#import "/template.typ": *

#show: doc => setup_book(title: "Ders 46: Test Senaryoları (TC-XXX): Use Case'leri Birbirine Bağlayan Uçtan Uca Yolculuklar", doc)

#lesson_header(
  46,
  "Test Senaryoları (TC-XXX): Use Case'leri Birbirine Bağlayan Uçtan Uca Yolculuklar",
  "Test Cases (TC-XXX): End-to-End Journeys Chaining Multiple Use Cases",
  "Dilimler (Slices), Testler ve İterasyon Döngüsü",
  "Slices, Tests, and the Iteration Loop"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 TC-XXX: UÇTAN UCA İŞ YOLCULUĞU TABLOSU                      │
└─────────────────────────────────────────────────────────────────────────────┘
  
  TC-001: Yeni Üye Olma ve İlk Kitabı Ödünç Alma Yolculuğu
  ┌───┬──────────────────────────┬───────────────────────┬──────────────────┐
  │ # │ Adım Açıklaması          │ Kullanılan Test Verisi│ İlgili Use Case  │
  ├───┼──────────────────────────┼───────────────────────┼──────────────────┤
  │ 1 │ Kullanıcı üye kaydı açar │ "bozkurt@maang.com"   │ UC-001 Register  │
  │ 2 │ E-posta onayını tamamlar │ Onay Linki / Token    │ UC-001 Register  │
  │ 3 │ Katalogda kitap arar     │ "Clean Architecture"  │ UC-003 Search    │
  │ 4 │ Kitabı ödünç alır        │ Kitap ID: "BK-101"    │ UC-002 Borrow    │
  │ 5 │ Ödünç listesini denetler │ Vade: 28 gün sonra    │ UC-004 My Loans  │
  └───┴──────────────────────────┴───────────────────────┴──────────────────┘
  
  🎯 MİMARİ İLKE:
  - Tek tek use case'ler detayları (kolonlar, hata mesajları) test eder.
  - TC-XXX ise DİKİŞ YERLERİNİ (Seams) test eder: Durumun bir use case'den
    diğer use case'e pürüzsüz aktarıldığını doğrular!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir bayrak yarışını (atletizm) düşünün: 4 farklı koşucu vardır. Her koşucu kendi 100 metresini harika koşabilir (Bireysel Use Case). Ama en kritik an, sopayı bir sonraki koşucunun eline düşürmeden vermektir (Dikiş Noktası / Seams)! TC-XXX testleri, sopanın elden ele düşmeden geçtiğini kontrol eden başhakemdir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of a 4x100m track relay race: Four runners sprint their own legs (Individual Use Cases). Each runner may run exceptionally well alone. But the most catastrophic failure happens at the baton handoff (The Seam)! A TC-XXX test case acts as the head referee, ensuring the baton passes flawlessly from runner to runner across the entire lap.]
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
      TC-XXX Uçtan Uca Yolculuk Dokümanlarının Mimarisi: Bir use case tek bir aktörün tek bir oturumda ulaştığı deniz seviyesi hedefidir (Sea-level). Ancak gerçek hayatta müşteriler ardışık birçok hedefi zincirleme icra eder: 'Kayıt Ol -> Doğrula -> Ara -> Sepete Ekle -> Öde -> Kargo Takip Et'. Cockburn'ün 'Uçurtma Seviyesi' (Kite-level) dediği bu süreçler AIUP içinde `docs/test_cases/TC-XXX-\<name>.md` dosyaları olarak formalize edilir. TC dokümanı tek bir akış tablosudur. Her satır bir adımı, o adımda kullanılan somut test verisini ve zincirlenen use case dosyasını (`UC-001`, `UC-002`) barındırır. Bu ayrım katı bir iş bölümü sağlar: 1) Use case seviyesindeki testler iç detaylara (kolonlar, validasyonlar, hata mesajları) odaklanır. 2) TC yolculuk testleri ise dikiş yerlerini (seams) denetler; yani UC-001'in oluşturduğu üye ID'sinin UC-002 tarafından hatasız şekilde tanınıp kullanılabildiğini garanti eder.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Architecture of TC-XXX End-to-End Journey Specifications: While a use case encapsulates a single sea-level user goal achieved in one sitting, business workflows span cohesive multi-step journeys (e.g., onboarding, checkout, fulfillment). Cockburn designated these 'kite-level' summary goals. In the AI Unified Process, kite-level workflows are codified as test journey artifacts in `docs/test_cases/TC-XXX-\<name>.md`. A TC document consists of a structured tabular progression where each row declares: the step description, literal input/output test data, and a hyperlink to the executed use case specification. This establishes a clean demarcation of testing concerns: individual use case specs own flow-level minutiae (validation messages, column sort orders), while journey tests own system seams—ensuring data and state flow seamlessly across use case boundaries.]
    ]
  )
]

#java25_box[
```java
// Java 25: Use Case'ler Arası Durum Aktarımını Doğrulayan Yolculuk Testi
package com.maang.aiup.journeys;

public class CrossUseCaseJourneyTest {
    // Adım 1: Kayıt Use Case Çıktısı
    public record RegisteredMember(String id, String email, boolean active) {}

    // Adım 2: Ödünç Use Case Çıktısı
    public record BorrowedReceipt(String loanId, String memberId, String bookId) {}

    public static class RegistrationService {
        public RegisteredMember register(String email) {
            return new RegisteredMember("MEM-99", email, true);
        }
    }

    public static class BorrowService {
        public BorrowedReceipt borrow(RegisteredMember member, String bookId) {
            if (!member.active()) throw new IllegalStateException("Üye aktif değil!");
            return new BorrowedReceipt("LN-1001", member.id(), bookId);
        }
    }

    void main() {
        // TC-001 Yolculuk İcrası:
        var regService = new RegistrationService();
        var borrowService = new BorrowService();

        // 1. Dikiş Noktası: Kayıt ol
        var member = regService.register("bozkurt@maang.com");
        System.out.println("TC-001 Adım 1 Başarılı: " + member);

        // 2. Dikiş Noktası: Kayıtlı üyeyi ödünç servisine geçir
        var receipt = borrowService.borrow(member, "BK-Clean-Arch");
        System.out.println("TC-001 Adım 2 Başarılı: " + receipt);

        assert receipt.memberId().equals("MEM-99") : "Dikiş hatası! Üye ID aktarılamadı.";
        System.out.println("✅ TC-001 Uçtan Uca Yolculuk Başarıyla Doğrulandı!");
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
      Yolculuk testlerinde (TC-XXX) tablo kolonlarını veya arayüz renklerini yeniden test etmeye kalkmayın! Yolculuk testinin tek görevi use case'ler arasındaki durum aktarımını sınamaktır.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never re-assert table columns or UI styling inside end-to-end journey tests. Journey tests own the seams between use cases, not internal UI presentation details.]
    ]
  )
]

#takeaways_box((
    ("TC-XXX dokümanları, birden fazla use case'i birleştiren uçtan uca yolculukları tanımlar.", "TC-XXX documents specify end-to-end user journeys that chain multiple use cases."),
    ("Yolculuk testleri 'dikiş yerlerini' (seams) denetler; durumun use case'ler arası geçişini doğrular.", "Journey tests verify system seams, ensuring state propagates across use cases flawlessly."),
    ("Her satırda somut test verisi ve tetiklenen use case referansı yer alır.", "Each journey step declares literal test data and links to the invoked use case specification."),
))
