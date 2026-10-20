#import "/template.typ": *

#show: doc => setup_book(title: "Ders 12: AI-Çağı İlkesi 15: Önce Şartname Değişir (Sessiz Hotfix Kültürüne Son!)", doc)

#lesson_header(
  12,
  "AI-Çağı İlkesi 15: Önce Şartname Değişir (Sessiz Hotfix Kültürüne Son!)",
  "AI-Era Principle 15: Change the Specification First (Killing the Silent Hotfix)",
  "Üç Okuyucu Modeli & Yapay Zekâ Çağının 5 Temel İlkesi",
  "The Three Readers & The 5 AI-Era Principles"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 İLKE 15: ÖNCE ŞARTNAME DEĞİŞİR (NO SIDE CHANNELS)           │
└─────────────────────────────────────────────────────────────────────────────┘
  YASAK VE ÖLÜMCÜL YOL (Sessiz Hotfix):
  Canlıda Bug Çıktı ──▶ Geliştirici Kodu Elle Düzeltti ──▶ "Şartnameye sonra bakarız"
                                                                   │
  Sonraki AI Kod Üretiminde (Regeneration) Hotfix SİLİNİR! ◀───────┘ (Büyük Prod Felaketi!)

  AI UNIFIED PROCESS YOLU:
  Canlıda Bug Çıktı ──▶ 1. Şartnameyi Düzelt (UC-002) ──▶ 2. Testi Güncelle
                                                                   │
  4. Canlıya Çık! ◀── 3. /implement ile Kodu Yeniden Üret ◀────────┘ (Sıfır Sapma!)
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir geminin rotasını değiştirmek istediğinde dümencinin eline gizlice vurup dümeni çevirmezsin. Önce kaptan köşküne gider haritayı güncellersin! Eğer haritayı güncellemeden dümene asılırsan, bir sonraki vardiyada gelen yeni dümenci (AI) haritaya bakar ve gemiyi tekrar eski rotaya kırıp kayalıklara çarpar! Hata çıksa da yeni özellik gelse de önce harita (şartname) değişir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[You don't alter a ship's heading by sneaking into the wheelhouse and wrestling the steering wheel away from the helmsman. You update the navigational nautical chart. If you yank the wheel without recording the new course on the chart, the next watchman (the AI generator) inspects the chart, swings the rudder back, and rams the vessel into an iceberg. The map changes first, always.]
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
      İlke 15: Önce şartnameyi değiştir (Change the specification first). Yeni bir özellik (feature), bir değişiklik talebi (change request) ve bir hata (bug)... AI Unified Process'te bu üç kavramın hepsi TEK VE AYNI ŞEYDİR: 'Bir use case'e yapılan değişiklik.' Sistemde /bug veya /hotfix adında özel bir komut yoktur! Hata çıktığında süreç şöyledir: 1) Hatanın niyetini sınıflandır (Kod mu saptı yoksa şartname mi yanlıştı?). 2) Şartnameyi güncelle. 3) /implement komutunu yeniden çalıştır. AI mevcut sınıfları bulur ve şartnamedeki değişikliğe göre yerinde günceller (in-place reconciliation). Eğer acil durum bahanesiyle kodu doğrudan IDE'den düzeltip şartnameyi güncellemezseniz, şartnamenin 'gerçeklik kaynağı' olma vasfı anında ölür. Bir sonraki sprint'te birisi `/implement` çalıştırdığında elle yazdığınız o hotfix tamamen silinir!
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Principle 15 Operational Discipline: 'Change the specification first.' A new feature, a change request, and a production bug report are fundamentally identical abstractions: a delta applied to a use case specification. The AI Unified Process provides no special `/hotfix` or `/patch` command. The protocol is singular: 1) Classify intent (did code diverge from spec, or was the spec flawed?). 2) Update the use case markdown file. 3) Re-invoke `/implement`. The generative engine reconciles existing classes in-place against the updated specification. Bypassing this loop under production pressure instantly corrupts the artifact chain. The next automated regeneration cycle will treat your undocumented hotfix as dead code and purge it.]
    ]
  )
]

#java25_box[
```java
// Java 25: Şartname Değişikliğinin Koddaki Yansıması (Regeneration Friendly)
package com.maang.aiup.principles;

public class LoanInterestCalculation {
    // ESKİ KURAL BR-012: Faiz oranı sabit %5.0 idi.
    // YENİ KURAL BR-012 (Değişiklik Şartnamede Yapıldı): VIP üyeler için faiz %3.5, diğerleri %5.0.
    
    public record Customer(String id, boolean isVip) {}

    public static double calculateInterestRate(Customer customer) {
        // Şartnamedeki BR-012 güncellemesinden sonra AI tarafından üretilen yeni kod:
        if (customer.isVip()) {
            return 3.5; // BR-012 (Revize edilmiş şartname kuralı)
        }
        return 5.0;     // BR-012 Standart kural
    }

    void main() {
        var vip = new Customer("VIP-1", true);
        var standard = new Customer("STD-2", false);

        System.out.println("VIP Faiz: %" + calculateInterestRate(vip));
        System.out.println("Standart Faiz: %" + calculateInterestRate(standard));
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
      Geliştiricilerin 'Hata çok acil, prod yanıyor, önce kodu pushlayalım şartnameyi pazartesi yazarız' tuzağına ASLA düşmeyin. O pazartesi hiçbir zaman gelmez. Şartnameyi değiştirmek 30 saniye, /implement çalıştırmak 10 saniyedir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Beware the fatal team rationalization: 'Production is down, let us hot-patch the code now and backfill the markdown spec on Monday.' That Monday never arrives. Updating the spec takes 30 seconds; letting it rot costs weeks of technical bankruptcy.]
    ]
  )
]

#takeaways_box((
    ("Yeni özellik, değişiklik ve bug: Hepsi aslında use case şartnamesine yapılan bir değişikliktir.", "Features, change requests, and bugs are all the exact same thing: a delta to a use case."),
    ("Kodu şartnameden geçirmeden doğrudan düzeltmek yasaktır; yan kanallar şartnameyi çürütür.", "Bypassing the specification via direct code hotfixes triggers immediate specification rot."),
    ("Şartname güncellendiğinde aynı /implement ve test komutları çalışarak kodu yerinde senkronize eder.", "When the spec changes, running the same commands reconciles existing code in place cleanly."),
))
