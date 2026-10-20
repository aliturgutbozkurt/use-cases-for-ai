#import "/template.typ": *

#show: doc => setup_book(title: "Ders 1: Büyük Tersine Dönüş (The Inversion): Kod Ucuzladı, İfade Edilmiş Niyet Kıymete Bindi", doc)

#lesson_header(
  1,
  "Büyük Tersine Dönüş (The Inversion): Kod Ucuzladı, İfade Edilmiş Niyet Kıymete Bindi",
  "The Great Inversion: Implementation is Cheap, Intent is Scarce",
  "Büyük Tersine Dönüş (The Inversion) & AI Çağında Use Case Rönesansı",
  "The AI Inversion & Why Use Cases Rule the GenAI Era"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 YAZILIM EKONOMİSİNDE BÜYÜK KIRILMA (THE INVERSION)          │
└─────────────────────────────────────────────────────────────────────────────┘
  1. GELENEKSEL DÜNYA (1970 - 2022):
     [ Niyet / Spesifikasyon: UCUZ LAF ] ──▶ [ Kodlama: ÇOK PAHALI, YAVAŞ, KIT ]
     * Geliştiriciler koridor sohbetlerinde boşlukları sezgileriyle doldururdu.
     * "Kod tek gerçektir" (Code is the truth) demek bir sinizm değil, ekonomik zorunluluktu.

  2. ÜRETKEN YAPAY ZEKA ÇAĞI (2023 - 2026+):
     [ Niyet / Spesifikasyon: KIT & PAHA BİÇİLMEZ ] ──▶ [ Kodlama: UCUZ, IŞIK HIZINDA ]
     * Kod artık bir kaynak değil; derleyici çıktısı gibi üretilip atılabilen bir ara üründür!
     * AI her niyet boşluğunu kendi uydurduğu (halüsinasyon) sahte bir özellikle doldurur!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Eskiden bir heykeltıraşa mermerden heykel yaptırmak aylar sürerdi ve çok pahalıydı; ona kabataslak 'Güzel bir at yap' desen bile adam oturup günlerce yontar, eksikleri zanaatiyle tamamlardı. Bugün ise elinde saniyede 10.000 heykel basabilen sihirli bir 3D yazıcı (Yapay Zekâ) var! Ama yazıcıya sadece 'at yap' dersen, sana kanatlı, 6 bacaklı, yeşil bir canavar basar ve 'Sen tam olarak ne istediğini söylemedin ki!' der. Artık heykel yontmak bedava; paha biçilmez olan şey heykelin milimetrik çizimidir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Historically, commissioning a stone sculptor was exorbitant and slow. If you gave vague instructions like 'carve a horse', the master craftsman filled the gaps with personal aesthetic judgment. Today, generative AI is a hyper-speed 3D printer that manufactures statues in 3 seconds for pennies. But if you lack precise blueprints, the printer invents a 6-legged neon unicorn and presents it with total confidence. Carving stone is now free; the rare, precious asset is the architectural blueprint of your intent.]
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
      Simon Martinelli'nin 'Writing Use Cases for AI' kitabında ortaya koyduğu 'The Inversion' tezi: Yazılım tarihi boyunca kod yazmak (implementation) pahalı, şartname hazırlamak (specification) ucuz bir formaliteydi. Ekipler eksik şartname yazmayı göze alabiliyordu çünkü kıdemli mühendisler eksik iş kurallarını kahve molalarında paydaşlarla konuşup sezgileriyle kapatıyordu. LLM'lerin (Claude Code, Cursor, Antigravity) gelmesiyle denklem tersyüz oldu. Yapay zekâ ajanı belirsiz bir prompt aldığında soru sormaz; boşluğu en olası gördüğü varsayımla sessizce doldurur. Sonuç: İlk bakışta çalışan ama asla sürdürülemeyen, yeniden üretilemeyen (regenerate edilemeyen) 'vibe coding spagettisi'. Çözüm: Şartnameyi birincil varlık (asset), kodu ise derlenebilir bir çıktı (output) kabul etmektir.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The core thesis of 'The Inversion': Throughout software engineering history, implementation was bottlenecked by expensive human labor, while specifications were treated as disposable scaffolding. Teams could afford under-specification because human engineers exercised contextual judgment during hallway discussions. Generative AI fundamentally inverts this economic equation: code generation is near-zero marginal cost, deterministic, and instantaneous. What is scarce is expressed, testable intent. When prompted with ambiguous requirements, an AI agent does not pause to ask for clarification; it hallucinates a plausible feature set that compiles but diverges from business reality.]
    ]
  )
]

#java25_box[
```java
// Java 25: Niyetin Açıkça Belirtildiği Use Case Arayüzü (Contract First)
package com.maang.aiup.banking;

public class LoanApplicationUseCase {
    // Niyet: Tam ve kesin girdi modeli (Records ile değişmezlik)
    public record ApplyLoanCommand(String memberId, double amountUsd, int durationMonths) {
        public ApplyLoanCommand {
            if (amountUsd <= 0) throw new IllegalArgumentException("Kredi tutarı pozitif olmalıdır.");
            if (durationMonths < 1 || durationMonths > 60) throw new IllegalArgumentException("Vade 1-60 ay arasında olmalıdır.");
        }
    }

    public record LoanDecision(boolean approved, String loanId, double interestRate, String rejectionReason) {}

    // Sistem Sözleşmesi: AI'ın kafasına göre kural uydurmasını engelleyen kesin metod
    public interface LoanService {
        LoanDecision applyForLoan(ApplyLoanCommand command);
    }

    void main() {
        var cmd = new ApplyLoanCommand("MEM-8921", 50000.0, 24);
        System.out.println("Niyet açıkça modellendi: " + cmd);
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
      Vibe coding tuzağı: Prompt ile hızlıca ayağa kaldırılan kodlar ilk 2 gün harika görünür; ancak 3. hafta bir iş kuralı değiştiğinde kodun neden öyle yazıldığını kimse bilemez ve yeniden üretilemez. Şartnamesiz üretilen kod teknik borç değil, teknik iflastır!
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[The Vibe Coding Trap: Generating software from loose prompts produces code that works on day one but is unmaintainable by day ten. Without a versioned specification, the business intent lives only in ephemeral chat history, rendering automated regeneration impossible.]
    ]
  )
]

#takeaways_box((
    ("Kodlama artık ucuz ve tekrarlanabilir bir emtiadır; asıl kıymetli varlık açıkça ifade edilmiş niyettir.", "Implementation is now a cheap commodity; precisely expressed intent is the primary asset."),
    ("AI belirsizlik gördüğünde durup soru sormaz; boşluğu uydurma (halüsinasyon) özelliklerle doldurur.", "AI never pauses at ambiguities; it fills gaps with plausible hallucinations."),
    ("AI Unified Process'te şartname ana varlıktır, kod ise onun derlenebilir bir çıktısıdır.", "In AIUP, the specification is the asset, and code is merely its generated output."),
))
