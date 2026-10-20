#import "/template.typ": *

#show: doc => setup_book(title: "Ders 25: AIUP Use Case Şablonu: Makinenin ve İnsanın Kusursuz Anladığı Format", doc)

#lesson_header(
  25,
  "AIUP Use Case Şablonu: Makinenin ve İnsanın Kusursuz Anladığı Format",
  "The AIUP Use Case Template: Anatomy of a Machine-Readable Document",
  "Ana Şartname Şablonu & Alan Alan Derinlemesine İnceleme",
  "The Master Specification Template & Field Breakdown"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                    AI UNIFIED PROCESS MASTER USE CASE ŞABLONU               │
└─────────────────────────────────────────────────────────────────────────────┘
  # Use Case: [Use Case Name]
  ## Overview
  - Use Case ID: UC-XXX  |  Status: Draft / Approved / Implemented
  - Primary Actor / Secondary Actors
  - Goal: Tek cümlelik gözlemlenebilir hedef ve gerekçesi
  - Trigger: Süreci başlatan tetikleyici olay (Durum değil, geçiş!)
  - Requirements: [FR-XXX, NFR-XXX, C-XXX](../requirements.md)
  
  ## Preconditions
  - [Sistemin zaten doğru olduğunu varsaydığı kapı şartları]
  
  ## Main Success Scenario
  1. [Etken çatılı, tek özneli, numaralı adımlar (3 - 9 adım)]
  
  ## Alternative Flows
  ### A1: [Hata veya İstisna Durumu] (step N)
  
  ## Postconditions (Success & Failure Garantileri)
  ## Business Rules (BR-XXX)
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir pasaport başvuru formunu düşünün. Dünyanın her yerinde pasaport formu aynı standart kutucuklara sahiptir: Ad, Soyad, Doğum Yeri, Anne Adı. Eğer herkes kendi kafasına göre mektup şeklinde başvuru yazsaydı memurlar çıldırırdı, pasaportlar basılamazdı! AIUP şablonu da böyledir: Her use case aynı tek tip üniformayı giyer. İnsan gözü aradığı şeyi saniyesinde bulur, yapay zekâ ise metni okurken asla bocalamadan her alanı ilgili kod katmanına yerleştirir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Consider an international passport application form: standardized boxes for Name, Date of Birth, Nationality, and Photo. If citizens submitted free-form handwritten essays, border control would collapse into chaos. Uniformity pays a double dividend: humans skim familiar structures in seconds, while AI generators parse labeled fields deterministically without guessing where the business logic begins.]
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
      Şablon Bütünlüğü ve Cockburn Şablonunun Evrimi: Cockburn 2001'de 'Töreni (ceremony) anlaşmazlığın maliyetine göre ayarlayın' demişti. Aynı odada çalışan küçük bir ekip günlük dilde use case yazabilirdi; ancak dağıtık ekipler 'fully dressed' (tam teşekküllü) formata muhtaçtı. AI çağında yapay zekâ, insan geliştiriciden katbekat daha uzaktır: Ne aynı koridoru paylaşır ne de kahve içer! Bu nedenle AIUP'ta her şartname istisnasız tam teşekküllü şablonla yazılır. Ancak bu şablon Cockburn'ün eski ağır şablonundan daha sadedir: 1) Kapsam (Scope) ve İrtifa (Level) satırları kaldırılmıştır; çünkü AIUP'ta kapsam daima Sistem Kapsamı, irtifa ise daima Deniz Seviyesidir (sabit kurallar tekrar edilmez). 2) Teknoloji ve Veri Varyasyonları kaldırılmıştır; çünkü teknoloji koda aittir. 3) Frekans ve Öncelik gereksinim kataloğuna (requirements.md) taşınmıştır. Geriye kalan alanlar saf, damıtılmış ve mekanik birer kontrattır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Structural Uniformity and the Modernization of Cockburn's Template: Cockburn advised calibrating documentation ceremony against the cost of misunderstanding: colocated engineers could survive on informal bullet points, whereas distributed enterprises required fully dressed forms. In generative development, the implementer (the LLM) is maximally distant. It possesses no shared culture and cannot ask for clarification. Consequently, every AIUP specification adopts a fully dressed structure. Yet the template is radically streamlined compared to classical RUP: 1) Scope and Altitude headers are omitted because they are invariant constants (System Scope, Sea Level). 2) Technology Variations are purged because technical mechanisms belong to stack plugins. 3) Prioritization and SLAs are delegated to the requirements catalog. The surviving schema is an unadulterated behavioral contract.]
    ]
  )
]

#java25_box[
```java
// Java 25: AIUP Şablonunun Domain Mimarisine Birebir İzdüşümü (Clean Ports)
package com.maang.aiup.template;

public class UseCaseTemplateStructure {
    // 1. Overview Metadata: Hedef ve Niyet
    public record Metadata(String id, String name, String goal, String trigger) {}

    // 2. Preconditions: Route Guard veya Güvenlik Ön Kontrolü
    public record Preconditions(boolean isAuthenticated, boolean isAccountActive) {
        public void verify() {
            if (!isAuthenticated || !isAccountActive) {
                throw new SecurityException("Önkoşul ihlali: Kullanıcı oturum açmamış veya hesap aktif değil!");
            }
        }
    }

    // 3. Postconditions: Başarı ve Başarısızlık Çıktı Garantileri
    public record ExecutionOutcome(boolean success, String payload, String auditLog) {}

    void main() {
        var meta = new Metadata("UC-002", "Borrow Book", "Member borrows a book", "User requests borrow");
        var pre = new Preconditions(true, true);
        pre.verify();
        System.out.println("Şablon doğrulaması başarılı: " + meta.name());
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
      Şablondaki başlıkların isimlerini kafanıza göre değiştirmeyin! 'Overview' yerine 'Genel Bilgiler', 'Main Success Scenario' yerine 'Adımlar' yazarsanız, downstream çalışan otomasyon ve /spec-review araçları şartnameyi parse edemez ve hata verir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not alter the markdown section headers arbitrarily. Renaming 'Main Success Scenario' to 'Steps' breaks the regex parsers in `/spec-review` and halts the automated build pipeline.]
    ]
  )
]

#takeaways_box((
    ("Tek tip standart şablon, insanların hızlı göz gezdirmesini ve AI'ın hatasız kod üretmesini sağlar.", "A uniform template accelerates human skimming and guarantees deterministic machine parsing."),
    ("Gereksiz alanlar (Teknoloji, Kapsam) atılmıştır; sadece saf davranışsal kontrat korunmuştur.", "Obsolete fields are discarded; only the pure behavioral and transactional contract remains."),
    ("Başlıklar ve alan isimleri otomasyon araçları tarafından denetlenen katı arayüzlerdir.", "Markdown headings are strict interfaces audited by automated quality tooling."),
))
