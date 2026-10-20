#import "/template.typ": *

#show: doc => setup_book(
  title: "Aptala Anlatır Gibi AI Çağında Use Case El Kitabı",
  author: "Antigravity & AI Unified Process Architecture Guild",
  doc
)

#book_front_cover()

#pagebreak()
#v(20pt)
#align(center)[
  #text(size: 20pt, weight: "bold", fill: rgb("081c24"))[Önsöz ve Başlarken / Preface & Getting Started]
]
#v(16pt)

#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [
    == 🇹🇷 Bu Eğitim Hakkında
    Bu kitap; Simon Martinelli'nin *"Writing Use Cases for AI: How to write use cases for stakeholders, engineers, and AI agents"* kitabındaki devrim niteliğindeki ilkeler (AI Unified Process / Spec-Driven Development) ve MAANG seviyesi sistem mimarisi mühendisliği temel alınarak hazırlanmıştır.

    Üretken yapay zekâ yazılım dünyasının ekonomisini tersine çevirdi (The Inversion): Artık kod yazmak ucuz, hızlı ve anında tekrarlanabilir hale geldi. Asıl kıt ve paha biçilemez olan şey *ifade edilmiş niyettir (expressed intent)*. Bir use case şartnamesi yalnızca insan paydaşın doğrulayacağı veya yazılımcının kodlayacağı bir belge değildir; yapay zekâ ajanının doğrudan çalışan kod ve testler ürettiği yaşayan bir *Sözleşmedir (Contract)*.

    60 derslik bu kapsamlı müfredatta; Ivar Jacobson ve Alistair Cockburn'ün 40 yıllık klasik temellerinden 2026'nın AIUP ilkelerine (Üç Okuyucu, 3 Bölge, Kara Liste, Dilimleme ve Taban Çizgisi Kurtarma) uzanan yolculuk, *bir aptala anlatır gibi* analojiler, zengin ASCII süreç şemaları ve modern *Java 25 LTS* mimarisiyle sunulmaktadır.
  ],
  [
    == 🇬🇧 About This Masterclass
    This masterclass is founded upon Simon Martinelli's seminal work *"Writing Use Cases for AI: How to write use cases for stakeholders, engineers, and AI agents"* within the AI Unified Process (AIUP) and Spec-Driven Development paradigm.

    Generative AI has inverted software economics: implementation is now cheap, fast, and repeatable. The scarce resource is precisely expressed intent. In this new era, a use case serves three distinct readers: the stakeholder who validates it, the software engineer who reviews it, and the tireless, literal AI agent that implements code directly from it.

    Across 60 structured lessons organized into 10 modules, we demystify the complete specification discipline—from sea-level goals and the 24-point audit checklist to the Zone 3 blocklist (banning SQL, JWT, regex in specs) and brownfield recovery—using intuitive Explain-Like-I'm-5 (ELI5) metaphors, architectural ASCII schematics, and clean Java 25 LTS reference implementations.
  ]
)

#v(20pt)
#line(length: 100%, stroke: 0.8pt + rgb("cbd5e1"))
#v(10pt)

#outline(
  title: [İçindekiler / Table of Contents],
  depth: 2,
  indent: auto
)

#pagebreak()

#module_cover(
  1,
  "Büyük Tersine Dönüş (The Inversion) & AI Çağında Use Case Rönesansı",
  "The AI Inversion & Why Use Cases Rule the GenAI Era",
  "Yazılım mühendisliği tarihinin en büyük ekonomik kırılması: Kodlama ucuzladı, niyet (intent) paha biçilmez oldu. Vibe coding'in çöküşü, determinizm yanılgısı, 1987'den günümüze Use Case evrimi ve Spec-Driven Development (SDD) paradigması.",
  "The greatest economic shift in software history: Implementation is cheap, intent is scarce. The failure of vibe coding, the determinism fallacy, the evolution of use cases from 1987 to 2026, and the Spec-Driven Development paradigm."
)

#include "/content/module_01_ai_inversion/lesson_01.typ"
#v(14pt)

#include "/content/module_01_ai_inversion/lesson_02.typ"
#v(14pt)

#include "/content/module_01_ai_inversion/lesson_03.typ"
#v(14pt)

#include "/content/module_01_ai_inversion/lesson_04.typ"
#v(14pt)

#include "/content/module_01_ai_inversion/lesson_05.typ"
#v(14pt)

#include "/content/module_01_ai_inversion/lesson_06.typ"
#v(14pt)


#module_cover(
  2,
  "Üç Okuyucu Modeli & Yapay Zekâ Çağının 5 Temel İlkesi",
  "The Three Readers & The 5 AI-Era Principles",
  "Use case'in üç farklı kitlesi: Paydaş (Stakeholder), Yazılım Mühendisi ve Yapay Zekâ Ajanı. AI'ın lafı harfi harfine anlaması ve boşluk bırakamaması. Use-Case 3.0'ın 10 ilkesine eklenen 5 yeni AI çağı ilkesi (İlke 11-15).",
  "The three readers of a use case: Stakeholder, Software Engineer, and AI Agent. How AI reads literally and cannot leave gaps unfilled. The five new principles for the AI era (Principles 11-15) extending Use-Case 3.0."
)

#include "/content/module_02_three_readers/lesson_07.typ"
#v(14pt)

#include "/content/module_02_three_readers/lesson_08.typ"
#v(14pt)

#include "/content/module_02_three_readers/lesson_09.typ"
#v(14pt)

#include "/content/module_02_three_readers/lesson_10.typ"
#v(14pt)

#include "/content/module_02_three_readers/lesson_11.typ"
#v(14pt)

#include "/content/module_02_three_readers/lesson_12.typ"
#v(14pt)


#module_cover(
  3,
  "Temel Esaslar: Aktörler, Deniz Seviyesi Hedefler & Paydaş Sözleşmeleri",
  "Core Fundamentals: Actors, Sea-Level Goals & Contracts",
  "Birincil ve ikincil aktörler, Alistair Cockburn'ün 3 adımlı adli testi (Etkileşim, Doğrulama, Durum Değişimi), Hedef İrtifaları (Bulut, Deniz Seviyesi, Balık), Kapsam sınırları ve In/Out listesi disiplini, 'Manage X' birleştir-sonra-böl kuralı ve kullanıcı dilinde isimlendirme.",
  "Primary and secondary actors, Cockburn's three-kind step test (Interaction, Validation, State Change), Goal Altitude tiers (Cloud, Sea Level, Fish), Scope boundaries via the In/Out list, the 'Manage X' aggregate-then-split rule, and naming in user-centric language."
)

#include "/content/module_03_actors_goals_scope/lesson_13.typ"
#v(14pt)

#include "/content/module_03_actors_goals_scope/lesson_14.typ"
#v(14pt)

#include "/content/module_03_actors_goals_scope/lesson_15.typ"
#v(14pt)

#include "/content/module_03_actors_goals_scope/lesson_16.typ"
#v(14pt)

#include "/content/module_03_actors_goals_scope/lesson_17.typ"
#v(14pt)

#include "/content/module_03_actors_goals_scope/lesson_18.typ"
#v(14pt)


#module_cover(
  4,
  "Eser Zinciri (Artifact Chain) & PlantUML Mimarisi",
  "The Artifact Chain & PlantUML Architecture",
  "AI Unified Process'in 6 halkalı eser zinciri: Vizyondan koda tasarım uzayının daraltılması, Göbek ve Parmaklıklar (Hub-and-Spokes) modeli, PlantUML kullanım senaryosu diyagramı, <<include>> ve <<extend>> tuzakları, mekanik arayüz olarak kararlı kimlikler (FR, UC, BR, TC) ve /spec-review otomatik denetim mimarisi.",
  "The 6-link AIUP artifact chain narrowing design space from vision to code, the Hub-and-Spokes architecture, PlantUML diagram as a table of contents, the truth about <<include>> and <<extend>>, identifiers as mechanical interfaces, and the two-pass /spec-review engine."
)

#include "/content/module_04_artifact_chain/lesson_19.typ"
#v(14pt)

#include "/content/module_04_artifact_chain/lesson_20.typ"
#v(14pt)

#include "/content/module_04_artifact_chain/lesson_21.typ"
#v(14pt)

#include "/content/module_04_artifact_chain/lesson_22.typ"
#v(14pt)

#include "/content/module_04_artifact_chain/lesson_23.typ"
#v(14pt)

#include "/content/module_04_artifact_chain/lesson_24.typ"
#v(14pt)


#module_cover(
  5,
  "Ana Şartname Şablonu & Alan Alan Derinlemesine İnceleme",
  "The Master Specification Template & Field Breakdown",
  "AI Unified Process use case şablonunun anatomisi: Genel Bakış (Overview), Önkoşullar ile Tetikleyicilerin ayrımı, 3-9 adımlı Ana Başarı Senaryosu, Başarı ve Başarısızlık Sonkoşulları (Postconditions / Guarantees), İş Kuralları (BR-XXX) ve örnek 'Borrow Book' master şartnamesinin adli analizi.",
  "Anatomy of the AIUP specification template: Overview metadata, the strict boundary between Preconditions and Triggers, the 3-to-9 step Main Success Scenario, transactional Postconditions (Success vs Failure guarantees), Business Rules (BR-XXX), and forensic deconstruction of the canonical 'Borrow Book' spec."
)

#include "/content/module_05_spec_template/lesson_25.typ"
#v(14pt)

#include "/content/module_05_spec_template/lesson_26.typ"
#v(14pt)

#include "/content/module_05_spec_template/lesson_27.typ"
#v(14pt)

#include "/content/module_05_spec_template/lesson_28.typ"
#v(14pt)

#include "/content/module_05_spec_template/lesson_29.typ"
#v(14pt)

#include "/content/module_05_spec_template/lesson_30.typ"
#v(14pt)


#module_cover(
  6,
  "Senaryolar ve Alternatif Akışlar Yazma Sanatı",
  "Writing Scenarios and Alternative Flows",
  "Bir senaryo adımının anatomisi: Özne-Yüklem-Nesne, topun kimde olduğu kuralı, 'validates' vs 'checks whether' tercihi, Cockburn'ün 3 turlu alternatif akış beyin fırtınası, numaralı adıma bağlanan tetikleyiciler, açık uçlu akış yasağı ve kapalı döngü (closed-loop) ritmi.",
  "The anatomy of a step: Subject-Verb-Object, who has the ball, 'validates' vs 'checks whether', Cockburn's 3-pass alternative flow brainstorming, anchored triggers, banned open-ended flows, and the closed-loop specification rhythm."
)

#include "/content/module_06_writing_scenarios/lesson_31.typ"
#v(14pt)

#include "/content/module_06_writing_scenarios/lesson_32.typ"
#v(14pt)

#include "/content/module_06_writing_scenarios/lesson_33.typ"
#v(14pt)

#include "/content/module_06_writing_scenarios/lesson_34.typ"
#v(14pt)

#include "/content/module_06_writing_scenarios/lesson_35.typ"
#v(14pt)

#include "/content/module_06_writing_scenarios/lesson_36.typ"
#v(14pt)


#module_cover(
  7,
  "Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?",
  "Precision for AI — What to Say and What to Leave Out",
  "Klasik Cockburn kuralı ile AI çağının çatışması: Gözlemlenebilir davranış (Zone 1), alan modeli referansı (Zone 2) ve yasaklı mekanizma detayları (Zone 3). Kara liste (JWT, SQL, regex, SMTP), UI tasarımcısının üçlü bölünmesi ve 3 soruluk revizyon filtresi.",
  "The collision between classical restraint and AI demands: Observable behavior (Zone 1), domain references (Zone 2), and forbidden mechanisms (Zone 3). The banned blocklist (JWT, SQL, regex, SMTP), the three-way UI split, and the 3-question revision pass."
)

#include "/content/module_07_precision_calibration/lesson_37.typ"
#v(14pt)

#include "/content/module_07_precision_calibration/lesson_38.typ"
#v(14pt)

#include "/content/module_07_precision_calibration/lesson_39.typ"
#v(14pt)

#include "/content/module_07_precision_calibration/lesson_40.typ"
#v(14pt)

#include "/content/module_07_precision_calibration/lesson_41.typ"
#v(14pt)

#include "/content/module_07_precision_calibration/lesson_42.typ"
#v(14pt)


#module_cover(
  8,
  "Dilimler (Slices), Testler ve İterasyon Döngüsü",
  "Slices, Tests, and the Iteration Loop",
  "Use-Case 3.0'ın 10. İlkesi: Sistemi dilimler halinde inşa etmek. Temel akış ilk dilimdir; alternatif akışlar iş önceliğine göre dilimlenir. İlke 14: 'Gerçeği Testler Taşır'. AIUP test piramidi, TC-XXX uçtan uca yolculukları, birebir (literal) test verisi ve BPMN iş süreçlerinden test türetme döngüsü.",
  "Use-Case 3.0's 10th Principle: Build the system in slices. The basic flow is Slice 1; alternative flows are sliced in business-priority order. Principle 14: 'Tests Carry the Truth'. The AIUP test pyramid, TC-XXX end-to-end journeys, literal test data discipline, and deriving test cases from BPMN processes."
)

#include "/content/module_08_slices_tests_journeys/lesson_43.typ"
#v(14pt)

#include "/content/module_08_slices_tests_journeys/lesson_44.typ"
#v(14pt)

#include "/content/module_08_slices_tests_journeys/lesson_45.typ"
#v(14pt)

#include "/content/module_08_slices_tests_journeys/lesson_46.typ"
#v(14pt)

#include "/content/module_08_slices_tests_journeys/lesson_47.typ"
#v(14pt)

#include "/content/module_08_slices_tests_journeys/lesson_48.typ"
#v(14pt)


#module_cover(
  9,
  "Değişiklik Talepleri, Hatalar (Bugs) ve Mevcut (Brownfield) Sistemler",
  "Change Requests, Bugs, and Brownfield Systems",
  "15. İlke: 'Tüm İşler Bir Use Case Değişikliğidir'. İmza testi (Sign-off test) ile hata vs geliştirme ayrımı, neden /bug komutunun olmadığı, mevcut (brownfield) sistemlerin niyetini tersine mühendislikle kurtarma, 40 REST ucunu 4-8 use case'e indirgeme ve SE-RE ortak taban çizgisi (baseline) incelemesi.",
  "Principle 15: 'All Work is a Change to a Use Case'. The sign-off test to classify bugs vs enhancements, why there is no /bug command, recovering specifications from legacy brownfield systems, collapsing 40 REST endpoints into 4-8 use cases, and the joint SE-RE baseline review."
)

#include "/content/module_09_changes_bugs_brownfield/lesson_49.typ"
#v(14pt)

#include "/content/module_09_changes_bugs_brownfield/lesson_50.typ"
#v(14pt)

#include "/content/module_09_changes_bugs_brownfield/lesson_51.typ"
#v(14pt)

#include "/content/module_09_changes_bugs_brownfield/lesson_52.typ"
#v(14pt)

#include "/content/module_09_changes_bugs_brownfield/lesson_53.typ"
#v(14pt)

#include "/content/module_09_changes_bugs_brownfield/lesson_54.typ"
#v(14pt)


#module_cover(
  10,
  "Kontrol Listeleri, Yaygın Hatalar ve MAANG Mimar Seviyesi Ustalık",
  "Checklists, Common Mistakes & MAANG Architect Mastery",
  "24 maddelik şartname kontrol listesi, 10 yaygın hata (5 klasik + 5 AI çağı tuzağı), monitör kenarı adım yazma kartı (Desk Card), MAANG sistem tasarımı mülakatlarında AIUP, otonom çoklu ajan (Multi-Agent) iş akışları ve Staff+ Seviye Gereksinim Mimarlığı yönetişimi.",
  "The 24-point specification checklist, the ten common mistakes (5 classical + 5 AI-era traps), the split-pane step-writing desk card, AIUP in MAANG system design interviews, autonomous multi-agent code generation workflows, and Staff+ Requirements Architect governance."
)

#include "/content/module_10_checklists_maang_architect/lesson_55.typ"
#v(14pt)

#include "/content/module_10_checklists_maang_architect/lesson_56.typ"
#v(14pt)

#include "/content/module_10_checklists_maang_architect/lesson_57.typ"
#v(14pt)

#include "/content/module_10_checklists_maang_architect/lesson_58.typ"
#v(14pt)

#include "/content/module_10_checklists_maang_architect/lesson_59.typ"
#v(14pt)

#include "/content/module_10_checklists_maang_architect/lesson_60.typ"
#v(14pt)


#pagebreak()
#v(40pt)
#align(center)[
  #rect(fill: rgb("081c24"), radius: 10pt, inset: (x: 24pt, y: 32pt), width: 90%)[
    #text(size: 24pt, fill: rgb("2dd4bf"), weight: "bold")[🎓 TEBRİKLER! / CONGRATULATIONS!]    #v(10pt)
    #text(size: 14pt, fill: white)[60 Derslik AIUP & Use Case Mimarlık Yolculuğunu Başarıyla Tamamladınız!]    #v(6pt)
    #text(size: 11pt, fill: rgb("94a3b8"))[You have successfully mastered all 60 lessons of the Writing Use Cases for AI Curriculum!]    #v(20pt)
    #line(length: 60%, stroke: 1pt + rgb("0d9488"))
    #v(15pt)
    #text(size: 10pt, fill: rgb("cbd5e1"))[
      Spec-Driven Development • 3 Readers • 3 Zones • Mechanical Traceability • Java 25 LTS
    ]
  ]
]
