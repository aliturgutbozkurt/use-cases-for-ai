#import "/template.typ": *

#show: doc => setup_book(title: "Ders 57: Masaüstü Adım Yazma Kartı (Step-Writing Desk Card): Bölünmüş Ekranda Hızlı Rehber", doc)

#lesson_header(
  57,
  "Masaüstü Adım Yazma Kartı (Step-Writing Desk Card): Bölünmüş Ekranda Hızlı Rehber",
  "The Step-Writing Desk Card: The Split-Pane Reference for Engineers",
  "Kontrol Listeleri, Yaygın Hatalar ve MAANG Mimar Seviyesi Ustalık",
  "Checklists, Common Mistakes & MAANG Architect Mastery"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 MASAÜSTÜ ADIM YAZMA KARTI (STEP-WRITING CARD)               │
└─────────────────────────────────────────────────────────────────────────────┘
  
  Mühendisler İçin Monitörün Sağında Açık Tutulacak Özet Kart:
  
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ 📝 BİR ADIM YAZARKEN (FOR MAIN SCENARIO STEPS):                         │
  │ 1. Tek bir cümle. Geniş / Şimdiki zaman. Etken çatı (Active Voice).     │
  │ 2. İLK KELİME = Top kimdeyse o aktörün adı!                             │
  │ 3. Formül: Özne ─► Yüklem ─► Nesne ─► Edat Öbeği.                      │
  │ 4. Hareketleri değil niyeti yaz; tek yöndeki verileri tek adımda topla! │
  │ 5. ASLA "checks whether" deme; "validates that..." de!                  │
  │ 6. Gözlemlenebilir alanda SOMUT ol (Kolon adları, net sayılar, mesaj).  │
  │ 7. Mekanizmada TAMAMEN SESSİZ kal (Protokol, şema, DB, kod adı YOK!).  │
  │ 8. 3 ila 9 adım arası yaz. Son adım = Hedefin teslim edildiği andır!    │
  ├─────────────────────────────────────────────────────────────────────────┤
  │ 🔀 ALTERNATİF AKIŞ YAZARKEN (FOR ALTERNATIVE FLOWS):                     │
  │ 1. Başlık: ### A#: <Durumun Adı>                                        │
  │ 2. Tetikleyici: **Trigger:** <Sistemin yakaladığı durum> (step N)       │
  │ 3. 1..N Adım: Yukarıdaki adım kurallarına harfiyen uyan adımlar.        │
  │ 4. Kesin Bitiş: "Use case continues at step N." VEYA "Use case ends."   │
  │ 5. "ends" ile biten her akış için Failure Postcondition garantisi şart! │
  └─────────────────────────────────────────────────────────────────────────┘
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Uçak pilotlarının kokpitindeki küçük acil durum kartlarını düşünün: Uçakta motor arızası çıktığında pilot 500 sayfalık kalın kitabı açıp okumaz; hemen direksiyonun yanındaki 8 maddelik küçük karta bakar! Adım yazma kartı, şartname yazarken monitörünüzün sağ köşesine yapıştıracağınız o hayat kurtaran kokpit kartıdır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of the quick-reference checklist clipped directly to an airline pilot's yoke: In severe turbulence, pilots don't flip through a 600-page manual; they scan the laminated 8-point card right in front of them! The Step-Writing Desk Card is that vital cockpit card, pinned to your split-pane IDE window while drafting specs!]
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
      Masaüstü Adım Yazma Kartının Pratik Değeri: Simon Martinelli kitabın 10.3 bölümünde bu kartı özel olarak tek sayfalık bir referans olarak sunar. Çünkü kimse şartname yazarken 60 sayfalık metodoloji kitabını baştan sona okumaz; mühendisler ikiye bölünmüş monitörde (split-pane) bir tarafta use case yazarken diğer tarafta hızlı kurallara bakmak ister. Bu kart iki kompakt bloktan oluşur: 1) Senaryo Adımları: 8 altın kural. Özne-yüklem uyumu, topun sahibinin ilk kelime olması, 'validates that' kalıbı, Zone 1 somutluğu ve Zone 3 sessizliği. 2) Alternatif Akışlar: 5 altın kural. Adıma çıpalama `(step N)`, 1..N adımlı işleme ve mutlaka iki yasal bitişten birisi (`continues at step N` veya `ends`). Bu kartı takip eden bir mühendisin şartnamesi `/spec-review` linter'ından ilk seferde %100 geçer not alır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Practical Utility of the Step-Writing Desk Card: In Section 10.3, Martinelli crystallizes the entire writing discipline into a desk card designed specifically for split-pane engineering environments. Software engineers and business analysts drafting specifications in an IDE do not consult a full-length book during authoring; they need an ambient, unencumbered reference visible on their secondary monitor or split editor. The card establishes two airtight syntactic blocks: 1) Scenario Step Rules: 8 constraints enforcing active voice, ball-holder primacy, intent encapsulation, strict 'validates that' grammar, Zone 1 observability, Zone 3 silence, and 3-9 step bounds. 2) Alternative Flow Rules: 5 constraints governing condition titling, anchored triggers `(step N)`, and explicit binary exits. Adhering to the desk card guarantees zero lint violations during `/spec-review` passes.]
    ]
  )
]

#java25_box[
```java
// Java 25: Masaüstü Kartı Kurallarına %100 Uyumlu Temiz Use Case Modeli
package com.maang.aiup.deskcard;

public class DeskCardComplianceDemo {
    // Kural 1-3: Aktör net (Üye, Sistem). Kural 5: Validates kuralı.
    public record BorrowContext(String memberId, String bookId, boolean isAvailable) {}

    public static class StepExecutionEngine {
        // Adım 4: Sistem kopyanın mevcut olduğunu doğrular (BR-004)
        public static String step4ValidateAvailability(BorrowContext ctx) {
            if (!ctx.isAvailable()) {
                // A1 Akışı: Tetikleyici step 4'e bağlı. Bitiş: Use case ends.
                return "A1: Kopya mevcut değil. En erken iade tarihi gösterildi. Use case ends.";
            }
            // Başarı yolu:
            return "Adım 4 Başarılı: Kopya mevcut. Use case continues at step 5.";
        }
    }

    void main() {
        var availableCtx = new BorrowContext("M1", "BK-9", true);
        var unavailableCtx = new BorrowContext("M1", "BK-9", false);

        System.out.println(StepExecutionEngine.step4ValidateAvailability(availableCtx));
        System.out.println(StepExecutionEngine.step4ValidateAvailability(unavailableCtx));
        System.out.println("✅ Adım Yazma Kartı kuralları koda kusursuz yansıdı.");
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
      Desk kartındaki formülü bozup 'Kitap mevcut ise sisteme kaydet' şeklinde şartlı (if-then) cümleler kurmayın! Şartları daima alternatif akışlara taşıyın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never violate the desk card syntax by embedding conditional 'if-then' clauses within a step. Main steps assert success; deviations belong strictly in alternative flows.]
    ]
  )
]

#takeaways_box((
    ("Masaüstü kartı, çift ekranlı çalışırken split-pane'de açık tutulacak en pratik kaynaktır.", "The desk card is the definitive split-pane reference for daily specification authoring."),
    ("Adım kuralları (özne başta, validates, 3-9 adım) hatasız bir ana akış kurar.", "Step rules (ball-holder first, validates, 3-9 steps) construct an unbranching happy path."),
    ("Akış kuralları (adıma çıpalama, net bitiş) açık uçlu hataları tamamen engeller.", "Flow rules (anchored triggers, explicit exits) eliminate dangling failure paths entirely."),
))
