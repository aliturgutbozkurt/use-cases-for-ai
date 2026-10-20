#import "/template.typ": *

#show: doc => setup_book(title: "Ders 44: Dilimleme Hiyerarşisi: Önce Temel Akış, Sonra Alternatifler (Bazıları Asla Yapılmaz!)", doc)

#lesson_header(
  44,
  "Dilimleme Hiyerarşisi: Önce Temel Akış, Sonra Alternatifler (Bazıları Asla Yapılmaz!)",
  "The Slicing Order: Basic Flow First, Alternatives by Priority, Some Never Built",
  "Dilimler (Slices), Testler ve İterasyon Döngüsü",
  "Slices, Tests, and the Iteration Loop"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 DİLİMLEME HİYERARŞİSİ VE 'YETERLİ AKIŞ' İLKESİ              │
└─────────────────────────────────────────────────────────────────────────────┘
  
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ ADIM 1: DİLİM 1 ──► TEMEL AKIŞ (Main Success Scenario)                  │
  │ Sadece mutlu yol! Uçtan uca veri tabanına yazar, ekranda başarıyı görür.│
  ├─────────────────────────────────────────────────────────────────────────┤
  │ ADIM 2: DİLİM 2..N ──► YÜKSEK ÖNCELİKLİ ALTERNATİFLER                   │
  │ Kullanıcıların %80'inin karşılaştığı istisnalar (Örn: Stok kalmadı).    │
  ├─────────────────────────────────────────────────────────────────────────┤
  │ ADIM 3: DİLİM X ──► NADİR VE EGZOTİK HATALAR                            │
  │ Sistem arızaları, nadir zaman aşımı senaryoları.                        │
  ├─────────────────────────────────────────────────────────────────────────┤
  │ 🛑 BAZI AKIŞLAR ASLA İNŞA EDİLMEZ! (DELIBERATELY NEVER BUILT):          │
  │ "Yıllık maliyeti 100 TL olan bir hata için 50.000 TL'lik kod yazılmaz!  │
  │  Use case 'Yeterli Akışlar Karşılandı' (Sufficient Flows Fulfilled)     │
  │  durumunda ömür boyu kalabilir. Bu bir eksiklik değil, mühendisliktir!" │
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
      Yeni açılan bir kahve dükkânını düşünün: İlk gün sadece sıcak kahve satarlar (Temel akış). İkinci hafta vanilyalı ve karamelli şuruplar gelir (Öncelikli alternatifler). 'Organik Madagaskar vanilyalı yulaflı latte'yi ise yılda bir kişi sorar diye menüye hiç koymazlar (Asla inşa edilmeyen akış!). Her şeyi aynı anda yapmaya çalışmak dükkânı batırır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Consider opening a new coffee shop: On Day 1, they only brew classic hot coffee (Basic Flow). By Week 2, they introduce caramel and hazelnut syrups (High-priority alternatives). But 'Organic Madagascar Vanilla Bean Oat Milk Cappuccino' is requested once a year, so they never add it to the menu (Deliberately never built!). Slicing prevents capital exhaustion.]
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
      Dilimleme Sırası ve 'Yeterli Akış' Felsefesi: Use-Case 3.0 ve Martinelli'nin metodolojisinde dilimleme sırası katı bir mantığa bağlıdır: 1) Dilim 1 Temel Akış: Sistemin en önemli use case'inin temel akışı, tüm mimari omurgayı (UI, servis, DB, güvenlik) doğrulamak için yeterlidir. 2) Sonraki Dilimler: En sık rastlanan ve iş değeri en yüksek alternatif akışlar sırayla dilimlenir. 3) 'Bazı Akışlar Asla İnşa Edilmez': Geleneksel waterfall zihniyeti şartnamedeki her satırın kodlanmasını şart koşar. Oysa Use-Case 3.0'ın en gerçekçi durumu 'Yeterli Akışlar Karşılandı' (Sufficient Flows Fulfilled) durumudur. Sistem ticari olarak hedefine ulaşmışsa, 5 yılda bir olabilecek çok nadir bir istisna için kod yazmak ve bakım maliyeti üstlenmek israftır. O akış şartnamede analiz edilmiş olarak bekler; manuel operasyonel süreçle idare edilir.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Slicing Order and the 'Sufficient Flows Fulfilled' State: Slicing follows an immutable cadence derived from the additive spec architecture: 1) Slice 1 is strictly the Basic Flow. Implementing the happy path end-to-end verifies the architectural backbone (REST endpoints, persistence, transaction boundaries, UI state) and yields early stakeholder validation. 2) Successive Slices incorporate alternative flows sorted strictly by business priority and risk mitigation. 3) Deliberately Unbuilt Flows: A vital tenet of Use-Case 3.0 is that not every analyzed flow must be implemented. A use case can intentionally reside in 'Sufficient Flows Fulfilled' indefinitely. Engineering rare edge-case automation whose cost exceeds manual operational fallback is anti-pattern waste. The specification documents the path; the business consciously opts not to cut the slice.]
    ]
  )
]

#java25_box[
```java
// Java 25: Dilimlerin Öncelik Sırasıyla Eklemeli (Additive) Olarak Büyütülmesi
package com.maang.aiup.slices;

public class SlicingEvolutionDemo {
    // Aşama 1: Sadece Temel Akış (Slice 1)
    public record BorrowRequest(String bookId, int availableCopies, int currentLoans) {}

    public static class BorrowFlowHandler {
        // Slice 1: Temel Başarı
        public String executeSlice1(BorrowRequest req) {
            return "✅ Kitap ödünç verildi.";
        }

        // Slice 2 Eklenir: A1 (Kopya Yok) ve A2 (Limit Doldu)
        public String executeSlice2(BorrowRequest req) {
            if (req.availableCopies() <= 0) {
                return "⚠️ Alternatif A1: Kopya yok, rezervasyona yönlendirildi.";
            }
            if (req.currentLoans() >= 5) {
                return "❌ Alternatif A2: Limit dolu (5 kitap), işlem engellendi.";
            }
            return executeSlice1(req);
        }
    }

    void main() {
        var handler = new BorrowFlowHandler();
        var normalReq = new BorrowRequest("BK-1", 3, 2);
        var noStockReq = new BorrowRequest("BK-2", 0, 1);

        System.out.println("1. İstek: " + handler.executeSlice2(normalReq));
        System.out.println("2. İstek: " + handler.executeSlice2(noStockReq));
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
      Temel akışı canlıya almadan veya paydaşa onaylatmadan alternatif akışları kodlamaya başlamayın; temel akışta yapılacak bir UI değişikliği tüm alternatifleri çöp edebilir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never begin coding alternative flows before the basic flow is reviewed by stakeholders; a fundamental change in happy path UI invalidates all downstream branches.]
    ]
  )
]

#takeaways_box((
    ("Dilimleme sırası sabittir: Önce temel akış, sonra en sık rastlanan alternatifler.", "The slicing order is fixed: basic flow first, followed by frequent alternatives."),
    ("Her alternatif akışı kodlamak zorunda değilsiniz; bazıları operasyonel olarak çözülür.", "Not all alternative flows must be coded; manual workarounds are often economically sound."),
    ("'Yeterli Akışlar Karşılandı' durumu bir use case için tamamen geçerli bir bitiş durumudur.", "'Sufficient Flows Fulfilled' is a valid, mature end-state for a production use case."),
))
