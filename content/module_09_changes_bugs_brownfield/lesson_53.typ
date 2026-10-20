#import "/template.typ": *

#show: doc => setup_book(title: "Ders 53: Uç Noktaları Birleştirme: 40 REST Endpoint'ini 4-8 Use Case'e İndirgeme", doc)

#lesson_header(
  53,
  "Uç Noktaları Birleştirme: 40 REST Endpoint'ini 4-8 Use Case'e İndirgeme",
  "Aggregating Endpoints: Collapsing 40 REST Endpoints into 4-8 Use Cases",
  "Değişiklik Talepleri, Hatalar (Bugs) ve Mevcut (Brownfield) Sistemler",
  "Change Requests, Bugs, and Brownfield Systems"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 REST ENDPOINT ÇÖPLÜĞÜNÜ USE CASE'E İNDİRGEME                │
└─────────────────────────────────────────────────────────────────────────────┘
  
  Mevcut 40 Adet REST Endpoint'i:
  POST   /api/v1/books
  GET    /api/v1/books/{id}
  PUT    /api/v1/books/{id}
  DELETE /api/v1/books/{id}
  GET    /api/v1/books/search
  PATCH  /api/v1/books/{id}/status
  ... (40 tane dağınık teknik URL)
                      │
                      ▼ 🧹 TOPLULAŞTIRMA (AGGREGATION RULE)
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ 1. UC-001: Kitap Arama (Search Catalog)                                 │
  │    - Aktör: Üye, Amaç: Kitap bulmak                                     │
  ├─────────────────────────────────────────────────────────────────────────┤
  │ 2. UC-002: Kitap Ödünç Alma (Borrow Book)                               │
  │    - Aktör: Üye, Amaç: Kitabı eve götürmek                              │
  ├─────────────────────────────────────────────────────────────────────────┤
  │ 3. UC-003: Kitap Envanterini Yönetme (Manage Books)                     │
  │    - Aktör: Kütüphaneci, Amaç: CRUD (Ekle, Güncelle, Sil, Listele)      │
  └─────────────────────────────────────────────────────────────────────────┘
  🎯 SONUÇ: 40 teknik URL çöplüğü, 4-8 adet insan ve AI tarafından
            anlaşılabilir gerçek deniz seviyesi hedefe indirgenir!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir akıllı telefonun içini açarsanız 500 tane lehimli kablo ve devre görürsünüz. Ama ekranı açtığınızda sadece 4 ikon görürsünüz: Telefon, Mesajlar, Kamera, Ayarlar! Kimse lehim kablosuyla uğraşmak istemez. İşte 40 REST endpoint'i o lehim kablolarıdır; 4-8 use case ise ekrandaki sade ve kullanışlı uygulama ikonlarıdır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[If you pry open an iPhone, you find 500 soldered micro-circuits and copper ribbons. But on the screen, you only interact with 4 icons: Phone, Messages, Camera, Settings! Nobody wants to touch raw solder. Forty REST endpoints are internal wiring; 4 to 8 use cases are the clean, intuitive app icons on the home screen!]
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
      Endpoint Toplulaştırma ve 'Manage X' Kuralı: Brownfield projelerde yapılan en yaygın hata, her bir Controller metodunu veya REST endpoint'ini bir use case zannetmektir. Bir projede 40 endpoint varsa, 40 tane use case yazmaya kalkan bir ekip şartname çöplüğünde boğulur. Martinelli'nin altın kuralı: 'Controller'lar, rotalar ve ekranlar use case değildir; use case'in delilleridir. Onları toplulaştırın!' 5 farklı CRUD endpoint'i (Create, Read, Update, Delete, List) aynı aktöre ve aynı veri akışına hizmet ettiği sürece tek bir 'Manage Books' use case'idir. Ancak ne zaman bir işlem kendi bağımsız iş kurallarına ve güvenlik rollerine sahip olursa (örn: 'Block Customer'), o zaman o işlem 'Manage X' çatısından ayrılıp kendi eylem seviyesi (action-level) use case'ine dönüşür. Tipik bir mikroservis bu yöntemle 4 ila 8 arası derli toplu use case'e indirgenir.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Endpoint Aggregation and the 'Manage X' Heuristic: The fatal pitfall in legacy recovery is mistaking technical controllers or routes for use cases. Documenting 40 use cases for 40 HTTP endpoints yields bureaucratic paralysis. Martinelli's rule: 'Controllers, routes, and views are evidence of use cases, not use cases. Aggregate them.' Five REST endpoints (`POST /books`, `PUT /books/{id}`, `GET /books`, `DELETE /books/{id}`) are consolidated into a single 'Manage Books' use case so long as they share an identical actor and shape. Only when a sub-operation acquires unique preconditions, distinct role-guards, or diverging state transitions (e.g., 'Archive Book' requiring audit approval) does it split out as an action-level use case. A production microservice typically condenses into 4 to 8 user-goal specifications.]
    ]
  )
]

#java25_box[
```java
// Java 25: 4 REST Endpoint'inin Tek Bir 'ManageBooks' Servisinde Toplulaştırılması
package com.maang.aiup.aggregation;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class EndpointAggregationDemo {
    public record BookRecord(String id, String title, String author) {}

    // Tek bir 'UC-003: Manage Books' use case'i altındaki CRUD operasyonları
    public static class ManageBooksUseCase {
        private final Map<String, BookRecord> db = new ConcurrentHashMap<>();

        public void createBook(BookRecord book) { db.put(book.id(), book); }
        public BookRecord readBook(String id) { return db.get(id); }
        public void updateBook(BookRecord book) { db.put(book.id(), book); }
        public void deleteBook(String id) { db.remove(id); }
    }

    void main() {
        var uc = new ManageBooksUseCase();
        uc.createBook(new BookRecord("B1", "Effective Java", "Joshua Bloch"));
        System.out.println("✅ 4 REST endpoint'i tek bir 'Manage Books' use case'inde toplulaştırıldı.");
        System.out.println("   -> Okunan Kitap: " + uc.readBook("B1"));
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
      Her HTTP GET veya POST isteği için ayrı bir use case dosyası açmayın! CRUD işlemlerini tek bir 'Manage X' altında toplayın; yalnızca kuralları ayrışan işlemleri split edin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not generate individual use case documents for every HTTP GET or POST route. Aggregate standard CRUD into 'Manage X'; split only when business policies diverge.]
    ]
  )
]

#takeaways_box((
    ("REST uçları use case değildir; use case'in varlığına işaret eden teknik izlerdir.", "REST endpoints are not use cases; they are technical evidence of underlying use cases."),
    ("Aynı aktör ve akışı paylaşan CRUD işlemleri tek bir 'Manage X' altında toplanır.", "CRUD operations sharing the same actor and flow aggregate into a single 'Manage X' spec."),
    ("Tipik bir kurumsal mikroservis 40 endpoint'ten 4-8 anlamlı use case'e indirgenir.", "A typical microservice condenses from 40 low-level routes into 4 to 8 meaningful use cases."),
))
