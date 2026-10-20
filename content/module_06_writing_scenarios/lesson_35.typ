#import "/template.typ": *

#show: doc => setup_book(title: "Ders 35: Toplam Başarısızlığı Yönetmek: 'Use Case Ends' Neden Başarısızlık Sonkoşulunu Şart Koşar?", doc)

#lesson_header(
  35,
  "Toplam Başarısızlığı Yönetmek: 'Use Case Ends' Neden Başarısızlık Sonkoşulunu Şart Koşar?",
  "Handling Total Failures: Why 'Use Case Ends' Demands Failure Postconditions",
  "Senaryolar ve Alternatif Akışlar Yazma Sanatı",
  "Writing Scenarios and Alternative Flows"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 'USE CASE ENDS' VE ASGARİ BAŞARISIZLIK GARANTİSİ            │
└─────────────────────────────────────────────────────────────────────────────┘
  Alternatif Akışta İşlem Başarısız Oldu:
  "4. Use case ends." (İşlem çöktü, hedef teslim edilemedi!)
          │
          ▼ GÜVENCE MEKANİZMASI DEVREYE GİRER:
  ┌─────────────────────────────────────────────────────────────────────────┐
  │  ### Failure Postconditions (Minimal Guarantees):                       │
  │  - Veritabanına hiçbir kısmi kayıt ATILMAMIŞTIR (Atomik Rollback!).      │
  │  - Kitabın mevcut kopya sayısı DEĞİŞMEMİŞTİR.                           │
  │  - Başarısızlık denemesi sistem loglarına kaydedilmiştir.               │
  └─────────────────────────────────────────────────────────────────────────┘
  
  ⚠️ KURAL: Eğer bir alternatif akış 'Use case ends' diyorsa ama arkasında
            bir Failure Postcondition yoksa, veritabanında yarım kalmış
            çöp kayıtlar (Zombi Veri) birikir!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir ameliyat sırasında anestezi uzmanı 'Tansiyon çok düştü, ameliyatı hemen durduruyoruz (Use case ends!)' dediğinde doktorlar hastayı öylece masada bırakıp eve gitmez! Yarayı hemen dikerler, kanamayı durdururlar, hastayı yoğun bakıma alıp rapor yazarlar (Başarısızlık Sonkoşulu!). İşte 'Use case ends' dendiğinde sistemin arkasında yaralı hasta veya açık yara (yarım kaydedilmiş bozuk veri) bırakmaması bu garantiler sayesinde sağlanır.
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[If a surgical team encounters an emergency and aborts an operation ('Use case ends'), the surgeons do not drop their scalpels and stroll out of the hospital. They immediately suture the incision, stabilize vitals, and transfer the patient to intensive care (Failure Postconditions). 'Use case ends' is only tolerable because the minimal guarantees promise that the patient survives clean and uncorrupted.]
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
      'Use Case Ends' ve İşlemsel Geri Alma (Rollback) Mimarisi: Bir alternatif akış 'Use case ends' dediğinde, birincil aktör hedefine ulaşamadan sistemden ayrılmış demektir. Cockburn bu durumun sistem açısından kabul edilebilir olmasının TEK BİR şartı olduğunu belirtir: 'Failure Postconditions' (Asgari Başarısızlık Garantileri) bölümünün eksiksiz tanımlanmış olması. Eğer bir akış başarısızlıkla sonuçlandığında arkasında silinmemiş bir geçici tablo kaydı, düşülmüş ama iade edilmemiş bir bakiye veya kilitli kalmış bir stok bırakıyorsa, sistem zehirlenir. AI açısından bu durum hayati bir mimari ayrıntıdır: LLM ajanı bir kod üretirken metottaki `try-catch` ve `\@Transactional` bloklarının içine ne yazacağını bu başarısızlık sonkoşullarına bakarak belirler. Eğer şartnamede 'Failure Postconditions: No partial data is stored' yazıyorsa, AI veritabanı işlemlerini atomik bir transaction ile sarar ve hata anında rollback tetikler.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Transactional Mechanics of Total Failure: Declaring 'Use case ends' signifies that the primary actor departs without achieving their goal. Cockburn asserts that this total failure is acceptable if and only if the system's Minimal Guarantees hold true. If an aborted flow leaves partial records, decremented inventory without a corresponding order, or orphaned connection handles, the system suffers state corruption. For AI code generators, the Failure Postconditions block acts as the specification for transactional exception handling. Stating 'No loan is recorded and book copy count is unchanged' instructs the AI to generate atomic `\@Transactional(rollbackFor = Exception.class)` boundaries with zero manual intervention.]
    ]
  )
]

#java25_box[
```java
// Java 25: Failure Postconditions Sayesinde Otomatik Rollback Yapan İşlem Modeli
package com.maang.aiup.failure;

public class TransactionalFailureGuaranteeDemo {
    public static class InventoryRepository {
        private int stock = 10;
        public void decrement() { stock--; }
        public void rollback() { stock++; }
        public int getStock() { return stock; }
    }

    // Failure Postcondition Garantisi: Hata çıkarsa stok ASLA değişmez!
    public static void executeWithMinimalGuarantee(InventoryRepository repo, boolean forceFail) {
        int initialStock = repo.getStock();
        repo.decrement(); // Kısmi işlem yapıldı

        try {
            if (forceFail) {
                throw new RuntimeException("Ödeme başarısız oldu (Use case ends)!");
            }
        } catch (Exception e) {
            // Failure Postcondition gereği sistem durumu geri alır:
            repo.rollback();
            assert repo.getStock() == initialStock : "KRİTİK HATA: Stok tutarsız kaldı!";
            System.out.println("🛡️ Failure Postcondition doğrulandı: Stok eski haline döndürüldü -> " + repo.getStock());
        }
    }

    void main() {
        var repo = new InventoryRepository();
        executeWithMinimalGuarantee(repo, true);
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
      Bir alternatif akışın sonunda 'Use case ends' yazdıktan sonra sistemin ne halde kalacağını Failure Postconditions'a yazmayı unutursanız, AI hata anında hiçbir veriyi geri almayan ve veritabanını bozan bir kod üretecektir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Omitting Failure Postconditions while invoking 'Use case ends' guarantees that the generated code will lack transactional rollback handlers, resulting in corrupted database state under error conditions.]
    ]
  )
]

#takeaways_box((
    ("'Use case ends' ancak ve ancak Başarısızlık Sonkoşulları (Minimal Guarantees) sağlandığında geçerlidir.", "'Use case ends' is valid only when backed by explicit Failure Postconditions."),
    ("Başarısızlık garantisi hiçbir kısmi verinin kaydedilmediğini ve sistemin temiz kaldığını taahhüt eder.", "Failure guarantees promise that no partial state is persisted and pre-state is restored."),
    ("Yapay zekâ veritabanı rollback ve loglama mekanizmasını bu sonkoşullara bakarak inşa eder.", "AI synthesizes transactional rollback and audit handlers directly from failure postconditions."),
))
