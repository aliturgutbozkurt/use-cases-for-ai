/**
 * Writing Use Cases for AI ELI5 - Web Companion Reader Application
 * Implements: Live search, bilingual switching, sidebar navigation, PDF modal, and direct deep-linking.
 */

(function () {
  let appData = null;
  let allLessons = [];
  let currentLessonIndex = 0;
  let currentLangMode = 'split'; // 'split', 'tr', 'en'
  let expandedModules = new Set([1]); // Module 1 open by default

  // DOM Elements
  const moduleAccordion = document.getElementById('moduleAccordion');
  const mainContent = document.getElementById('mainContent');
  const searchInput = document.getElementById('searchInput');
  const lessonCounterBadge = document.getElementById('lessonCounterBadge');
  const pdfModal = document.getElementById('pdfModal');
  const btnOpenPdfModal = document.getElementById('btnOpenPdfModal');
  const btnClosePdfModal = document.getElementById('btnClosePdfModal');
  const modalModulePdfList = document.getElementById('modalModulePdfList');
  const modalIndividualPdfList = document.getElementById('modalIndividualPdfList');

  // Initialize
  async function init() {
    try {
      if (window.LESSONS_DATA) {
        appData = window.LESSONS_DATA;
      } else {
        const res = await fetch('data/lessons.json');
        appData = await res.json();
      }
    } catch (e) {
      console.warn("Could not load via fetch, checking window.LESSONS_DATA:", e);
      if (window.LESSONS_DATA) {
        appData = window.LESSONS_DATA;
      }
    }

    if (!appData || !appData.modules) {
      mainContent.innerHTML = `<div style="padding: 2rem; color: #f43f5e;">Hata: Müfredat verisi yüklenemedi. Lütfen sayfayı yenileyin.</div>`;
      return;
    }

    // Flatten all lessons with module reference
    allLessons = [];
    appData.modules.forEach(m => {
      m.lessons.forEach(l => {
        allLessons.push({
          ...l,
          module: m
        });
      });
    });

    setupEventListeners();
    buildPdfModalContent();

    // Check hash for direct link (e.g. #lesson-25)
    handleHashNavigation();
  }

  function setupEventListeners() {
    // Language Buttons
    document.querySelectorAll('.lang-btn').forEach(btn => {
      btn.addEventListener('click', (e) => {
        document.querySelectorAll('.lang-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        currentLangMode = btn.dataset.lang;
        renderActiveLesson();
      });
    });

    // Search Input
    let debounceTimer;
    searchInput.addEventListener('input', (e) => {
      clearTimeout(debounceTimer);
      debounceTimer = setTimeout(() => {
        const query = e.target.value.trim().toLowerCase();
        renderSidebar(query);
      }, 150);
    });

    // PDF Modal
    btnOpenPdfModal.addEventListener('click', () => {
      pdfModal.classList.add('active');
    });

    btnClosePdfModal.addEventListener('click', () => {
      pdfModal.classList.remove('active');
    });

    pdfModal.addEventListener('click', (e) => {
      if (e.target === pdfModal) {
        pdfModal.classList.remove('active');
      }
    });

    window.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && pdfModal.classList.contains('active')) {
        pdfModal.classList.remove('active');
      }
    });

    // Hash change
    window.addEventListener('hashchange', handleHashNavigation);
  }

  function handleHashNavigation() {
    const hash = window.location.hash;
    if (hash && hash.startsWith('#lesson-')) {
      const num = parseInt(hash.replace('#lesson-', ''), 10);
      const idx = allLessons.findIndex(l => l.num === num);
      if (idx !== -1) {
        currentLessonIndex = idx;
        expandedModules.add(allLessons[idx].module.id);
      }
    }
    renderSidebar();
    renderActiveLesson();
  }

  function selectLesson(index) {
    if (index < 0 || index >= allLessons.length) return;
    currentLessonIndex = index;
    const lesson = allLessons[index];
    expandedModules.add(lesson.module.id);
    window.location.hash = `#lesson-${lesson.num}`;
    renderSidebar();
    renderActiveLesson();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  // --- RENDER SIDEBAR ---
  function renderSidebar(query = '') {
    moduleAccordion.innerHTML = '';
    const isSearching = query.length > 0;

    appData.modules.forEach(m => {
      const matchingLessons = m.lessons.filter(l => {
        if (!isSearching) return true;
        const text = (l.title_tr + " " + l.title_en + " " + l.eli5_tr + " " + l.eli5_en + " " + l.deep_tr + " " + l.deep_en).toLowerCase();
        return text.includes(query);
      });

      if (isSearching && matchingLessons.length === 0) return;

      const isExpanded = isSearching || expandedModules.has(m.id);
      const card = document.createElement('li');
      card.className = `module-card ${isExpanded ? 'expanded' : ''}`;

      card.innerHTML = `
        <div class="module-header" data-mod-id="${m.id}">
          <div class="module-meta">
            <span class="module-tag">BÖLÜM ${m.id} / MODULE ${m.id}</span>
            <span class="module-title-text">${m.title_tr}</span>
          </div>
          <span class="module-toggle-icon">▶</span>
        </div>
        ${isExpanded ? `
          <ul class="lesson-sublist">
            ${matchingLessons.map(l => {
              const globalIdx = allLessons.findIndex(x => x.num === l.num);
              const isActive = globalIdx === currentLessonIndex;
              return `
                <li class="lesson-item ${isActive ? 'active' : ''}" data-lesson-idx="${globalIdx}">
                  <span class="lesson-badge">${l.num}</span>
                  <span style="flex:1; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                    ${l.title_tr}
                  </span>
                </li>
              `;
            }).join('')}
          </ul>
        ` : ''}
      `;

      card.querySelector('.module-header').addEventListener('click', () => {
        if (expandedModules.has(m.id)) {
          expandedModules.delete(m.id);
        } else {
          expandedModules.add(m.id);
        }
        renderSidebar(searchInput.value.trim().toLowerCase());
      });

      card.querySelectorAll('.lesson-item').forEach(item => {
        item.addEventListener('click', (e) => {
          e.stopPropagation();
          const idx = parseInt(item.dataset.lessonIdx, 10);
          selectLesson(idx);
        });
      });

      moduleAccordion.appendChild(card);
    });

    lessonCounterBadge.textContent = `Ders ${allLessons[currentLessonIndex]?.num || 1} / 60`;
  }

  // --- RENDER ACTIVE LESSON ---
  function renderActiveLesson() {
    const lesson = allLessons[currentLessonIndex];
    if (!lesson) return;

    const mod = lesson.module;
    lessonCounterBadge.textContent = `Ders ${lesson.num} / 60`;

    // Filter content based on currentLangMode
    const showTr = currentLangMode === 'split' || currentLangMode === 'tr';
    const showEn = currentLangMode === 'split' || currentLangMode === 'en';

    mainContent.innerHTML = `
      <!-- Hero Header -->
      <header class="lesson-hero">
        <div class="lesson-hero-top">
          <span class="lesson-number-tag">DERS / LESSON #${lesson.num}</span>
          <div class="lesson-actions">
            <a href="../output/individual/lesson_${String(lesson.num).padStart(2, '0')}.pdf" target="_blank" class="btn-primary" style="font-size:0.78rem; padding: 0.4rem 0.85rem;">
              📄 Bu Dersin PDF'i
            </a>
            <a href="../output/modules/module_${String(mod.id).padStart(2, '0')}.pdf" target="_blank" class="btn-secondary" style="font-size:0.78rem; padding: 0.4rem 0.85rem;">
              📦 Bölüm ${mod.id} PDF'i
            </a>
          </div>
        </div>

        <div class="lesson-hero-module-name">BÖLÜM ${mod.id}: ${mod.title_tr} • ${mod.title_en}</div>
        <h1 class="lesson-hero-title-tr">${lesson.title_tr}</h1>
        <h2 class="lesson-hero-title-en">${lesson.title_en}</h2>
      </header>

      <!-- 1. Diagram Box -->
      <section class="box-section">
        <div class="diagram-card">
          <div class="diagram-header">
            <span class="diagram-title">⚡ Mimari Akış ve Süreç Şeması / Process Schematic</span>
            <button class="btn-copy" onclick="navigator.clipboard.writeText(document.getElementById('diagramText').innerText); this.innerText='Kopyalandı!'; setTimeout(()=>this.innerText='Kopyala', 2000)">Kopyala</button>
          </div>
          <div class="diagram-body" id="diagramText">${escapeHtml(lesson.diagram)}</div>
        </div>
      </section>

      <!-- 2. ELI5 Box -->
      <section class="box-section">
        <div class="eli5-card">
          <div class="eli5-header">💡 Aptala Anlatım (ELI5 Metaforu) / Real-Life Metaphor</div>
          <div class="split-content">
            ${showTr ? `
              <div class="lang-column">
                <span class="col-label tr">🇹🇷 Türkçe (ELI5)</span>
                ${lesson.eli5_tr}
              </div>
            ` : ''}
            ${showEn ? `
              <div class="lang-column ${currentLangMode === 'split' ? 'english' : ''}">
                <span class="col-label en">🇬🇧 English (ELI5)</span>
                ${lesson.eli5_en}
              </div>
            ` : ''}
          </div>
        </div>
      </section>

      <!-- 3. Deep-Dive Box -->
      <section class="box-section">
        <div class="deep-card">
          <div class="deep-header">🔍 AIUP & MAANG Seviyesi Teknik Derinlik / Technical Deep-Dive</div>
          <div class="split-content">
            ${showTr ? `
              <div class="lang-column">
                <span class="col-label tr">🇹🇷 Türkçe (Derinlemesine)</span>
                ${lesson.deep_tr}
              </div>
            ` : ''}
            ${showEn ? `
              <div class="lang-column ${currentLangMode === 'split' ? 'english' : ''}">
                <span class="col-label en">🇬🇧 English (Technical Analysis)</span>
                ${lesson.deep_en}
              </div>
            ` : ''}
          </div>
        </div>
      </section>

      <!-- 4. Java 25 Box -->
      <section class="box-section">
        <div class="java-card">
          <div class="java-header">
            <span class="java-title">☕ Modern Java 25 LTS & Clean Architecture Uygulaması</span>
            <button class="btn-copy" onclick="navigator.clipboard.writeText(document.getElementById('javaCodeText').innerText); this.innerText='Kopyalandı!'; setTimeout(()=>this.innerText='Kopyala', 2000)">Kopyala</button>
          </div>
          <pre class="java-code-pre" id="javaCodeText"><code>${escapeHtml(lesson.java_code)}</code></pre>
        </div>
      </section>

      <!-- 5. Warning Box -->
      <section class="box-section">
        <div class="warning-card">
          <div class="warning-header">⚠️ Mülakat Tuzağı ve AI Halüsinasyonu / Interview Trap & Hallucination</div>
          <div class="split-content">
            ${showTr ? `
              <div class="lang-column">
                <span class="col-label tr">🇹🇷 Kritik Uyarı</span>
                ${lesson.warning_tr}
              </div>
            ` : ''}
            ${showEn ? `
              <div class="lang-column ${currentLangMode === 'split' ? 'english' : ''}">
                <span class="col-label en">🇬🇧 Architectural Risk</span>
                ${lesson.warning_en}
              </div>
            ` : ''}
          </div>
        </div>
      </section>

      <!-- 6. Takeaways Box -->
      <section class="box-section">
        <div class="takeaways-card">
          <div class="takeaways-header">🎯 Mülakatta ve Üretimde Hatırlanacak Altın Kurallar / Key Takeaways</div>
          <div class="takeaways-list">
            ${(lesson.takeaways || []).map(t => `
              <div class="takeaway-row">
                ${showTr ? `<div class="takeaway-tr">• ${t[0]}</div>` : ''}
                ${showEn ? `<div class="takeaway-en">• ${t[1]}</div>` : ''}
              </div>
            `).join('')}
          </div>
        </div>
      </section>

      <!-- Navigation Footer -->
      <footer class="lesson-nav-footer">
        <button id="btnPrevLesson" class="btn-secondary" ${currentLessonIndex === 0 ? 'disabled style="opacity:0.4; cursor:not-allowed;"' : ''}>
          ⬅️ Önceki Ders (${currentLessonIndex > 0 ? allLessons[currentLessonIndex - 1].num : ''})
        </button>
        <span style="font-size: 0.85rem; color: var(--text-muted);">
          Ders ${lesson.num} / 60
        </span>
        <button id="btnNextLesson" class="btn-primary" ${currentLessonIndex === allLessons.length - 1 ? 'disabled style="opacity:0.4; cursor:not-allowed;"' : ''}>
          Sonraki Ders (${currentLessonIndex < allLessons.length - 1 ? allLessons[currentLessonIndex + 1].num : ''}) ➡️
        </button>
      </footer>
    `;

    // Footer button events
    const btnPrev = document.getElementById('btnPrevLesson');
    const btnNext = document.getElementById('btnNextLesson');

    if (btnPrev && currentLessonIndex > 0) {
      btnPrev.addEventListener('click', () => selectLesson(currentLessonIndex - 1));
    }
    if (btnNext && currentLessonIndex < allLessons.length - 1) {
      btnNext.addEventListener('click', () => selectLesson(currentLessonIndex + 1));
    }
  }

  // --- PDF MODAL CONTENT BUILDER ---
  function buildPdfModalContent() {
    // 10 Module Bundles
    modalModulePdfList.innerHTML = appData.modules.map(m => `
      <a href="../output/modules/module_${String(m.id).padStart(2, '0')}.pdf" target="_blank" class="pdf-card-btn">
        <span>📦 Bölüm ${m.id}: ${m.title_tr.substring(0, 32)}...</span>
        <span style="color: var(--accent-cyan);">PDF ↗</span>
      </a>
    `).join('');

    // 60 Individual Lessons
    modalIndividualPdfList.innerHTML = allLessons.map(l => `
      <a href="../output/individual/lesson_${String(l.num).padStart(2, '0')}.pdf" target="_blank" class="pdf-lesson-chip" title="${l.title_tr}">
        Ders ${l.num} ↗
      </a>
    `).join('');
  }

  function escapeHtml(str) {
    if (!str) return '';
    return str
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#039;");
  }

  // Run app
  document.addEventListener('DOMContentLoaded', init);
})();
