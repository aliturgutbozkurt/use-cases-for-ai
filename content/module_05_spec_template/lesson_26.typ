#import "/template.typ": *

#show: doc => setup_book(title: "Ders 26: Önkoşul vs Tetikleyici (Preconditions vs Triggers): Asla Akışta Yeniden Doğrulanmayan Bekçiler", doc)

#lesson_header(
  26,
  "Önkoşul vs Tetikleyici (Preconditions vs Triggers): Asla Akışta Yeniden Doğrulanmayan Bekçiler",
  "Preconditions vs Triggers: The Gatekeepers That AI Must Never Re-Validate",
  "Ana Şartname Şablonu & Alan Alan Derinlemesine İnceleme",
  "The Master Specification Template & Field Breakdown"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 TETİKLEYİCİ (TRIGGER) VS ÖNKOŞUL (PRECONDITION)             │
└─────────────────────────────────────────────────────────────────────────────┘
  TETİKLEYİCİ (TRIGGER):
  - Bir DURUM değil, bir GEÇİŞTİR (Transition from Waiting to Running)!
  - "Üye kitabı seçer ve 'Ödünç Al' butonuna tıklar." (Olay anı!)
  - Sistemin uyku halinden uyanmasını sağlayan kıvılcımdır.

  ÖNKOŞUL (PRECONDITION):
  - Senaryo başlamadan önce ZATEN DOĞRU olduğu garanti edilen durumdur.
  - "Üye oturum açmıştır" & "Üyenin hesabı aktiftir."
  - ⚠️ SİSTEM BUNU ASLA SENARYO ADIMLARINDA YENİDEN KONTROL ETMEZ!
  - Kodda bir if-else değil; bir ROTA KORUYUCUSU (Route Guard / Filter) olur!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir uçağa binmeyi düşünün: 1) Önkoşul: Pasaportunun olması ve güvenlik kontrolünden geçmiş olmandır (Sen daha uçağın kapısına gelmeden çok önce zaten tamamlanmıştır). 2) Tetikleyici: Hostesin 'Uçağa biniş başladı, lütfen biletinizi okutun' anonsu yapmasıdır (Hareketi başlatan an!). Uçağın içine girdikten sonra koltuğuna otururken hostes sana 'Dur bir daha pasaportunu göster, güvenlikten geçtin mi kontrol edeyim' demez (Önkoşul akış içinde tekrar doğrulanmaz!).
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Boarding a commercial flight: 1) Precondition: Possessing a valid passport and having cleared airport security. This state was established long before reaching the boarding gate. 2) Trigger: The gate agent announcing 'Group A may now board.' (The catalyst transitioning you from waiting to boarding). Once you step down the jetway, flight attendants do not halt you in the aisle to re-screen your luggage for liquids. A precondition is never re-validated inside the execution flow.]
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
      Önkoşul Semantiği ve AI Kod Üretimindeki Önemi: Martinelli ve Cockburn önkoşul ile tetikleyici arasındaki farkı şöyle netleştirir: 1) Tetikleyici (Trigger): 'Bekleme' durumundan 'Çalışma' durumuna geçiştir. Kullanıcının bir isteği, zamana bağlı bir alarm veya harici sistemden gelen bir web-hook mesajıdır. Zaten doğru olan bir durum (ör: 'Üye kitap ister') tetikleyici olamaz; tetikleyici olayı anlatmalıdır. 2) Önkoşul (Precondition): Sistemin daha use case başlamadan önce kesinlikle doğru olduğunu garanti ettiği durumdur. Bu kuralın iki altın testi vardır: a) Sistem bunu zorlayabilir (enforce) mi? 'Üye kitabı geri getirmek niyetindedir' bir önkoşul olamaz çünkü sistem niyeti bilemez. b) Bu önkoşul daha önce başka bir use case tarafından kuruldu mu? 'Üye oturum açmıştır' önkoşulu, daha önce çalışmış olan 'UC-001 Log In' use case'i tarafından kurulmuştur. Eğer hiçbir use case kurmadıysa, o bir önkoşul değil; senaryonun 1. adımıdır! 3) AI Kuralı: Önkoşul, use case akışının içinde bir if-else kontrolü olarak YAZILMAZ; HTTP filtrelerinde veya Spring Controller `\@PreAuthorize` katmanında çözülür.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Precondition and Trigger Mechanics in Generated Architectures: 1) Trigger: The catalyst event that transitions the use case from idle to active. It must describe an occurrence (an actor action, an inbound webhook, or a temporal scheduler tick), never a persistent state. 2) Preconditions: The state guarantees enforced by the system prior to execution. Cockburn established two definitive tests: First, the condition must be programmatically enforceable (an actor's emotional intent fails). Second, it must have been established by an upstream use case (e.g. 'Member is signed in' was established by `UC-001 Log In`). If no prior use case established it, it is a runtime validation for Step 1, not a precondition. 3) Architectural Translation: Preconditions compile into ingress boundary assertions or route guards. Crucially, they are never re-checked inside the scenario steps; asserting preconditions within the happy path violates the additive flow model.]
    ]
  )
]

#java25_box[
```java
// Java 25: Önkoşulun (Guard) Akıştan Ayrılması (Spring Security / Gateway Modeli)
package com.maang.aiup.preconditions;

public class PreconditionEnforcementDemo {
    public record UserSession(String userId, boolean active) {}

    // ÖNKOŞUL KORUYUCUSU (Route Guard / Interceptor):
    // Use Case başlamadan önce çalışır; akışın içinde if-else kirliliği yapmaz!
    public static class PreconditionGuard {
        public static void ensurePreconditions(UserSession session) {
            if (session == null || !session.active()) {
                throw new SecurityException("Önkoşul İhlali: Oturum geçersiz veya hesap kilitli!");
            }
        }
    }

    // USE CASE: Önkoşulun sağlandığını bilir ve sadece asıl hedefe odaklanır
    public static class BorrowBookFlow {
        public void execute(UserSession session, String bookId) {
            PreconditionGuard.ensurePreconditions(session); // Kapı kontrolü
            // Akış içinde artık 'Oturum açık mı?' diye if-else yapılmaz!
            System.out.println("Ana akış çalışıyor: Kitap ödünç verildi -> " + bookId);
        }
    }

    void main() {
        var validSession = new UserSession("USR-99", true);
        new BorrowBookFlow().execute(validSession, "B-12");
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
      Senaryo adımlarının 1. maddesine 'Sistem kullanıcının oturum açtığını kontrol eder' YAZMAYIN! Eğer oturum açmak bir önkoşulsa zaten Önkoşullar bölümüne yazılmıştır. Senaryonun içinde tekrarlamak AI'ın gereksiz çift kontroller üretmesine yol açar.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never write 'Step 1: System verifies user is logged in'. If authentication is a precondition, it is already guaranteed. Duplicating preconditions inside scenario steps causes AI generators to produce redundant defensive boilerplate.]
    ]
  )
]

#takeaways_box((
    ("Tetikleyici sistemi uyandıran olaydır (eylem); Önkoşul ise zaten var olan durumdur.", "A trigger is the event waking the system; a precondition is an already established state."),
    ("Önkoşul sistem tarafından denetlenebilir olmalı ve daha önceki bir use case tarafından kurulmuş olmalıdır.", "Preconditions must be enforceable and established by an upstream use case."),
    ("Önkoşullar kodda rota koruyucusu (route guard) olur; senaryo adımlarında tekrar kontrol edilmez.", "Preconditions translate into route guards; they are never re-checked within scenario steps."),
))
