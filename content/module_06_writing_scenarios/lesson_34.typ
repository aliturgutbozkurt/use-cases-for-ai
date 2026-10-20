#import "/template.typ": *

#show: doc => setup_book(title: "Ders 34: Bir Alternatif Akışın Anatomisi: Adıma Bağlı Tetikleyici & Açık Uçlu Akış Yasağı", doc)

#lesson_header(
  34,
  "Bir Alternatif Akışın Anatomisi: Adıma Bağlı Tetikleyici & Açık Uçlu Akış Yasağı",
  "Anatomy of an Alternative Flow: Anchored Triggers & Explicit Endings",
  "Senaryolar ve Alternatif Akışlar Yazma Sanatı",
  "Writing Scenarios and Alternative Flows"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 BİR ALTERNATİF AKIŞIN KESİN ŞABLONU                         │
└─────────────────────────────────────────────────────────────────────────────┘
  ### A1: No Copies Available  ◀── [ Koşulun İsmi Başlık Olur ]
  
  **Trigger:** No copy of the book is available (step 4) ◀── [ Hangi adımda koptu? ]
  **Flow:**
  1. System informs member that all copies are on loan.
  2. System offers to place a reservation.
  3. If member accepts, system records reservation (UC-005 Reserve Book).
  4. Use case ends.  ◀── [ KESİN BİTİŞ! ASLA UCU AÇIK BIRAKILAMAZ! ]

  🚫 YASAK: Bir akışın son satırında "Use case continues at step N." veya
            "Use case ends." yazmıyorsa, bu bir şartname hatasıdır (Spec Bug)!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir tren yolculuğundasın ve makas değiştirip yan raya girdin. Makasın başında tabela yazar: 'Makas 4. kilometrede ayrıldı (Tetikleyici)'. Yan rayda birkaç yüz metre gidersin. Rayın sonunda ise iki ihtimal vardır: Ya ray tekrar ana hatta bağlanır ('Yolculuk 5. kilometreden devam eder') ya da ray bir takozla son bulur ('Yolculuk burada biter!'). Eğer rayı boşlukta bırakırsan tren uçurumdan yuvarlanır! Alternatif akışların ucu asla açık bırakılamaz!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Riding a train onto a siding track: the switch is explicitly marked ('Diverted at Kilometer 4'). You travel down the spur line for 500 meters. At the end of the spur, only two geometric outcomes are physically possible: either the track merges back into the main line ('Use case continues at step 5'), or it strikes a hydraulic buffer stop ('Use case ends'). Leaving a track hanging in mid-air derails the train. Open-ended flows are specification bugs.]
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
      Alternatif Akış Anatomisi ve Açık Uçlu Akış Yasağı: Cockburn bir alternatif akışı 'minyatür bir use case' olarak adlandırır. Bir alternatif akışın 3 zorunlu bileşeni vardır: 1) İsimlendirilmiş Başlık: Koşulun adını taşır (`### A1: No Copies Available`). 2) Adıma Çapalanmış Tetikleyici (Anchored Trigger): Sistemin neyi tespit ettiğini ve ana senaryonun HANGİ adımından koptuğunu kesin olarak belirtir: `**Trigger:** No copy of the book is available (step 4)`. Bu çapa hem insan denetçinin dalı bulmasını sağlar hem de AI'ın hata yakalama kodunu ilgili metodun içine gömmesini garantiler. Eğer hata bir aralıkta çıkabiliyorsa 'at any time between steps 2 and 6' yazılır. 3) Açık Bitiş Kuralı (Explicit Ending): Bir alternatif akış tam olarak iki şekilde bitebilir: a) `Use case continues at step N.` (Düzeltme yapıldı, ana yola geri dönüldü). b) `Use case ends.` (Hedefe ulaşılamadı, işlem iptal edildi). Sonu belirtilmemiş açık uçlu bir akış şartname hatasıdır (Spec Bug); insan geliştirici bunu omuz silkerek geçiştirebilir ama yapay zekâ kendi kafasından uyduruk bir son seçer.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Anatomy of an Alternative Flow and the Prohibition of Open-Endedness: An alternative flow is a miniature use case nested within the specification. It mandates three non-negotiable structural components: 1) Condition-Based Header: Named precisely after the observed system condition (`### A2: Loan Limit Reached`). 2) Step-Anchored Trigger: Declares what the system detected and anchors explicitly to a numbered main-scenario step: `**Trigger:** Member already has maximum loans (step 5)`. The step anchor enables AI code generators to attach the exception interceptor to the precise functional invocation. 3) Deterministic Termination: Exactly two mechanical endings exist: `Use case continues at step N.` or `Use case ends.` An alternative flow lacking an explicit terminal statement is a severe specification bug. While a human engineer might infer an ending, an LLM will invent one arbitrarily.]
    ]
  )
]

#java25_box[
```java
// Java 25: Adıma Çapalanmış ve Kesin Bitişli Alternatif Akış Metodu
package com.maang.aiup.flows;

public class AlternativeFlowAnatomyDemo {
    public record ReservationResult(boolean completed, String nextStep) {}

    // A1: No Copies Available (step 4)
    public static ReservationResult handleAlternativeA1(String bookId, boolean userAcceptsReservation) {
        System.out.println("Step 4'ten A1 akışına girildi: Kopya bulunamadı.");

        // Flow Step 1: System informs member
        System.out.println("A1.1: Üyeye tüm kopyaların ödünçte olduğu bildirildi.");

        // Flow Step 2 & 3: Offer & Record Reservation
        if (userAcceptsReservation) {
            System.out.println("A1.3: Rezervasyon kaydedildi (UC-005 Reserve Book).");
        }

        // Flow Step 4: KESİN BİTİŞ (Use case ends!)
        System.out.println("A1.4: Use case ends.");
        return new ReservationResult(true, "USE_CASE_ENDS");
    }

    void main() {
        handleAlternativeA1("BK-101", true);
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
      Bir alternatif akışın içine bir alternatif akış daha açıp (iç içe 3 katmanlı dallanma) şartnameyi labirente çevirmeyin! 2. seviyeden daha derin bir dallanma ihtiyacı doğduysa, o akış use case olmaktan çıkmış demektir; onu ayrı bir use case olarak sisteme ekleyin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never nest alternative flows more than one level deep. If an alternative flow branches into secondary and tertiary sub-alternatives, the abstraction is broken: promote the flow into its own standalone sea-level use case.]
    ]
  )
]

#takeaways_box((
    ("Her alternatif akışın tetikleyicisi ana senaryodaki numaralı bir adıma çapalanır (step N).", "Every alternative flow trigger must anchor to a numbered main step (step N)."),
    ("Bir akış yalnızca iki şekilde bitebilir: 'Use case continues at step N.' veya 'Use case ends.'", "Flows terminate strictly via 'Use case continues at step N.' or 'Use case ends.'"),
    ("Ucu açık bırakılmış akışlar birer şartname hatasıdır ve AI'ın uydurma kararlar almasına yol açar.", "Open-ended flows are specification defects that provoke arbitrary AI hallucinations."),
))
