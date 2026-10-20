#import "/template.typ": *

#show: doc => setup_book(title: "Ders 37: Hassasiyet Paradoksu: Gözlemlenebilir Davranış vs Mekanizma Detayı", doc)

#lesson_header(
  37,
  "Hassasiyet Paradoksu: Gözlemlenebilir Davranış vs Mekanizma Detayı",
  "The Precision Paradox: Observable Behavior vs Mechanism Detail",
  "Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?",
  "Precision for AI — What to Say and What to Leave Out"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
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
   Sistemin bunu arkada nasıl başardığı hakkında HİÇBİR ŞEY yazmayın!" 
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir restorana gidip şefe sipariş verdiğinizi düşünün: Şefe 'Bana orta pişmiş antrikot, yanında kuşkonmaz ve patates püresi ile saat 20:00'de gelsin' dersiniz (Gözlemlenebilir istek!). Ama şefe 'Fırını 230 dereceye ayarla, tavayı 3 dakika ısıt, tuzu sol elle at' derseniz şef sizi mutfaktan kovar (Mekanizma detayı!). İşte use case şefe ne istediğinizi söyler, mutfak aletlerinin kullanımını şefe bırakır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Imagine ordering at a fine restaurant: You tell the chef 'Bring me medium-rare ribeye steak with grilled asparagus and mashed potatoes at 8:00 PM' (Observable requirement!). But if you instruct the chef: 'Set the stove to 230 degrees, preheat the pan for 3 minutes, and sprinkle salt with your left hand', the chef kicks you out (Mechanism detail!). The use case defines what lands on the table; it lets the kitchen execute the technique.]
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
      Hassasiyet Paradoksunun Çözümü: Klasik use case literatüründe Cockburn, detay yazmanın tehlikeleri konusunda onlarca sayfa uyarıda bulunmuştur. Detay belgeyi kırılganlaştırır, bakım maliyetini artırır ve yetenekli geliştiricilerin yaratıcılığını çalar. Ancak günümüz AI destekli dünyasında Martinelli, 'Kitap listesini gösterir' gibi gevşek adımların AI tarafından tamamen rastgele kolonlarla üretilmesine sebep olduğunu gösterir. Çözüm, detayı tek bir eksen değil, iki zıt eksen olarak görmektir: 1) Gözlemlenebilir Detay (Observable Detail): Kullanıcının ekranda gördüğü veri, sıralama ölçütü, iş mantığı sınırları (28 gün, 5 kitap). Bu detay eksik bırakılırsa AI boşluğu kendi tahminleriyle doldurur ve sistem mimarisi çöker. 2) Mekanizma Detayı (Mechanism Detail): HTTP fiilleri, SQL transaction izolasyon seviyeleri, hash algoritmaları, regex desenleri. Bu detay yazılırsa şartname koda bağımlı hale gelir ve yeniden üretilebilirlik (regenerability) yok olur.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Resolving the Precision Paradox: Cockburn warned extensively against over-specification because detail in traditional engineering is expensive to maintain, fragile against refactoring, and strips decisions from experienced developers. However, generative AI inverts this dynamic: an under-specified step like 'System displays books' forces the LLM to invent arbitrary table columns, sorting heuristics, and layout fields. Martinelli resolves this tension via a single axiom: 'Specify everything a stakeholder could observe and a test could verify. Specify nothing about how the system achieves it.' Detail is not one-dimensional; it splits into observable outcomes (required) versus underlying mechanisms (strictly banned).]
    ]
  )
]

#java25_box[
```java
// Java 25: Gözlemlenebilir İş Sonucunun Mekanizmadan Ayrılması
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
      'Sistem kullanıcıyı uygun şekilde bilgilendirir' veya 'verileri gösterir' gibi yuvarlak ifadeler kullanmayın. Bu kelimeler AI'a kafasına göre uydurma yetkisi (blank check) verir!
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never use vague escape phrases like 'System notifies user appropriately' or 'System shows relevant data'. Every ambiguous word delegates architecture decisions to AI halluncinations.]
    ]
  )
]

#takeaways_box((
    ("Paydaşın görebileceği ve testin doğrulayabileceği her şeyi somut olarak yazın.", "Specify everything a stakeholder can observe and an acceptance test can verify."),
    ("Sistemin bunu nasıl yaptığı (SQL, JWT, regex) use case şartnamesine asla yazılamaz.", "Never specify implementation mechanisms (SQL, JWT, regex) in use case specifications."),
    ("Eksik gözlemlenebilir detay, AI'ın kafasına göre kod uydurmasına davetiye çıkarır.", "Omitted observable details force the AI to invent business behavior arbitrarily."),
))
