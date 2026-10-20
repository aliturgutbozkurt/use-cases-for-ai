#import "/template.typ": *

#show: doc => setup_book(title: "Ders 39: Zone 2 (Alan Modeli): Referans Ver, Asla Tekrarlama (entity_model.md)", doc)

#lesson_header(
  39,
  "Zone 2 (Alan Modeli): Referans Ver, Asla Tekrarlama (entity_model.md)",
  "Zone 2 (Domain Data): Reference, Never Restate (entity_model.md Truth)",
  "Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?",
  "Precision for AI — What to Say and What to Leave Out"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
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
  🎯 KURAL: Varlık yapısı yalnızca entity_model.md dosyasında yaşar!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Ev adresinizi düşünün: Arkadaşlarınıza her seferinde 'Dünya gezegeni, Türkiye cumhuriyeti, İstanbul ili, Kadıköy ilçesi, Moda caddesi, No:5 Daire:3' diye 5 sayfa anlatmazsınız. 'Moda'daki evime gel' dersiniz; herkes navigasyona (Harita / Entity Model) bakar. Use case adresi verir, haritanın kendisini içine çizmez!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of giving your home address: You don't recite: 'Planet Earth, coordinates 41.0082 N, continent Europe, district Kadikoy, apartment 3...' Every time someone asks. You say 'Come to my place in Moda.' They look up the map (Entity Model). The use case supplies the semantic reference; the entity model holds the authoritative schema.]
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
      Zone 2'nin DRY (Don't Repeat Yourself) İlkesi: Klasik yazılım mühendisliğinde kodun tekrarlanmaması (DRY) esastır. AI Unified Process bu ilkeyi gereksinim mühendisliğine taşır: 'Tek bir gerçeğin iki farklı kopyası varsa, zamanla bu kopyalar birbirinden uzaklaşır. Yapay zekâ bu çelişkiyi sessizce kendi kafasına göre çözer!' Use case şartnamesi içine veritabanı sütun tipleri, karakter uzunlukları veya DTO alan tabloları ASLA yazılmaz. Use case sadece alan adını (Entity Noun) zikreder: 'Üye', 'Kitap', 'Ödünç', 'Rezervasyon'. Bu isimlerin tüm veri yapısı, tipleri ve alan seviyesindeki doğrulama kuralları (örn: eposta regex'i, ISBN formatı) `docs/entity_model.md` dosyasında merkezi olarak tanımlanır. Böylece veri modeli güncellendiğinde tüm use case'ler otomatik olarak bu güncellemeyle uyumlu kalır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Zone 2 Domain Referencing & Requirements DRY: In classical software engineering, duplication is an operational nuisance. In an AI-driven workflow, duplication between artifacts is fatal. When an entity attribute is described in both `docs/use_cases/UC-002.md` and `docs/entity_model.md`, human maintainers inevitably update one and overlook the other. An LLM encountering contradictory schemas will silently resolve the ambiguity by picking one arbitrary interpretation. Zone 2 dictates: 'Reference domain nouns, never restate attribute tables.' Every domain noun used in a scenario ('Member', 'Loan', 'BookCopy') must exist verbatim in the entity model, which acts as the authoritative dictionary for types, constraints, and relationships.]
    ]
  )
]

#java25_box[
```java
// Java 25: Zone 2 - Entity Model ile Use Case Ayrımı
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
      Use case senaryolarının içerisine tablo çizip veritabanı sütun tiplerini (VARCHAR, INT, NotNull) doldurmayın! Bu tablolar yalnızca entity\_model.md dosyasında yaşar.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never embed database schemas, data types (VARCHAR, INT), or attribute definition tables inside use case steps. Those belong exclusively in docs/entity\_model.md.]
    ]
  )
]

#takeaways_box((
    ("Use case adımlarında geçen tüm isimler (Member, Loan) entity model'de tanımlı olmalıdır.", "All business nouns used in steps must correspond directly to entities in docs/entity_model.md."),
    ("Veri özniteliklerini şartnameye kopyalamayın; tek doğruluk kaynağına referans verin.", "Never duplicate entity attributes in use cases; reference the single source of truth."),
    ("Gereksinimlerde DRY ilkesi şarttır: İki farklı dokümandaki çelişkiyi AI kafasına göre çözer.", "DRY is a requirements principle: contradictory specs cause silent hallucinations in AI output."),
))
