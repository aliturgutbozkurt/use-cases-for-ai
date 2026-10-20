#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_all.py
Master generator and compiler for the 10-Module, 60-Lesson Bilingual ELI5
Writing Use Cases for AI Masterclass (Based on Simon Martinelli's book & the AI Unified Process).
Features:
  - Bilingual TR & EN side-by-side
  - ASCII diagrams in every lesson
  - Modern Java 25 LTS code examples
  - 60 Individual Lesson PDFs
  - 10 Module Bundle PDFs
  - 1 Master Book PDF
  - Web Companion Reader (JSON & offline JS data)
"""

import os
import sys
import json
import re
import subprocess
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
MODULES_DATA_DIR = BASE_DIR / "modules_data"
CONTENT_DIR = BASE_DIR / "content"
OUTPUT_DIR = BASE_DIR / "output"
WEB_DIR = BASE_DIR / "web"

sys.path.insert(0, str(MODULES_DATA_DIR))
import mod01_ai_inversion
import mod02_three_readers
import mod03_actors_goals_scope
import mod04_artifact_chain
import mod05_spec_template
import mod06_writing_scenarios
import mod07_precision_calibration
import mod08_slices_tests_journeys
import mod09_changes_bugs_brownfield
import mod10_checklists_maang_architect

MODULES = [
    mod01_ai_inversion.MODULE,
    mod02_three_readers.MODULE,
    mod03_actors_goals_scope.MODULE,
    mod04_artifact_chain.MODULE,
    mod05_spec_template.MODULE,
    mod06_writing_scenarios.MODULE,
    mod07_precision_calibration.MODULE,
    mod08_slices_tests_journeys.MODULE,
    mod09_changes_bugs_brownfield.MODULE,
    mod10_checklists_maang_architect.MODULE,
]

def sanitize_typst_text(s: str) -> str:
    """Escapes dollar signs, unescaped angle brackets, and @ symbols."""
    if not s:
        return ""
    # Escapes for math and citations
    s = s.replace("$", "\\$")
    s = re.sub(r"(?<!\\)<", r"\<", s)
    s = re.sub(r"(?<!\\)@", r"\@", s)
    # Outside backticks, escape unescaped underscores to avoid italic errors
    parts = s.split("`")
    for i in range(0, len(parts), 2):
        parts[i] = re.sub(r"(?<!\\)_", r"\_", parts[i])
        parts[i] = re.sub(r"(?<!\\)#", r"\#", parts[i])
    s = "`".join(parts)
    return s

def escape_typst_string_literal(s: str) -> str:
    """Escapes backslashes and double quotes inside Typst string literals."""
    if not s:
        return ""
    return s.replace('\\', '\\\\').replace('"', '\\"')

def generate_lesson_typ(m: dict, l: dict) -> str:
    takeaways_typ = ""
    for item in l.get('takeaways', []):
        tr_item = escape_typst_string_literal(item[0])
        en_item = escape_typst_string_literal(item[1])
        takeaways_typ += f'    ("{tr_item}", "{en_item}"),\n'

    eli5_tr = sanitize_typst_text(l['eli5_tr'])
    eli5_en = sanitize_typst_text(l['eli5_en'])
    deep_tr = sanitize_typst_text(l['deep_tr'])
    deep_en = sanitize_typst_text(l['deep_en'])
    warning_tr = sanitize_typst_text(l['warning_tr'])
    warning_en = sanitize_typst_text(l['warning_en'])

    title_tr = escape_typst_string_literal(l['title_tr'])
    title_en = escape_typst_string_literal(l['title_en'])
    mod_title_tr = escape_typst_string_literal(m['title_tr'])
    mod_title_en = escape_typst_string_literal(m['title_en'])

    content = f'''#import "/template.typ": *

#show: doc => setup_book(title: "Ders {l['num']}: {title_tr}", doc)

#lesson_header(
  {l['num']},
  "{title_tr}",
  "{title_en}",
  "{mod_title_tr}",
  "{mod_title_en}"
)

#diagram_box[
```text
{l['diagram']}
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\\
      #v(3pt)
      {eli5_tr}
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\\
      #v(3pt)
      #text(fill: rgb("334155"))[{eli5_en}]
    ]
  )
]

#deep_dive_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("115e59"), size: 9pt)[🇹🇷 AIUP & MAANG DERİNLEMESİNE ANALİZ]\\
      #v(3pt)
      {deep_tr}
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\\
      #v(3pt)
      #text(fill: rgb("334155"))[{deep_en}]
    ]
  )
]

#java25_box[
```java
{l['java_code']}
```
]

#warning_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("9f1239"), size: 9pt)[🇹🇷 MÜLAKAT TUZAĞI VE AI HALÜSİNASYONU]\\
      #v(3pt)
      {warning_tr}
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\\
      #v(3pt)
      #text(fill: rgb("881337"))[{warning_en}]
    ]
  )
]

#takeaways_box((
{takeaways_typ}))
'''
    return content

def generate_module_typ(m: dict) -> str:
    desc_tr = escape_typst_string_literal(m['desc_tr'])
    desc_en = escape_typst_string_literal(m['desc_en'])
    title_tr = escape_typst_string_literal(m['title_tr'])
    title_en = escape_typst_string_literal(m['title_en'])

    content = f'''#import "/template.typ": *

#show: doc => setup_book(title: "Bölüm {m['id']}: {title_tr}", doc)

#module_cover(
  {m['id']},
  "{title_tr}",
  "{title_en}",
  "{desc_tr}",
  "{desc_en}"
)

'''
    for l in m['lessons']:
        filename = f"lesson_{l['num']:02d}.typ"
        content += f'#include "{filename}"\n#v(16pt)\n\n'
    return content

def generate_master_book_typ() -> str:
    content = '''#import "/template.typ": *

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
'''
    for m in MODULES:
        desc_tr = escape_typst_string_literal(m['desc_tr'])
        desc_en = escape_typst_string_literal(m['desc_en'])
        title_tr = escape_typst_string_literal(m['title_tr'])
        title_en = escape_typst_string_literal(m['title_en'])
        content += f'''
#module_cover(
  {m['id']},
  "{title_tr}",
  "{title_en}",
  "{desc_tr}",
  "{desc_en}"
)

'''
        for l in m['lessons']:
            rel_path = f"/content/{m['dir']}/lesson_{l['num']:02d}.typ"
            content += f'#include "{rel_path}"\n#v(14pt)\n\n'

    content += '''
#pagebreak()
#v(40pt)
#align(center)[
  #rect(fill: rgb("081c24"), radius: 10pt, inset: (x: 24pt, y: 32pt), width: 90%)[
    #text(size: 24pt, fill: rgb("2dd4bf"), weight: "bold")[🎓 TEBRİKLER! / CONGRATULATIONS!]\
    #v(10pt)
    #text(size: 14pt, fill: white)[60 Derslik AIUP & Use Case Mimarlık Yolculuğunu Başarıyla Tamamladınız!]\
    #v(6pt)
    #text(size: 11pt, fill: rgb("94a3b8"))[You have successfully mastered all 60 lessons of the Writing Use Cases for AI Curriculum!]\
    #v(20pt)
    #line(length: 60%, stroke: 1pt + rgb("0d9488"))
    #v(15pt)
    #text(size: 10pt, fill: rgb("cbd5e1"))[
      Spec-Driven Development • 3 Readers • 3 Zones • Mechanical Traceability • Java 25 LTS
    ]
  ]
]
'''
    return content

def generate_web_json():
    data = {
        "title_tr": "Aptala Anlatır Gibi AI Çağında Use Case",
        "title_en": "Writing Use Cases for AI: ELI5 Masterclass",
        "description": "60 Ders • 10 Bölüm • Çift Dilli (TR & EN) • Mimari Şemalar • Java 25 LTS",
        "modules": MODULES
    }
    web_data_dir = WEB_DIR / "data"
    web_data_dir.mkdir(parents=True, exist_ok=True)
    with open(web_data_dir / "lessons.json", "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    with open(web_data_dir / "lessons.js", "w", encoding="utf-8") as f:
        f.write("window.LESSONS_DATA = " + json.dumps(data, ensure_ascii=False) + ";\n")
    print(f"✔ Exported web data to {web_data_dir / 'lessons.json'} and lessons.js")

def write_all_typst_files():
    CONTENT_DIR.mkdir(parents=True, exist_ok=True)
    for m in MODULES:
        mod_dir = CONTENT_DIR / m['dir']
        mod_dir.mkdir(parents=True, exist_ok=True)
        for l in m['lessons']:
            lesson_typ = generate_lesson_typ(m, l)
            lesson_path = mod_dir / f"lesson_{l['num']:02d}.typ"
            with open(lesson_path, "w", encoding="utf-8") as f:
                f.write(lesson_typ)
        
        module_typ = generate_module_typ(m)
        module_path = mod_dir / f"module_{m['id']:02d}.typ"
        with open(module_path, "w", encoding="utf-8") as f:
            f.write(module_typ)
    
    book_typ = generate_master_book_typ()
    with open(BASE_DIR / "book.typ", "w", encoding="utf-8") as f:
        f.write(book_typ)
    print("✔ All Typst source files generated successfully!")

def compile_typst(src: Path, out: Path) -> bool:
    out.parent.mkdir(parents=True, exist_ok=True)
    cmd = [
        "typst", "compile",
        "--root", str(BASE_DIR),
        str(src),
        str(out)
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        print(f"❌ Error compiling {src.name}: {res.stderr}")
        return False
    return True

def compile_all_pdfs():
    (OUTPUT_DIR / "individual").mkdir(parents=True, exist_ok=True)
    (OUTPUT_DIR / "modules").mkdir(parents=True, exist_ok=True)
    (OUTPUT_DIR / "book").mkdir(parents=True, exist_ok=True)

    print("\n--- 1. Compiling Master Book PDF ---")
    book_src = BASE_DIR / "book.typ"
    book_out = OUTPUT_DIR / "book" / "Writing_Use_Cases_for_AI_ELI5.pdf"
    if compile_typst(book_src, book_out):
        size_kb = book_out.stat().st_size / 1024
        print(f"✔ Master Book PDF created: {book_out.name} ({size_kb:.1f} KB)")

    print("\n--- 2. Compiling 10 Module PDFs ---")
    for m in MODULES:
        mod_src = CONTENT_DIR / m['dir'] / f"module_{m['id']:02d}.typ"
        mod_out = OUTPUT_DIR / "modules" / f"module_{m['id']:02d}.pdf"
        if compile_typst(mod_src, mod_out):
            size_kb = mod_out.stat().st_size / 1024
            print(f"✔ Module {m['id']} PDF: {mod_out.name} ({size_kb:.1f} KB)")

    print("\n--- 3. Compiling 60 Individual Lesson PDFs ---")
    success_count = 0
    for m in MODULES:
        for l in m['lessons']:
            les_src = CONTENT_DIR / m['dir'] / f"lesson_{l['num']:02d}.typ"
            les_out = OUTPUT_DIR / "individual" / f"lesson_{l['num']:02d}.pdf"
            if compile_typst(les_src, les_out):
                success_count += 1
            else:
                print(f"Failed lesson {l['num']}")
    print(f"✔ Compiled {success_count}/60 Individual Lesson PDFs successfully!")

if __name__ == "__main__":
    print("🚀 Starting Complete Curriculum Generation...")
    write_all_typst_files()
    generate_web_json()

    mode = sys.argv[1] if len(sys.argv) > 1 else "--all"
    if mode == "--all":
        compile_all_pdfs()
    elif mode == "--book":
        book_src = BASE_DIR / "book.typ"
        book_out = OUTPUT_DIR / "book" / "Writing_Use_Cases_for_AI_ELI5.pdf"
        compile_typst(book_src, book_out)
    elif mode == "--modules":
        for m in MODULES:
            mod_src = CONTENT_DIR / m['dir'] / f"module_{m['id']:02d}.typ"
            mod_out = OUTPUT_DIR / "modules" / f"module_{m['id']:02d}.pdf"
            compile_typst(mod_src, mod_out)
    elif mode == "--json-only":
        pass
