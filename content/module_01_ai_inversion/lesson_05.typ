#import "/template.typ": *

#show: doc => setup_book(title: "Ders 5: Kullanıcı Hikayeleri vs Use Case: Neden Yapışkan Post-it Kağıtları LLM Çağında İflas Etti?", doc)

#lesson_header(
  5,
  "Kullanıcı Hikayeleri vs Use Case: Neden Yapışkan Post-it Kağıtları LLM Çağında İflas Etti?",
  "User Stories vs Use Cases: Why Agile Sticky Notes Broke in the Age of LLMs",
  "Büyük Tersine Dönüş (The Inversion) & AI Çağında Use Case Rönesansı",
  "The AI Inversion & Why Use Cases Rule the GenAI Era"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 USER STORY (POST-IT) VS USE CASE (DAVRANIŞSAL ANLATI)       │
└─────────────────────────────────────────────────────────────────────────────┘
  1. USER STORY (Tek Cümlelik Parça):
     "Bir üye olarak, kitap ödünç almak istiyorum, böylece evde okuyabilirim."
     ❌ Tetikleyici nerede? Önkoşullar ne? Hangi hata durumları var?
     ❌ AI bu cümleyi görünce tüm doğrulama ve veritabanı kurallarını KAFASINA GÖRE UYDURUR!

  2. USE CASE (Tam Davranışsal Sözleşme):
     Tetikleyici ──▶ Önkoşul ──▶ 1..9 Başarı Adımları ──▶ Alternatif Akışlar (A1, A2) ──▶ Sonkoşul
     ✅ AI ajanı neyin başarılı neyin başarısız olduğunu tam olarak bilir;
        tahmin etmez, uydurmaz, sözleşmeyi koda döker!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      User Story, buzdolabının üstüne yapıştırılan 'Akşama ekmek al' notu gibidir. Eve gelen eşin fırının kapalı olduğunu görürse ne yapacağını bilmez (eve boş döner veya pastaneden pasta alır). Use Case ise tam bir görev talimatıdır: 'Akşam fırından 2 tam buğday ekmeği al. Fırın kapalıysa yan bakkala bak. Bakkalda da yoksa beni ara, sakın beyaz ekmek alma!' Yapay zekâya post-it verirsen kafası karışır; Use Case verirsen harfiyen yerine getirir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[A user story is a fridge note that says: 'Buy bread on the way home.' If the bakery is locked, your partner is baffled: do they visit a grocery store, buy cake, or return empty-handed? A use case is the full protocol: 'Buy two sourdough loaves at Bakery A. If closed (A1), proceed to Market B. If sold out (A2), call home. Under no circumstances buy white bread.' AI agents flounder with fridge notes; they thrive on structured protocols.]
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
      Kullanıcı Hikayeleri (User Stories) ile Use Case arasındaki tamamlayıcı ilişki: Çevik ekipler 20 yıl boyunca use case'lerin yerini user story'lerin aldığını iddia etti. Oysa Cockburn'ün 2024'te vurguladığı gibi: User Story bir konuşma biletidir (token for a conversation); detay içermez. Ancak AI ile çalışırken karşınızda kahve içip sohbet edebileceğiniz bir insan yoktur! Bir LLM ajanına 'As a user I want to borrow a book' prompt'u verirseniz; kaç kitap limiti olduğunu, gecikmiş borç kontrolünü, kitap kopyası kalmadığında ne yapılacağını bilemez ve kafasına göre bir senaryo yazar. AI Unified Process'te `docs/requirements.md` içinde gereksinimler User Story formatında listelenir (FR-012); ancak bu hikayelerin gerçek davranışsal sözleşmesi Use Case dosyalarında (UC-002) yaşar.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The dialectic of User Stories vs Use Cases: User stories ('As a... I want... So that...') were explicitly designed as conversation starters—placeholders for verbal negotiations between product owners and developers. But LLMs cannot engage in informal office banter; they generate code immediately from whatever text they are fed. Feeding an ambiguous user story into an AI coding engine forces the model to invent preconditions, error pathways, and state rollbacks. In the AI Unified Process, user stories express functional requirements in the catalog (`docs/requirements.md`), while use cases encapsulate the multi-path behavioral contract.]
    ]
  )
]

#java25_box[
```java
// Java 25: User Story'nin Use Case Sözleşmesine Dönüştürülmesi
package com.maang.aiup.contract;

public class LibraryContract {
    // 1. User Story: "Bir üye olarak kitap ödünç almak istiyorum..." (Gereksinim Kataloğu)
    public record UserStoryRef(String frId, String summary) {}

    // 2. Use Case: Tüm alternatif akışları içeren somut davranış modeli
    public static class BorrowBookUseCase {
        public static final UserStoryRef TRACES_TO = new UserStoryRef("FR-012", "Book Borrowing Flow");

        public record BorrowResult(boolean success, String message, String dueDate) {}

        public BorrowResult execute(String memberId, String isbn, boolean isOverdue, int currentLoans, int copiesAvailable) {
            // Alternatif Akış A3: Gecikmiş borç kontrolü
            if (isOverdue) return new BorrowResult(false, "A3: Gecikmiş kitap borcunuz var!", null);
            // Alternatif Akış A2: Limit kontrolü
            if (currentLoans >= 5) return new BorrowResult(false, "A2: Maksimum 5 kitap limitine ulaştınız!", null);
            // Alternatif Akış A1: Stok kontrolü
            if (copiesAvailable <= 0) return new BorrowResult(false, "A1: Uygun kopya kalmadı, rezervasyon önerildi.", null);

            // Ana Başarı Akışı
            return new BorrowResult(true, "Kitap başarıyla ödünç verildi.", "2026-11-17");
        }
    }

    void main() {
        var uc = new BorrowBookUseCase();
        var res = uc.execute("M101", "ISBN-123", false, 2, 3);
        System.out.println("Use Case İcrası: " + res);
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
      User Story ile Use Case'i birbirine düşman sanmak büyük bir hatadır. User Story 'Neden ve Kimin için' olduğunu söyler; Use Case ise 'Sistemin adım adım ne yapacağını ve hangi hataları yöneteceğini' belirler.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not treat user stories and use cases as adversarial paradigms. User stories capture business intent and stakeholder value; use cases specify the exhaustive interaction contract and failure topologies.]
    ]
  )
]

#takeaways_box((
    ("User Story konuşma başlatmak için bir jetondur; Use Case ise varılan kararların yaşadığı evdir.", "User stories are tokens for conversation; use cases are where the negotiated details live."),
    ("Tek satırlık kullanıcı hikayesiyle kod üreten AI, tüm köşe vakaları ve kuralları kafasından uydurur.", "Feeding single-sentence user stories to an AI forces it to hallucinate business logic."),
    ("AIUP'ta her Use Case en az bir kullanıcı hikayesine (FR-XXX) mekanik olarak izlenebilir şekilde bağlanır.", "In AIUP, every use case traces mechanically to at least one user story in the requirements catalog."),
))
