#import "/template.typ": *

#show: doc => setup_book(title: "Ders 32: 'Validates' vs 'Checks Whether': Ana Akışta Başarıyı Mühürleme Sanatı", doc)

#lesson_header(
  32,
  "'Validates' vs 'Checks Whether': Ana Akışta Başarıyı Mühürleme Sanatı",
  "The 'Validates' vs 'Checks Whether' Dictum: Asserting Success in Main Flow",
  "Senaryolar ve Alternatif Akışlar Yazma Sanatı",
  "Writing Scenarios and Alternative Flows"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 'VALIDATES' VS 'CHECKS WHETHER' DİLBİLGİSEL DİKTASI         │
└─────────────────────────────────────────────────────────────────────────────┘
  ❌ 'CHECKS WHETHER' (KONTROL EDER - UCU AÇIK & TEHLİKELİ):
  "Sistem parolanın doğru olup olmadığını KONTROL EDER."
  - Sonuç açıkta kaldı! Doğruysa ne olacak? Yanlışsa ne olacak?
  - Kodda iç içe geçmiş devasa if-else spagettisi doğurur!

  ✅ 'VALIDATES THAT' (DOĞRULAR - BAŞARIYI MÜHÜRLER):
  "Sistem parolanın doğru olduğunu DOĞRULAR (BR-001)."
  - Ana akışta bu adım KESİNLİKLE BAŞARILIDIR! (Asserts Success!)
  - Peki ya parola yanlışsa? Cevap net: Alternatif Akış A1'e git!
  
  🎯 MİMARİ SONUÇ: Ana akış dümdüz bir otoban gibi akar; tüm pürüzler
                   adlandırılmış alternatif akışlara (A1, A2) delege edilir!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Havalimanında pasaport polisine gittiğinde spiker şöyle demez: 'Polis pasaportun sahte olup olmadığına bakıyor ve düşünüyor.' Hayır! Ana senaryoda 'Polis pasaportun geçerli olduğunu doğrular' denir ve yürür geçersin. Eğer pasaport sahteyse, o zaman polis düğmeye basar ve seni yan odaya (Alternatif Akış A1) çekerler! 'Doğrular' kelimesi ana yolda yürümeyi sağlar; soru işaretlerini çöpe atar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[At passport control, the script does not read: 'Officer ponders whether the visa is forged.' The main scenario asserts: 'Border officer validates that the visa is authentic.' You proceed immediately to the gate. If forged, that failure diverts cleanly into Alternative Flow A1 (Detention Room). Using 'validates' asserts victory in the happy path and pushes failure into an explicit branch.]
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
      'Validates' Kelimesinin Eklemeli (Additive) Mimari Gücü: Cockburn ve Martinelli'nin en radikal kuralı: 'Validates, never checks whether.' (Doğrular deyin, kontrol eder demeyin!). 'Checks whether' ifadesi iki ucu açık bir olasılıktır ve if-else şartlı dallanmalarını tetikler. Use case'in ana senaryosuna if-else sokulamaz! 'Sistem üyenin gecikmiş borcu olmadığını doğrular (BR-006)' dediğinizde, ana akışta bu adımın %100 başarılı olduğu mühürlenmiş olur. Bu tek bir kelime tercihi sisteme şu muhteşem mimari faydaları sağlar: 1) Eklemeli Yapı (Additive Structure): Ana senaryo baştan sona pürüzsüz akar; her bir başarısızlık ihtimali ise aşağıda bağımsız bir alternatif akış (A1, A2) olarak tanımlanır. 2) AI'a Hata Şablonu Verme: AI ajanı bu yapıyı gördüğünde kodun içinde spagetti if-else blokları kurmaz; doğrudan `if (!valid) throw new ValidationException()` veya Result/Either monadı üreterek akışı ilgili alternatif metoda delege eder.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Additive Architecture of 'Validates' vs 'Checks Whether': 'Checks whether' is an open-ended predicate that invites inline branching and nested conditionals within the main scenario. The main scenario must remain strictly linear and unconditionally successful. Writing 'System validates that password matches hash (BR-001)' asserts success in the primary flow. This single verb choice constructs the additive architecture of the specification: 1) The main scenario is an unbranching highway where every validation passes. 2) Deviations are strictly quarantined into numbered alternative flows. 3) For generative AI, this enforces clean architectural patterns: guard-clause rejections (`if (!valid) throw new DomainException()`) rather than tangled if-else pyramids.]
    ]
  )
]

#java25_box[
```java
// Java 25: 'Validates' Kuralının Guard-Clause Mimarisiyle Temiz İcrası
package com.maang.aiup.validates;

public class ValidationGuardArchitecture {
    // ❌ CHECKS WHETHER (Spagetti if-else):
    // if (checkPassword()) { if (checkLimit()) { doSomething(); } else { error(); } }

    // ✅ VALIDATES (Guard Clauses - Şartnamedeki her 'validates' bir guard'dır):
    public static void processBorrowWithGuards(boolean isCopyAvailable, boolean isLimitOk) {
        // Step 4: System validates copy is available (A1)
        if (!isCopyAvailable) {
            handleAlternativeA1();
            return;
        }

        // Step 5: System validates loan limit (A2)
        if (!isLimitOk) {
            handleAlternativeA2();
            return;
        }

        // Ana akış dümdüz devam eder!
        System.out.println("Tüm doğrulamalar geçti, ana akış başarıyla bitti.");
    }

    private static void handleAlternativeA1() { System.out.println("Dallanma A1: Kopya yok."); }
    private static void handleAlternativeA2() { System.out.println("Dallanma A2: Limit aşıldı."); }

    void main() {
        processBorrowWithGuards(true, true);
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
      Şartnamede 'Sistem kullanıcının bakiyesini kontrol eder' yazıp bırakırsanız AI bakiye yetersiz olduğunda ne yapacağını bilemez ve kafasına göre kullanıcıya eksi bakiye tanımlayabilir! 'Sistem bakiyenin yeterli olduğunu doğrular (BR-002)' yazın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Writing 'System checks customer balance' without asserting success leaves the failure path undefined. An AI agent might hallucinate overdraft credit. Write 'System validates that balance is sufficient (BR-002)' and bind failure to flow A1.]
    ]
  )
]

#takeaways_box((
    ("'Validates' ana senaryoda kesin başarıyı mühürler; 'checks whether' ise ucu açık if-else yaratır.", "'Validates' asserts success in the main flow; 'checks whether' creates ambiguous branching."),
    ("Her 'validates' adımı başarısızlık ihtimalini isimlendirilmiş bir Alternatif Akışa devreder.", "Every validation step delegates its failure outcome to a named alternative flow."),
    ("Bu kural sayesinde ana akış dümdüz bir başarı otobanı gibi tertemiz kalır.", "This rule preserves the happy path as a linear, unbranching highway to the goal."),
))
