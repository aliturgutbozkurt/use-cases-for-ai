#import "/template.typ": *

#show: doc => setup_book(title: "Ders 47: Test Verisi Disiplini: Somut Veri ('Acme Corp', '5') vs Ölümcül Yer Tutucular", doc)

#lesson_header(
  47,
  "Test Verisi Disiplini: Somut Veri ('Acme Corp', '5') vs Ölümcül Yer Tutucular",
  "Test Data Discipline: Literal Test Data vs Deadly Generic Placeholders",
  "Dilimler (Slices), Testler ve İterasyon Döngüsü",
  "Slices, Tests, and the Iteration Loop"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 SOMUT TEST VERİSİ VS ÖLÜMCÜL YER TUTUCULAR                   │
└─────────────────────────────────────────────────────────────────────────────┘
  
  ❌ ÖLÜMCÜL YER TUTUCULAR (GENERIC PLACEHOLDERS):
  - "Kullanıcı geçerli bir ad ve e-posta girer."
  - "Sistem siparişi uygun miktarda oluşturur."
  💥 AI Ne Yapar?: 'Geçerli e-posta' ne demek? 'test@test' mi, 'a@b.c' mi?
                   AI kendi kafasından veri uydurur ve test kırılganlaşır!
  
  ✅ BİREBİR SOMUT TEST VERİSİ (LITERAL TEST DATA):
  - "Kullanıcı Şirket Adı olarak 'Acme Corp', Adet olarak '5' girer."
  - "Kullanıcı e-posta olarak 'sarah.connor@cyberdyne.com' yazar."
  
  🎯 MİMARİ KURAL:
  - İnsan test mühendisi yer tutucuların etrafından doğaçlama yapabilir.
  - Kod üreten yapay zekâ DOĞAÇLAMA YAPAMAZ!
  - Bıraktığınız her yer tutucu, AI'ın ürettiği bir halüsinasyona dönüşür!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir terziye takım elbise diktireceğinizi düşünün: Terziye 'Bana uygun boyda bir pantolon dik' derseniz (Yer tutucu!), terzi boyunuzu tahmin eder ve pantolon ya dizinizde kalır ya yerde sürünür! Ama 'Bel 82 cm, paça boyu 104 cm' derseniz (Somut veri!), pantolon üstünüze tam oturur. Testte de 'geçerli veri' değil, tam santimetreleri vermelisiniz!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Imagine ordering a custom tailored suit: If you tell the tailor 'Sew me a properly sized jacket' (Generic placeholder!), they guess your dimensions and the sleeves hang down past your knees! But if you declare 'Chest 40 inches, sleeve 33 inches' (Literal data!), it fits like a glove. Automated tests cannot guess; they demand exact dimensions.]
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
      Test Verisinde Birebirlik (Literal Test Data) İlkesi: Şartname ve test dokümanlarında mühendislerin düştüğü en büyük tuzaklardan biri soyut yer tutuculardır ('geçerli bir müşteri', 'örnek bir ürün', 'uygun bir tarih'). İnsan test uzmanı bu metni okuduğunda zihninde 'John Doe', 'Laptop', '2026-05-01' gibi veriler uydurabilir. Ancak yapay zekâ destekli üretim motorları (`/test-case`) soyut kavramları rastgele doldurur. Bir çalıştırmada boşluk 'user1' ile doldurulurken diğerinde 'test\@invalid' ile doldurulabilir ve testler tutarsızlaşır (flaky tests). Martinelli'nin altın kuralı: 'Test verisi harfi harfine somut (literal) olmalıdır.' Test tablosunda müşteri adı 'Acme Corp', ürün adı 'Widget-X', miktar '5', tarih '2026-10-20' olarak açıkça yazılmalıdır. Bu sayede üretilen test kodları deterministik, tekrarlanabilir ve sıfır varsayımla çalışır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Literal Test Data Mandate: In traditional testing, human QA engineers tolerate placeholder abstractions like 'a valid customer' or 'sufficient balance' because human intuition bridges the gap with impromptu mock values. Generative AI agents possess no such intuition. When presented with placeholder phrasing, an AI implementer invents arbitrary mock data—varying between runs, introducing edge-case boundary mutations, and creating flaky test suites. Martinelli insists upon literalism: 'Acme Corp, Widget, 5, never a valid customer.' Specifying explicit string literals, deterministic integers, and concrete RFC-compliant dates ensures that generated unit and integration tests compile with identical, deterministic assertions across every single regeneration cycle.]
    ]
  )
]

#java25_box[
```java
// Java 25: Deterministik Somut Test Verisi ile Güvenli Test İcrası
package com.maang.aiup.testdata;

public class LiteralTestDataDemo {
    // ❌ YANLIŞ: Soyut yer tutucu (AI kafasına göre mock nesnesi üretir)
    // var customer = createAnyValidCustomer();

    // ✅ DOĞRU: Birebir Somut Veri (Literal Test Data)
    public record CustomerOrder(String companyName, String productSku, int quantity) {}

    public static class OrderProcessor {
        public static boolean process(CustomerOrder order) {
            return "Acme Corp".equals(order.companyName()) 
                && "WDG-99".equals(order.productSku()) 
                && order.quantity() == 5;
        }
    }

    void main() {
        // Harfi harfine şartnamedeki somut veri:
        var order = new CustomerOrder("Acme Corp", "WDG-99", 5);
        boolean success = OrderProcessor.process(order);

        assert success : "Somut veri doğrulaması başarısız!";
        System.out.println("✅ Somut veriyle çalışan deterministik test başarıyla geçti: " + order);
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
      Test senaryolarında asla 'geçerli bir kullanıcı adı' veya 'yeterli bakiye' gibi soyut tabirler yazmayın; her veriyi 'sarah.connor' ve '500.00 TL' şeklinde harfi harfine yazın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never write abstract descriptors like 'a valid user' or 'an active subscription'. Specify literal values ('sarah.connor', '\$500.00') to guarantee deterministic tests.]
    ]
  )
]

#takeaways_box((
    ("Test senaryolarındaki veriler harfi harfine somut olmalıdır ('Acme Corp', '5 adet').", "Test data must be strictly literal ('Acme Corp', '5 items') with zero placeholders."),
    ("Yer tutucular ('geçerli müşteri') AI'ın kafasına göre veri uydurmasına ve testlerin bozulmasına yol açar.", "Placeholders cause AI to improvise test values, introducing flaky and non-reproducible tests."),
    ("Deterministik test verisi, şartnameden üretilen kodun her çalıştırmada aynı sonucu vermesini sağlar.", "Deterministic test fixtures guarantee identical outcomes across all code regenerations."),
))
