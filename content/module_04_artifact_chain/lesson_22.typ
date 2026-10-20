#import "/template.typ": *

#show: doc => setup_book(title: "Ders 22: <<include>> ve <<extend>> Hakkındaki Gerçek: Neden Neredeyse Hiç İhtiyacınız Yok?", doc)

#lesson_header(
  22,
  "<<include>> ve <<extend>> Hakkındaki Gerçek: Neden Neredeyse Hiç İhtiyacınız Yok?",
  "The Truth About <<include>> and <<extend>>: Why You Almost Never Need Them",
  "Eser Zinciri (Artifact Chain) & PlantUML Mimarisi",
  "The Artifact Chain & PlantUML Architecture"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 <<INCLUDE>> VE <<EXTEND>> TUZAĞI VE MODERN ÇÖZÜM            │
└─────────────────────────────────────────────────────────────────────────────┘
  1. ESKİ YANLIŞ KULLANIM (AŞIRI MÜHENDİSLİK):
     [ Kitap Ödünç Al ] ──<<include>>──▶ [ Kullanıcıyı Giriş Yaptır ] (YANLIŞ!)
     [ Kitap Ödünç Al ] ──<<include>>──▶ [ Veritabanına Bağlan ]     (FACİA!)
     * Kimlik doğrulama bir include DEĞİLDİR; o bir ÖNKOŞULDUR (Precondition)!

  2. MODERN AIUP KURALI:
     - <<include>>: SADECE gerçekten 3'ten fazla use case tarafından paylaşılan
                    ve bağımsız değeri olan ağır bir alt akış varsa kullanılır (Nadir!).
     - <<extend>>:  Yazılımı anlamayı imkansızlaştırır; AIUP'ta NEREDEYSE HİÇ KULLANILMAZ!
     - Kural: Basit tutun! Bir akış diğerini çağıracaksa referans verin: (UC-005 Reserve Book).
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Eski modelciler yemek yaparken her hareket için ayrı bir döküman açmaya bayılırdı: 'Yemek Pişir' use case'i, 'Tuzluğu Tut' use case'ini `\<\<include>>` eder; 'Tuzluğu Tut' ise 'Kapağı Aç'ı `\<\<include>>` ederdi. Sonunda kimse yemek pişiremez hale gelirdi! 'Giriş Yap' bir include değildir; mutfağa girmeden önce kapının anahtarla açılmış olması bir önkoşuldur (Precondition). Akıllı bir usta gibi davranın: Birbirine bağlı gereksiz oklar çizmeyi bırakın, sadece ana işi yazın!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Bureaucratic modelers loved fracturing simple recipes: 'Cook Omelet' would `\<\<include>>` 'Grasp Salt Shaker', which would `\<\<include>>` 'Unscrew Cap'. The kitchen ground to a halt under paper overload. Authentication is not an included sub-routine; having unlocked the kitchen door is a static Precondition. In the AI era, procedural spaghetti arrows between ellipses confuse AI parsers. Omit them.]
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
      \<\<include>> ve \<\<extend>> İlişkilerinin Çöküşü: UML tarihindeki en büyük kafa karışıklığı ve zaman israfı bu iki anahtar kelimeden doğmuştur. Cockburn 2001'de açıkça uyarmıştı: 'Alt use case'ler pahalıdır; yalnızca yeniden kullanılabilirlik veya aşırı okunabilirlik gerektiren durumlarda mazur görülebilir. Pratikte bu kural şuna indirgenir: Neredeyse hiçbir zaman!' AI Unified Process'te bu kural daha da katılaşır: 1) Kimlik Doğrulama Bir Include Değildir: 'Kullanıcı Girişi' (Log In) asla bir include olarak her senaryoya bağlanamaz; o bir Önkoşuldur (Preconditions: The member is signed in). Önkoşul olarak yazıldığında bir rota korumasına (Route Guard) dönüşür ve akışın içinde tekrar tekrar doğrulanmaz. 2) \<\<extend>> Yasağı: Extend ilişkisi akışın dışarıdan bir şarta bağlı olarak use case'e enjekte edilmesidir; akışın nerede dallandığını gizler ve hem insanı hem AI'ı şaşırtır. AIUP'ta extend yerine Alternatif Akışlar (A1, A2) kullanılır. 3) Handoff by Reference: Eğer bir use case başka bir use case'i tetikleyecekse, ok çizmek yerine alternatif akışın içine parantez içinde link verilir: `3. If the member accepts, system records reservation (UC-005 Reserve Book).` Hafif, temiz ve sıfır karmaşıklık!
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Deconstruction of \<\<include>> and \<\<extend>>: UML literature generated decades of futile debate over relationship arrows. Cockburn's original rule of thumb: sub-use cases carry immense overhead; they are justified strictly by cross-functional reuse. In practice, this heuristic collapses to: almost never. In the AI Unified Process: 1) Authentication is never an Include: Injecting 'Log In' via `\<\<include>>` into 20 different use cases is an architectural anti-pattern. Authentication is a Precondition ('The member is signed in'). Preconditions translate cleanly into Spring Security filters or gateway route guards, bypassing in-flow redundant validations. 2) The Banishment of \<\<extend>>: Extension points fragment execution context across disjointed files, baffling human reviewers and confusing AI generators. All conditional deviations belong in named Alternative Flows (A1, A2). 3) Handoff by Reference: When a use case legitimately triggers another, it invokes it inline via alphanumeric citation: `(UC-005 Reserve Book)` without drawing complex UML dependency webs.]
    ]
  )
]

#java25_box[
```java
// Java 25: <<include>> Yerine Önkoşul (Route Guard) ve Referans ile Çağrı Modeli
package com.maang.aiup.relationships;

public class RelationshipModernPatterns {
    // ❌ YANLIŞ: Her use case içinde kimlik doğrulama include'u çalıştırmak.
    // ✅ DOĞRU: Önkoşul (Precondition) güvenlik filtresinde çözülür:
    public record AuthenticatedUser(String id, String role) {}

    public static class CleanBorrowService {
        // Önkoşul sistem tarafından garantilenmiştir (Guarded Entry)
        public void borrow(AuthenticatedUser user, String bookId) {
            // Include yok! Doğrudan iş kuralı ve referans var:
            boolean bookAvailable = false;

            if (!bookAvailable) {
                // Handoff by reference: UC-005 Reserve Book tetiklenir!
                triggerReserveBookUseCase(user, bookId);
                return;
            }
            System.out.println("Ödünç tamamlandı.");
        }

        private void triggerReserveBookUseCase(AuthenticatedUser user, String bookId) {
            System.out.printf("UC-005 Reserve Book devreye girdi: %s için rezervasyon yapıldı.%n", user.id());
        }
    }

    void main() {
        var service = new CleanBorrowService();
        service.borrow(new AuthenticatedUser("U1", "MEMBER"), "BK-44");
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
      Bir PlantUML diyagramında 10'dan fazla \<\<include>> ve \<\<extend>> oku görüyorsanız o diyagram çöp olmuştur. Hepsini silin; kimlik doğrulamayı önkoşul yapın, dallanmaları ise alternatif akışlara taşıyın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[If a use case diagram resembles a spiderweb of `\<\<include>>` and `\<\<extend>>` arrows, the model is deeply corrupted. Purge them. Move authentication to Preconditions and push deviations into local Alternative Flows.]
    ]
  )
]

#takeaways_box((
    ("Kimlik doğrulama bir <<include>> değildir; senaryo öncesi bir Önkoşuldur (Precondition).", "Authentication is never an include; it is an established Precondition."),
    ("<<extend>> ilişkisi akışı gizler ve karmaşıklaştırır; AIUP'ta bunun yerine Alternatif Akışlar kullanılır.", "`<<extend>>` obscures control flow; use explicit Alternative Flows instead."),
    ("Başka bir use case'e geçiş, senaryo adımı içinde referans verilerek (UC-005 Reserve Book) hafifçe çözülür.", "Hand off between use cases lightly by inline reference: (UC-005 Reserve Book)."),
))
