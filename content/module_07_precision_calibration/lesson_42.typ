#import "/template.typ": *

#show: doc => setup_book(title: "Ders 42: 3 Soruluk Revizyon Filtresi: Şartnameyi Yeniden Üretilebilirliğe Karşı Denetleme", doc)

#lesson_header(
  42,
  "3 Soruluk Revizyon Filtresi: Şartnameyi Yeniden Üretilebilirliğe Karşı Denetleme",
  "The 3-Question Revision Pass: Auditing Specs for True Regeneration",
  "Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?",
  "Precision for AI — What to Say and What to Leave Out"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
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
     └── EVET  ──► ✅ MÜKEMMEL ADIM! Şartname onaylanmaya hazırdır!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Evinizin tapusunu düşünün: Tapuda 'Bu arsa Ahmet'indir, sınırları kuzeyde dere, güneyde yoldur' yazar. Tapuda 'Ahmet bu arsaya çimento taşırken sarı renkli 2018 model kamyon kullandı' yazmaz! Çünkü o kamyon 10 yıl sonra hurda olur ama tapu 100 yıl geçerlidir. 3 soruluk filtre, şartnamenizden sarı kamyonları ayıklayıp tapuyu ölümsüz kılar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of a land deed: The deed records: 'This parcel belongs to Ahmet, bounded by the creek to the north and the highway to the south.' It never mentions: 'Ahmet hauled concrete using a yellow 2018 dump truck.' The truck will be scrap metal in 10 years, but the deed remains legally binding for a century. The 3-question filter strips away the dump trucks, leaving an immortal contract.]
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
      3 Soruluk Revizyon Filtresinin Metodolojisi: Üretken yapay zekâ tarafından taslak olarak çıkarılan veya bir analist tarafından aceleyle yazılan use case'ler her zaman tahmin edilebilir hatalar barındırır. Bu şartnameleri /implement aşamasına sokmadan önce Martinelli'nin '3 Soruluk Filtresi' işletilir: 1. Paydaş Testi: 'Sistem gelen JSON payload'unu UserDTO nesnesine deserialize eder' gibi bir adımı hiçbir iş paydaşı anlayamaz ve doğrulayamaz. Bu adım derhal silinmelidir. 2. İcat Testi: 'Sistem kullanıcıyı bilgilendirir' adımını gören AI, bir modal mı açacak, SMS mi atacak yoksa konsola log mu basacak? Kararı AI'a bırakmak istemiyorsanız, içeriği ('SMS ile onay kodu gönderir') somutlaştırmalısınız. 3. 1 Yıl Sonra Testi: 'Sistem Redis cache'ini temizler' cümlesi seneye Redis yerine Hazelcast veya doğrudan Postgres kullanıldığında yanlış hale gelecektir. Bu yüzden 'Sistem güncel bakiye bilgisini tazeler' şeklinde teknoloji-bağımsız yazılmalıdır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The 3-Question Spec Revision Methodology: Generated drafts and human drafts fail in predictable archetypes. Martinelli mandates applying three rigorous filter questions to every single step before approval: 1. Stakeholder Verifiability: 'Could a business stakeholder confirm this step occurred?' If an action reads 'System maps entity to response DTO', no stakeholder can confirm it. It is internal narration; delete it. 2. Hallucination Risk: 'What would the AI have to invent to implement this step?' If a step says 'System displays available slots', the AI must invent sorting, pagination, and columns. Either specify them (Zone 1) or consciously delegate. 3. Regeneration Longevity: 'Would this sentence remain 100% true if regenerated on an entirely new platform stack next year?' If the sentence mentions Kafka, SQL, or JWT, it will rot upon migration. Strip the technology; preserve the pure business invariant.]
    ]
  )
]

#java25_box[
```java
// Java 25: 3 Soruluk Filtreden Geçmiş Ölümsüz Şartname İcra Modeli
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
      Şartname revizyonunu tek başınıza yapmayın; bir yazılım mühendisi ile bir iş analistinin şartname üzerinde birlikte bu 3 soruyu sorması en kaliteli sonucu verir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never conduct the revision pass in isolation; a software engineer and a business analyst reviewing the 3 questions together guarantees an airtight specification.]
    ]
  )
]

#takeaways_box((
    ("Paydaşın gözlemleyemeyeceği adımları ('DTO dönüştürür') şartnameden derhal silin.", "Immediately excise internal plumbing steps ('maps DTO') that stakeholders cannot confirm."),
    ("AI'ın doldurmak zorunda kalacağı her boşluğu ya somutlaştırın ya da bilinçli serbest bırakın.", "For every gap the AI would have to invent, specify it concretely or consciously leave it free."),
    ("Gelecek yıl stack değiştiğinde yalan olacak teknik kelimeleri şartnameden temizleyin.", "Purge any technological terminology that would become false upon a framework migration."),
))
