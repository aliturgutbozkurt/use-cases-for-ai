#import "/template.typ": *

#show: doc => setup_book(title: "Ders 38: Zone 1 (Gözlemlenebilir Davranış): Somut Arayüz Yapısı, Kolonlar ve İş Miktarları", doc)

#lesson_header(
  38,
  "Zone 1 (Gözlemlenebilir Davranış): Somut Arayüz Yapısı, Kolonlar ve İş Miktarları",
  "Zone 1 (Observable Behavior): Concrete Interface Structure, Columns & Quantities",
  "Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?",
  "Precision for AI — What to Say and What to Leave Out"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 ZONE 1: GÖZLEMLENEBİLİR DAVRANIŞ HARİTASI                   │
└─────────────────────────────────────────────────────────────────────────────┘
  
  ❌ YETERSİZ TANIMLAMA (UNDER-SPECIFIED):
  1. "Sistem kitapları gösterir."
  2. "Sistem kullanıcıyı borçlar hakkında uyarır."
  💥 AI Ne Yapar?: Hangi kolonları koysun? ID mi, Basım yılı mı? Uyarıda ne yazsın?
  
  ✅ ZONE 1 SOMUT TANIMLAMA (CONCRETE & AUDITABLE):
  1. "Sistem kitapları Başlık (artan alfabetik), Yazar, ISBN ve Mevcut Kopya
      kolonlarından oluşan bir tabloda listeler."
  2. "Sistem kullanıcıya gecikmiş borçları nedeniyle ödünç alma işleminin
      engellendiğini bildirir ve geciken kitapların listesini gösterir."
  
  📋 ZONE 1 İÇİNDE YER ALANLAR:
  ├── 1. Görüntülenen alanlar ve sıralama (Örn: 'Title ascending')
  ├── 2. Kesin iş miktarları (Örn: '28 gün', 'en fazla 5 ödünç')
  ├── 3. Hata/Onay mesajının içeriği (Widget tipi değil, anlamsal içerik!)
  └── 4. Bir kerede girilen veriler (Entity adıyla paketlenmiş)
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Anneannenize market alışveriş listesi yazdığınızı düşünün: 'Bana biraz meyve al' derseniz anneanneniz erik yerine greyfurt getirebilir ve suçlayamazsınız! Ama '3 tane Amasya elması, 1 kilo yerli muz' yazarsanız tam istediğiniz gelir. Zone 1, alışveriş listesindeki meyvenin tam adı ve adedidir. Widget'ın poşet mi file mi olduğu önemli değildir; içindeki elmanın cinsi bellidir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of writing a grocery list: If you write 'Buy some fruit', you might get sour lemons instead of sweet strawberries, and you can't complain! But if you write '3 Honeycrisp apples and 1 kg of bananas', you get precisely what you crave. Zone 1 is the exact fruit and quantity. Whether carried in a plastic bag or a wicker basket is irrelevant; the fruit itself is unambiguous.]
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
      Zone 1'in Derin Mühendisliği (Observable Behavior): AI destekli kod üretiminde şartnamelerin en çok tökezlediği yer Zone 1 eksikliğidir. Geliştirici 'Sistem sipariş detayını gösterir' yazdığında, insan bir yazılımcı şirketin önceki ekranlarına bakarak siparişte hangi alanların olduğunu hatırlar. Ancak bir LLM için bağlam sınırlıdır; 'sipariş detayı' adımından yola çıkarak rastgele DTO'lar, gereksiz kolonlar veya eksik alanlar üretir. Martinelli Zone 1 kurallarını şöyle netleştirir: 1) İsimlendirilmiş Kolonlar ve Sıralama: Tabloda hangi kolonların çıkacağı ve listenin neye göre sıralanacağı yazılmalıdır ('Sistem Grid üzerinde Başlık, Yazar, ISBN ve Stok kolonlarını Başlığa göre artan sırada gösterir'). 2) Kesin İş Miktarları: Asla 'yakında', 'birkaç tane' denemez; 'bugünden itibaren 28 gün sonra', 'en fazla 5 açık ödünç' denmelidir. 3) Hata Mesajının Anlamsal Özü: 'Hata gösterir' denemez; 'Ödünç almanın geciken kitaplar yüzünden engellendiğini bildirir ve geciken kitapları listeler' denmelidir.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Zone 1 Precision Engineering: Under-specification in Zone 1 is the single greatest cause of prompt hallucination and code drift. When an engineer specifies 'System displays order details', human developers infer missing fields from adjacent legacy screens. An AI model, having no coffee-machine memory, invents arbitrary fields or omits mission-critical data. Zone 1 demands explicit observable facts: 1) Named Columns and Sort Orders: Define exact fields and orderings ('Grid showing Title, Author, ISBN, Available Copies sorted by Title ascending'). 2) Exact Business Quantities: Never write 'shortly' or 'a few'; declare exact constants ('due date 28 days from today', 'at most 5 loans'). 3) Message Content, Not Widgets: Never prescribe dialog boxes; mandate observable content ('System informs member that borrowing is blocked while loans are overdue and lists the overdue items').]
    ]
  )
]

#java25_box[
```java
// Java 25: Zone 1 Gözlemlenebilir Veri Sözleşmesi (Named Columns & Ordering)
package com.maang.aiup.zone1;

import java.util.Comparator;
import java.util.List;

public class CatalogDisplayService {
    // Zone 1 Tanımı: Title, Author, ISBN, AvailableCopies
    public record BookCatalogItem(String title, String author, String isbn, int availableCopies) {}

    public static class CatalogQueryHandler {
        public List<BookCatalogItem> fetchSortedCatalog(List<BookCatalogItem> rawItems) {
            // Şartname Kuralı: "sorted by Title ascending"
            return rawItems.stream()
                .sorted(Comparator.comparing(BookCatalogItem::title, String.CASE_INSENSITIVE_ORDER))
                .toList();
        }
    }

    void main() {
        var items = List.of(
            new BookCatalogItem("The Pragmatic Programmer", "Hunt & Thomas", "978-0201616224", 3),
            new BookCatalogItem("Clean Code", "Robert C. Martin", "978-0132350884", 0),
            new BookCatalogItem("Design Patterns", "GoF", "978-0201633610", 2)
        );

        var service = new CatalogQueryHandler();
        var sorted = service.fetchSortedCatalog(items);
        
        System.out.println("✅ Zone 1 Uyumu: Başlığa göre sıralı katalog tablosu:");
        sorted.forEach(b -> System.out.println("   -> [" + b.title() + "] by " + b.author() + " (Stok: " + b.availableCopies() + ")"));
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
      Zone 1'de arayüz bileşenlerinin adlarını yazmayın: 'Modal popup açılır', 'Dropdown menü gösterilir' veya 'Toast mesajı fırlar' YAZMAYIN! Bunlar Zone 3 ihlalidir. Sadece içeriği ve aksiyonu söyleyin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never mandate concrete UI widgets in Zone 1 (e.g., 'A modal pop-up appears' or 'Dropdown renders'). Specify the information conveyed and user actions, not visual presentation widgets.]
    ]
  )
]

#takeaways_box((
    ("Tablolardaki kolon isimlerini ve sıralama ölçütünü (sort order) şartnamede açıkça belirtin.", "Explicitly state displayed column names and sorting orders in the specification."),
    ("İş kurallarındaki sayısal sınırları ('28 gün', '5 limit') net olarak yazın; yuvarlak laflardan kaçının.", "Use precise business quantities ('28 days', '5 loans') rather than vague approximations."),
    ("Hata mesajlarının biçimini değil, kullanıcıya ilettiği zorunlu bilgi içeriğini tarif edin.", "Specify the informative payload of error messages, not the UI container or toast widget."),
))
