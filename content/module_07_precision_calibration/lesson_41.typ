#import "/template.typ": *

#show: doc => setup_book(title: "Ders 41: UI Tasarımcısı Nereye Gitti? Üçlü Sorumluluk Bölünmesi", doc)

#lesson_header(
  41,
  "UI Tasarımcısı Nereye Gitti? Üçlü Sorumluluk Bölünmesi",
  "Where Did the UI Designer Go? The Three-Way Responsibility Split",
  "Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?",
  "Precision for AI — What to Say and What to Leave Out"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 UI TASARIMCISININ ÜÇLÜ SORUMLULUK BÖLÜNMESİ                  │
└─────────────────────────────────────────────────────────────────────────────┘
  
  Cockburn (2001): "UI tasarımcısına güvenin; ekran detayını şartnameye yazmayın."
  AIUP (2026):     "Peki insan UI tasarımcısı yoksa ekranı kim tasarlayacak?"
                   CEVAP: Sorumluluk üç parçaya bölünür!
  
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ 1. ETKİLEŞİM YAPISI (Interaction Structure) ──► USE CASE SPEC (Zone 1)  │
  │    - Kullanıcı ne görür, neyi seçer, hangi kararı verir?                │
  │    - Örnek: "Sistem mevcut kopyaları ve en erken iade tarihini gösterir"│
  ├─────────────────────────────────────────────────────────────────────────┤
  │ 2. DÜZEN VE GÖRÜNÜM (Layout & Visual Look)   ──► MOCKUP ARTIFACT (Harici)│
  │    - Figma / Wireframe / CSS teması (Şartnameden link verilir, gömülmez)│
  │    - Mockup yoksa AI platform konvansiyonlarına göre düzenler.          │
  ├─────────────────────────────────────────────────────────────────────────┤
  │ 3. WIDGET SEÇİMİ VE KABLOLAMA (Widgets)     ──► STACK PLUGIN (/implement│
  │    - Buton Vaadin mi, React/Tailwind mi, Angular Material mi, Blazor mı?│
  │    - Şartname 'dialog' veya 'dropdown' demez; stack bunu otomatik seçer! │
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
      Bir tiyatro oyununu düşünün: Senaryo yazarı (Use Case) der ki: 'Romeo sahneye girer, elindeki mektubu Juliet'e uzatır ve aşkını ilan eder.' Senaryo yazarı 'Juliet kırmızı kadife koltuğa 45 derece açıyla otursun, arkadan 40 watt sarı spot yansısın' demez! Koltuğu dekoratör (Mockup), ışığı teknisyen (Stack Plugin) ayarlar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of a theater play: The playwright (Use Case) writes: 'Romeo enters stage left, hands the letter to Juliet, and professes his love.' The playwright does not dictate: 'Juliet must sit on a 45-degree angle crimson sofa illuminated by a 40-watt tungsten lamp.' The set designer (Mockup) and stage crew (Stack Plugin) handle layout and fixtures.]
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
      UI Tasarımcısının Üçlü Bölünmesi (The Three-Way Split): Cockburn'ün 'UI tasarımcısına güvenin' öğüdü, şartnameyi okuyup ekran tasarlayan bir insan tasarımcının varlığına dayanıyordu. AI Unified Process'te bu rol üçe ayrılır: 1) Etkileşim Yapısı (Interaction Structure): Use Case şartnamesinin asli görevidir (Zone 1). Kullanıcının her adımda ne yapabileceğini, hangi veriyi gördüğünü ve hangi kararı verdiğini belirtir. 2) Düzen ve Görünüm (Layout & Look): Mockup veya Figma tasarımının görevidir. Eğer harici bir mockup varsa, use case buna link verir (`Mockup: docs/mockups/UC-002.png`). Mockup yoksa AI, platformun modern UX standartlarına göre düzeni kendi kurar. 3) Widget Seçimi ve Kablolama (Widget Choice & Wiring): Stack Plugin'inin görevidir. /implement komutu projenin React mı, Vue mu, Vaadin mi yoksa Flutter mı olduğunu bilir. Use case asla 'dropdown menüden seçer' veya 'modal popup açılır' demez; 'seçer' ve 'görüntüler' der.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The Three-Way Split of the UI Designer Role: Cockburn's counsel to trust the UI designer assumed a human specialist interpreting business intent. In generative development, that function partitions across three decoupled layers: 1) Interaction Structure: Owned entirely by the use case specification (Zone 1). It dictates the logical payload—what the actor enters, inspects, and acknowledges. 2) Layout and Aesthetics: Owned by supplementary mockup artifacts (e.g., SVG/Figma files) linked from the spec. In the absence of a mockup, the AI synthesizes layouts adhering to modern platform heuristics. 3) Widget Selection & Component Wiring: Owned by the implementation stack plugin. Whether an input maps to a `Select`, a radio group, or an autocomplete combo-box is the platform stack's prerogative. The spec remains agnostic of widget nomenclature.]
    ]
  )
]

#java25_box[
```java
// Java 25: Etkileşim Yapısının (Use Case) Widget'tan (UI Framework) Ayrılması
package com.maang.aiup.uisplit;

public class UiSplitDemo {
    // 1. USE CASE: Sadece etkileşim yapısını (veri ve eylem) bilir
    public record BorrowInteractionModel(String selectedBookId, boolean confirmed) {}

    // 2. STACK PLUGIN: Vaadin, React veya Thymeleaf bileşenlerini stack üretir
    // Use case şartnamesi 'Button' veya 'Modal' kelimesini bilmez!
    public static class MockWebComponentRenderer {
        public void renderBookActions(BorrowInteractionModel model) {
            System.out.println("🖥️ UI Renderer: Seçilen Kitap (" + model.selectedBookId() + ") için buton üretildi.");
            if (model.confirmed()) {
                System.out.println("🖥️ UI Renderer: Onaylandı durumu ekrana yansıtıldı.");
            }
        }
    }

    void main() {
        var interaction = new BorrowInteractionModel("BK-99", true);
        var renderer = new MockWebComponentRenderer();
        renderer.renderBookActions(interaction);
        System.out.println("✅ UI Sorumluluk bölünmesi doğrulandı.");
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
      Şartnamede 'Kullanıcı OK butonuna tıklar' veya 'İptal linkine basar' gibi widget isimleri yerine 'Kullanıcı işlemi onaylar' veya 'Kullanıcı işlemi iptal eder' deyin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Replace widget mechanics like 'User clicks OK button' or 'User clicks cancel link' with user intent: 'User confirms operation' or 'User cancels operation'.]
    ]
  )
]

#takeaways_box((
    ("Etkileşim yapısı (ne görülür/yapılır) use case'in, düzen mockup'ın, widget seçimi stack'in işidir.", "Interaction structure belongs to specs, layout to mockups, widget choice to stack plugins."),
    ("Use case asla 'dropdown', 'dialog box' veya 'toast' demez; sadece iş niyetini tarif eder.", "Never use terms like 'dropdown' or 'dialog box'; specify user intent and information flow."),
    ("Mockup eksikse AI modern tasarım kalıplarına göre düzeni başarıyla oluşturabilir.", "When mockups are absent, AI synthesizes layouts from interaction structure and conventions."),
))
