#import "/template.typ": *

#show: doc => setup_book(title: "Ders 18: Kullanıcının Diliyle İsimlendirme: Neden 'Kitap Ödünç Al', 'Ödünç Kaydı Oluştur'dan İyidir?", doc)

#lesson_header(
  18,
  "Kullanıcının Diliyle İsimlendirme: Neden 'Kitap Ödünç Al', 'Ödünç Kaydı Oluştur'dan İyidir?",
  "Naming in the User's Language: Why 'Borrow Book' Beats 'Create Loan Record'",
  "Temel Esaslar: Aktörler, Deniz Seviyesi Hedefler & Paydaş Sözleşmeleri",
  "Core Fundamentals: Actors, Sea-Level Goals & Contracts"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 İSİMLENDİRME FELSEFESİ: KULLANICI DİLİ VS TEKNİK JARGON     │
└─────────────────────────────────────────────────────────────────────────────┘
  ❌ GELİŞTİRİCİ DİLİ (TEKNİK / VERİTABANI ODAKLI):
  - "Create Loan Record" (Ödünç Kaydı Oluştur)
  - "Insert User Entity" (Kullanıcı Varlığı Ekle)
  - "Update Account Balance Table" (Bakiye Tablosunu Güncelle)
  💥 Hata: Paydaşın kafasını karıştırır, sistemi veritabanı CRUD operasyonuna indirger!

  ✅ KULLANICI DİLİ (İŞ HEDEFİ ODAKLI):
  - "Borrow Book" (Kitap Ödünç Al)
  - "Register Member" (Üye Kaydet)
  - "Transfer Funds" (Para Transfer Et)
  🎯 Başarı: Aktif fiil öbeğidir, gerçek dünya hedefini anlatır, her 3 okuyucu da anlar!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Kütüphaneye gittiğinde görevliye 'Affedersiniz, veritabanınızdaki ödünç tablosuna yeni bir satır ekleyip benim ID'mi o satırla ilişkilendirmek istiyorum' demezsin! Görevliye sadece 'Şu kitabı ödünç almak istiyorum' dersin. Bir use case'in adı, kullanıcının ağzından çıkan o doğal cümle olmalıdır. Teknik kelimeleri arkadaki motora bırak; tabelaya herkesin anladığı ismi yaz!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[When visiting a library, you never announce to the desk clerk: 'Greetings, I wish to initiate an INSERT transaction on your LOANS table linking my foreign key to this asset ID.' You say: 'I would like to borrow this book.' The title of a use case must always match the natural words spoken by the human pursuing the goal. Keep technical jargon inside the engine; keep the billboard clean.]
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
      İsimlendirme Semantiği ve Arayüz Olarak İsim Kuralı: Cockburn ve Martinelli use case isimlerinin yalnızca birer başlık değil, sistemin 'dış arayüzü' (interface) olduğunu vurgular: 1) Aktif Fiil Öbeği (Active Verb Phrase): İsim daima bir eylemle başlamalıdır: 'Borrow Book', 'Enroll in Course', 'Checkout Cart'. 'Kitap İşlemleri' veya 'Kullanıcı Modülü' gibi isimler use case olamaz çünkü bir hedef belirtmez. 2) Kullanıcı Dili (User Domain Language): 'Create Loan Record' ismi bir hedefin değil, veritabanındaki bir yazma operasyonunun adıdır. Eğer bir use case'i bir hedef olarak adlandıramıyorsanız, henüz elinizde bir use case yok demektir! 3) Birebir Eşleşme (Verbatim Interface): Use case diyagramındaki (PlantUML) isim ile şartname dosyasının adı (`UC-002-borrow-book.md`) ve dökümanın içindeki `# Use Case: Borrow Book` başlığı noktası virgülüne kadar aynı olmalıdır. Bu kural downstream çalışan kod üretim araçlarının (`/implement`) dökümanları hatasız bulmasını sağlar.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Naming as an Architectural Interface: 1) Active Verb-Noun Syntax: Use case names must strictly form active verb phrases representing user objectives: 'Borrow Book', 'Register Account', 'Submit Expense Claim'. Generic labels like 'Book Processing' or 'User Maintenance' fail because they denote static categories rather than goal-directed behaviors. 2) User Vocabulary vs Schema Projections: 'Create Loan Record' describes an internal database mutation; 'Borrow Book' captures the real-world business transaction. If you cannot articulate the name as a tangible user goal, the requirements boundaries are premature. 3) Verbatim Traceability Interface: The label in the PlantUML diagram (`UC-002\nBorrow Book`), the filename (`UC-002-borrow-book.md`), and the title header must match identically. Downstream AI tools rely on strict lexical matching to bridge architectural models with source code generation.]
    ]
  )
]

#java25_box[
```java
// Java 25: Kullanıcı Dilini Doğrudan Kod Semantiğine Taşıma (Ubiquitous Language)
package com.maang.aiup.naming;

public class DomainNamingDemo {
    // ❌ KÖTÜ TEKNİK İSİMLENDİRME:
    // public class LoanRecordCreator { public void insertRow(...) {} }

    // ✅ TEMİZ VE KULLANICI ODAKLI İSİMLENDİRME (Use Case ile Birebir):
    public static class BorrowBookUseCase {
        public record Command(String memberId, String bookIsbn) {}
        public record Result(String loanId, String dueDate) {}

        public Result borrowBook(Command cmd) {
            // Kod şartnamenin dilini konuşur!
            System.out.printf("Kitap ödünç alındı: Üye %s -> Kitap %s%n", cmd.memberId(), cmd.bookIsbn());
            return new Result("L-101", "2026-11-17");
        }
    }

    void main() {
        var uc = new BorrowBookUseCase();
        uc.borrowBook(new BorrowBookUseCase.Command("MEM-9", "ISBN-456"));
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
      Use case adında 'Veritabanı', 'Kayıt', 'Tablo', 'API', 'Servis' gibi yazılımcı kelimeleri geçiyorsa o isim yanlıştır. Hemen o kelimeleri silin ve kullanıcının gerçek hayattaki eylemini yazın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[If words like 'Database', 'Record', 'Table', 'Entity', or 'API' appear in your use case title, the name is corrupted by implementation bias. Strip away technical nouns and state the actor's real-world goal.]
    ]
  )
]

#takeaways_box((
    ("Use case ismi daima kullanıcının dilinde kısa ve aktif bir fiil öbeğidir (Borrow Book).", "Use case titles must be short active verb phrases in user language (e.g. Borrow Book)."),
    ("Veritabanı jargonu ('Create Loan Record') hedefi değil, uygulama mekanizmasını anlatır ve yanlıştır.", "Database jargon describes technical mutations, failing to capture user goals."),
    ("Diyagramdaki isim, dosya adı ve başlık noktası virgülüne kadar birbirini tutmalıdır.", "The diagram name, markdown file name, and header title must match verbatim."),
))
