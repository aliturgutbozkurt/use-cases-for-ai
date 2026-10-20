#import "/template.typ": *

#show: doc => setup_book(title: "Ders 31: Bir Adımın Anatomisi: Özne-Yüklem-Nesne, Kuşbakışı Bakış & 'Top Kimde?' Kuralı", doc)

#lesson_header(
  31,
  "Bir Adımın Anatomisi: Özne-Yüklem-Nesne, Kuşbakışı Bakış & 'Top Kimde?' Kuralı",
  "The Shape of a Step: Subject-Verb-Object & 'Who Has the Ball'",
  "Senaryolar ve Alternatif Akışlar Yazma Sanatı",
  "Writing Scenarios and Alternative Flows"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 BİR ADIMIN ANATOMİSİ VE 'TOP KİMDE?' KURALI                 │
└─────────────────────────────────────────────────────────────────────────────┘
  ❌ HATALI ADIM (ÖZNESİZ / EDİLGEN / İÇERİDEN BAKIŞ):
  "Tutar bakiyeden düşülür." (Edilgen!)
  "Düş bakiyeden 100 TL."   (Öznesiz!)
  💥 AI Alarmı: Top kimde belli değil! UI mu yapacak, servis mi yapacak, banka mı?

  ✅ DOĞRU ADIM (ETKEN ÇATI / TEK ÖZNE / DIŞARIDAN KUŞBAKIŞI BAKIŞ):
  [ ÖZNE (Topun Sahibi) ] + [ EYLEM / FİİL ] + [ NESNE ] + [ TÜMLEÇ ]
  "Sistem"                + "düşer"          + "tutarı"  + "hesap bakiyesinden."
  "Üye"                   + "seçer"          + "kitabı"  + "katalog listesinden."

  🎯 KURAL: Her adımın İLK KELİMESİ o an hareket yapan aktörün adı olmalıdır!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir basketbol maçını anlatan spikeri dinleyin: Spiker asla 'Top potaya girdi ve sayı oldu' deyip susmaz! 'Curry topu sürdü, pası LeBron'a attı, LeBron smacı bastı!' der. Her saniye topun kimin elinde olduğu bellidir. Eğer use case adımında 'Para çekildi' dersen spiker susmuş gibi olur; parayı hırsız mı çekti, veznedar mı verdi, ATM mi saydı bilemezsin! İlk kelime daima topu elinde tutan oyuncunun adı olmalıdır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Listen to a live sports commentator: they never mutter passively 'The ball was hurled toward the hoop.' They say: 'Curry drives the lane, kicks the ball to LeBron, and LeBron slams it down!' At every fraction of a second, you know who holds the ball. If you write 'Money is debited', the ball-holder is invisible. Did a pickpocket steal it, or did the ledger process it? The first word of every step must name the actor holding the ball.]
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
      Bir Adımın Dilbilgisel ve Mimari Anatomisi: Cockburn use case yazımını 'temelde bir düzyazı denemesi egzersizi' olarak tanımlar. Ancak bu edebi bir üslup değil, katı bir mühendislik kuralıdır: 1) Basit Gramer: Özne, Yüklem, Nesne ve Edat öbeği. Şimdiki zaman ve etken çatı (Active Voice). 2) 'Top Kimde?' (Who Has the Ball): Her adımda tam olarak tek bir aktör hareket eder ve o aktör cümlenin ilk kelimesidir. Edilgen cümleler ('Para hesaba aktarılır') topun sahibini gizler. Oysa yapay zekâ için topun sahibi hayati önem taşır; çünkü o adımın bir Controller/UI kodu mu, bir Domain Servis kodu mu yoksa harici bir RestClient çağrısı mı olacağına bu özne karar verir! 3) Kuşbakışı Bakış (Bird's Eye View): Senaryo sistemin içinden dışarıya bakarak ('Kartı al, PIN doğrula, parayı say') yazılmaz; tüm etkileşimi yukarıdan izleyen tarafsız bir gözlemci gibi yazılır. İçeriden yazılan adımlarda kullanıcı kaybolur ve AI kullanıcı arayüzü üretmeyi unutur.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Linguistic and Architectural Shape of a Step: 1) Grammatical Strictness: One sentence per step. Present tense, active voice. Subject - Verb - Direct Object - Prepositional Phrase ('System deducts amount from account balance'). Omitted subjects ('Deduct amount') force LLMs to infer the actor, frequently assigning server logic to client components. 2) 'Who Has the Ball': Exactly one actor acts per step, declared as the very first word. Passive voice ('The loan is recorded') conceals the ball-holder. The ball-holder is the primary signal an AI uses to partition responsibilities across the architecture: actor actions become UI events; system actions become domain service methods; secondary actor actions become outbound API adapters. 3) Bird's Eye Perspective: Frame interactions from above the entire ecosystem rather than from inside the server looking out ('Read card, dispense cash' loses the human). Retaining the actor guarantees that frontend views and forms are synthesized accurately.]
    ]
  )
]

#java25_box[
```java
// Java 25: 'Top Kimde' Kuralının Temiz Mimari Katmanlarına Dağılımı
package com.maang.aiup.stepshape;

public class BallHolderArchitecture {
    // 1. ÖZNE: Üye (UI / Presentation Layer) -> Top Üyede!
    public record MemberUiAction(String memberId, String bookId) {
        public void userClicksBorrowButton() {
            System.out.println("Üye butona tıkladı (Top Üyede): " + bookId);
        }
    }

    // 2. ÖZNE: Sistem (Domain Service Layer) -> Top Sistemde!
    public static class SystemDomainService {
        public void systemDeductsInventory(String bookId) {
            System.out.println("Sistem envanteri 1 azalttı (Top Sistemde): " + bookId);
        }
    }

    void main() {
        var ui = new MemberUiAction("M1", "BK-42");
        var service = new SystemDomainService();

        ui.userClicksBorrowButton();
        service.systemDeductsInventory("BK-42");
        System.out.println("✅ Adımların sorumluluğu katmanlara başarıyla yansıdı.");
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
      Bir adıma birden fazla aktörün hareketini sıkıştırmayın: 'Kullanıcı formu doldurur ve sistem bilgileri onaylar' YAZMAYIN! Bu iki ayrı adımdır. İlk adımda top kullanıcıda, ikinci adımda sistemdedir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never combine two actor actions into a single compound step (e.g. 'User submits form and system validates data'). Split them. Step 1: User submits form. Step 2: System validates data.]
    ]
  )
]

#takeaways_box((
    ("Her adım geniş zamanlı, etken çatılı ve tek bir cümledir; ilk kelime topun sahibidir.", "A step is one active-voice sentence in present tense; the first word is the ball-holder."),
    ("Edilgen cümleler ('Para aktarılır') aktörü gizler ve AI'ın kod katmanını şaşırmasına yol açar.", "Passive voice obscures responsibilities, causing AI to misallocate logic across layers."),
    ("Etkileşimi sistemin içinden değil, yukarıdan kuşbakışı izleyen tarafsız bir gözle yazın.", "Write from a bird's-eye view above the interaction, preserving the user's presence."),
))
