#import "/template.typ": *

#show: doc => setup_book(title: "Ders 33: Alternatif Akışları Keşfetme Sanatı: Cockburn'ün 3 Turlu Beyin Fırtınası Yöntemi", doc)

#lesson_header(
  33,
  "Alternatif Akışları Keşfetme Sanatı: Cockburn'ün 3 Turlu Beyin Fırtınası Yöntemi",
  "Finding Alternative Flows: Cockburn's 3-Pass Brainstorming Method",
  "Senaryolar ve Alternatif Akışlar Yazma Sanatı",
  "Writing Scenarios and Alternative Flows"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 COCKBURN'ÜN 3 TURLU ALTERNATİF AKIŞ BULMA YÖNTEMİ           │
└─────────────────────────────────────────────────────────────────────────────┘
  TUR 1: BEYİN FIRTINASI (BRAINSTORM - Asla Çözüm Yazma!)
  - Senaryodaki her 'validates' adımını al: "Bu doğrulama patlarsa ne olur?"
  - Aktör hataları: "Yanlış girdi, zaman aşımı (timeout), vazgeçme?"
  - Dış sistem hataları: "Ödeme gateway yanıt vermezse, SMS servisi çökerse?"
  - İç donanım arızaları: "Para sayma haznesi sıkışırsa?"

  TUR 2: RASYONALİZE ET & BİRLEŞTİR (RATIONALIZE)
  - Sistemin tespit edemeyeceği şeyleri sil! ("Üye şifresini unuttu" -> tespit edilemez!)
    Bunu "3 kere yanlış şifre girildi" olarak yeniden yaz!
  - Aynı sonucu veren arızaları birleştir: "Kart çizik, okuyucu bozuk" -> "Kart Okunamadı."

  TUR 3: ÇÖZÜMÜ YAZ (WRITE THE HANDLING)
  - Hayatta kalan her duruma A1, A2, A3 diye temiz akış adımlarını yaz!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir dedektif gibi suç mahallini inceliyorsun: 1. Turda aklına gelen her çılgın şüpheyi tahtaya yazarsın: 'Hırsız bacadan mı girdi, helikopterle mi indi, içerideki biri mi yardım etti?' (Asla hemen karar verme!). 2. Turda saçma olanları elersin: 'Evde baca yok, helikopter sesi duyulmadı, demek ki içeriden biri yardım etti' (Sadeleştir!). 3. Turda ise hayatta kalan tek ihtimalin peşine düşüp tutuklama planını yazarsın. Üçünü aynı anda yapmaya çalışırsan beynin yanar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of a forensic detective: in Pass 1, brainstorm every wild hypothesis without filtering: 'Did the intruder rappel from a blimp? Tunnel through the basement? Use a master key?' In Pass 2, rationalize: cross off the blimp because radar was clear; collapse lock scratches into 'Forced Entry'. In Pass 3, write the formal arrest warrant. Trying to invent the solution while brainstorming the failure conditions drains cognitive energy.]
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
      Cockburn'ün 3 Turlu Yöntemi ve Eksik Akışların Maliyeti: Yazılım sistemlerinin kod karmaşıklığının %80'i mutlu yolda değil; alternatif akışlarda ve hata yönetiminde yaşar. Bir insan projesinde unutulan bir hata akışı, test aşamasında bir mühendisin 'Peki ya kartta bakiye yoksa ne olacak?' sorusuyla ortaya çıkabilirdi. AI çağında ise unutulan her alternatif akış, yapay zekanın kendi kafasından uydurduğu sahte bir davranışa dönüşür! Bu yüzden beyin fırtınası opsiyonel bir lüks değil, zorunlu bir güvenlik adımıdır: 1) Tur 1: Çözümü düşünmeden sadece tüm başarısızlık ihtimallerini listele. 2) Tur 2: Sistemin algılayamayacağı insan niyetlerini sistemsel olaylara dönüştür. Örneğin 'Üye PIN kodunu unuttu' sistem tarafından bilinemez; sistem sadece 'PIN girme süresi aşıldı (Timeout)' durumunu algılayabilir. Birbirinin aynı olan 5 hata sebebini tek bir başlıkta topla ('Kaydetme Başarısız'). 3) Tur 3: Sadece bu süzgeçten geçen gerçek durumlara A1, A2 akışlarını yaz.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Cockburn's 3-Pass Brainstorming Protocol: Eighty percent of enterprise code complexity resides in failure topologies. In legacy shops, an unstated failure mode surfaced during manual testing when an observant engineer raised an edge-case question. With autonomous LLM coders, an omitted failure mode produces invented behavior. Brainstorming is therefore mandatory: 1) Pass 1 (Exhaustive Brainstorming): Enumerate every conceivable failure without designing remedies. Sweep through every 'validates' step, actor input errors, timeout events, and secondary system outages. 2) Pass 2 (Rationalization): Discard undetectable phenomena ('User forgot password' is undetectable; reframe as 'Max failed attempts exceeded'). Merge identical outcomes ('Magnetic stripe scratched', 'Chip corrupted' merge into 'Card Unreadable'). 3) Pass 3 (Handling): Author the formal steps and termination semantics for the surviving conditions.]
    ]
  )
]

#java25_box[
```java
// Java 25: 3 Turlu Analizin Koddaki Karşılığı Olan Hata Hiyerarşisi
package com.maang.aiup.brainstorm;

public class AlternativeFlowHandling {
    // Tur 2'de sadeleştirilen ve sisteme mal edilen hata tipleri
    public sealed interface PaymentFailure permits CardUnreadable, InsufficientFunds, GatewayTimeout {}

    public record CardUnreadable(String details) implements PaymentFailure {}
    public record InsufficientFunds(double required, double current) implements PaymentFailure {}
    public record GatewayTimeout(String gatewayName) implements PaymentFailure {}

    // Tur 3'te yazılan çözüm akışları (Pattern Matching ile kusursuz dallanma):
    public static void handleFailure(PaymentFailure failure) {
        switch (failure) {
            case CardUnreadable _ -> System.out.println("A1 Flow: Kart okunamadı, başka bir kart talep edildi.");
            case InsufficientFunds f -> System.out.printf("A2 Flow: Bakiye yetersiz (Gereken: %.2f), alternatif ödeme istendi.%n", f.required());
            case GatewayTimeout _ -> System.out.println("A3 Flow: Banka zaman aşımı, işlem kuyruğa alındı.");
        }
    }

    void main() {
        handleFailure(new InsufficientFunds(100.0, 45.0));
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
      Alternatif akışları düşünürken hemen çözüm yazmaya kalkışmayın. Hatanın nasıl çözüleceğini düşünmek, yeni hata durumlarını keşfetme enerjinizi tüketir. Önce tüm arızaları listeleyin, sonra çözümleri yazın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never attempt to write the handling logic while brainstorming failure conditions. Designing the solution exhausts the cognitive bandwidth required to uncover subtle system failure modes.]
    ]
  )
]

#takeaways_box((
    ("Alternatif akışlar 3 turda bulunur: 1. Beyin fırtınası yap, 2. Sadeleştir, 3. Çözümü yaz.", "Alternative flows are discovered in three passes: 1. Brainstorm, 2. Rationalize, 3. Author handling."),
    ("Sistemin algılayamayacağı insan durumları ('şifreyi unuttu') sistemsel olaylara ('zaman aşımı') çevrilir.", "Undetectable human states must be translated into detectable system events."),
    ("Aynı sonucu doğuran mikro hatalar tek bir genel akış başlığı altında birleştirilmelidir.", "Micro-failures yielding identical systemic outcomes must be rolled up into a unified flow."),
))
