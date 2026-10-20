#import "/template.typ": *

#show: doc => setup_book(title: "Ders 15: Hedef İrtifası: Neden Deniz Seviyesinde (Sea Level) Yazıyoruz? (Bulut ve Balık Tuzakları)", doc)

#lesson_header(
  15,
  "Hedef İrtifası: Neden Deniz Seviyesinde (Sea Level) Yazıyoruz? (Bulut ve Balık Tuzakları)",
  "Goal Altitude: Why We Write at Sea Level (Avoiding Kite & Fish Traps)",
  "Temel Esaslar: Aktörler, Deniz Seviyesi Hedefler & Paydaş Sözleşmeleri",
  "Core Fundamentals: Actors, Sea-Level Goals & Contracts"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ALISTAIR COCKBURN'ÜN HEDEF İRTİFALARI                    │
└─────────────────────────────────────────────────────────────────────────────┘
  ☁️ BULUT SEVİYESİ (KITE / CLOUD - Çok Yüksek):
  "Kütüphaneyi İşlet" (Run the Library)
  ❌ Çok geniş! Günler/haftalar sürer. AI tahmin edemez, devasa bir monolit uydurur!
     (Bu seviye Inception aşamasındaki BPMN İş Sürecine aittir!)

  🌊 DENİZ SEVİYESİ (SEA LEVEL / USER-GOAL - TAM İDEAL NOKTA!):
  "Kitap Ödünç Al" (Borrow Book) / "Rezervasyon Yap" (Reserve Book)
  ✅ TEK KİŞİ, TEK YERDE, TEK OTURUMDA (2 - 20 DAKİKA) tamamlar!
  ✅ Aktör işi bitince sistemin başından mutlu ayrılır!

  🐟 BALIK SEVİYESİ (FISH / SUBFUNCTION - Çok Alçak / Su Altı):
  "ISBN Kodunu Doğrula" / "Açılır Menüyü Aç"
  ❌ Çok küçük! Kendi başına bir iş değeri yoktur. Bir use case değil, bir alt adımdır!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir restorana gittiğini hayal et: 1) Bulut Seviyesi: 'Beni doyur ve ömrümün sonuna kadar besle' demek gibidir (Çok genel, garson ne yapacağını şaşırır). 2) Balık Seviyesi: 'Garsona çatalı uzatmasını söyle, çatalı sol eline al, ağzını 3 santim aç' demektir (Gereksiz detayda boğulursun). 3) Deniz Seviyesi: 'Bir porsiyon mantı getir' demektir! Siparişini verirsin, yersin, hesabı öder mutlu bir şekilde masadan kalkarsın (20 dakika, tek oturum!). Use case'ler daima deniz seviyesinde yazılır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[At a restaurant: 1) Cloud Level: Demanding 'Nourish my biological existence for the next forty years.' (Absurdly broad, paralyzes the waiter). 2) Fish Level: 'Extend index finger, wrap around fork tine, elevate elbow 15 degrees.' (Absurdly granular, micromanages physical mechanics). 3) Sea Level: 'Order the ribeye steak.' You order, dine, settle the bill, and leave satisfied in 45 minutes. Use cases exist strictly at sea level.]
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
      Hedef Seviyeleri (Goal Levels) ve Mühendislik Dengesi: Cockburn use case yazımındaki en zor zanaatin doğru irtifayı bulmak olduğunu söyler: 1) Su Altı / Balık Seviyesi (Subfunctions): 'Kullanıcı Adı Kontrolü' veya 'Kredi Kartı Format Doğrulama' birer use case değildir; bir ana hedefin içindeki basit birer adımdır. Eğer bunları use case yaparsanız, sistem 500 tane anlamsız, bağlamsız, başı sonu olmayan dosya parçasına bölünür (Fragment Monolith). AI bunlardan kod üretirken bağımlılıkları bağlayamaz. 2) Bulut Seviyesi (Summary Goals): 'Hastaneyi Yönet' veya 'Tedarik Zincirini Çalıştır'. Bunlar birden fazla kişinin günlerce süren oturumlarını kapsar. Bu süreçler use case değil, BPMN iş süreçleridir. 3) Deniz Seviyesi Testi: Bir hedefin deniz seviyesinde olduğunu anlamanın iki turnusol kağıdı vardır: a) 'Neden?' sorusu bir üst seviyeyi (bulut), 'Nasıl?' sorusu bir alt seviyeyi (balık) verir. b) Tek bir aktör, tek bir yerde, tek bir oturumda (2 ila 20 dakika içinde) bitirip sistemin başından mutlu ayrılıyor mu? AIUP'ta tüm use case'ler istisnasız deniz seviyesinde yazılır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Goal Altitude Taxonomy: 1) Fish Level (Subfunction): Underwater activities like 'Validate ISBN' or 'Query Customer Record'. They deliver zero standalone business utility. Elevating them to use case artifacts fractures the architecture into hundreds of disconnected fragments that confuse LLMs. 2) Cloud Level (Summary Goal): Multi-day, multi-party business workflows ('Manage Inventory', 'Run Logistics'). These belong in Inception BPMN diagrams, not functional specs. 3) Sea Level (User-Goal Level): The sweet spot. Cockburn's litmus test: executed by one person, in one location, in one sitting (2 to 20 minutes), concluding with the actor walking away with completed business value. LLMs generate cohesive services and comprehensive test harnesses when bounded strictly to sea-level scope.]
    ]
  )
]

#java25_box[
```java
// Java 25: Deniz Seviyesi Use Case Sınırı (Ne Çok Büyük Ne Çok Küçük)
package com.maang.aiup.altitude;

public class SeaLevelUseCaseDemo {
    // ❌ BALIK SEVİYESİ (Ayrı bir use case DEĞİL, sadece bir metod/kuraldır):
    public static boolean validateIsbn(String isbn) {
        return isbn != null && isbn.startsWith("978");
    }

    // ✅ DENİZ SEVİYESİ (Gerçek Use Case: Tek Oturum, Tek Hedef, Tam Değer):
    public record BorrowBookRequest(String memberId, String isbn) {}
    public record BorrowBookResponse(boolean success, String receiptId) {}

    public static class BorrowBookService {
        public BorrowBookResponse execute(BorrowBookRequest request) {
            // Balık seviyesi kontroller içeride çağrılır:
            if (!validateIsbn(request.isbn())) {
                throw new IllegalArgumentException("Geçersiz ISBN!");
            }
            // Deniz seviyesi iş tamamlanır:
            return new BorrowBookResponse(true, "RCPT-" + System.currentTimeMillis());
        }
    }

    void main() {
        var service = new BorrowBookService();
        var resp = service.execute(new BorrowBookRequest("M-1", "978-0134685991"));
        System.out.println("Deniz seviyesi use case tamamlandı: " + resp);
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
      'Müşteri Ara' bir use case değildir! Müşteri ara butonuna basıp ekranı kapatıp evine giden kimse mutlu olmaz. Müşteri 'Siparişi İptal Etmek' için aranır; asıl use case sipariş iptalidir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))['Search Customer' is rarely a sea-level use case. Nobody logs into a banking app simply to gaze at a customer profile and log out satisfied. They search in order to transfer funds or update an address. The user goal is the transfer.]
    ]
  )
]

#takeaways_box((
    ("Use case'ler daima deniz seviyesinde yazılır: Tek kişi, tek yerde, tek oturumda (2-20 dk).", "Use cases must be drafted at sea level: one person, in one place, in one sitting (2-20 min)."),
    ("Balık seviyesi hedefler (Validate ISBN) use case değil, bir use case'in içindeki adımlardır.", "Fish-level tasks are implementation steps or validations, not independent use cases."),
    ("Bulut seviyesi hedefler (Run Company) use case değil, Inception aşamasındaki BPMN süreçleridir.", "Cloud-level workflows belong in high-level BPMN business process diagrams."),
))
