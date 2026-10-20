#import "/template.typ": *

#show: doc => setup_book(title: "Ders 28: Sonkoşullar Kontrattır: Başarı Garantileri vs Asgari Başarısızlık Garantileri", doc)

#lesson_header(
  28,
  "Sonkoşullar Kontrattır: Başarı Garantileri vs Asgari Başarısızlık Garantileri",
  "Postconditions as Contracts: Success Guarantees vs Failure Minimums",
  "Ana Şartname Şablonu & Alan Alan Derinlemesine İnceleme",
  "The Master Specification Template & Field Breakdown"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 SONKOŞULLAR (POSTCONDITIONS): İKİ TARAFLI GARANTİ           │
└─────────────────────────────────────────────────────────────────────────────┘
  BAŞARI SONKOŞULLARI (SUCCESS POSTCONDITIONS / SUCCESS GUARANTEES):
  - Hedef tamamlandığında dünyanın aldığı YENİ DURUM:
    * "Üye ile kitap arasında 28 gün vadeli bir ödünç kaydı mevcuttur."
    * "Kitabın mevcut kopya sayısı 1 azaltılmıştır."
    * "Ödünç kaydı üyenin aktif listesinde görüntülenir."

  BAŞARISIZLIK SONKOŞULLARI (FAILURE POSTCONDITIONS / MINIMAL GUARANTEES):
  - Hangi hata olursa olsun (A1, A2, A3) sistemin verdiği ASGARİ TAAHHÜT:
    * "Hiçbir kısmi kayıt veritabanına YAZILMAMIŞTIR (Rollback garantisi!)."
    * "Kitabın mevcut kopya sayısı DEĞİŞMEMİŞTİR."
    * "Başarısızlık denemesi denetim loguna (audit log) işlenmiştir."

  🎯 AI İÇİN ÖNEMİ: Sonkoşullar veritabanı @Transactional sınırını ve testlerin
                   assert (doğrulama) bloklarını doğrudan belirler!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir banka ATM'sinden para çekmeyi düşünün: 1) Başarı Sonkoşulu: Cebinde 1000 TL nakit para vardır, banka hesabından 1000 TL düşmüştür (Hedef tamam!). 2) Başarısızlık Sonkoşulu: ATM tam para sayarken elektrik kesilirse sistemin sana verdiği asgari sözdür: 'Merak etme! Para vermediysem hesabından da 1 kuruş bile DÜŞMEDİM, kartını geri verdim ve log tuttum!' (Kısmi işlem yok!). Sonkoşul, sistemin ne olursa olsun arkasında çöp bırakmayacağının garantisidir.
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Withdrawing money from an ATM: 1) Success Postcondition: You hold \$100 cash in hand, and your account balance is debited by exactly \$100. 2) Failure Postcondition: If the power cuts out while gears are turning, the bank provides an ironclad minimum guarantee: 'No partial withdrawal occurred, your bank balance is untouched, your card is returned, and an audit incident is logged.' Failure postconditions enforce transactional atomicity.]
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
      Sonkoşullar ve İşlemsel Bütünlük (Transactional Contract): Cockburn'ün en güçlü kavramlarından biri olan 'Guarantees' (Garantiler), AIUP şablonunda 'Success Postconditions' ve 'Failure Postconditions' olarak ikiye ayrılmıştır. 1) Başarı Sonkoşulları: Sistemin mutlu yolda yarattığı tüm kalıcı durum değişikliklerini listeler. 2) Başarısızlık Sonkoşulları (Minimal Guarantees): Sistem başarısız olduğunda neyin ASLA bozulmayacağını taahhüt eder. 'Hiçbir kısmi veri kaydedilmez' garantisi, AI'ın veritabanı işlemlerini `\@Transactional` bloğu içine almasını zorunlu kılar. 'Deneme denetim günlüğüne kaydedilir' garantisi ise AI'ın güvenlik loglarını üretmesini sağlar. 3) Testlerin Tohumu: Her iki sonkoşul bölümü de boş bırakılamaz! Çünkü üretilen otomatik testlerin `assert` blokları doğrudan bu sonkoşullardan türetilir: `assertEquals(oldBalance, newBalance)` başarısızlık sonkoşulunun doğrudan koddaki yansımasıdır. Cockburn'ün altın taktiği: Senaryoyu yazmadan ÖNCE sonkoşulları yazın ve 'Başarılı bir akışın sonunda paydaşı ne mutsuz ederdi?' diye sorun; çıkan cevaplar unuttuğunuz doğrulamaları yakalamanızı sağlar.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Postconditions as Transactional Contracts: Cockburn's concept of 'Guarantees' maps directly to the dual postconditions of the AIUP template: 1) Success Postconditions: Explicitly describe the state of the universe when the goal is fulfilled: records created, inventories adjusted, notifications queued. 2) Failure Postconditions (Minimal Guarantees): Express what remains true even when disaster strikes. They are not descriptions of the failure; they are the baseline invariants the system promises under catastrophic exit (e.g. 'No partial loan is persisted', 'Pre-use-case state is restored', 'The failed attempt is recorded in the security log'). 3) Generative Significance: For an AI agent, failure postconditions dictate database transaction boundaries (`\@Transactional(rollbackFor = Exception.class)`). Furthermore, postconditions seed the assertion blocks of generated test suites. Cockburn's heuristic: draft postconditions before writing the steps, asking 'What would make stakeholders furious after an apparent success?']
    ]
  )
]

#java25_box[
```java
// Java 25: Başarı ve Başarısızlık Sonkoşullarını Garanti Eden Transactional Kod
package com.maang.aiup.postconditions;

public class TransactionalContractService {
    public record Account(String id, double balance) {}

    // Başarısızlık Sonkoşulu: Hata anında bakiye ASLA değişmez (Rollback garantisi!)
    public static Account transferMoney(Account from, Account to, double amount) {
        double originalBalance = from.balance();
        try {
            if (from.balance() < amount) {
                throw new IllegalStateException("Yetersiz bakiye!");
            }
            // Başarı Sonkoşulu: Para düşüldü
            return new Account(from.id(), from.balance() - amount);
        } catch (Exception e) {
            // Başarısızlık Garantisi Assert Edilir:
            assert from.balance() == originalBalance : "KRİTİK HATA: Bakiye bozuldu!";
            System.out.println("🛡️ Failure Postcondition devrede: Bakiye korundu, log yazıldı.");
            throw e;
        }
    }

    void main() {
        var acc = new Account("ACC-1", 500.0);
        try {
            transferMoney(acc, new Account("ACC-2", 0), 1000.0);
        } catch (Exception _) {
            System.out.println("İşlem beklendiği gibi güvenle iptal edildi.");
        }
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
      Başarısızlık sonkoşullarına 'Hata mesajı gösterilir' YAZMAYIN! Hata mesajı bir sonkoşul değil, alternatif akışın bir adımıdır. Sonkoşul sistemin kalıcı durumunu anlatır: 'Hiçbir veri kaydedilmedi ve hesap durumu değişmedi.'
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not write 'Error message is displayed' as a failure postcondition. Error notifications are transient UI steps within an alternative flow. A failure postcondition defines persistent state invariants: 'No partial loan was created and inventory remains unchanged.']
    ]
  )
]

#takeaways_box((
    ("Başarı sonkoşulları hedefe ulaşıldığında dünyanın yeni kalıcı durumunu belirtir.", "Success postconditions define the persistent state of the world when the goal is achieved."),
    ("Başarısızlık sonkoşulları hata anında verilen asgari garantidir (Örn: Kısmi veri yazılmaz).", "Failure postconditions define minimal guarantees (e.g. no partial state is stored)."),
    ("Her iki sonkoşul bölümü de zorunludur; otomatik testlerin assert blokları buradan beslenir.", "Both postcondition sections are mandatory; they directly seed the assertion blocks of tests."),
))
