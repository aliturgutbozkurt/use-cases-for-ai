#import "/template.typ": *

#show: doc => setup_book(title: "Ders 3: Determinizm Yanılgısı: Mükemmel Şartname Diye Bir Şey Yoktur ve Gerek de Yoktur!", doc)

#lesson_header(
  3,
  "Determinizm Yanılgısı: Mükemmel Şartname Diye Bir Şey Yoktur ve Gerek de Yoktur!",
  "The Determinism Fallacy: Why Perfect Specs Don't Exist and Aren't Needed",
  "Büyük Tersine Dönüş (The Inversion) & AI Çağında Use Case Rönesansı",
  "The AI Inversion & Why Use Cases Rule the GenAI Era"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 DETERMİNİZM YANILGISI VS KISA DÖNGÜLÜ DÜZELTME              │
└─────────────────────────────────────────────────────────────────────────────┘
  YANILGI (Şelale Kafası):
  [ 500 Sayfalık Kusursuz Şartname ] ──▶ [ AI Tek Seferde Hatasız Kod Üretir ]
  💥 İMKÂNSIZ! İnsan beyni yazılımın tüm durum uzayını tek seferde kusursuz yazamaz.

  GERÇEKLİK (AI Unified Process Çözümü):
  ┌──▶ [ Niyet & Sınırlar (Deniz Seviyesi Use Case) ]
  │            │
  │            ▼
  │    [ AI Kod ve Test Üretir ]
  │            │
  │            ▼
  │    [ Testler Koşar + İnsan İnceler ]
  │            │
  └──── [ Şartname Netleşir & Kod Güçlenir ] ◀── Kısa Döngülerle Evrim!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bazı insanlar 'Yapay zekanın doğru kod yazması için 10.000 sayfalık kusursuz bir kural kitabı yazmalıyız, bu da imkansız, demek ki AI bir işe yaramaz!' der. Bu şuna benzer: 'Bir şoföre gideceği yeri anlatmak için yoldaki her taşın yerini tarif edemem, o halde taksiye binmeyeyim!' Hayır! Şoföre sadece 'Kadıköy rıhtıma git, sahilden sür' dersin (sınırlar). Yanlış sokağa girerse 'Sağa dön' dersin (kısa döngülü test). Mükemmel tarif gerekmez; net hedef ve anında düzeltme yeterlidir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Skeptics argue: 'AI generation only works if the spec is 100% mathematically complete to force deterministic code. Perfect specs are impossible, therefore AI coding is a failure.' This is like refusing to take a taxi because you cannot describe the molecular coordinates of every pebble on the highway. You don't need a perfect spec; you need clear boundary constraints and rapid automated tests that catch deviations within seconds.]
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
      Determinizm Yanılgısı (The Determinism Fallacy): Birçok mühendis, AI güdümlü yazılım geliştirmenin ancak 'tamamen deterministik ve sıfır boşluklu' devasa spesifikasyonlarla mümkün olabileceğini savunarak yöntemi baştan reddeder. Cockburn ve Martinelli bu tezi çürütür: 1) İlk taslak değerin %50'sini üretir; kelimeler üzerinde sonsuza kadar oynamak iletişimi artırmaz. 2) Amaç deterministik bir robot yaratmak değil, 'her okuyucunun (insan paydaş, mühendis ve AI) aynı niyeti anladığı' bir zemin kurmaktır. 3) Kalite, tek seferlik kusursuz yazımda değil; Şartname -> Üretim -> Test Doğrulaması -> Paydaş İncelemesi döngüsünün dakikalar içinde tekrarlanabilmesinde saklıdır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Determinism Fallacy deconstructed: The objection states that generative AI requires airtight, mathematically exhaustive specifications to prevent non-deterministic code branching. Because perfect specifications are impossible in human language, the approach is deemed unviable. Martinelli refutes this: the AI Unified Process never demands exhaustive determinism. It requires precision strictly about observable behavior, backed by immutable test assertions. Quality is achieved not through monolithic upfront perfection, but through hyper-short feedback loops: specify intent, generate, verify with unit/slice tests, refine.]
    ]
  )
]

#java25_box[
```java
// Java 25: Kısa Döngülü Test Doğrulaması ile Niyet Denetimi (Test-Protected)
package com.maang.aiup.verification;

public class OrderValidationEngine {
    public record OrderItem(String sku, int quantity, double unitPrice) {}
    public record Order(String orderId, java.util.List<OrderItem> items) {}

    // Kural BR-010: Bir siparişte en fazla 10 adet ürün olabilir ve toplam tutar pozitif olmalıdır.
    public static boolean validateOrder(Order order) {
        if (order.items() == null || order.items().isEmpty()) return false;
        int totalQty = order.items().stream().mapToInt(OrderItem::quantity).sum();
        if (totalQty > 10) return false;
        double total = order.items().stream().mapToDouble(i -> i.quantity() * i.unitPrice()).sum();
        return total > 0.0;
    }

    void main() {
        // Hızlı doğrulama testi (Determinizmi koruyan emniyet kemeri)
        var validOrder = new Order("ORD-1", java.util.List.of(new OrderItem("BOOK-1", 2, 25.0)));
        var invalidOrder = new Order("ORD-2", java.util.List.of(new OrderItem("BOOK-2", 15, 10.0)));

        assert validateOrder(validOrder) : "Geçerli sipariş onaylanmalıydı!";
        assert !validateOrder(invalidOrder) : "10 adetten fazla ürün reddedilmeliydi!";

        System.out.println("✅ Determinizm testlerle koruma altına alındı!");
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
      Şartnameyi kusursuzlaştırmak için haftalarca toplantı yapıp tek satır kod üretmemek (Analysis Paralysis) şelale modeline geri dönüştür. İlk gün deniz seviyesi taslağı çıkarın, AI'a ürettirin ve test sonuçlarına bakarak şartnameyi rafine edin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Spending weeks polishing a specification without running an AI generation pass is a regression into the waterfall trap. Draft the sea-level spec in hours, run `/implement`, inspect the generated test suite, and iterate.]
    ]
  )
]

#takeaways_box((
    ("Mükemmel şartname imkânsızdır ve gerekli de değildir; önemli olan şey gözlemlenebilir davranışın netliğidir.", "Perfect specifications are impossible and unnecessary; observable clarity is what matters."),
    ("Determinizm tek seferlik yazımla değil, testlerle korunan kısa çevrimli geri bildirim döngüleriyle sağlanır.", "Determinism is enforced by automated test harnesses in rapid iterative loops."),
    ("Şartname niyetin sınırlarını çizer, AI bu sınırlar içinde kodu doldurur, testler ise sınır ihlalini yakalar.", "The spec sets the boundaries, AI implements inside them, and tests catch boundary violations."),
))
