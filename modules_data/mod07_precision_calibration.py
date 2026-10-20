# -*- coding: utf-8 -*-
"""
Module 7: Precision for AI — What to Say and What to Leave Out (Lessons 37-42)
"""

MODULE = {
    "id": 7,
    "dir": "module_07_precision_calibration",
    "title_tr": "Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?",
    "title_en": "Precision for AI — What to Say and What to Leave Out",
    "desc_tr": "Klasik Cockburn kuralı ile AI çağının çatışması: Gözlemlenebilir davranış (Zone 1), alan modeli referansı (Zone 2) ve yasaklı mekanizma detayları (Zone 3). Kara liste (JWT, SQL, regex, SMTP), UI tasarımcısının üçlü bölünmesi ve 3 soruluk revizyon filtresi.",
    "desc_en": "The collision between classical restraint and AI demands: Observable behavior (Zone 1), domain references (Zone 2), and forbidden mechanisms (Zone 3). The banned blocklist (JWT, SQL, regex, SMTP), the three-way UI split, and the 3-question revision pass.",
    "lessons": [
        {
            "num": 37,
            "title_tr": "Hassasiyet Paradoksu: Gözlemlenebilir Davranış vs Mekanizma Detayı",
            "title_en": "The Precision Paradox: Observable Behavior vs Mechanism Detail",
            "diagram": """┌─────────────────────────────────────────────────────────────────────────────┐
│                       HASSASİYETİN İKİ AYRI EKSENİ                          │
└─────────────────────────────────────────────────────────────────────────────┘
  
   Alistair Cockburn (2001):          AI Unified Process (2026):
   "Aşırı detaydan kaçının!           "AI varsayım yapamaz! Detaysız bırakırsanız
   Fazla yazmaktansa az yazmak        kendi kafasından uydurur! Her iki taraf da
   daha az zarar verir."              haklıdır; çünkü FARKLI DETAYLARDAN bahseder!"
                    │                                    │
                    ▼                                    ▼
       ❌ MEKANİZMA DETAYI (YASAK!)         ✅ GÖZLEMLENEBİLİR DETAY (ŞART!)
       - Hangi SQL sorgusu çalışacak?       - Hangi kolonlar hangi sırada görünecek?
       - Hangi JWT algoritması kullanılacak? - Hata mesajında kullanıcıya ne denecek?
       - Hangi regex ile kontrol edilecek?  - 28 günlük vade ve 5 adet limit şartı!
       (AI bunu stack plugin'inden öğrenir) (Bunu sadece paydaş ve use case bilir)

  🎯 ALTIN KURAL:
  "Paydaşın gözlemleyebileceği ve testin doğrulayabileceği HER ŞEYİ yazın.
   Sistemin bunu arkada nasıl başardığı hakkında HİÇBİR ŞEY yazmayın!" """,
            "eli5_tr": "Bir restorana gidip şefe sipariş verdiğinizi düşünün: Şefe 'Bana orta pişmiş antrikot, yanında kuşkonmaz ve patates püresi ile saat 20:00'de gelsin' dersiniz (Gözlemlenebilir istek!). Ama şefe 'Fırını 230 dereceye ayarla, tavayı 3 dakika ısıt, tuzu sol elle at' derseniz şef sizi mutfaktan kovar (Mekanizma detayı!). İşte use case şefe ne istediğinizi söyler, mutfak aletlerinin kullanımını şefe bırakır!",
            "eli5_en": "Imagine ordering at a fine restaurant: You tell the chef 'Bring me medium-rare ribeye steak with grilled asparagus and mashed potatoes at 8:00 PM' (Observable requirement!). But if you instruct the chef: 'Set the stove to 230 degrees, preheat the pan for 3 minutes, and sprinkle salt with your left hand', the chef kicks you out (Mechanism detail!). The use case defines what lands on the table; it lets the kitchen execute the technique.",
            "deep_tr": "Hassasiyet Paradoksunun Çözümü: Klasik use case literatüründe Cockburn, detay yazmanın tehlikeleri konusunda onlarca sayfa uyarıda bulunmuştur. Detay belgeyi kırılganlaştırır, bakım maliyetini artırır ve yetenekli geliştiricilerin yaratıcılığını çalar. Ancak günümüz AI destekli dünyasında Martinelli, 'Kitap listesini gösterir' gibi gevşek adımların AI tarafından tamamen rastgele kolonlarla üretilmesine sebep olduğunu gösterir. Çözüm, detayı tek bir eksen değil, iki zıt eksen olarak görmektir: 1) Gözlemlenebilir Detay (Observable Detail): Kullanıcının ekranda gördüğü veri, sıralama ölçütü, iş mantığı sınırları (28 gün, 5 kitap). Bu detay eksik bırakılırsa AI boşluğu kendi tahminleriyle doldurur ve sistem mimarisi çöker. 2) Mekanizma Detayı (Mechanism Detail): HTTP fiilleri, SQL transaction izolasyon seviyeleri, hash algoritmaları, regex desenleri. Bu detay yazılırsa şartname koda bağımlı hale gelir ve yeniden üretilebilirlik (regenerability) yok olur.",
            "deep_en": "Resolving the Precision Paradox: Cockburn warned extensively against over-specification because detail in traditional engineering is expensive to maintain, fragile against refactoring, and strips decisions from experienced developers. However, generative AI inverts this dynamic: an under-specified step like 'System displays books' forces the LLM to invent arbitrary table columns, sorting heuristics, and layout fields. Martinelli resolves this tension via a single axiom: 'Specify everything a stakeholder could observe and a test could verify. Specify nothing about how the system achieves it.' Detail is not one-dimensional; it splits into observable outcomes (required) versus underlying mechanisms (strictly banned).",
            "java_code": """// Java 25: Gözlemlenebilir İş Sonucunun Mekanizmadan Ayrılması
package com.maang.aiup.precision;

import java.time.LocalDate;
import java.util.List;

public class PrecisionParadoxDemo {
    // 1. GÖZLEMLENEBİLİR İŞ SONUCU (Paydaş ve Test Bunu Görür!)
    public record BorrowConfirmationView(
        String bookTitle,
        String memberName,
        LocalDate dueDate,
        int remainingLoanQuota
    ) {}

    // 2. MEKANİZMA (Use case'de ASLA geçmez; Spring Data, SQL, Redis buraya aittir)
    public interface LoanRepositoryPort {
        void persistLoanRecord(String memberId, String bookId, LocalDate dueDate);
    }

    // 3. USE CASE İCRA EDİCİSİ (Sadece gözlemlenebilir kuralı işletir)
    public static class BorrowBookInteractor {
        public BorrowConfirmationView execute(String memberName, String title, int currentLoans) {
            if (currentLoans >= 5) { // BR-005 kuralı
                throw new IllegalStateException("Ödünç limiti aşıldı! En fazla 5 kitap.");
            }
            LocalDate dueDate = LocalDate.now().plusDays(28); // 28 gün kuralı
            return new BorrowConfirmationView(title, memberName, dueDate, 5 - (currentLoans + 1));
        }
    }

    void main() {
        var interactor = new BorrowBookInteractor();
        var result = interactor.execute("Alice", "Designing Data-Intensive Apps", 2);
        System.out.println("✅ Gözlemlenebilir Sonuç: " + result);
    }
}""",
            "warning_tr": "'Sistem kullanıcıyı uygun şekilde bilgilendirir' veya 'verileri gösterir' gibi yuvarlak ifadeler kullanmayın. Bu kelimeler AI'a kafasına göre uydurma yetkisi (blank check) verir!",
            "warning_en": "Never use vague escape phrases like 'System notifies user appropriately' or 'System shows relevant data'. Every ambiguous word delegates architecture decisions to AI halluncinations.",
            "takeaways": [
                ("Paydaşın görebileceği ve testin doğrulayabileceği her şeyi somut olarak yazın.", "Specify everything a stakeholder can observe and an acceptance test can verify."),
                ("Sistemin bunu nasıl yaptığı (SQL, JWT, regex) use case şartnamesine asla yazılamaz.", "Never specify implementation mechanisms (SQL, JWT, regex) in use case specifications."),
                ("Eksik gözlemlenebilir detay, AI'ın kafasına göre kod uydurmasına davetiye çıkarır.", "Omitted observable details force the AI to invent business behavior arbitrarily.")
            ]
        },
        {
            "num": 38,
            "title_tr": "Zone 1 (Gözlemlenebilir Davranış): Somut Arayüz Yapısı, Kolonlar ve İş Miktarları",
            "title_en": "Zone 1 (Observable Behavior): Concrete Interface Structure, Columns & Quantities",
            "diagram": """┌─────────────────────────────────────────────────────────────────────────────┐
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
  └── 4. Bir kerede girilen veriler (Entity adıyla paketlenmiş)""",
            "eli5_tr": "Anneannenize market alışveriş listesi yazdığınızı düşünün: 'Bana biraz meyve al' derseniz anneanneniz erik yerine greyfurt getirebilir ve suçlayamazsınız! Ama '3 tane Amasya elması, 1 kilo yerli muz' yazarsanız tam istediğiniz gelir. Zone 1, alışveriş listesindeki meyvenin tam adı ve adedidir. Widget'ın poşet mi file mi olduğu önemli değildir; içindeki elmanın cinsi bellidir!",
            "eli5_en": "Think of writing a grocery list: If you write 'Buy some fruit', you might get sour lemons instead of sweet strawberries, and you can't complain! But if you write '3 Honeycrisp apples and 1 kg of bananas', you get precisely what you crave. Zone 1 is the exact fruit and quantity. Whether carried in a plastic bag or a wicker basket is irrelevant; the fruit itself is unambiguous.",
            "deep_tr": "Zone 1'in Derin Mühendisliği (Observable Behavior): AI destekli kod üretiminde şartnamelerin en çok tökezlediği yer Zone 1 eksikliğidir. Geliştirici 'Sistem sipariş detayını gösterir' yazdığında, insan bir yazılımcı şirketin önceki ekranlarına bakarak siparişte hangi alanların olduğunu hatırlar. Ancak bir LLM için bağlam sınırlıdır; 'sipariş detayı' adımından yola çıkarak rastgele DTO'lar, gereksiz kolonlar veya eksik alanlar üretir. Martinelli Zone 1 kurallarını şöyle netleştirir: 1) İsimlendirilmiş Kolonlar ve Sıralama: Tabloda hangi kolonların çıkacağı ve listenin neye göre sıralanacağı yazılmalıdır ('Sistem Grid üzerinde Başlık, Yazar, ISBN ve Stok kolonlarını Başlığa göre artan sırada gösterir'). 2) Kesin İş Miktarları: Asla 'yakında', 'birkaç tane' denemez; 'bugünden itibaren 28 gün sonra', 'en fazla 5 açık ödünç' denmelidir. 3) Hata Mesajının Anlamsal Özü: 'Hata gösterir' denemez; 'Ödünç almanın geciken kitaplar yüzünden engellendiğini bildirir ve geciken kitapları listeler' denmelidir.",
            "deep_en": "Zone 1 Precision Engineering: Under-specification in Zone 1 is the single greatest cause of prompt hallucination and code drift. When an engineer specifies 'System displays order details', human developers infer missing fields from adjacent legacy screens. An AI model, having no coffee-machine memory, invents arbitrary fields or omits mission-critical data. Zone 1 demands explicit observable facts: 1) Named Columns and Sort Orders: Define exact fields and orderings ('Grid showing Title, Author, ISBN, Available Copies sorted by Title ascending'). 2) Exact Business Quantities: Never write 'shortly' or 'a few'; declare exact constants ('due date 28 days from today', 'at most 5 loans'). 3) Message Content, Not Widgets: Never prescribe dialog boxes; mandate observable content ('System informs member that borrowing is blocked while loans are overdue and lists the overdue items').",
            "java_code": """// Java 25: Zone 1 Gözlemlenebilir Veri Sözleşmesi (Named Columns & Ordering)
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
}""",
            "warning_tr": "Zone 1'de arayüz bileşenlerinin adlarını yazmayın: 'Modal popup açılır', 'Dropdown menü gösterilir' veya 'Toast mesajı fırlar' YAZMAYIN! Bunlar Zone 3 ihlalidir. Sadece içeriği ve aksiyonu söyleyin.",
            "warning_en": "Never mandate concrete UI widgets in Zone 1 (e.g., 'A modal pop-up appears' or 'Dropdown renders'). Specify the information conveyed and user actions, not visual presentation widgets.",
            "takeaways": [
                ("Tablolardaki kolon isimlerini ve sıralama ölçütünü (sort order) şartnamede açıkça belirtin.", "Explicitly state displayed column names and sorting orders in the specification."),
                ("İş kurallarındaki sayısal sınırları ('28 gün', '5 limit') net olarak yazın; yuvarlak laflardan kaçının.", "Use precise business quantities ('28 days', '5 loans') rather than vague approximations."),
                ("Hata mesajlarının biçimini değil, kullanıcıya ilettiği zorunlu bilgi içeriğini tarif edin.", "Specify the informative payload of error messages, not the UI container or toast widget.")
            ]
        },
        {
            "num": 39,
            "title_tr": "Zone 2 (Alan Modeli): Referans Ver, Asla Tekrarlama (entity_model.md)",
            "title_en": "Zone 2 (Domain Data): Reference, Never Restate (entity_model.md Truth)",
            "diagram": """┌─────────────────────────────────────────────────────────────────────────────┐
│                 ZONE 2: TEK DOĞRULUK KAYNAĞI VE REFERANS AĞI                 │
└─────────────────────────────────────────────────────────────────────────────┘
  
  ❌ YANLIŞ YOL (ALAN ÖZNİTELİKLERİNİ USE CASE İÇİNE GÖMMEK):
  UC-002 Adım 1: "Kullanıcı üye numarası (String 10 hane), T.C. kimlik (11 hane),
                  eposta ve telefon bilgisini girer."
  💥 FELAKET: Yarın eposta formatı değişirse 15 farklı use case dosyasını
               güncellemek zorunda kalırsınız! Biri unutulursa AI çelişkide kalır!
  
  ✅ DOĞRU YOL (ZONE 2 REFERANS İLKESİ):
  UC-002 Adım 1: "Kullanıcı üyelik bilgilerini girer."
                   │
                   ▼ (İsim Bağlantısı / Semantic Reference)
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ docs/entity_model.md                                                    │
  │ Member {                                                                │
  │   memberId: String(10) [PK]                                             │
  │   email: String(255) [Unique, Valid-Email]                              │
  │   loanCount: Integer [Min=0, Max=5]                                     │
  │ }                                                                       │
  └─────────────────────────────────────────────────────────────────────────┘
  🎯 KURAL: Varlık yapısı yalnızca entity_model.md dosyasında yaşar!""",
            "eli5_tr": "Ev adresinizi düşünün: Arkadaşlarınıza her seferinde 'Dünya gezegeni, Türkiye cumhuriyeti, İstanbul ili, Kadıköy ilçesi, Moda caddesi, No:5 Daire:3' diye 5 sayfa anlatmazsınız. 'Moda'daki evime gel' dersiniz; herkes navigasyona (Harita / Entity Model) bakar. Use case adresi verir, haritanın kendisini içine çizmez!",
            "eli5_en": "Think of giving your home address: You don't recite: 'Planet Earth, coordinates 41.0082 N, continent Europe, district Kadikoy, apartment 3...' Every time someone asks. You say 'Come to my place in Moda.' They look up the map (Entity Model). The use case supplies the semantic reference; the entity model holds the authoritative schema.",
            "deep_tr": "Zone 2'nin DRY (Don't Repeat Yourself) İlkesi: Klasik yazılım mühendisliğinde kodun tekrarlanmaması (DRY) esastır. AI Unified Process bu ilkeyi gereksinim mühendisliğine taşır: 'Tek bir gerçeğin iki farklı kopyası varsa, zamanla bu kopyalar birbirinden uzaklaşır. Yapay zekâ bu çelişkiyi sessizce kendi kafasına göre çözer!' Use case şartnamesi içine veritabanı sütun tipleri, karakter uzunlukları veya DTO alan tabloları ASLA yazılmaz. Use case sadece alan adını (Entity Noun) zikreder: 'Üye', 'Kitap', 'Ödünç', 'Rezervasyon'. Bu isimlerin tüm veri yapısı, tipleri ve alan seviyesindeki doğrulama kuralları (örn: eposta regex'i, ISBN formatı) `docs/entity_model.md` dosyasında merkezi olarak tanımlanır. Böylece veri modeli güncellendiğinde tüm use case'ler otomatik olarak bu güncellemeyle uyumlu kalır.",
            "deep_en": "Zone 2 Domain Referencing & Requirements DRY: In classical software engineering, duplication is an operational nuisance. In an AI-driven workflow, duplication between artifacts is fatal. When an entity attribute is described in both `docs/use_cases/UC-002.md` and `docs/entity_model.md`, human maintainers inevitably update one and overlook the other. An LLM encountering contradictory schemas will silently resolve the ambiguity by picking one arbitrary interpretation. Zone 2 dictates: 'Reference domain nouns, never restate attribute tables.' Every domain noun used in a scenario ('Member', 'Loan', 'BookCopy') must exist verbatim in the entity model, which acts as the authoritative dictionary for types, constraints, and relationships.",
            "java_code": """// Java 25: Zone 2 - Entity Model ile Use Case Ayrımı
package com.maang.aiup.zone2;

// 1. ENTITY MODEL (docs/entity_model.md karşılığı): Tek doğruluk kaynağı
public record Member(String memberId, String email, int activeLoanCount) {
    public Member {
        if (memberId == null || memberId.isBlank()) {
            throw new IllegalArgumentException("memberId boş olamaz!");
        }
        if (activeLoanCount < 0 || activeLoanCount > 5) {
            throw new IllegalArgumentException("Ödünç sayısı 0-5 arasında olmalıdır!");
        }
    }
}

// 2. USE CASE: Varlık özniteliklerini ezberlemez, varlığı bir bütün olarak ele alır
public class BorrowService {
    public boolean canBorrow(Member member) {
        // Use case sadece iş kuralını sorgular; alan tiplerini yeniden tanımlamaz
        return member.activeLoanCount() < 5;
    }

    void main() {
        var member = new Member("M-101", "alice@example.com", 3);
        var service = new BorrowService();
        System.out.println("✅ Üye ödünç alabilir mi? " + service.canBorrow(member));
    }
}""",
            "warning_tr": "Use case senaryolarının içerisine tablo çizip veritabanı sütun tiplerini (VARCHAR, INT, NotNull) doldurmayın! Bu tablolar yalnızca entity_model.md dosyasında yaşar.",
            "warning_en": "Never embed database schemas, data types (VARCHAR, INT), or attribute definition tables inside use case steps. Those belong exclusively in docs/entity_model.md.",
            "takeaways": [
                ("Use case adımlarında geçen tüm isimler (Member, Loan) entity model'de tanımlı olmalıdır.", "All business nouns used in steps must correspond directly to entities in docs/entity_model.md."),
                ("Veri özniteliklerini şartnameye kopyalamayın; tek doğruluk kaynağına referans verin.", "Never duplicate entity attributes in use cases; reference the single source of truth."),
                ("Gereksinimlerde DRY ilkesi şarttır: İki farklı dokümandaki çelişkiyi AI kafasına göre çözer.", "DRY is a requirements principle: contradictory specs cause silent hallucinations in AI output.")
            ]
        },
        {
            "num": 40,
            "title_tr": "Zone 3 (Mekanizma - YASAK!): Kara Liste (JWT, SQL, bcrypt, Regex, SMTP)",
            "title_en": "Zone 3 (Mechanism - BANNED): The Blocklist (JWT, SQL, bcrypt, Regex, SMTP)",
            "diagram": """┌─────────────────────────────────────────────────────────────────────────────┐
│                 ZONE 3: ŞARTNAMEDE KESİNLİKLE YASAKLI KELİMELER             │
└─────────────────────────────────────────────────────────────────────────────┘
  
  🛑 ŞARTNAME DOĞRULAMA MOTORU TARAFINDAN ENGELLENEN BLOKLİST:
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ SMTP, email server, JWT, token, bcrypt, hash, salt, SHA, SQL, SELECT,   │
  │ INSERT, HTTP verbs (GET, POST), regex patterns, class names, exceptions │
  └─────────────────────────────────────────────────────────────────────────┘
  
  ❌ YASAKLI YAZIM (ZONE 3 MEKANİZMA):      ✅ DOĞRU YAZIM (ZONE 1 İŞ İRADESİ):
  ────────────────────────────────────      ───────────────────────────────────
  "Sistem şifreyi bcrypt ile hash'ler."     "Sistem parolayı güvenli şekilde saklar."
  "Sistem kullanıcıya JWT token verir."     "Sistem kullanıcı oturumunu açar."
  "Sistem reservations tablosuna INSERT     "Sistem rezervasyon kaydını oluşturur."
   sorgusu fırlatır."
  "Sistem SMTP port 587 üzerinden mail atar" "Sistem onay e-postası gönderir."
  "Sistem ValidationException fırlatır."    "Sistem hata mesajı görüntüler."
  
  🎯 NEDEN?: Bugün bcrypt olan yarın argon2 olur! Şartname teknolojiyi değil
             iş hedefini mühürler; teknoloji değişse de şartname hayatta kalır!""",
            "eli5_tr": "Birine mektup gönderirken postacıya 'Mektubu al, dizel motorlu Fiat Doblo marka aracın sağ ön koltuğuna koy, 2. viteste git' demezsiniz! 'Bu mektubu Ankara'daki adrese teslim et' dersiniz. Postacı arabayla mı gider, bisikletle mi gider onun işidir. Zone 3 yasakları, postacının motor markasını use case'e yazmayı yasaklar!",
            "eli5_en": "When posting a letter, you never instruct the postal carrier: 'Put this envelope in a diesel Fiat van, drive in second gear, and make 3 right turns.' You simply say: 'Deliver this letter to the address in Ankara.' Whether they drive a truck or pedal a bicycle is their operational choice. Zone 3 forbids specifying the carrier's engine model in your contract.",
            "deep_tr": "Zone 3 Mekanizma Yasağının Mimari Sebepleri: Simon Martinelli'nin AIUP modelinde şartname doğrulama komutları (`/spec-review`) şartnamelerde geçen belirli teknik terimleri katı bir 'Blacklist' (Kara Liste) ile tarar ve bulduğunda build'i kırar. Bu kelimeler şunlardır: SMTP, JWT, bcrypt, hash, salt, SQL, SELECT, INSERT, UPDATE, HTTP verbs (GET/POST), regex, sınıf adları ve exception isimleri. Bu yasağın arkasında iki hayati neden vardır: 1) İnsan ve AI Ayrımı: İnsan yazılımcı kötü bir şartnamede gördüğü saçma bir SQL tüyosunu görmezden gelip doğru mimariyi kurabilir; ancak yapay zekâ şartnamede gördüğü her kelimeyi kanun kabul eder! 'Şifreyi bcrypt ile hash'le' yazdığınızda, yarın Argon2id standardına geçmek istediğinizde şartname kodla çatışır. 2) Yeniden Üretilebilirlik (Regenerability): Şartname kodun ömründen daha uzun yaşayacaksa (İlke 11), şartname bir teknoloji yığınına (Spring Boot, NestJS, .NET Blazor) göbekten bağlanamaz. Şartname iş hedefini belirtir ('parolayı güvenli şekilde saklar'), mekanizma ise stack plugin'inin sorumluluğundadır.",
            "deep_en": "Architectural Rationale for the Zone 3 Blocklist: In the AI Unified Process, `/spec-review` scans use case specifications against a strict lexical blocklist: SMTP, email server, JWT, token, bcrypt, hash, salt, SHA, SQL, SELECT, INSERT, HTTP verbs, regex patterns, class names, exception names. The existence of this blocklist stems from two fundamental realities: 1) Literal AI Execution: Unlike human senior engineers who ignore poor architectural hints in a spec, an LLM adheres slavishly to written text. Specifying 'hash password with bcrypt and salt' prevents the AI from upgrading to Argon2id without spec refactoring. 2) Framework Portability: The specification outlives the implementation (Principle 11). If an organization migrates from Spring Boot to Quarkus, .NET, or Go, a specification free of Zone 3 leaks remains 100% valid and immediately regenerable.",
            "java_code": """// Java 25: Mekanizmanın (Zone 3) İş Mantığından Soyutlanması (Port & Adapter)
package com.maang.aiup.zone3;

public class MechanismDecouplingDemo {
    // 1. ŞARTNAME TANIMI: "Sistem parolayı güvenli şekilde saklar"
    // Mekanizma bir port arayüzünün arkasına gizlenir; use case mekanizmayı bilmez!
    public interface PasswordHasherPort {
        String secureHash(String rawPassword);
    }

    // 2. MEKANİZMA UYGULAMASI (Bugün PBKDF2/Bcrypt, yarın Argon2)
    public static class ModernPasswordHasher implements PasswordHasherPort {
        @Override
        public String secureHash(String rawPassword) {
            // Şartnamede 'Argon2' veya 'bcrypt' adı ASLA anılmaz!
            return "SECURE_HASH::" + rawPassword.hashCode(); 
        }
    }

    public static class UserAccountService {
        private final PasswordHasherPort hasher;

        public UserAccountService(PasswordHasherPort hasher) {
            this.hasher = hasher;
        }

        public void registerUser(String username, String rawPassword) {
            // İş mantığı: Güvenli sakla
            String hashed = hasher.secureHash(rawPassword);
            System.out.println("✅ Kullanıcı '" + username + "' kaydedildi. Güvenli özet oluşturuldu.");
        }
    }

    void main() {
        var service = new UserAccountService(new ModernPasswordHasher());
        service.registerUser("bozkurt", "SuperSecret2026!");
    }
}""",
            "warning_tr": "E-posta doğrulama için regex desenini (/^[\\w]+@[\\w]+\\.[a-z]+$/) şartnameye kopyalamayın! 'Sistem e-posta formatını doğrular' yazın; regex'i stack plugin'i veya entity model halleder.",
            "warning_en": "Never inline regex validation patterns into use case steps. State 'System validates email format'; let the stack plugin or entity model supply the RFC-compliant pattern.",
            "takeaways": [
                ("Kara listedeki kelimeler (JWT, SQL, bcrypt, regex, SMTP) use case içinde KESİNLİKLE yasaktır.", "Blocklist keywords (JWT, SQL, bcrypt, regex, SMTP) are strictly prohibited in use cases."),
                ("Şartname iş hedefini söyler ('güvenli saklar'); teknolojiyi stack plugin'ine bırakır.", "Specifications state business goals ('securely stores'); technical stacks determine mechanisms."),
                ("Mekanizmadan arındırılmış şartnameler, teknoloji yığını değişse bile 10 yıl sonra dahi çalışır.", "Mechanism-free specs survive stack migrations, enabling flawless code regeneration years later.")
            ]
        },
        {
            "num": 41,
            "title_tr": "UI Tasarımcısı Nereye Gitti? Üçlü Sorumluluk Bölünmesi",
            "title_en": "Where Did the UI Designer Go? The Three-Way Responsibility Split",
            "diagram": """┌─────────────────────────────────────────────────────────────────────────────┐
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
  └─────────────────────────────────────────────────────────────────────────┘""",
            "eli5_tr": "Bir tiyatro oyununu düşünün: Senaryo yazarı (Use Case) der ki: 'Romeo sahneye girer, elindeki mektubu Juliet'e uzatır ve aşkını ilan eder.' Senaryo yazarı 'Juliet kırmızı kadife koltuğa 45 derece açıyla otursun, arkadan 40 watt sarı spot yansısın' demez! Koltuğu dekoratör (Mockup), ışığı teknisyen (Stack Plugin) ayarlar!",
            "eli5_en": "Think of a theater play: The playwright (Use Case) writes: 'Romeo enters stage left, hands the letter to Juliet, and professes his love.' The playwright does not dictate: 'Juliet must sit on a 45-degree angle crimson sofa illuminated by a 40-watt tungsten lamp.' The set designer (Mockup) and stage crew (Stack Plugin) handle layout and fixtures.",
            "deep_tr": "UI Tasarımcısının Üçlü Bölünmesi (The Three-Way Split): Cockburn'ün 'UI tasarımcısına güvenin' öğüdü, şartnameyi okuyup ekran tasarlayan bir insan tasarımcının varlığına dayanıyordu. AI Unified Process'te bu rol üçe ayrılır: 1) Etkileşim Yapısı (Interaction Structure): Use Case şartnamesinin asli görevidir (Zone 1). Kullanıcının her adımda ne yapabileceğini, hangi veriyi gördüğünü ve hangi kararı verdiğini belirtir. 2) Düzen ve Görünüm (Layout & Look): Mockup veya Figma tasarımının görevidir. Eğer harici bir mockup varsa, use case buna link verir (`Mockup: docs/mockups/UC-002.png`). Mockup yoksa AI, platformun modern UX standartlarına göre düzeni kendi kurar. 3) Widget Seçimi ve Kablolama (Widget Choice & Wiring): Stack Plugin'inin görevidir. /implement komutu projenin React mı, Vue mu, Vaadin mi yoksa Flutter mı olduğunu bilir. Use case asla 'dropdown menüden seçer' veya 'modal popup açılır' demez; 'seçer' ve 'görüntüler' der.",
            "deep_en": "The Three-Way Split of the UI Designer Role: Cockburn's counsel to trust the UI designer assumed a human specialist interpreting business intent. In generative development, that function partitions across three decoupled layers: 1) Interaction Structure: Owned entirely by the use case specification (Zone 1). It dictates the logical payload—what the actor enters, inspects, and acknowledges. 2) Layout and Aesthetics: Owned by supplementary mockup artifacts (e.g., SVG/Figma files) linked from the spec. In the absence of a mockup, the AI synthesizes layouts adhering to modern platform heuristics. 3) Widget Selection & Component Wiring: Owned by the implementation stack plugin. Whether an input maps to a `Select`, a radio group, or an autocomplete combo-box is the platform stack's prerogative. The spec remains agnostic of widget nomenclature.",
            "java_code": """// Java 25: Etkileşim Yapısının (Use Case) Widget'tan (UI Framework) Ayrılması
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
}""",
            "warning_tr": "Şartnamede 'Kullanıcı OK butonuna tıklar' veya 'İptal linkine basar' gibi widget isimleri yerine 'Kullanıcı işlemi onaylar' veya 'Kullanıcı işlemi iptal eder' deyin.",
            "warning_en": "Replace widget mechanics like 'User clicks OK button' or 'User clicks cancel link' with user intent: 'User confirms operation' or 'User cancels operation'.",
            "takeaways": [
                ("Etkileşim yapısı (ne görülür/yapılır) use case'in, düzen mockup'ın, widget seçimi stack'in işidir.", "Interaction structure belongs to specs, layout to mockups, widget choice to stack plugins."),
                ("Use case asla 'dropdown', 'dialog box' veya 'toast' demez; sadece iş niyetini tarif eder.", "Never use terms like 'dropdown' or 'dialog box'; specify user intent and information flow."),
                ("Mockup eksikse AI modern tasarım kalıplarına göre düzeni başarıyla oluşturabilir.", "When mockups are absent, AI synthesizes layouts from interaction structure and conventions.")
            ]
        },
        {
            "num": 42,
            "title_tr": "3 Soruluk Revizyon Filtresi: Şartnameyi Yeniden Üretilebilirliğe Karşı Denetleme",
            "title_en": "The 3-Question Revision Pass: Auditing Specs for True Regeneration",
            "diagram": """┌─────────────────────────────────────────────────────────────────────────────┐
│                 3 SORULUK ŞARTNAME REVİZYON FİLTRESİ                        │
└─────────────────────────────────────────────────────────────────────────────┘
  
  Şartnamedeki HER BİR ADIMI gözden geçirirken şu 3 soruyu sırayla sorun:
  
  ❓ SORU 1: "Bir paydaş bu adımın gerçekleştiğini doğrulayabilir mi?"
     ├── HAYIR ──► Kod anlatımıdır veya Zone 3 sızıntısıdır! (Örn: 'DTO map eder')
     │             🚨 EYLEM: Adımı silin veya gözlemlenebilir bir sonuca dönüştürün!
     └── EVET  ──► Soru 2'ye geçin.
  
  ❓ SORU 2: "AI bu adımı kodlamak için kafasından ne uydurmak zorunda kalır?"
     ├── ÇOK ŞEY ─► Yetersiz tanımlama (Under-specification)! Kolonlar veya kurallar eksik!
     │             🚨 EYLEM: Ya somutlaştırın (Zone 1) ya da entity model'e bağlayın (Zone 2)!
     └── HİÇBİR ŞEY ► Soru 3'e geçin.
  
  ❓ SORU 3: "Gelecek yıl bu sistemi yepyeni bir teknolojiyle yeniden üretsek,
             bu cümle HALA DOĞRU KALIR MI?"
     ├── HAYIR ──► Teknoloji bağımlılığı sızmıştır! (Örn: 'JWT token süresi 15 dk')
     │             🚨 EYLEM: Teknoloji kelimesini atın, iş kuralına dönüştürün!
     └── EVET  ──► ✅ MÜKEMMEL ADIM! Şartname onaylanmaya hazırdır!""",
            "eli5_tr": "Evinizin tapusunu düşünün: Tapuda 'Bu arsa Ahmet'indir, sınırları kuzeyde dere, güneyde yoldur' yazar. Tapuda 'Ahmet bu arsaya çimento taşırken sarı renkli 2018 model kamyon kullandı' yazmaz! Çünkü o kamyon 10 yıl sonra hurda olur ama tapu 100 yıl geçerlidir. 3 soruluk filtre, şartnamenizden sarı kamyonları ayıklayıp tapuyu ölümsüz kılar!",
            "eli5_en": "Think of a land deed: The deed records: 'This parcel belongs to Ahmet, bounded by the creek to the north and the highway to the south.' It never mentions: 'Ahmet hauled concrete using a yellow 2018 dump truck.' The truck will be scrap metal in 10 years, but the deed remains legally binding for a century. The 3-question filter strips away the dump trucks, leaving an immortal contract.",
            "deep_tr": "3 Soruluk Revizyon Filtresinin Metodolojisi: Üretken yapay zekâ tarafından taslak olarak çıkarılan veya bir analist tarafından aceleyle yazılan use case'ler her zaman tahmin edilebilir hatalar barındırır. Bu şartnameleri /implement aşamasına sokmadan önce Martinelli'nin '3 Soruluk Filtresi' işletilir: 1. Paydaş Testi: 'Sistem gelen JSON payload'unu UserDTO nesnesine deserialize eder' gibi bir adımı hiçbir iş paydaşı anlayamaz ve doğrulayamaz. Bu adım derhal silinmelidir. 2. İcat Testi: 'Sistem kullanıcıyı bilgilendirir' adımını gören AI, bir modal mı açacak, SMS mi atacak yoksa konsola log mu basacak? Kararı AI'a bırakmak istemiyorsanız, içeriği ('SMS ile onay kodu gönderir') somutlaştırmalısınız. 3. 1 Yıl Sonra Testi: 'Sistem Redis cache'ini temizler' cümlesi seneye Redis yerine Hazelcast veya doğrudan Postgres kullanıldığında yanlış hale gelecektir. Bu yüzden 'Sistem güncel bakiye bilgisini tazeler' şeklinde teknoloji-bağımsız yazılmalıdır.",
            "deep_en": "The 3-Question Spec Revision Methodology: Generated drafts and human drafts fail in predictable archetypes. Martinelli mandates applying three rigorous filter questions to every single step before approval: 1. Stakeholder Verifiability: 'Could a business stakeholder confirm this step occurred?' If an action reads 'System maps entity to response DTO', no stakeholder can confirm it. It is internal narration; delete it. 2. Hallucination Risk: 'What would the AI have to invent to implement this step?' If a step says 'System displays available slots', the AI must invent sorting, pagination, and columns. Either specify them (Zone 1) or consciously delegate. 3. Regeneration Longevity: 'Would this sentence remain 100% true if regenerated on an entirely new platform stack next year?' If the sentence mentions Kafka, SQL, or JWT, it will rot upon migration. Strip the technology; preserve the pure business invariant.",
            "java_code": """// Java 25: 3 Soruluk Filtreden Geçmiş Ölümsüz Şartname İcra Modeli
package com.maang.aiup.revision;

import java.time.Instant;

public class SpecRevisionDemo {
    // ❌ FİLTREDEN GEÇEMEYEN ŞARTNAME KODU (Teknoloji sızıntısı dolu):
    // public void saveToMongoAndPublishToKafka(UserDTO dto) { ... }

    // ✅ 3 SORULUK FİLTREDEN GEÇMİŞ KOD (Ölümsüz İş Mantığı):
    public record MemberRegistrationOutcome(String memberId, Instant registeredAt, String status) {}

    public static class RegisterMemberUseCase {
        public MemberRegistrationOutcome register(String email) {
            // Soru 1: Paydaş kaydın yapıldığını görebilir mi? -> Evet.
            // Soru 2: AI ne uydurdu? -> Hiçbir şey, outcome alanları net.
            // Soru 3: Seneye Mongo yerine Postgres gelse bu cümle doğru mu? -> Kesinlikle evet!
            return new MemberRegistrationOutcome("MEM-" + System.currentTimeMillis(), Instant.now(), "ACTIVE");
        }
    }

    void main() {
        var useCase = new RegisterMemberUseCase();
        var outcome = useCase.register("engineer@maang.com");
        System.out.println("✅ 3 Soruluk filtreden geçmiş tertemiz use case sonucu:");
        System.out.println("   -> " + outcome);
    }
}""",
            "warning_tr": "Şartname revizyonunu tek başınıza yapmayın; bir yazılım mühendisi ile bir iş analistinin şartname üzerinde birlikte bu 3 soruyu sorması en kaliteli sonucu verir.",
            "warning_en": "Never conduct the revision pass in isolation; a software engineer and a business analyst reviewing the 3 questions together guarantees an airtight specification.",
            "takeaways": [
                ("Paydaşın gözlemleyemeyeceği adımları ('DTO dönüştürür') şartnameden derhal silin.", "Immediately excise internal plumbing steps ('maps DTO') that stakeholders cannot confirm."),
                ("AI'ın doldurmak zorunda kalacağı her boşluğu ya somutlaştırın ya da bilinçli serbest bırakın.", "For every gap the AI would have to invent, specify it concretely or consciously leave it free."),
                ("Gelecek yıl stack değiştiğinde yalan olacak teknik kelimeleri şartnameden temizleyin.", "Purge any technological terminology that would become false upon a framework migration.")
            ]
        }
    ]
}
