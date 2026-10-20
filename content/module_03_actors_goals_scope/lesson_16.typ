#import "/template.typ": *

#show: doc => setup_book(title: "Ders 16: Kapsam Denetimi & In/Out Listesi: Kapsam Kaymasını ve AI Halüsinasyonunu Engelleme", doc)

#lesson_header(
  16,
  "Kapsam Denetimi & In/Out Listesi: Kapsam Kaymasını ve AI Halüsinasyonunu Engelleme",
  "Scope Control & The In/Out List: Preventing Scope Creep & AI Hallucinations",
  "Temel Esaslar: Aktörler, Deniz Seviyesi Hedefler & Paydaş Sözleşmeleri",
  "Core Fundamentals: Actors, Sea-Level Goals & Contracts"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 COCKBURN'ÜN IN / OUT LİSTESİ İLE KAPSAM KİLİTLEME           │
└─────────────────────────────────────────────────────────────────────────────┘
  SİSTEM: KÜTÜPHANE YÖNETİM SİSTEMİ (LIBRARY SYSTEM)

  KAPSAM İÇİNDE (IN)                      │ KAPSAM DIŞINDA (OUT) - ASLA ÜRETME!
  ────────────────────────────────────────┼────────────────────────────────────
  - Katalogda kitap arama                 │ - Çevrimiçi kredi kartı ile ödeme
  - Kitap ödünç alma & iade               │ - Sesli kitap (Audiobook) streaming
  - Gecikme cezası hesaplama              │ - Kargo ile eve kitap teslimatı
  - E-posta ile iade hatırlatması         │ - Kafeterya entegrasyonu ve kahve siparişi

  🛡️ GÖREVİ: AI ajanının 'Out' kolonundaki özellikleri kafasına göre
             koda eklemesini (Scope Hallucination) %100 engeller!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir marangoza 'Bana bir çalışma masası yap' dediğinde, marangoz kendi kendine gaza gelip masanın altına mini buzdolabı, üstüne disko ışığı ve kenarına masaj aleti takmaya kalkabilir. Cockburn'ün In/Out listesi masanın üstüne koyduğun kırmızı listedir: 'Masa yapılacak: EVET. Çekmece olacak: EVET. Buzdolabı: KESİNLİKLE HAYIR! Disko topu: HAYIR!' Marangoz (veya AI) bu kırmızı listeyi görünce haddini bilir, sadece senden isteneni yapar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Commissioning a carpenter to build a desk without boundary limits might inspire them to mount a mini-fridge, cup warmer, and neon strip lights to the wood. An In/Out list is the contract pinned to their workbench: 'Oak tabletop: IN. Two pencil drawers: IN. Refrigeration unit: OUT. Ambient LED lighting: OUT.' AI agents possess expansive latent knowledge; without an explicit OUT boundary, they aggressively generate out-of-scope fluff.]
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
      Tasarım Kapsamı (Design Scope) ve In/Out Disiplini: Cockburn'ün geliştirdiği 'In/Out Listesi', yazılım tarihindeki en ucuz ve en etkili kapsam yönetimi aracıdır. Masaya oturup 10 dakika içinde neyin sistemin içinde neyin kesinlikle dışında olduğunu bir tabloya yazmak, haftalar süren kapsam kaymasını (Scope Creep) önler. AI Unified Process'te bu liste iki kat daha hayatidir: LLM'ler eğitim verilerindeki kalıpları tekrarlamaya meyillidir. Örneğin bir 'Kütüphane Ödünç Alma' sistemi tasarlarken, AI internette gördüğü Amazon veya e-ticaret sitelerinden esinlenerek 'Kredi Kartıyla Ödeme' veya 'Ev Adresine Kargo Takibi' gibi devasa modülleri koda eklemeye kalkar. Şartnamenin ve vizyon dökümanının (`docs/vision.md`) başındaki In/Out tablosu, AI ajanının bu gereksiz özellikleri üretmesini kesin olarak bloke eder. Sistem bir kara kutu (black box) olarak sınırlandırılır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Architectural Scope Boundaries via the In/Out List: Design scope defines the black-box perimeter of the target system. Cockburn's In/Out list remains the most cost-effective governance instrument in engineering: spending 10 minutes debating boundary edge cases prevents months of scope creep. In the AI Unified Process, the In/Out list acts as a hard negative-constraint prompt for autonomous coders. LLMs inherently suffer from feature inflation: prompt an agent to build an inventory tool, and it instinctively hallucinates Stripe checkout flows or third-party courier dispatchers because modern public repos frequently couple them. Explicitly documenting the OUT column creates a structural barrier against generative overreach.]
    ]
  )
]

#java25_box[
```java
// Java 25: Kapsam Dışına Çıkmayı Engelleyen Sınırlandırılmış Servis Modeli
package com.maang.aiup.scope;

public class BoundedLibraryService {
    public record BorrowRequest(String memberId, String bookId) {}

    // IN Kapsamı: Sadece kütüphane içi ödünç alma işlemi
    public void processBorrow(BorrowRequest req) {
        System.out.println("IN Kapsamı: Kitap ödünç işlemi yapıldı: " + req.bookId());
    }

    // OUT Kapsamı Uyarısı: AI bu metodları uydurmaya kalkarsa derleme/mimari testleri engeller
    // public void processOnlineCreditCardPayment(...) -> YASAK (docs/vision.md OUT listesi!)
    // public void dispatchHomeDeliveryCargo(...)     -> YASAK (docs/vision.md OUT listesi!)

    void main() {
        var service = new BoundedLibraryService();
        service.processBorrow(new BorrowRequest("M-10", "BK-99"));
        System.out.println("✅ Kapsam sınırları başarıyla korundu.");
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
      In/Out listesi yaparken OUT kolonunu boş bırakmayın! Bir sistemde neyin yapılmayacağını söylemek, neyin yapılacağını söylemek kadar önemlidir. AI 'yapılmayacaklar' listesinden güç alır.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never leave the OUT column empty. Declaring what the system will NOT do is just as critical as defining its features. Negative constraints narrow the AI's generation space exponentially.]
    ]
  )
]

#takeaways_box((
    ("In/Out listesi 10 dakikada hazırlanır ve haftalar sürecek kapsam kaymasını engeller.", "An In/Out list takes 10 minutes to draft and prevents weeks of costly scope drift."),
    ("AI geniş eğitim verisi yüzünden kapsam dışı e-ticaret/ödeme özellikleri uydurmaya meyillidir.", "AI is prone to hallucinating out-of-scope enterprise features from its training data."),
    ("OUT kolonu, yapay zekanın tasarım uzayını daraltan en güçlü negatif kısıttır.", "The OUT column provides the strongest negative prompt boundary for code generation."),
))
