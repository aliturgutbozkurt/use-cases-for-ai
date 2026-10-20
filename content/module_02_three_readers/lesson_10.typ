#import "/template.typ": *

#show: doc => setup_book(title: "Ders 10: AI-Çağı İlkesi 12: Okuyucu Hiyerarşisi (Paydaş > Mühendis > Yapay Zekâ)", doc)

#lesson_header(
  10,
  "AI-Çağı İlkesi 12: Okuyucu Hiyerarşisi (Paydaş > Mühendis > Yapay Zekâ)",
  "AI-Era Principle 12: Reader Hierarchy (Stakeholder > Engineer > AI)",
  "Üç Okuyucu Modeli & Yapay Zekâ Çağının 5 Temel İlkesi",
  "The Three Readers & The 5 AI-Era Principles"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 İLKE 12: KATI OKUYUCU HİYERARŞİSİ PİRAMİDİ                  │
└─────────────────────────────────────────────────────────────────────────────┘
                     ▲
                    / \
                   / 1 \   PAYDAŞ (STAKEHOLDER)
                  /─────\  * Doğrulayamazsa şartname ÇÖPTÜR!
                 /   2   \ YAZILIM MÜHENDİSİ (SOFTWARE ENGINEER)
                /─────────\* Kodun doğruluğunu denetleyemezse sistem ÇÖKER!
               /     3     \ YAPAY ZEKÂ AJANI (AI AGENT)
              /─────────────\* Harfi harfine üretir (En alttaki işçidir!)

  KURAL: Bir use case ASLA yapay zekayı memnun etmek için paydaşın
         anlayamayacağı bir formata (JSON, pseudo-code) indirgenemez!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir şirkette patron (Paydaş), başmimar (Mühendis) ve inşaat robotu (AI) vardır. Şirketin yeni binasının planı çizilirken kime göre çizilir? Elbette patrona ve mimara göre! Eğer robot daha rahat anlasın diye mimari planı '010101' şeklinde ikili bilgisayar kodlarıyla yazarsan, patron 'Ben bu binayı istemedim ki!' diyemez bile. İlk önce patron anlayacak, sonra mimar onaylayacak, en son robot tuğlayı koyacak!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[In a corporate hierarchy, you have the Executive (Stakeholder), the Chief Architect (Engineer), and the Construction Drone (AI Agent). If you draft building blueprints in raw assembly bytecode so the drone can ingest them faster, the executive cannot verify whether the building has enough emergency exits. The blueprint must first be legible to the owner, verifiable by the engineer, and only then parsed by the drone.]
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
      İlke 12: Üç okuyucu için şu katı öncelik sırasıyla yaz: 1) Paydaş, 2) Mühendis, 3) Yapay Zekâ. Martinelli'nin uyarısı: Eğer bir paydaş şartnameyi okuyup doğrulayamıyorsa, o şartnamenin taşıdığı teknik hassasiyet tamamen değersizdir. Eğer bir mühendis o şartnameye bakarak üretilen kodun doğruluğunu teyit edemiyorsa, sistemin güvenliği sıfırdır. Ancak ilk iki okuyucu tatmin edildikten sonra yapay zekanın tüketebilirliği (AI-consumability) önem kazanır. Harika olan gerçek şudur: İlk iki okuyucuya mükemmel hizmet eden bir use case (etken çatı, açık aktör isimleri, 'kontrol eder' yerine 'doğrular', numaralı adımlar), neredeyse otomatik olarak üçüncü okuyucuya (AI) da kusursuz hizmet eder. Bu yüzden okuyucular arasında bir ödünleşim (trade-off) hissettiğinizde, neredeyse kesinlikle gereksiz bir uygulama detayına (implementation mechanism) sapmışsınız demektir!
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Principle 12 Governance Formula: 'Write for three readers, in strict descending order: Stakeholder, Engineer, AI.' If a business stakeholder cannot comprehend the specification, its algorithmic precision is worthless. If a software engineer cannot cross-examine the generated code against the spec, correctness cannot be validated. Only after these human gates are established does machine consumability matter. Fortunately, these needs converge: active voice, single-responsibility steps, and explicit business rules satisfy humans and machines simultaneously. If you ever feel compelled to sacrifice human readability for AI parsing, you have invariably leaked implementation mechanisms into the specification.]
    ]
  )
]

#java25_box[
```java
// Java 25: Paydaşın, Mühendisin ve AI'ın Birlikte Doğrulayabildiği Domain Modeli
package com.maang.aiup.hierarchy;

public class ReaderHierarchyDemo {
    // Paydaş Okur: "Üye, Kurs ve Kayıt" kelimelerini görür.
    // Mühendis Okur: Tip güvenliğini ve değişmezliği (immutability) görür.
    // AI Okur: Hangi validation kurallarının işletileceğini eksiksiz anlar.
    public record CourseEnrollment(
        String enrollmentId,
        String memberId,
        String courseCode,
        boolean isPrerequisiteSatisfied,
        int availableSeats
    ) {
        public CourseEnrollment {
            // Step 4: System validates prerequisites (BR-020)
            if (!isPrerequisiteSatisfied) {
                throw new IllegalStateException("BR-020: Önkoşul dersleri tamamlanmamış.");
            }
            // Step 5: System validates seat availability (BR-021)
            if (availableSeats <= 0) {
                throw new IllegalStateException("BR-021: Kursta boş kontenjan kalmadı.");
            }
        }
    }

    void main() {
        var enrollment = new CourseEnrollment("ENR-10", "MEM-5", "CS-101", true, 15);
        System.out.println("✅ Üç okuyucunun da onayladığı kayıt: " + enrollment);
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
      Şartnameye JSON şemaları, SQL sorguları veya regex desenleri koyarak 'AI böyle daha iyi anlıyor' bahanesine sığınmayın. Bu tür detaylar paydaşın okumasını engeller ve İlke 12'yi doğrudan ihlal eder.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never inline regex formulas, SQL statements, or JSON schemas into use case steps under the pretext that 'the AI understands code better'. Doing so alienates stakeholders and destroys the foundational reader hierarchy.]
    ]
  )
]

#takeaways_box((
    ("Okuyucu sırası asla değişmez: 1. Paydaş, 2. Mühendis, 3. Yapay Zekâ.", "Reader priority is immutable: 1. Stakeholder, 2. Software Engineer, 3. AI Agent."),
    ("Paydaşın onaylamadığı şartnameyle üretilen kod, ne kadar hatasız çalışırsa çalışsın çöptür.", "Code generated from an unvalidated spec is useless, regardless of algorithmic elegance."),
    ("İnsanın kolay okuduğu yapı (aktif dil, numaralı adımlar), AI için de en az yanılsama üreten yapıdır.", "Structures that maximize human readability also minimize AI hallucination rates."),
))
