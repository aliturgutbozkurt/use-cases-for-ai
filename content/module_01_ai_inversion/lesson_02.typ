#import "/template.typ": *

#show: doc => setup_book(title: "Ders 2: Koridor Sohbeti Öldü: İletişim Boşluklarının ve AI Halüsinasyonunun Gerçek Maliyeti", doc)

#lesson_header(
  2,
  "Koridor Sohbeti Öldü: İletişim Boşluklarının ve AI Halüsinasyonunun Gerçek Maliyeti",
  "The Hallway Conversation is Dead: The True Cost of Code Hallucination",
  "Büyük Tersine Dönüş (The Inversion) & AI Çağında Use Case Rönesansı",
  "The AI Inversion & Why Use Cases Rule the GenAI Era"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 İLETİŞİM KANALLARININ KOPUŞU VE AI HALÜSİNASYONU            │
└─────────────────────────────────────────────────────────────────────────────┘
  ESKİ SİSTEM:
  Eksik Şartname ──▶ İnsan Geliştirici ──▶ "Şurada ne demek istediniz?" (Kahve Molası)
                            ▲                            │
                            └──── Netleştirme Yapılır ───┘ (Sıfır Hata!)

  AI ÇAĞI:
  Eksik Şartname ──▶ AI Kod Ajanı ──▶ Soru Yok! Tahmin Et! ──▶ Yanlış Kod Üretildi!
                                                                      │
  Canlı Ortama Sızar ◀── Test / Review Gözden Kaçırırsa ──────────────┘
  (Maliyet: 10 dakikalık sohbet yerine 2 haftalık prod kriz analizi!)
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Eski iş yerlerinde stajyer bir çocuğa 'Müşterilere indirim yap' dediğinde, çocuk masana gelip 'Abi kime yüzde kaç indirim yapacağız?' diye sorardı. Yapay zekâ ise soru sormayan, aşırı özgüvenli bir robottur. Ona 'indirim yap' dersen, kafasına göre şirketin en pahalı ürününü herkese %90 indirimle satar ve sana 'İndirim yaptım, harika oldu!' diye gülümser. Soru soracak insan kalmadığı için kuralları en baştan taşa kazımak zorundasın!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[In a traditional office, if you told an apprentice engineer to 'discount the shopping cart', they would walk to your desk and clarify the percentage rules. An AI coding agent is a hyper-confident worker that never asks questions. Tell it to 'discount carts', and it might quietly slash prices by 90% across the entire inventory, presenting the pull request with a cheerful smile. Because hallway questions are gone, precision must be baked into the spec upfront.]
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
      Geleneksel yazılım süreçlerinde 'Eksik Belgeleme' (Under-specification) bir felaket değildi çünkü organizasyonun içinde 'Sosyal Netleştirme Ağı' (Social Disambiguation Network) vardı: Slack mesajları, stand-up toplantıları ve koridor sohbetleri. Bir junior mühendis şartnamede bir çelişki gördüğünde işi durdurup sorardı; bu soru ücretsiz bir 'belirsizlik dedektörü' görevi görürdü. AI ajanları (Claude, Copilot, Antigravity) ise bu dedektörü tamamen yok etti. Bir ajan, boş bırakılan her alanı istatistiksel ağırlıklarına göre en mantıklı gelen kod parçasıyla tamamlar. Martinelli'nin belirttiği gibi: Eskiden belirsizliğin maliyeti 5 dakikalık bir sohbetti; bugün ise canlıya çıkan ve haftalarca fark edilmeyen sessiz veri bozulmalarıdır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[In classical workflows, under-specification was buffered by organizational social networks: hallway chats, quick Slack pings, and standup debates. An observant human developer served as a free ambiguity detector: encountering an unhandled edge case, they halted execution and sought clarification. LLM-based agents eradicate this feedback loop. They suffer from zero hesitation, synthesizing plausible implementations across unstated boundaries. The cost of ambiguity has migrated from a 5-minute conversation to production data corruption that escapes unnoticed until an audit.]
    ]
  )
]

#java25_box[
```java
// Java 25: Boşluk Bırakmayan Domain Doğrulama Mekanizması
package com.maang.aiup.discount;

import java.math.BigDecimal;

public class DiscountPolicy {
    // İş Kuralı BR-001: İndirim sadece VIP üyelere ve maksimum %20 uygulanabilir.
    public record DiscountRequest(String customerTier, BigDecimal cartTotal, BigDecimal requestedDiscountPercent) {}

    public record ValidatedDiscount(BigDecimal finalDiscountAmount, String appliedRule) {}

    // AI'ın kafasına göre indirim uydurmasını engelleyen deterministik kural motoru
    public static ValidatedDiscount calculate(DiscountRequest req) {
        if (!"VIP".equalsIgnoreCase(req.customerTier())) {
            return new ValidatedDiscount(BigDecimal.ZERO, "BR-001: Standart üyelere indirim uygulanamaz.");
        }
        // AI'ın %90 yapmasını engelleyen sınır
        BigDecimal maxAllowed = new BigDecimal("20.00");
        BigDecimal effectivePercent = req.requestedDiscountPercent().min(maxAllowed);
        BigDecimal discount = req.cartTotal().multiply(effectivePercent).divide(new BigDecimal("100"));

        return new ValidatedDiscount(discount, "BR-001: VIP indirimi başarıyla hesaplandı.");
    }

    void main() {
        var req = new DiscountRequest("VIP", new BigDecimal("1000.00"), new BigDecimal("35.00"));
        var result = calculate(req);
        System.out.println("Sonuç: " + result);
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
      AI ile çalışırken 'Sistem kullanıcıyı uygun şekilde bilgilendirir' veya 'Gereken indirim yapılır' gibi yuvarlak cümleler kurmayın! 'Uygun şekilde' kelimesi, sistemin mimarisini ve kurallarını tamamen yapay zekanın hayal gücüne terk etmek demektir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never write vague requirements like 'system notifies user appropriately' or 'applies a reasonable discount'. The phrase 'appropriately' delegates total architectural authority to an algorithm that cannot feel business consequences.]
    ]
  )
]

#takeaways_box((
    ("İnsan geliştiricilerin sorduğu netleştirme soruları ücretsiz bir belirsizlik dedektörüydü; AI bu dedektörü yok etti.", "Human clarifying questions were free ambiguity detectors; AI agents completely eliminate them."),
    ("Belirsizlik artık bir soru olarak geri dönmez; yanlış ve sessizce çalışan bir kod olarak canlıya sızar.", "Ambiguity no longer surfaces as a question; it manifests as silent production bugs."),
    ("Tüm iş kuralları ve limitler şartnamede sayısal ve net olarak tanımlanmalıdır.", "All business invariants and limits must be specified with numerical precision in the spec."),
))
