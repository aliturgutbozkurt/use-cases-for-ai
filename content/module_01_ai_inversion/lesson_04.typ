#import "/template.typ": *

#show: doc => setup_book(title: "Ders 4: Use Case'in 40 Yıllık Evrimi: Ericsson (1987), Cockburn (2001) ve Use-Case 3.0 (2024)", doc)

#lesson_header(
  4,
  "Use Case'in 40 Yıllık Evrimi: Ericsson (1987), Cockburn (2001) ve Use-Case 3.0 (2024)",
  "The Evolution of Use Cases: From Ericsson (1987) to Cockburn (2001) to Use-Case 3.0",
  "Büyük Tersine Dönüş (The Inversion) & AI Çağında Use Case Rönesansı",
  "The AI Inversion & Why Use Cases Rule the GenAI Era"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                    USE CASE'İN 40 YILLIK BÜYÜK YOLCULUĞU                    │
└─────────────────────────────────────────────────────────────────────────────┘
  1987: Ivar Jacobson (Ericsson)
  └──▶ OOPSLA bildirisi: Telefon santralleri için kullanıcı odaklı senaryolar.
       "Sistem ne yapar?" sorusunun ilk yapısal cevabı.

  2001: Alistair Cockburn ("Writing Effective Use Cases")
  └──▶ Yazma sanatı: Hedef Seviyeleri (Deniz/Bulut/Balık), Paydaş Çıkarları,
       Ana Akış ve Alternatif Akış disiplini.

  2000-2020: Çevik Yozlaşma (User Stories İstismarı)
  └──▶ Post-it çılgınlığı! Parçalanmış, bağlamsız, uç durumları unutan yapışkan kağıtlar.

  2024: Jacobson & Cockburn ("Use-Case 3.0")
  └──▶ Dilimleme (Slices), Çevik ve Hafif Entegrasyon: "Use Cases are Essential!"

  2026+: AI Unified Process & Simon Martinelli
  └──▶ Ajanlar için yeniden doğuş: AI'ın anlayabileceği tek tam davranışsal kontrat!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      1980'lerde icat edilen çekiç ve tekerlek gibi bazı aletler o kadar mükemmeldir ki teknoloji ne kadar değişirse değişsin eskimez. 1987'de telefon santralleri için icat edilen 'Use Case', 2000'lerde 'Biz artık çeviğiz, post-it yapıştırıyoruz' denilerek çöpe atılmak istendi. Ama yapay zekâ gelince görüldü ki, mini minnacık post-it notlarıyla koca sistemleri AI'a anlatamazsın! 40 yıllık Use Case, yapay zekanın en iyi anlayabildiği süper modern bir mimari haritaya dönüştü!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Fundamental inventions like the wheel or the hammer never become obsolete. Invented in 1987 by Ivar Jacobson at Ericsson and formalized by Alistair Cockburn in 2001, use cases were temporarily sidelined by agile teams wielding single-sentence sticky notes. But generative AI cannot build complex systems from disconnected sticky notes. Today, Use-Case 3.0 and the AI Unified Process have restored use cases as the premier behavioral contract for autonomous agents.]
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
      Use Case'in tarihsel kırılma noktaları: 1) 1987 Jacobson OOPSLA: Nesne yönelimli programlamanın (OOP) içine 'davranışsal hikaye' kavramını soktu; Rational Unified Process'in (RUP) üç temel direğinden biri oldu (Use-Case Driven). 2) 2001 Cockburn: Şablon çılgınlığını sadeleştirdi; Deniz Seviyesi (Sea Level) hedefleri ve başarısızlık durumlarını garanti altına alan sözleşme (contract) modelini oturttu. 3) 2023-2024 ACM Queue & Use-Case 3.0: Jacobson ve Cockburn 'Use Cases are Essential' makalesiyle kullanım senaryolarının çevik dilimlerle (slices) Scrum ve Kanban'a entegre olabileceğini kanıtladı. 4) 2026 AIUP: Martinelli, üçüncü okuyucunun (AI Ajanı) gelişiyle use case'in kod ve test üreten birincil generatif varlık olduğunu ilan etti.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[The 40-year architectural lineage: 1) 1987 Jacobson (Ericsson): Introduced use cases at OOPSLA to model telecommunication switching flows, establishing the core axiom: software must be driven by user goals. 2) 2001 Cockburn: Standardized the craft in 'Writing Effective Use Cases', defining goal altitude tiers (Cloud, Sea, Fish), stakeholder guarantees, and the 3-kind step hierarchy. 3) 2024 Use-Case 3.0: Reconciled use cases with lightweight agile delivery via 'use-case slices'—modular delivery units threading through the basic flow into edge paths. 4) 2026 AIUP (Martinelli): Positioned use cases as the central generative hub connecting system vision to autonomous AI coding agents.]
    ]
  )
]

#java25_box[
```java
// Java 25: Use-Case 3.0 Dilimleme (Slice) Mantığının Kodda Karşılığı
package com.maang.aiup.slices;

public class BookBorrowingSlice {
    // Dilim 1 (Slice 1): Sadece Temel Başarı Senaryosu (Happy Path)
    public record BorrowBasicSlice(String memberId, String bookIsbn) {
        public void execute() {
            System.out.println("Slice 1 Çalıştı: Kitap ödünç verildi, teslim tarihi 28 gün sonrası.");
        }
    }

    // Dilim 2 (Slice 2): Alternatif Akış Eklenmiş Gelişmiş Dilim
    public record BorrowWithLimitCheckSlice(String memberId, String bookIsbn, int activeLoanCount) {
        public boolean execute() {
            if (activeLoanCount >= 5) {
                System.out.println("Slice 2 (A2 Flow): Limit aşıldı! Ödünç engellendi.");
                return false;
            }
            System.out.println("Slice 2: Kontrol başarılı, kitap verildi.");
            return true;
        }
    }

    void main() {
        new BorrowBasicSlice("M101", "ISBN-9988").execute();
        new BorrowWithLimitCheckSlice("M101", "ISBN-9988", 5).execute();
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
      Geçmişte RUP döneminde yazılan 100 sayfalık bürokratik use case dökümanlarıyla modern Use-Case 3.0'ı karıştırmayın! Modern use case hafiftir, 3-9 adımlı senaryolardan oluşur ve doğrudan dilimler (slices) halinde kodlanır.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not conflate modern AIUP use cases with 1990s RUP bureaucratic monoliths. Modern use cases are lean, bounded to 3-9 steps, sliced iteratively, and engineered for direct machine parsing.]
    ]
  )
]

#takeaways_box((
    ("Use case 1987'de doğmuş, 2001'de Cockburn ile olgunlaşmış ve 2024'te Use-Case 3.0 ile çevikleşmiştir.", "Use cases originated in 1987, matured via Cockburn in 2001, and became agile in 2024."),
    ("Kullanıcı hikayeleri konuşma başlatır; Use Case ise varılan kararların ve kuralların yaşadığı yerdir.", "User stories initiate conversations; use cases store the architectural decisions."),
    ("AI çağında use case, kodlama ajanlarına niyet aktarabilen tek eksiksiz davranış formatıdır.", "In the AI era, use cases are the only established format that conveys complete behavioral context."),
))
