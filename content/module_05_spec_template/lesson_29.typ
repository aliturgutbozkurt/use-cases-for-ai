#import "/template.typ": *

#show: doc => setup_book(title: "Ders 29: İş Kuralları (BR-XXX): Yerel Numaralandırma, Nitelikli Çağrı & DRY İlkesi", doc)

#lesson_header(
  29,
  "İş Kuralları (BR-XXX): Yerel Numaralandırma, Nitelikli Çağrı & DRY İlkesi",
  "Business Rules (BR-XXX): Local Numbering, Cross-Spec Referencing & DRY",
  "Ana Şartname Şablonu & Alan Alan Derinlemesine İnceleme",
  "The Master Specification Template & Field Breakdown"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 İŞ KURALLARI (BUSINESS RULES) REFERANS VE KAPSAM MODELİ      │
└─────────────────────────────────────────────────────────────────────────────┘
  USE CASE 1 (docs/use_cases/UC-001-search-catalog.md):
  ## Business Rules
  ### BR-001: Minimum Search Characters
  Arama terimi en az 3 karakter olmalıdır.

  USE CASE 2 (docs/use_cases/UC-002-borrow-book.md):
  ## Main Success Scenario
  4. System validates that the search term is valid (UC-001 BR-001). ◀── [ Nitelikli Referans! ]
  5. System validates member has no overdue loans (BR-006).          ◀── [ Yerel Referans! ]

  ## Business Rules
  ### BR-006: Overdue Block
  Gecikmiş borcu olan üyeler borç kapanana kadar yeni kitap alamaz.

  🚫 KURAL: UC-001'deki kural metnini UC-002'ye ASLA kopyalama! Link ver!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir kanun kitabını düşünün: Trafik Kanunu'nda 'Kırmızı ışıkta geçmek yasaktır (Madde 48)' yazar. Belediye otobüsleri yönetmeliğinde bu kural tekrar uzun uzun yazılmaz; 'Otobüs şoförleri Trafik Kanunu Madde 48'e uymak zorundadır' diye tek satır referans verilir. Eğer kuralı her yönetmeliğe baştan yazarsan, yarın kırmızı ışık cezası değiştiğinde bazı kitapçıklarda eski ceza kalır ve ortalık karışır! Kuralı bir kere yaz, her yerden maddesiyle (kimliğiyle) çağır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[In statutory law, the penal code defines traffic violations once (e.g. Article 48: Running Red Lights). Municipal bus transit regulations do not duplicate the full legal text of Article 48; they state: 'Bus operators are subject to Penal Code Article 48.' If rules are copy-pasted across fifty municipal pamphlets, an amendment to the primary statute creates immediate legal contradictions across stale copies. Define the rule once; cite it by identifier everywhere.]
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
      İş Kuralları (Business Rules) Mimarisi ve DRY Kuralı: Cockburn, kullanım senaryoları ile iş kuralları arasındaki derin ilişkiyi şu sözle özetler: 'Alternatif akışlar ve kurallar, sistemin en ilginç ve en değerli gereksinimlerinin yaşadığı yerdir.' Martinelli bu ilişkiyi katı bir mimariye oturtur: 1) Ayrı Bölüm (Dedicated Section): İş kuralları senaryo adımlarının içine satır içi (inline) gömülmez; şartnamenin sonundaki `## Business Rules` başlığı altında toplanır. Bu sayede 3 farklı akış aynı kurala atıfta bulunabilir. 2) Yerel Numaralandırma (Local Numbering): BR numaraları her use case'in kendi içinde yereldir (`BR-001`, `BR-002`...). Bu kural merkezi bir excel tablosundaki numara çakışması krizini çözer. 3) Nitelikli Çapraz Çağrı (Qualified Cross-Spec Citation): Başka bir use case'in kuralı çağrılacaksa mutlaka use case ID'si ile nitelenir: `(UC-001 BR-002)`. Başına use case kodu konmayan çıplak bir `(BR-005)` sadece o dosyanın içinde aranır. 4) Kopyalama Yasağı: Kural metnini kopyalayıp başka dökümana yapıştırmak `/spec-review` tarafından derhal yakalanır ve engellenir.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Business Rule Architecture and Qualified Scoping: Cockburn recognized that the core business value of software concentrates within rule extensions. The AI Unified Process formalizes this via rigorous conventions: 1) Decoupled Rule Section: Rules are isolated in a dedicated `## Business Rules` section rather than embedded inline within step prose. This allows multiple steps and alternative flows to link against a singular rule definition. 2) Local Identifier Namespacing: Rule numbering is strictly local per use case specification (`UC-001` owns `BR-001..003`; `UC-002` owns `BR-001..006`). This eliminates global coordination bottlenecks across distributed squads. 3) Qualified Cross-Referencing: When a specification cites a rule declared elsewhere, it must qualify the identifier: `UC-001 BR-002`. An unqualified citation (`BR-004`) refers exclusively to the host file. 4) Absolute Prohibition of Rule Cloning: Duplicating rule prose across files triggers deterministic build failure during `/spec-review` audits.]
    ]
  )
]

#java25_box[
```java
// Java 25: İş Kurallarını Merkezi Enum/Sözlük ile İzlenebilir Kılma
package com.maang.aiup.rules;

public class BusinessRuleCatalog {
    // İş kurallarının Java tarafındaki değişmez temsili
    public enum Rule {
        UC001_BR001("UC-001 BR-001", "Arama terimi en az 3 karakter olmalıdır."),
        UC002_BR005("UC-002 BR-005", "Üye aynı anda en fazla 5 açık ödünç kitaba sahip olabilir."),
        UC002_BR006("UC-002 BR-006", "Gecikmiş borcu olan üyeler ödünç alamaz.");

        public final String id;
        public final String description;
        Rule(String id, String desc) { this.id = id; this.description = desc; }
    }

    public static void validateMemberEligibility(int openLoans, boolean hasOverdue) {
        if (openLoans >= 5) {
            throw new IllegalStateException(Rule.UC002_BR005.id + ": " + Rule.UC002_BR005.description);
        }
        if (hasOverdue) {
            throw new IllegalStateException(Rule.UC002_BR006.id + ": " + Rule.UC002_BR006.description);
        }
    }

    void main() {
        validateMemberEligibility(3, false);
        System.out.println("✅ Tüm iş kuralları başarıyla doğrulandı.");
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
      Bir iş kuralına 'BR-001: Hızlı olmalıdır' veya 'BR-002: Güvenli olmalıdır' gibi ölçülemeyen temenniler yazmayın! İş kuralları net politikalardır: 'Üyenin en fazla 5 açık ödüncü olabilir.'
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never frame an NFR as a business rule (e.g. 'BR-001: Must respond quickly'). Business rules state definitive enterprise policy: 'A member may hold at most 5 concurrent loans.']
    ]
  )
]

#takeaways_box((
    ("İş kuralları senaryo içine gömülmez; şartnamenin sonundaki Business Rules bölümünde listelenir.", "Business rules are declared in their own dedicated section, not embedded in step text."),
    ("BR numaraları use case içinde yereldir; dışarıdan çağrılırken nitelikli yazılır (UC-001 BR-002).", "BR numbering is local per spec; cross-spec citations must be qualified (UC-001 BR-002)."),
    ("Kural metinlerini dosyalar arasında kopyalamak kesinlikle yasaktır; her kural bir kere yazılır.", "Cloning rule text across specifications is forbidden; define once and cite by identifier."),
))
