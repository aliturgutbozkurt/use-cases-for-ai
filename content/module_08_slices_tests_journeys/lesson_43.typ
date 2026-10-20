#import "/template.typ": *

#show: doc => setup_book(title: "Ders 43: 10. İlke: Sistemi Dilimlerle İnşa Etmek (Use-Case Slices)", doc)

#lesson_header(
  43,
  "10. İlke: Sistemi Dilimlerle İnşa Etmek (Use-Case Slices)",
  "Principle 10: Slices — Slicing the System into Deliverable Units",
  "Dilimler (Slices), Testler ve İterasyon Döngüsü",
  "Slices, Tests, and the Iteration Loop"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 USE-CASE 3.0 İLKE 10: DİLİMLER (SLICES) MİMARİSİ             │
└─────────────────────────────────────────────────────────────────────────────┘
  
  BÜTÜN USE CASE (Sprint İçin Çok Büyük & Düzensiz):
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ UC-002: Borrow Book                                                     │
  │ [Temel Akış] + [A1: Kopya Yok] + [A2: Limit Dolu] + [A3: Borç Var] +... │
  └─────────────────────────────────────────────────────────────────────────┘
                                   │
               ✂️ DİLİMLEME (USE-CASE SLICING)
                                   ▼
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ DİLİM 1 (Slice 1 - En Küçük Değer):                                     │
  │ -> Sadece TEMEL AKIŞ (Main Success Scenario) + İlgili Testler!          │
  │ -> UI + Domain + Veritabanı baştan sona dikey olarak çalışır!          │
  ├─────────────────────────────────────────────────────────────────────────┤
  │ DİLİM 2 (Slice 2 - İlk Alternatif):                                     │
  │ -> Sadece [A1: Kopya Yok] Akışı + Rezervasyon Handoff'u + Testler       │
  ├─────────────────────────────────────────────────────────────────────────┤
  │ DİLİM 3 (Slice 3 - Güvenlik & Limit):                                   │
  │ -> [A2: Limit Dolu] + [A3: Borç Var] Akışları + Testler                 │
  └─────────────────────────────────────────────────────────────────────────┘
  🎯 SONUÇ: Dilim (Slice), backlog'a giren gerçek teslimat birimidir!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Kocaman bir doğum günü pastasını bir lokmada ağzınıza atamazsınız, boğulursunuz! Pastayı dilim dilim kesersiniz. İlk dilim sadece kekin ve kremanın tadını verir (Temel akış). Sonraki dilimlerde çilekler ve çikolatalar gelir (Alternatif akışlar). İşte use case pastanın tamamıdır, sprint'e giren şey ise o tek bir lezzetli dilimdir (Slice)!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[You cannot swallow an entire multi-layered birthday cake in one bite; you'd choke! You slice it cleanly. Slice 1 gives you the foundational sponge cake and frosting (Basic Flow). Subsequent slices bring strawberries and chocolate chips (Alternative Flows). The use case is the whole cake; the actionable backlog ticket for your sprint is the vertical slice!]
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
      Use-Case 3.0'ın 10. İlkesi (Build the System in Slices): Ivar Jacobson ve Ian Spence'in klasik use case metodolojisine kattığı en devrimci ilke budur. Bir use case, bir hedefe ulaşmanın TÜM yollarını (başarı, istisnalar, hatalar) içerdiği için tek bir sprint veya tek bir PR için fazla büyüktür ve dengesiz boyutlardadır. Teslimat birimi use case değil, 'Use-Case Slice'dır. Bir dilim; use case içindeki bir veya birkaç yolu, o yolları icra eden tasarımı, kodu ve testleri içeren dikey, bağımsız ve test edilebilir bir pakettir. Bu sayede use case'ler Scrum sprint backlog'larına, Kanban sütunlarına ve SAFe trenlerine mükemmel uyum sağlar. AI Unified Process'te bir şartnamenin Status alanı bu dilimleme yaşam döngüsünü yönetir: Temel akış kodlanıp testten geçtiğinde use case 'Implemented/Tested' aşamasına geçer; kalan alternatif akışlar şartnamede beklerken sistem güvenle çalışır durumda kalır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Principle 10: Building the System in Slices: Jacobson and Spence added the 10th principle to bridge classical use cases with agile delivery. Because a use case captures every permutation of achieving a goal, it is irregularly sized and too monolithic to flow smoothly through a sprint board. The fundamental unit of delivery is the use-case slice: one or more paths through a use case, accompanied by the design, production code, and automated tests that implement and verify them. Slices start at the trigger, conclude at the postconditions, and provide immediate, testable business value. Slices map directly to user stories or sprint backlog items. In the AI Unified Process, this additive structure allows teams to generate Slice 1 via `/implement UC-002`, review the running UI with stakeholders, and then progressively generate slices for alternative flows without architectural churn.]
    ]
  )
]

#java25_box[
```java
// Java 25: Birinci Dilim (Slice 1: Sadece Temel Akış) Uygulaması
package com.maang.aiup.slices;

import java.time.LocalDate;

public class UseCaseSliceOneDemo {
    // DİLİM 1: Sadece temel akış verileri ve başarısı (Alternatifler henüz yok!)
    public record BorrowSliceOneResult(String bookId, String memberId, LocalDate dueDate) {}

    public static class BorrowBookSliceOneService {
        public BorrowSliceOneResult executeBasicFlow(String bookId, String memberId) {
            // Dilim 1 kapsamında sadece mutlu yol çalışır:
            LocalDate dueDate = LocalDate.now().plusDays(28);
            System.out.println("📦 Slice 1 Başarılı: Kitap (" + bookId + ") üyeye (" + memberId + ") verildi.");
            return new BorrowSliceOneResult(bookId, memberId, dueDate);
        }
    }

    void main() {
        var sliceOne = new BorrowBookSliceOneService();
        var result = sliceOne.executeBasicFlow("BK-42", "MEM-007");
        System.out.println("✅ Dilim 1 Dikey Olarak Çalıştı: " + result);
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
      Bir use case'in tüm akışlarını (happy path + 8 alternatif akış) tek bir seferde AI'a kodlatmaya çalışmayın! Temel akışı ilk dilim olarak üretip paydaşa gösterin, geri bildirim alın, sonra diğer akışları ekleyin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Resist the urge to generate an entire use case (happy path + 8 branches) in a single massive prompt. Implement Slice 1 first, get visual feedback, then add alternative branches incrementally.]
    ]
  )
]

#takeaways_box((
    ("Teslimatın temel birimi use case değil, dikey ve test edilebilir 'use-case slice'dır.", "The unit of delivery is the use-case slice, not the entire use case document."),
    ("Dilim 1 daima temel akıştır (happy path); en hızlı iş değerini ve geri bildirimi o sağlar.", "Slice 1 is always the basic flow, delivering immediate feedback and functional baseline."),
    ("Dilimleme sayesinde use case'ler Scrum, Kanban ve CI/CD akışlarına pürüzsüz entegre olur.", "Slicing enables seamless integration of formal use cases into Scrum, Kanban, and modern CI/CD."),
))
