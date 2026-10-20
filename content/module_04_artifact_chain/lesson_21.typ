#import "/template.typ": *

#show: doc => setup_book(title: "Ders 21: PlantUML Use Case Diyagramı: Sistemin İçindekiler Tablosu (Modelin Kendisi Değil!)", doc)

#lesson_header(
  21,
  "PlantUML Use Case Diyagramı: Sistemin İçindekiler Tablosu (Modelin Kendisi Değil!)",
  "The PlantUML Use Case Diagram: Table of Contents, Not the Model",
  "Eser Zinciri (Artifact Chain) & PlantUML Mimarisi",
  "The Artifact Chain & PlantUML Architecture"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 PLANTUML DİYAGRAMI VE VERBATIM DOSYA EŞLEŞMESİ              │
└─────────────────────────────────────────────────────────────────────────────┘
  PlantUML Kodu (docs/use_cases.puml):
  @startuml
  actor "Member" as member
  rectangle "Library System" {
    usecase "UC-001\nSearch Catalog" as UC001
    usecase "UC-002\nBorrow Book" as UC002
  }
  member --> UC001
  member --> UC002
  @enduml

  BİREBİR DOSYA SİSTEMİ EŞLEŞMESİ (VERBATIM FILE SYSTEM):
  docs/use_cases/
  ├── UC-001-search-catalog.md  ◀── (UC-001\nSearch Catalog ile noktası virgülüne aynı!)
  └── UC-002-borrow-book.md     ◀── (UC-002\nBorrow Book ile noktası virgülüne aynı!)
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir kitaptaki 'İçindekiler' sayfasını düşünün: Sayfada sadece 'Bölüm 1: Giriş - Sayfa 15' yazar. İçindekiler sayfasına oturup tüm romanı sığdırmaya çalışmazsın; sadece hangi konunun nerede olduğunu tek bir bakışta gösterir. PlantUML diyagramı da yazılımın İçindekiler tablosudur! Yuvarlakların içine tüm detayları yazamazsın; yuvarlak sadece kapıdaki tabeladır, asıl oda arkasındaki markdown dosyasındadır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[A book's Table of Contents does not contain the complete novel; it indexes chapter titles and page numbers so readers can navigate the landscape at a glance. A PlantUML use case diagram plays the exact same role. The ellipses are not the system architecture; they are visual signposts. Attempting to cram complex algorithms into diagram bubbles ruins both the diagram and the specification.]
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
      PlantUML Diyagramının Mühendislik Sınırları ve Kuralları: Cockburn use case diyagramlarının modelin kendisi olmadığını, sadece bir 'Büyük Resim / İçindekiler Tablosu' olduğunu ısrarla vurgulamıştır. `docs/use_cases.puml` dosyası downstream çalışan AI araçları için bir haritadır. Bu haritanın kusursuz çalışması için Martinelli 4 katı kural koyar: 1) İki Satırlı Etiket: Her use case yuvarlağı ID ve İsmi iki satırda taşımalıdır: `UC-001\nSearch Catalog`. 2) Gerçek Sistem İsmi: `rectangle` etiketinde soyut isimler değil, projenin gerçek sistem adı yazmalıdır (`rectangle "Library System"`). 3) Her Aktör Bağlı Olmalıdır: Diyagramdaki her aktör en az bir use case'e, her use case de en az bir aktöre bağlanmalıdır; yetim yuvarlak kalamaz. 4) Verbatim Eşleşme: Diyagramdaki isim kebab-case yapılarak dosya adına dönüşür: `UC-002\nBorrow Book` -> `docs/use_cases/UC-002-borrow-book.md`. `/spec-review` komutu bu eşleşmeyi otomatik doğrular; uyuşmazlık varsa CI derlemesini kırar.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[PlantUML Diagram Semantics and Verification Protocol: Cockburn continually warned against treating use case diagrams as architectural models. In the AI Unified Process, `docs/use_cases.puml` serves strictly as the system's navigable index. Downstream parsing engines enforce four non-negotiable conventions: 1) Two-Line Labeling: Every use case node must declare its alphanumeric identifier and human name across two lines: `UC-001\nSearch Catalog`. 2) System Boundary: The enclosing bounding box must declare the authentic bounded-context system name. 3) Completeness Invariant: Every defined actor must link to at least one use case; isolated nodes fail verification. 4) Verbatim Filename Parity: The string literal in the diagram maps deterministically to the file system: `UC-002\nBorrow Book` maps exclusively to `docs/use_cases/UC-002-borrow-book.md`. Automated tools parse this contract to guarantee zero orphan specifications.]
    ]
  )
]

#java25_box[
```java
// Java 25: PlantUML Eşleşmesini Otomatik Denetleyen Doğrulama Kodu
package com.maang.aiup.diagram;

import java.nio.file.Files;
import java.nio.file.Path;

public class DiagramParityChecker {
    // PlantUML dosyasındaki 'UC-002\nBorrow Book' tanımı:
    public record UseCaseEntry(String id, String rawName) {
        public String expectedFileName() {
            String sanitized = rawName.toLowerCase().replace(" ", "-");
            return id + "-" + sanitized + ".md";
        }
    }

    public static boolean verifyFileExists(Path baseDir, UseCaseEntry entry) {
        Path expectedPath = baseDir.resolve(entry.expectedFileName());
        boolean exists = Files.exists(expectedPath);
        System.out.printf("Denetim: %s -> %s (Mevcut: %s)%n", entry.rawName(), expectedPath.getFileName(), exists);
        return exists;
    }

    void main() {
        var entry = new UseCaseEntry("UC-002", "Borrow Book");
        System.out.println("Beklenen dosya: " + entry.expectedFileName());
        assert entry.expectedFileName().equals("UC-002-borrow-book.md") : "İsim eşleşme hatası!";
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
      PlantUML diyagramını oklarla, koşullarla ve if-else mantıklarıyla boğmayın! Diyagram bir akış şeması (flowchart) değildir. Adımların sırası diyagramda değil, use case şartnamesinin içindeki numaralı adımlarda yaşar.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not treat a use case diagram as an execution flowchart. Avoid drawing conditional branching arrows between ellipses. The chronological flow belongs exclusively within the numbered steps of the markdown specification.]
    ]
  )
]

#takeaways_box((
    ("PlantUML diyagramı sistemin içindekiler tablosudur; modelin kendisi değil, haritasıdır.", "The PlantUML diagram is the system's table of contents, not the architectural model."),
    ("Diyagramdaki etiket iki satırdan oluşur: ID ve İsim (UC-001\\nSearch Catalog).", "Diagram nodes must declare ID and Name on two lines (e.g. UC-001\\nSearch Catalog)."),
    ("Diyagramdaki isim ile dosya adı (UC-001-search-catalog.md) noktası virgülüne eşleşmelidir.", "The diagram name and the markdown filename must maintain 1:1 verbatim parity."),
))
