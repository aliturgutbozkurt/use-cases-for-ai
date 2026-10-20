#import "/template.typ": *

#show: doc => setup_book(title: "Ders 7: Üç Okuyucu Modeli: Paydaş Doğrular, Mühendis İnceler, AI Üretir", doc)

#lesson_header(
  7,
  "Üç Okuyucu Modeli: Paydaş Doğrular, Mühendis İnceler, AI Üretir",
  "The Three Readers: Stakeholder Validates, Engineer Reviews, AI Generates",
  "Üç Okuyucu Modeli & Yapay Zekâ Çağının 5 Temel İlkesi",
  "The Three Readers & The 5 AI-Era Principles"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 USE CASE'İN ÜÇ OKUYUCUSU VE OKUMA ŞEKİLLERİ                 │
└─────────────────────────────────────────────────────────────────────────────┘
  OKUYUCU 1: PAYDAŞ (STAKEHOLDER)
  - Ne İçin Okur? "İstediğim şey bu mu? Teslim edildiğinde anlayabilecek miyim?"
  - Nasıl Okur?   Hızlıca göz gezdirir (Skim). Hikayeye, isimlere, mutlu yola bakar. Çabuk sıkılır!

  OKUYUCU 2: YAZILIM MÜHENDİSİ (SOFTWARE ENGINEER)
  - Ne İçin Okur? "Bu inşa edilebilir mi? Üretilen kod ve testler bu şartnameye uyuyor mu?"
  - Nasıl Okur?   Satır satır inceler (Review). Akışları kod ve testlerle çapraz doğrular.

  OKUYUCU 3: YAPAY ZEKÂ AJANI (AI AGENT)
  - Ne İçin Okur? "Ben tam olarak ne üreteceğim?"
  - Nasıl Okur?   Harfi harfine ve eksiksizce (Literally & Exhaustively). Asla sıkılmaz,
                  tüm referansları takip eder ve 'ne demek istediniz' diye ASLA sormaz!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir restoran düşünün: 1) Müşteri (Paydaş) menüye bakar, resimleri ve yemek isimlerini hızlıca süzer, lezzetli görünüyorsa 'Bunu istiyorum' der. 2) Restoran Müdürü (Mühendis) menüye bakar; 'Mutfakta malzeme var mı, maliyet kurtarır mı, hijyen kurallarına uygun mu?' diye kontrol eder. 3) Mutfaktaki Robot Aşçı (AI) ise tarifi harfi harfine okur: '1 gram tuz, 200 derece fırın'. Robot aşçı müşterinin gözünün içine bakıp 'Tuzlu mu seversin?' diye sormaz; tarifte ne yazıyorsa milimetrik olarak tabağa koyar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Consider a restaurant menu: 1) The Customer (Stakeholder) skims the pictures and dish names. If it looks appetizing, they order. They have zero patience for ingredient chemical formulas. 2) The General Manager (Engineer) reviews the menu to confirm inventory feasibility and safety regulations. 3) The Robotic Cook (AI Agent) parses the recipe exhaustively down to the milligram. The robot cook will never look up from the stove to ask if you prefer extra garlic; it executes the written text with uncompromising literalism.]
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
      Klasik yazılım mühendisliğinde kullanım senaryolarının yalnızca iki okuyucusu vardı: Doğrulayan iş birimi (business) ve kodu yazan insan geliştirici (developer). Cockburn'ün en önemli kuralı 'okunabilirlik' (readability) idi: 'Okunabilirliği feda ederseniz paydaşlarınız use case okumayı bırakır.' AI Unified Process üçüncü bir okuyucuyu sahneye çıkardı: AI Kodlama Ajanı. Ancak yapılan en ölümcül hata, 'Madem AI okuyor, öyleyse use case'i prompt mühendisliğine çevirelim, JSON veya pseudo-code yazalım' yanılgısıdır. Bir use case pseudo-code haline getirilirse paydaş onu okumadan imzalar; okunmadan imzalanan bir şartname ise kontrat olmaktan çıkar! Çözüm: İnsan için okunabilir olan kuralların (etken çatı, net özneler, tekil adımlar) aynı zamanda AI için de en az belirsizlik içeren format olduğunu anlamaktır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Historically, use cases served a dual audience: the business stakeholder who verified functional intent, and the software engineer who transcribed it into code. Cockburn made readability the supreme heuristic: an unreadable spec is abandoned by its business sponsors. The AI Unified Process introduces a third constituent: the autonomous AI agent. A catastrophic misconception is attempting to optimize the specification format exclusively for the machine via pseudo-code or prompt-engineering templates. Doing so alienates stakeholders, who sign off unread, turning the contract into fiction. Crucially, syntactic clarity (active voice, explicit subjects, named validation rules) satisfies both human skimming and machine parsing without compromise.]
    ]
  )
]

#java25_box[
```java
// Java 25: Üç Okuyucunun Ortak Dili Olan 'Clean Use Case Interactor'
package com.maang.aiup.readers;

public class CancelSubscriptionUseCase {
    // 1. Paydaşın anladığı iş modeli (Gözlemlenebilir Niyet)
    public record CancellationRequest(String memberId, String reason, boolean immediate) {}
    public record CancellationSummary(String memberId, boolean isTerminated, String refundStatus) {}

    // 2. Mühendisin denetlediği mimari kontrat
    public interface SubscriptionRepository {
        boolean hasActiveSubscription(String memberId);
        void recordCancellation(String memberId, String reason);
    }

    // 3. AI'ın doğrudan ürettiği ve test ettiği icra sınıfı
    public static class CancelSubscriptionInteractor {
        private final SubscriptionRepository repository;

        public CancelSubscriptionInteractor(SubscriptionRepository repository) {
            this.repository = repository;
        }

        public CancellationSummary execute(CancellationRequest request) {
            // Step 2: System validates active subscription exists (BR-014)
            if (!repository.hasActiveSubscription(request.memberId())) {
                throw new IllegalStateException("BR-014: İptal edilecek aktif abonelik bulunamadı.");
            }
            // Step 3: System records cancellation and calculates refund
            repository.recordCancellation(request.memberId(), request.reason());
            String refund = request.immediate() ? "REFUND_PRORATED" : "NO_REFUND_ACTIVE_UNTIL_CYCLE_END";

            return new CancellationSummary(request.memberId(), true, refund);
        }
    }

    void main() {
        System.out.println("Üç okuyucunun niyetini taşıyan Clean Use Case hazır.");
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
      Use case'i yapay zekaya hitap edeceğim diye Python/Java benzeri sözde kodlarla (pseudo-code) yazmayın! Bir dökümanı paydaş (iş analisti, ürün yöneticisi) okuyup gözüyle doğrulayamıyorsa, o döküman bir şartname değil teknik çöplüktür.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never degrade use cases into pseudo-code or machine-syntax prompts. If a business stakeholder cannot skim the narrative and validate whether it solves their problem, the contract is severed and the governance model collapses.]
    ]
  )
]

#takeaways_box((
    ("Use case'in 3 okuyucusu vardır: Paydaş doğrular, Mühendis inceler, AI ise doğrudan kod ve test üretir.", "A use case has three readers: Stakeholder validates, Engineer reviews, AI generates."),
    ("Okunabilirlik her zaman ilk şarttır; makine için insanı devre dışı bırakan döküman şartname vasfını yitirir.", "Readability remains paramount; a spec that humans cannot validate is no longer a contract."),
    ("İyi yazılmış bir senaryo hem meşgul bir paydaşı hem de harfi harfine çalışan AI'ı aynı anda tatmin eder.", "A disciplined, active-voice spec satisfies both the busy human stakeholder and the literal AI agent."),
))
