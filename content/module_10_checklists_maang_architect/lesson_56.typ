#import "/template.typ": *

#show: doc => setup_book(title: "Ders 56: En Yaygın 10 Hata: 5 Klasik Tuzak vs 5 AI Çağı Felaketi", doc)

#lesson_header(
  56,
  "En Yaygın 10 Hata: 5 Klasik Tuzak vs 5 AI Çağı Felaketi",
  "The Ten Common Mistakes: 5 Classical Pitfalls vs 5 AI-Era Disasters",
  "Kontrol Listeleri, Yaygın Hatalar ve MAANG Mimar Seviyesi Ustalık",
  "Checklists, Common Mistakes & MAANG Architect Mastery"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 EN YAYGIN 10 USE CASE HATASI VE TEDAVİSİ                    │
└─────────────────────────────────────────────────────────────────────────────┘
  
  🏛️ 5 KLASİK TUZAK (2001'den Beri Değişmeyenler):
  1. Sistem Yok (No System): Sadece kullanıcı hareket eder, sistem hiçbir şey yapmaz!
  2. Aktör Yok (No Actor): Sistemin içinden yazılmıştır; ekranda kullanıcı kaybolur!
  3. UI Turu (UI Walkthrough): 6 adım boyunca tıklandı/yazıldı sayılır (En yaygın hata!).
  4. Su Altı Seviye (Underwater Goal): 'ISBN Doğrula' gibi atomik işler use case sanılır!
  5. Amaç-İçerik Uyuşmazlığı: 'Giriş Yap' içinde tüm sistemi tarif etmeye kalkmak!
  
  🤖 5 AI ÇAĞI FELAKETİ (2026'nın Yeni Tehlikeleri):
  6. Mekanizma Sızıntısı (Mechanism Leak): JWT, SQL, regex yazıp kodu kitlemek!
  7. Gerçeğin Tekrarı (Restated Truth): Entity alanlarını şartnameye kopyalamak!
  8. Açık Uçlu Akış (The Open Flow): Bitiş cümlesi olmayan sahipsiz alternatif dallar!
  9. Açık Çek (The Blank Check): 'Uygun şekilde', 'ilgili veriler' gibi boş kelimeler!
  10. Sonradan Yazılan Şartname (Backfilled Spec): Kodu yazıp şartnameyi sonra yamamak!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir pastacı düşünün: 5 tane klasik hata vardır (Fırını açmayı unutmak, unu döküp şekeri unutmak, yumurtayı kabuğuyla kırmak gibi). Bir de yeni nesil akıllı elektrikli fırınların getirdiği 5 hata vardır (Fırının wifi şifresini kek harcına karıştırmak, derece yerine fırının kodunu değiştirmek gibi). İşte bu 10 hata hem 20 yıldır yapılan hem de AI ile yeni başlayan en tehlikeli 10 tuzaktır!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of baking: There are 5 classical amateur blunders (forgetting to preheat, dumping uncracked eggs, confusing salt with sugar). And there are 5 brand-new modern digital hazards (spilling liquid on the microchip panel, overriding the firmware safety valve). The 10 common mistakes split evenly between eternal human blunders and fatal AI-era traps!]
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
      10 Yaygın Hatanın Analizi ve Önleme Stratejileri: Martinelli'nin use case analizinde hatalar iki eşit kampa ayrılır: 1) Klasik Hatalar: Cockburn'ün 2001'de uyardığı tuzaklar bugün de devam etmektedir. 'Sistem Yok' hatasında kullanıcı her şeyi yapar ama sistem tepki vermez, sonuçta AI eylemsiz bir UI üretir. 'UI Walkthrough' hatasında 6 adımda form doldurma anlatılır, oysa 'Kullanıcı üye bilgilerini girer' denmelidir. 'Su Altı Hedef' hatasında tek bir buton kontrolü use case yapılır. 2) AI Çağı Hataları: 'Mekanizma Sızıntısı' (Zone 3 ihlali), şartnamenin teknoloji göçlerinde çöp olmasına yol açar. 'Gerçeğin Tekrarı' (Restated Truth), entity\_model.md ile use case arasında çelişki yaratır ve AI sessizce uydurma yapar. 'Açık Uçlu Akış' (Open Flow), sonu belirtilmemiş bir alternatif daldır; insan bunu görmezden gelir ama AI kafasından bir bitiş uydurarak müşteriyi yanlış bir ekrana fırlatır. 'Açık Çek' (Blank Check), 'uygun şekilde işler' diyerek kararı AI'a bırakmaktır. 'Sonradan Yazılan Şartname' (Backfilled Spec) ise şartname tabanlı yazılımı tamamen öldüren en ölümcül günahtır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Analysis of the Ten Common Mistakes: Martinelli categorizes specification failures into five classical human biases and five novel AI-era failure modes: 1) Classical Pitfalls: 'No System' leaves out automated responses, yielding inert UI forms; 'No Actor' specifies internal batch routines, discarding presentation layers; 'UI Walkthrough' recites keystrokes rather than intent; 'Underwater Goals' elevate atomic validation routines to full use cases; 'Purpose-Content Mismatch' overloads auxiliary flows. 2) AI-Era Disasters: 'Mechanism Leakage' bakes ephemeral protocol jargon (JWT, bcrypt, SQL) into living assets; 'Restated Truth' creates duplicate schemas that drift and cause silent LLM reconciliation bugs; 'The Open Flow' omits explicit terminations, causing AI to hallucinate arbitrary navigation jumps; 'The Blank Check' uses lazy vocabulary ('handles appropriately', 'etc.') delegating core business decisions; 'Backfilled Specs' updates documentation retroactively, destroying spec-first authority.]
    ]
  )
]

#java25_box[
```java
// Java 25: 10 Yaygın Hatanın Önlenmesi (Açık Çek ve Açık Uçlu Akış Tedavisi)
package com.maang.aiup.mistakes;

public class CommonMistakesRemedyDemo {
    // ❌ HATA 8: Açık Uçlu Akış (Ne olacağı belirsiz):
    // if (!valid) return; // Ne döndü? Log mu attı? Ekrana ne dedi?

    // ✅ TEDAVİ: Kesin Bitiş ve Minimum Garanti (Failure Postcondition)
    public sealed interface FlowResult permits FlowResult.Success, FlowResult.Halted {
        record Success(String orderId) implements FlowResult {}
        record Halted(String errorCode, String userMessage) implements FlowResult {}
    }

    public static class SafeOrderHandler {
        public static FlowResult execute(int stock) {
            if (stock <= 0) {
                // Alternatif Akış A1: Açık uçlu değil! Kesin bitiş ve mesaj var:
                return new FlowResult.Halted("ERR-01", "A1: Stok tükenmiştir. Use case sonlanır.");
            }
            return new FlowResult.Success("ORD-999");
        }
    }

    void main() {
        var result = SafeOrderHandler.execute(0);
        switch (result) {
            case FlowResult.Success s -> System.out.println("Başarı: " + s.orderId());
            case FlowResult.Halted h -> System.out.println("✅ Hata 8 ve 9 Önlendi: " + h.userMessage());
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
      Şartnamenizde 'vb.', 've benzeri', 'uygun şekilde işler' kelimelerini gördüğünüz anda silin! Her biri AI'a kafasına göre uydurma yetkisi veren birer açık çektir.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Search your specification for 'etc.', 'and so on', or 'appropriately'. Erase them immediately. Every vague qualifier delegates architectural control to LLM randomness.]
    ]
  )
]

#takeaways_box((
    ("5 klasik hata (UI walkthrough, su altı hedefi) 20 yıldır şartnamelerin en büyük derdidir.", "5 classical blunders (UI walkthrough, underwater goals) remain persistent pitfalls."),
    ("5 AI çağı hatası (mekanizma sızıntısı, açık uçlu akış, açık çek) üretimi doğrudan zehirler.", "5 AI-era disasters (mechanism leaks, open flows, blank checks) directly corrupt code generation."),
    ("Sonradan şartname yazmak (backfilling) şartname tabanlı kalkınmanın ölüm fermanıdır.", "Backfilling specifications after coding completely destroys spec-driven development."),
))
