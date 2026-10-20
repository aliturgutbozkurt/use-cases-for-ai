#import "/template.typ": *

#show: doc => setup_book(title: "Ders 60: Staff+ Seviye Gereksinim Mimarlığı: Yönetişim, İzlenebilirlik ve AIUP Çağı", doc)

#lesson_header(
  60,
  "Staff+ Seviye Gereksinim Mimarlığı: Yönetişim, İzlenebilirlik ve AIUP Çağı",
  "The Staff+ Requirements Architect: Governance, Traceability & The AIUP Future",
  "Kontrol Listeleri, Yaygın Hatalar ve MAANG Mimar Seviyesi Ustalık",
  "Checklists, Common Mistakes & MAANG Architect Mastery"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 STAFF+ GEREKSİNİM MİMARLIĞININ KURUMSAL YÖNETİŞİMİ           │
└─────────────────────────────────────────────────────────────────────────────┘
  
  Geleneksel Yazılım Dünyası:              AI Unified Process Dünyası:
  ───────────────────────────              ───────────────────────────
  - Kod = Tek Gerçek (Pahalı Varlık)       - Şartname = Tek Gerçek (Kalıcı Varlık)
  - Şartname = Çöpe atılan iskele          - Kod = İhtiyaç anında üretilen derleme çıktısı
  - Mimar = Kod yazan kıdemli geliştirici  - Mimar = Sistem Niyetini ve Sözleşmeyi Korkan Lider!
  
  KURUMSAL İZLENEBİLİRLİK ZİNCİRİ (MECHANICAL TRACEABILITY):
  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
  │   FR-005     │ ──► │    UC-003    │ ──► │  A2 AKIŞI    │ ──► │ UC-003 BR-007│
  │ (İş Hikayesi)│     │  (Use Case)  │     │(Alternatif)  │     │ (İş Kuralı)  │
  └──────────────┘     └──────────────┘     └──────────────┘     └──────┬───────┘
                                                                        │
                                       ┌────────────────────────────────┴────────┐
                                       ▼                                         ▼
                             ┌──────────────────┐                      ┌──────────────────┐
                             │    JAVA 25 KODU  │                      │   OTOMATİK TEST  │
                             └──────────────────┘                      └──────────────────┘
  🎯 VİZYON:
  "Bir gün sistemin tamamını Go veya Rust'a taşımak gerekirse, tek bir satır kod
   yazmadan sadece stack plugin'ini değiştirip tüm şirketi 1 günde modernize edeceğiz!" 
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Dünyanın en büyük orkestrasını düşünün: 100 tane kemancı, 50 tane trompetçi vardır. Trompetçi değişebilir, kemancı emekli olabilir, hatta enstrümanlar ahşaptan elektroniğe geçebilir. Ama Mozart'ın yazdığı nota kâğıdı (Partisyon / Şartname) 300 yıldır aynı ihtişamla çalınır! Staff+ Mimar, o ölümsüz partisyonu yazan ve tüm orkestrayı yöneten baş şeftir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of the world's greatest philharmonic orchestra: 100 violinists, 50 brass players. Musicians retire, violinists are replaced, instruments may transition from acoustic to carbon-fiber. But Mozart's symphonic score (The Specification) endures across centuries with flawless fidelity! The Staff+ Architect is the master conductor who preserves the eternal score.]
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
      Staff+ Seviye Gereksinim Mimarlığı ve Kurumsal Yönetişim: Yazılım dünyasında 40 yıl boyunca 'Kod tek gerçektir' yalanıyla yaşadık. Bu yaklaşım, sistemlerin 5 yılda bir teknik borç bataklığına saplanmasına ve milyonlarca dolarlık 'legacy rewrite' facialarına yol açtı. AI Unified Process ve Simon Martinelli'nin metodolojisi yazılım mühendisliğini gerçek bir mühendislik disiplinine kavuşturur: Kod artık derlenip atılabilen geçici bir ikincil çıktıdır; asıl şirket varlığı (asset) ise gereksinimlerden use case'lere, oradan entity model ve testlere uzanan 'Şartname Zinciri'dir (Artifact Chain). Staff+ Requirements Architect; bu zincirin mekanik izlenebilirliğini (Traceability: `FR -> UC -> Flow -> BR -> Code -> Test`), kara liste kontrollerini ve alan modellerini yöneten kurumsal stratejisttir. Bir regülatör veya müşteri 'Neden bu işlem reddedildi?' diye sorduğunda, kod aramak yerine saniyeler içinde kural kimliğini gösterir. Şirketin teknoloji yığını yarın Spring Boot'tan başka bir platforma geçse dahi, şartname zinciri sayesinde tek bir iş kaybı olmadan tüm sistem saatler içinde yeniden üretilebilir.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Staff+ Requirements Architecture and Enterprise Governance: For four decades, the software industry operated under the economic premise that 'the code is the truth'—an assumption that produced unmaintainable monoliths, trillion-dollar technical debt, and recurrent failed re-writes. The AI Unified Process permanently inverts this paradigm. Code is demoted to an ephemeral, regenerable compilation artifact. The durable enterprise asset is the Specification Artifact Chain: Vision -> Requirements Catalog -> Entity Model -> Use Case Diagram -> Use Case Specifications -> Test Journeys. The Staff+ Requirements Architect is the strategic custodian of this ecosystem, enforcing mechanical traceability (`FR-XXX -> UC-XXX -> Flow -> BR-XXX -> Code -> Test`), lexical hygiene, and architectural boundaries. When auditors or clients query why a transaction was declined, the answer is a deterministic chain of identifiers rather than code archaeology. When infrastructure stacks evolve, the enterprise regenerates its entire portfolio with zero business friction.]
    ]
  )
]

#java25_box[
```java
// Java 25: Staff+ Seviye Mekanik İzlenebilirlik Zinciri (Traceability Metadata)
package com.maang.aiup.staffarchitect;

import java.lang.annotation.*;

public class EnterpriseTraceabilityDemo {
    // Kurumsal İzlenebilirlik Notasyonu
    @Retention(RetentionPolicy.RUNTIME)
    @Target(ElementType.METHOD)
    public @interface Traceability {
        String requirementId();
        String useCaseId();
        String flowId();
        String businessRule();
    }

    public static class EnterpriseLoanEngine {
        @Traceability(
            requirementId = "FR-012",
            useCaseId = "UC-002",
            flowId = "A2",
            businessRule = "BR-005: Loan Limit"
        )
        public boolean evaluateLoanQuota(int currentLoans) {
            // Mekanik zincir: Koddaki her satır doğrudan iş kuralına bağlanır!
            return currentLoans < 5;
        }
    }

    void main() throws NoSuchMethodException {
        var method = EnterpriseLoanEngine.class.getMethod("evaluateLoanQuota", int.class);
        var trace = method.getAnnotation(Traceability.class);

        System.out.println("🏛️ Staff+ Kurumsal İzlenebilirlik Raporu:");
        System.out.println("   -> İlgili Gereksinim: " + trace.requirementId());
        System.out.println("   -> İlgili Use Case  : " + trace.useCaseId());
        System.out.println("   -> İlgili Akış      : " + trace.flowId());
        System.out.println("   -> Uygulanan Kural  : " + trace.businessRule());
        System.out.println("✅ Kod doğrudan iş şartnamesine bağlandı. AIUP Tamamlandı!");
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
      Şartname zincirini sadece dokümantasyon olarak görmeyin; o zincir şirketin yazılımsal DNA'sıdır. Kod ölür, şartname yaşar!
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never treat the artifact chain as mere bureaucratic documentation. The specification is the living genetic code of the enterprise. Code is ephemeral; specifications endure.]
    ]
  )
]

#takeaways_box((
    ("AI Unified Process ile yazılım mühendisliği gerçek bir mühendislik disiplinine kavuşur.", "The AI Unified Process elevates software development into a true engineering discipline."),
    ("Mekanik izlenebilirlik (FR -> UC -> Flow -> BR -> Code -> Test) kurumsal şeffaflığı sağlar.", "Mechanical traceability connects every line of code to a specific business requirement."),
    ("Şartname tek kalıcı varlıktır; kod yarın başka bir dile veya stack'e saniyeler içinde taşınabilir.", "Specifications are the sole durable asset; code can be regenerated onto new stacks effortlessly."),
))
