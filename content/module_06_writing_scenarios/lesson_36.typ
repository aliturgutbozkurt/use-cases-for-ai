#import "/template.typ": *

#show: doc => setup_book(title: "Ders 36: Tamamlanmış Şartnamenin Ritmi: Sıfır Açık Uç ve Kapalı Döngü (Closed Loop) Mimarisi", doc)

#lesson_header(
  36,
  "Tamamlanmış Şartnamenin Ritmi: Sıfır Açık Uç ve Kapalı Döngü (Closed Loop) Mimarisi",
  "The Rhythm of a Finished Spec: Closed Loops with Zero Dangling Threads",
  "Senaryolar ve Alternatif Akışlar Yazma Sanatı",
  "Writing Scenarios and Alternative Flows"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 KUSURSUZ ŞARTNAMENİN KAPALI DÖNGÜ (CLOSED LOOP) RİTMİ        │
└─────────────────────────────────────────────────────────────────────────────┘
  1. HER ANA SENARYO ADIMI KESİNLİKLE BAŞARILIDIR. (Dallanma yok!)
     │
     ▼
  2. HER 'VALIDATES' ADIMININ TAM OLARAK BİR ALTERNATİF AKIŞ KARŞILIĞI VARDIR.
     (Step 4 Validates ──▶ A1 Flow)
     │
     ▼
  3. HER ALTERNATİF AKIŞ NUMARALI BİR ADIMDA BAŞLAR, KESİN BİR ÇIKIŞLA BİTER.
     (Trigger: Step 4 ──▶ Ends / Continues at Step N)
     │
     ▼
  4. HER 'ENDS' BİR BAŞARISIZLIK SONKOŞULUYLA (FAILURE POSTCONDITION) DESTEKLENİR.
     │
     ▼
  5. ATIFTA BULUNULAN HER (BR-XXX) İŞ KURALI LİSTESİNDE TANIMLIDIR.

  🔒 SIFIR AÇIK UÇ! Bu kapalı döngü yapay zekanın uydurma yapmasını İMKÂNSIZ kılar!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir elektrik devresini düşünün: Pilden çıkan kablo ampule gider, ampulden anahtara, anahtardan tekrar pile döner. Eğer devrede tek bir kablonun ucu havada sallanıyorsa ampul yanmaz (Açık devre!). Kusursuz bir use case şartnamesi kapalı bir elektrik devresi gibidir: Adım başlar, kurala bağlanır, hataya bağlanır, sonkoşula bağlanır ve döngü tamamlanır. Tek bir açık uç kalmadığında sistem ışık saçar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Consider an electrical circuit: current flows from the battery to the switch, through the lamp, and returns cleanly to ground. If a single wire dangles disconnected, no current flows. A finished use case specification is a closed electrical circuit: every validation links to a rule, every rule links to a flow, and every flow terminates cleanly. When there are zero dangling threads, the AI generates software that works on the first run.]
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
      Kapalı Döngü Şartname Ritim ve Denetim Kuralları: Martinelli, kaliteli bir use case dökümanının 'kendi içinde kapalı bir döngü' (closed loop) oluşturması gerektiğini belirtir. Bu ritim review (inceleme) sırasında gözle veya `/spec-review` ile kolayca doğrulanabilir: 1) Kural 1: Ana senaryodaki her adım başarıyla biter; if-else veya dallanma barındırmaz. 2) Kural 2: Ana senaryoda kaç tane 'validates' kelimesi geçiyorsa, alternatif akışlarda tam olarak o sayıda A1, A2 akışı bulunmalıdır; ne eksik ne fazla! 3) Kural 3: Her alternatif akışın tetikleyicisi ana senaryodaki numaralı bir adıma çapalanır ve ya 'Use case continues at step N' ya da 'Use case ends' ile biter. 4) Kural 4: Senaryodaki her 'Use case ends' ifadesi, Failure Postconditions bölümündeki en az bir garantiyle örtüşür. 5) Kural 5: Metin içinde parantezle referans verilen her `(BR-XXX)` kuralı, dökümanın altındaki Business Rules listesinde eksiksiz mevcuttur. Bu 5 kural sağlandığında şartnamede tek bir 'açıkta kalmış ip' (dangling thread) kalmaz. İşte bu kapalı döngü ritmi, şartnameyi generatif (AI tarafından %100 kodlanabilir) kılan mucizevi sırdır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Closed-Loop Specification Rhythm: A production-ready use case forms a closed relational loop where no logical thread dangles unmoored. Reviewers audit this rhythm via five invariants: 1) Invariant 1: Every main-scenario step succeeds unconditionally; no branches exist. 2) Invariant 2: Every step containing the verb 'validates' is matched by exactly one alternative flow resolving its failure. 3) Invariant 3: Every alternative flow anchors to a numbered step and terminates deterministically. 4) Invariant 4: Every 'Use case ends' terminal state is insured by a corresponding Failure Postcondition assertion. 5) Invariant 5: Every rule cited as `(BR-XXX)` exists in the Business Rules section, and every business rule is cited at least once. This closed loop provides total architectural containment: an AI agent cannot execute an unhandled path without directly violating a line of written text.]
    ]
  )
]

#java25_box[
```java
// Java 25: Kapalı Döngü (Closed Loop) Ritmine Sahip Kusursuz Use Case Denetçisi
package com.maang.aiup.closedloop;

public class ClosedLoopAuditor {
    public record SpecAuditMetrics(int validationSteps, int alternativeFlows, boolean hasFailurePostconditions) {
        public boolean isClosedLoop() {
            // Ritim 2 & 4: Doğrulama sayısı akış sayısına eşit olmalı ve sonkoşul bulunmalıdır!
            return validationSteps == alternativeFlows && hasFailurePostconditions;
        }
    }

    void main() {
        // Borrow Book Şartnamesinin Ritim Sayımı: 3 Doğrulama (Adım 4,5,6) = 3 Akış (A1,A2,A3)
        var borrowBookSpec = new SpecAuditMetrics(3, 3, true);

        if (borrowBookSpec.isClosedLoop()) {
            System.out.println("✅ Şartname Kapalı Döngü (Closed Loop) ritmine sahip: Sıfır açık uç!");
        } else {
            System.err.println("❌ Şartname ritmi bozuk: Eksik akış veya sonkoşul tespit edildi!");
        }
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
      Şartnamenizde bir 'System validates' adımı olup da altında o adımı karşılayan bir alternatif akış (A1, A2) yoksa bu ölümcül bir açıktır. AI o doğrulamayı kodlar ama başarısız olduğunda sistemin çökeceği bir RuntimeException fırlatıp kullanıcıyı ekranda dondurur.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Leaving a 'System validates' step without a corresponding Alternative Flow creates a critical flaw. The AI will generate a validation check that throws an unhandled server error, locking the frontend UI.]
    ]
  )
]

#takeaways_box((
    ("Kapalı döngü şartnamede her 'validates' bir akışa, her akış ise bir sonkoşula bağlanır.", "A closed loop connects every validation to a flow, and every flow to a postcondition."),
    ("Hiçbir açık uç bırakılmadığında yapay zekanın kendi kafasından kural uydurması imkansızlaşır.", "Zero dangling threads makes it mathematically impossible for an AI to hallucinate logic."),
    ("Bu kapalı döngü ritmi hem insan incelemesini kolaylaştırır hem de otomatik test üretimini besler.", "This closed-loop rhythm accelerates human reviews and powers automated test generation."),
))
