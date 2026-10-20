// ==============================================================================
// WRITING USE CASES FOR AI ELI5 - TYPST TEMPLATE (v0.15+ COMPATIBLE)
// Çift Dilli (Türkçe & English) - Yayın Kalitesinde Kitap ve Ders Şablonu
// ==============================================================================

#let setup_book(title: "", author: "Antigravity & AI Unified Process Guild", body) = {
  set document(title: title, author: author)
  set text(font: ("Avenir Next", "Helvetica Neue", "Arial"), size: 9.5pt, lang: "tr")
  set page(
    paper: "a4",
    margin: (x: 1.8cm, top: 2.2cm, bottom: 2.2cm),
    header: context {
      let cur_page = counter(page).get().first()
      if cur_page > 2 [
        #text(size: 8pt, fill: rgb("64748b"))[
          #grid(
            columns: (1fr, 1fr),
            [Writing Use Cases for AI • Spec-Driven Development],
            [#align(right)[Aptala Anlatır Gibi AI Çağında Use Case]]
          )
        ]
        #v(-2pt)
        #line(length: 100%, stroke: 0.5pt + rgb("e2e8f0"))
      ]
    },
    footer: context {
      let cur_page = counter(page).get().first()
      if cur_page > 2 [
        #line(length: 100%, stroke: 0.5pt + rgb("e2e8f0"))
        #v(2pt)
        #text(size: 8pt, fill: rgb("64748b"))[
          #grid(
            columns: (1fr, 1fr),
            [AI Unified Process • Slices & Tests • Java 25 LTS Blueprint],
            [#align(right)[Sayfa / Page #counter(page).display()]]
          )
        ]
      ]
    }
  )
  set par(justify: true, leading: 0.6em)
  body
}

#let diagram_box(body) = {
  v(5pt)
  rect(
    width: 100%,
    fill: rgb("06141d"), // deep cyber dark slate
    stroke: (left: 4.5pt + rgb("0d9488"), rest: 0.5pt + rgb("134e4a")),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 10pt,
        [#text(weight: "bold", fill: rgb("2dd4bf"), size: 10pt)[⚡ Akış, Varlık & Süreç Şeması]],
        [#align(right)[#text(weight: "bold", fill: rgb("14b8a6"), size: 10pt)[⚡ Process & Artifact Schematic]]]
      )
      #v(4pt)
      #body
    ]
  )
  v(5pt)
}

#let eli5_box(body) = {
  v(5pt)
  rect(
    width: 100%,
    fill: rgb("eff6ff"), // soft blue
    stroke: (left: 4.5pt + rgb("2563eb"), rest: 0.5pt + rgb("bfdbfe")),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 10pt,
        [#text(weight: "bold", fill: rgb("1e40af"), size: 10pt)[💡 Aptala Anlatım (ELI5 Metaforu)]],
        [#align(right)[#text(weight: "bold", fill: rgb("1d4ed8"), size: 10pt)[💡 ELI5 Metaphor]]]
      )
      #v(5pt)
      #body
    ]
  )
  v(5pt)
}

#let deep_dive_box(body) = {
  v(5pt)
  rect(
    width: 100%,
    fill: rgb("f8fafc"), // slate
    stroke: (left: 4.5pt + rgb("0f766e"), rest: 0.5pt + rgb("ccfbf1")),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 10pt,
        [#text(weight: "bold", fill: rgb("115e59"), size: 10pt)[🔍 MAANG & AIUP Seviyesi Teknik Derinlik]],
        [#align(right)[#text(weight: "bold", fill: rgb("0f766e"), size: 10pt)[🔍 MAANG & AIUP Technical Deep-Dive]]]
      )
      #v(5pt)
      #body
    ]
  )
  v(5pt)
}

#let java25_box(body) = {
  v(5pt)
  rect(
    width: 100%,
    fill: rgb("faf5ff"), // light violet
    stroke: (left: 4.5pt + rgb("9333ea"), rest: 0.5pt + rgb("e9d5ff")),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 10pt,
        [#text(weight: "bold", fill: rgb("6b21a8"), size: 10pt)[⚡ Modern Java 25 & Clean Architecture Uygulaması]],
        [#align(right)[#text(weight: "bold", fill: rgb("7e22ce"), size: 10pt)[⚡ Java 25 & Clean Architecture Implementation]]]
      )
      #v(5pt)
      #body
    ]
  )
  v(5pt)
}

#let warning_box(body) = {
  v(5pt)
  rect(
    width: 100%,
    fill: rgb("fff1f2"), // rose/red
    stroke: (left: 4.5pt + rgb("e11d48"), rest: 0.5pt + rgb("fecdd3")),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 10pt,
        [#text(weight: "bold", fill: rgb("9f1239"), size: 10pt)[⚠️ AI Yanılsaması, Mekanizma Sızıntısı & Mülakat Tuzağı]],
        [#align(right)[#text(weight: "bold", fill: rgb("be123c"), size: 10pt)[⚠️ AI Hallucination, Mechanism Leak & Interview Trap]]]
      )
      #v(5pt)
      #body
    ]
  )
  v(5pt)
}

#let takeaways_box(takeaways) = {
  v(5pt)
  rect(
    width: 100%,
    fill: rgb("f0fdf4"), // emerald
    stroke: (left: 4.5pt + rgb("16a34a"), rest: 0.5pt + rgb("bbf7d0")),
    radius: (right: 6pt),
    inset: (x: 12pt, y: 10pt),
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 10pt,
        [#text(weight: "bold", fill: rgb("15803d"), size: 10pt)[🎯 Mülakatta ve Üretimde Hatırlanacak Altın Kurallar]],
        [#align(right)[#text(weight: "bold", fill: rgb("166534"), size: 10pt)[🎯 Key Architectural Takeaways]]]
      )
      #v(5pt)
      #for item in takeaways [
        #grid(
          columns: (1fr, 1fr),
          gutter: 12pt,
          [#text(size: 8.5pt)[• #item.at(0)]],
          [#text(size: 8.5pt, fill: rgb("475569"))[• #item.at(1)]]
        )
        #v(2.5pt)
      ]
    ]
  )
  v(5pt)
}

#let lesson_header(lesson_num, title_tr, title_en, module_name_tr, module_name_en) = {
  v(4pt)
  rect(
    width: 100%,
    fill: rgb("081c24"), // dark deep teal
    radius: 8pt,
    inset: (x: 14pt, y: 12pt),
    [
      #grid(
        columns: (auto, 1fr),
        gutter: 12pt,
        [
          #circle(radius: 18pt, fill: rgb("0d9488"))[ // Teal badge
            #align(center + horizon)[#text(weight: "bold", fill: white, size: 12pt)[#lesson_num]]
          ]
        ],
        [
          #text(size: 7.5pt, fill: rgb("5eead4"), weight: "bold")[
            BÖLÜM: #upper(module_name_tr)  |  MODULE: #upper(module_name_en)
          ]
          #v(2pt)
          #text(size: 12.5pt, fill: white, weight: "bold")[#title_tr]
          #v(2pt)
          #text(size: 10.5pt, fill: rgb("38bdf8"), weight: "medium")[#title_en]
        ]
      )
    ]
  )
  v(6pt)
}

#let module_cover(module_num, title_tr, title_en, desc_tr, desc_en) = {
  pagebreak()
  v(25pt)
  align(center)[
    #rect(
      width: 100%,
      fill: rgb("051923"),
      radius: 12pt,
      inset: (x: 22pt, y: 28pt),
      [
        #text(size: 13pt, fill: rgb("2dd4bf"), weight: "bold")[BÖLÜM #module_num / MODULE #module_num]
        #v(8pt)
        #text(size: 20pt, fill: white, weight: "bold")[#title_tr]
        #v(5pt)
        #text(size: 15pt, fill: rgb("94a3b8"), weight: "medium")[#title_en]
        #v(14pt)
        #line(length: 60%, stroke: 1.5pt + rgb("0d9488"))
        #v(14pt)
        #grid(
          columns: (1fr, 1fr),
          gutter: 18pt,
          [
            #align(left)[
              #text(size: 9.5pt, fill: rgb("cbd5e1"))[#desc_tr]
            ]
          ],
          [
            #align(left)[
              #text(size: 9.5pt, fill: rgb("94a3b8"))[#desc_en]
            ]
          ]
        )
      ]
    )
  ]
  v(18pt)
}

#let book_front_cover() = {
  set page(header: none, footer: none, margin: 0pt)
  rect(
    width: 100%,
    height: 100%,
    fill: rgb("021017"), // ultimate midnight cyan obsidian
    inset: (x: 3.2cm, y: 3.2cm),
    [
      #v(20pt)
      #rect(fill: rgb("134e4a"), radius: 4pt, inset: (x: 10pt, y: 6pt))[
        #text(size: 9.5pt, fill: rgb("ccfbf1"), weight: "bold")[MAANG SPEC-DRIVEN ENGINEERING & AI UNIFIED PROCESS (BILINGUAL)]
      ]
      #v(16pt)
      #text(size: 32pt, fill: white, weight: "bold")[
        Aptala Anlatır Gibi\ AI Çağında Use Case
      ]
      #v(8pt)
      #text(size: 18pt, fill: rgb("2dd4bf"), weight: "medium")[
        Writing Use Cases for AI: How to Write for Stakeholders, Engineers, and AI Agents
      ]
      #v(12pt)
      #text(size: 11.5pt, fill: rgb("94a3b8"))[
        10 Bölüm • 60 Ders • Mimari Şemalar • Simon Martinelli / Ivar Jacobson / Alistair Cockburn Temelleri • Java 25 LTS
      ]
      #v(24pt)
      #line(length: 100%, stroke: 2pt + rgb("0d9488"))
      #v(24pt)
      #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 12pt,
        [
          #rect(fill: rgb("08202b"), radius: 6pt, inset: 10pt, width: 100%)[
            #text(weight: "bold", fill: white, size: 9.5pt)[🔄 The AI Inversion]\
            #v(2pt)
            #text(size: 8pt, fill: rgb("94a3b8"))[Kod ucuzladı, niyet kıymete bindi. Vibe Coding çöküşü ve Spec-Driven Development]
          ]
        ],
        [
          #rect(fill: rgb("08202b"), radius: 6pt, inset: 10pt, width: 100%)[
            #text(weight: "bold", fill: white, size: 9.5pt)[🎯 The Three Readers]\
            #v(2pt)
            #text(size: 8pt, fill: rgb("94a3b8"))[Paydaş doğrular, Mühendis inceler, Yapay Zekâ doğrudan kod ve test üretir]
          ]
        ],
        [
          #rect(fill: rgb("08202b"), radius: 6pt, inset: 10pt, width: 100%)[
            #text(weight: "bold", fill: white, size: 9.5pt)[🛡️ 3 Zones & Blocklist]\
            #v(2pt)
            #text(size: 8pt, fill: rgb("94a3b8"))[Gözlemlenebilir davranış net, mekanizma sessiz. Test-Protected dilimleme mimarisi]
          ]
        ]
      )
      #v(40pt)
      #align(bottom)[
        #text(size: 9pt, fill: rgb("64748b"))[
          Yayın Sürümü: 1.0.0 • AI Unified Process • Spec-Driven Development • 2026
        ]
      ]
    ]
  )
}
