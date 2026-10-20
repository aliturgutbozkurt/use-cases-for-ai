#import "/template.typ": *

#show: doc => setup_book(title: "Ders 19: 6 Halkalı Eser Zinciri: Vizyondan Koda Tasarım Uzayını Daraltma", doc)

#lesson_header(
  19,
  "6 Halkalı Eser Zinciri: Vizyondan Koda Tasarım Uzayını Daraltma",
  "The 6-Link Artifact Chain: Narrowing Design Space from Vision to Code",
  "Eser Zinciri (Artifact Chain) & PlantUML Mimarisi",
  "The Artifact Chain & PlantUML Architecture"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 AI UNIFIED PROCESS 6 HALKALI ESER ZİNCİRİ                    │
└─────────────────────────────────────────────────────────────────────────────┘
  1. VİZYON (docs/vision.md) ──▶ [ Tek elle yazılan insan eseri! ]
        │
        ▼ /requirements
  2. GEREKSİNİM KATALOĞU (docs/requirements.md) ──▶ [ FR-XXX, NFR-XXX, C-XXX ]
        │
        ▼ /entity-model & /use-case-diagram
  3. VARLIK MODELİ (docs/entity_model.md) ──┬──▶ [ Mermaid ERD + Nitelikler ]
  4. USE CASE DİYAGRAMI (docs/use_cases.puml)┘  ▶ [ PlantUML İçindekiler Tablosu ]
        │
        ▼ /use-case-spec
  5. USE CASE ŞARTNAMELERİ (docs/use_cases/UC-XXX-*.md) ──▶ [ Davranışsal Kontrat ]
        │
        ▼ /test-case & /implement
  6. KOD VE TESTLER (src/ & test/) ──▶ [ Çalışan Yazılım & Otomatik Güvence! ]

  🎯 KURAL: Her halka, bir sonraki aşama için yapay zekanın tasarım uzayını daraltır!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir roket fırlatırken hedefe ulaşmak için 6 aşamalı bir kilit sistemi kullanırsın: 1) Haritada Mars'ı gösterirsin (Vizyon). 2) İhtiyaçları yazarsın: 'Oksijen, yakıt, 3 astronot' (Gereksinimler). 3) Roketin parçalarını çizersin (Varlık Modeli). 4) Görev adımlarını listelersin (Diyagram). 5) Her düğmenin ne zaman basılacağını kâğıda dökersin (Use Case). 6) Motorları ateşlersin (Kod!). Eğer direkt 1. adımdan 6. adıma atlarsan roket havada patlar! Zincirdeki her halka roketin rotasını milimetrik daraltır.
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Launching an interplanetary rocket requires a six-stage telemetry sequence: 1) Pointing at Mars on the celestial map (Vision). 2) Sizing fuel and payload specifications (Requirements Catalog). 3) Blueprinting module geometries (Entity Model). 4) Indexing operational phases (Diagram). 5) Authoring step-by-step launch protocols (Use Case Specs). 6) Igniting the thrusters (Code & Tests). Skipping directly from Vision to Ignition ensures catastrophic atmospheric explosion. Each artifact progressively restricts variance until implementation becomes deterministic.]
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
      Eser Zinciri (The Artifact Chain) ve Tasarım Uzayı Mekaniği: Bir LLM'e tek satırlık bir prompt verip 'Bana bir e-ticaret sistemi yaz' dediğinizde tasarım uzayı (design space) sonsuzdur; model milyonlarca farklı mimari, tablo ve API rotası seçebilir ve bu da determinizmi sıfırlar. AI Unified Process bu sorunu 'Aşamalı Kısıtlama Zinciri' ile çözer: 1) docs/vision.md: Projede tek elle yazılan insan eseridir. Sistemin sınırlarını, aktörlerini ve alan adlarını belirler. 2) docs/requirements.md: Niyeti FR (Kullanıcı Hikayeleri), NFR ve Kısıtlar (Constraints) olarak kodlar. 3) docs/entity\_model.md: Domain terimlerini ve ilişkilerini tek bir yerde tanımlar. 4) docs/use\_cases.puml: Sistemin tüm use case haritasını çizer. 5) docs/use\_cases/UC-XXX.md: Davranışı adım adım kilitler. `/implement` komutu çalıştığında yapay zekanın elinde vizyon, veri modeli, gereksinim satırı ve use case zaten mevcuttur; bu sayede üretilen kod tesadüfi değil, matematiksel bir kesinlik taşır. Hiçbir tekil dökümanın kusursuz olması gerekmez; bu katmanlı yapı sistemi sağlam kılar.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The mechanics of Design Space Constriction across the Artifact Chain: Prompting an LLM with 'Generate an e-commerce platform' presents an unconstrained, near-infinite degrees-of-freedom search space. The resulting architecture is chaotic, unprincipled, and un-reproducible. The AI Unified Process resolves this via a deterministic pipeline: each artifact progressively constricts the degrees of freedom for the next command. The vision document anchors boundary scope; the requirements catalog maps user stories to alphanumeric IDs; the entity model binds database nouns; the PlantUML diagram indexes the interaction portfolio; use case specifications define the step contracts. When `/implement` executes, the AI operates inside a tightly fenced sandbox. Reliable generation emerges from structural layering, not magical prompt engineering.]
    ]
  )
]

#java25_box[
```java
// Java 25: Eser Zincirinin Tamamını Yansıtan Temiz Mimari Yapısı
package com.maang.aiup.chain;

public class ArtifactChainDemonstration {
    // 1. docs/entity_model.md'den türeyen Domain Modeli
    public record BookCopyEntity(String copyId, String isbn, boolean isAvailable) {}

    // 2. docs/use_cases/UC-002-borrow-book.md'den türeyen Use Case Arayüzü
    public interface BorrowBookPort {
        void execute(String memberId, String copyId);
    }

    // 3. /implement tarafından üretilen temiz servis uygulaması
    public static class BorrowBookServiceImpl implements BorrowBookPort {
        @Override
        public void execute(String memberId, String copyId) {
            System.out.printf("Zincir tamamlandı: Üye %s -> Kopya %s başarıyla bağlandı.%n", memberId, copyId);
        }
    }

    void main() {
        var service = new BorrowBookServiceImpl();
        service.execute("MEM-101", "CPY-99");
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
      Zincirdeki halkaları atlayıp doğrudan /use-case-spec veya /implement çalıştırmaya kalkmayın! Elinde bir varlık modeli (entity model) olmayan AI, her use case'de aynı tablo için farklı kolon isimleri uydurur (örn: bir yerde memberId, diğerinde user\_id) ve veritabanı kilitlenir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never short-circuit the artifact chain by executing `/implement` without an entity model. Deprived of a canonical entity dictionary, the AI will invent conflicting field names across specifications (e.g. `memberId` vs `user_id` vs `account_num`), triggering schema drift.]
    ]
  )
]

#takeaways_box((
    ("Eser zinciri 6 halkadan oluşur: Vizyon, Gereksinimler, Varlık Modeli, Diyagram, Şartnameler, Kod/Test.", "The artifact chain spans 6 links: Vision, Requirements, Entity Model, Diagram, Specs, Code/Tests."),
    ("Tek elle yazılan döküman vizyondur; diğer tüm eserler komutlarla AI tarafından taslaklanır ve insan tarafından onaylanır.", "Vision is the sole hand-written artifact; downstream artifacts are generated and human-refined."),
    ("Her halka bir sonrakinin tasarım uzayını daraltarak rastgele kod üretimini deterministik kılar.", "Each artifact narrows the design space, making AI code synthesis deterministic and predictable."),
))
