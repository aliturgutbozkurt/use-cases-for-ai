# 📐 Writing Use Cases for AI: How to Write for Stakeholders, Engineers, and AI Agents
### *Aptala Anlatır Gibi (ELI5) MAANG Seviyesi Başucu Rehberi • 10 Bölüm • 60 Ders • Çift Dilli (TR 🇹🇷 & EN 🇬🇧)*

[![Java 25 LTS](https://img.shields.io/badge/Java-25%20LTS-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://openjdk.org/)
[![AI Unified Process](https://img.shields.io/badge/AIUP-Spec--Driven%20Development-0d9488?style=for-the-badge)](https://unifiedprocess.ai)
[![Typst 0.15](https://img.shields.io/badge/Typst-0.15.1%20Ready-239dad?style=for-the-badge)](https://typst.app/)
[![PDFs Generated](https://img.shields.io/badge/PDFs-71%20Files%20Built-10b981?style=for-the-badge)](#-yayınlanan-pdf-kütüphanesi-71-pdf)

> **"Kod artık derleme çıktısıdır; asıl yaşayan varlık ise şartnamedir!"**  
> Bu proje, **Simon Martinelli**'nin *"Writing Use Cases for AI"* kitabı, **Ivar Jacobson**'ın Use-Case 3.0 modeli ve **Alistair Cockburn**'ün 40 yıllık kullanım senaryosu temelleri üzerine inşa edilmiştir.

---

## 📑 İçindekiler / Table of Contents
1. [Büyük Tersine Dönüş (The AI Inversion)](#-büyük-tersine-dönüş-the-ai-inversion)
2. [Üç Okuyucu Modeli (The Three Readers)](#-üç-okuyucu-modeli-the-three-readers)
3. [Hassasiyetin 3 Bölgesi & Kara Liste (3 Zones & Blocklist)](#-hassasiyetin-3-bölgesi--kara-liste-3-zones--blocklist)
4. [Müfredat: 10 Bölüm & 60 Ders (Curriculum)](#-müfredat-10-bölüm--60-ders)
5. [Yayınlanan PDF Kütüphanesi (71 PDF)](#-yayınlanan-pdf-kütüphanesi-71-pdf)
6. [Web Companion Reader (İnteraktif Web Okuyucu)](#-web-companion-reader-interaktif-web-okuyucu)
7. [Çalıştırılabilir Java 25 Örnekleri (Examples)](#-çalıştırılabilir-java-25-örnekleri)
8. [Kurulum ve Derleme (Build & Compile)](#-kurulum-ve-derleme-build--compile)

---

## 🔄 Büyük Tersine Dönüş (The AI Inversion)

Yazılım tarihinin ilk 40 yılında kod yazmak pahalı, şartname yazmak ise ucuz bir sohbetten ibaretti. Geliştiriciler şartnamedeki eksikleri koridor sohbetlerinde tamamlar, "Tek gerçek koddur" denirdi.

**Üretken Yapay Zekâ bu denklemi kökünden tersine çevirdi:**
* **Kodlama artık ucuz, hızlı ve anında tekrarlanabilir hale geldi.**
* **Asıl kıt ve değerli olan kaynak: İfade Edilmiş Niyettir (Expressed Intent).**
* Muğlak bir prompt verdiğinizde AI boşlukları kafasına göre doldurur ("Vibe Coding"). Ortaya çıkan sistem bakım yapılamaz ve yeniden üretilemez.
* **AI Unified Process (AIUP)** bu sebeple şartnameyi şirketin en değerli kalıcı varlığı (*asset*), kodu ise onun geçici bir derleme çıktısı (*build artifact*) kabul eder.

```text
  Geleneksel Yazılım Dünyası:              AI Unified Process Dünyası:
  ───────────────────────────              ───────────────────────────
  - Kod = Tek Gerçek (Pahalı Varlık)       - Şartname = Tek Gerçek (Kalıcı Varlık)
  - Şartname = Çöpe atılan iskele          - Kod = İhtiyaç anında üretilen çıktı
  - Mimar = Kod yazan kıdemli geliştirici  - Mimar = Sistem Niyetini Koruyan Lider!

  MEKANİK İZLENEBİLİRLİK ZİNCİRİ (TRACEABILITY):
  [ FR-005 ] ──► [ UC-003 ] ──► [ A2 Akışı ] ──► [ UC-003 BR-007 ] ──► [ Java 25 Kodu & Test ]
```

---

## 👥 Üç Okuyucu Modeli (The Three Readers)

Klasik kullanım senaryolarının 2 okuyucusu vardı: **Paydaş** ve **Geliştirici**.  
AIUP çağında artık **3 Okuyucu** vardır:

| Okuyucu | Ne İçin Okur? | Nasıl Okur? |
| :--- | :--- | :--- |
| **1. İş Paydaşı (Stakeholder)** | *"İstediğim şey bu mu? Teslimatta kontrol edebilecek miyim?"* | Göz gezdirir (Skims). Mutlu yolu ve hikâyeyi okur. Çabuk sıkılır. |
| **2. Yazılım Mühendisi (SE)** | *"Bu inşa edilebilir mi? Üretilen kod ve testler şartnameyle uyuşuyor mu?"* | İnceler (Reviews). Akışları kod ve testlerle çapraz kontrol eder. |
| **3. Yapay Zekâ Ajanı (AI)** | *"Tam olarak neyi kodlayıp test edeceğim?"* | Harfi harfine, kelimesi kelimesine okur. Asla soru sormaz, boşlukları kafasından uydurur! |

> **Altın Kural (İlke 12):** Şartnameyi daima şu öncelik sırasına göre yazın: **1. Paydaş, 2. Mühendis, 3. AI**.  
> İlk iki okuyucuyu tatmin eden bir şartname, üçüncü okuyucuya (AI) neredeyse otomatik olarak kusursuz hizmet eder.

---

## 🛡️ Hassasiyetin 3 Bölgesi & Kara Liste (3 Zones & Blocklist)

> *"Paydaşın gözlemleyebileceği ve testin doğrulayabileceği HER ŞEYİ yazın. Sistemin bunu arkada nasıl başardığı hakkında HİÇBİR ŞEY yazmayın!"*

1. **Zone 1 — Gözlemlenebilir Davranış (SOMUT YAZIN):**
   * Ekranda görünen kolon adları ve sıralama (Örn: *Title, Author, ISBN, Available Copies sorted by Title ascending*).
   * Kesin iş miktarları (Örn: *due date 28 days from today*, *at most 5 loans*).
   * Hata ve onay mesajının anlamsal içeriği.
2. **Zone 2 — Alan Verisi (REFERANS VERİN, ASLA TEKRARLAMAYIN):**
   * Varlık yapıları, tipler ve uzunluklar yalnızca `docs/entity_model.md` dosyasında yaşar.
   * Şartname varlığı sadece ismiyle çağırır (*Member*, *Book*, *Loan*). Asla içine tablo çizmez!
3. **Zone 3 — Mekanizma (KESİNLİKLE YASAKTIR / BLOCKED):**
   * Şartnamede geçen teknoloji kelimeleri `/spec-review` tarafından anında engellenir:
   * 🛑 **KARA LİSTE:** `SMTP`, `email server`, `JWT`, `token`, `bcrypt`, `hash`, `salt`, `SHA`, `SQL`, `SELECT`, `INSERT`, `HTTP verbs`, `regex patterns`, `class names`, `exception names`.

---

## 📚 Müfredat: 10 Bölüm & 60 Ders

* **Bölüm 1: Büyük Tersine Dönüş (The Inversion) & AI Çağında Use Case Rönesansı** (Ders 1-6)
  * Ders 1: The AI Inversion: Kodun Değersizleşmesi ve Niyetin Paha Biçilemez Hale Gelmesi
  * Ders 2: Koridor Sohbetinin Ölümü: AI Boşluk Bırakmaz, Uydurur!
  * Ders 3: Determinizm Yanılgısı (The Determinism Fallacy): Mükemmel Şartname Efsanesi
  * Ders 4: 40 Yıllık Evrim: Jacobson (1987) -> Cockburn (2001) -> Use-Case 3.0 (2024) -> AIUP (2026)
  * Ders 5: Kullanıcı Hikâyeleri (User Stories) vs Use Case: Neden Biri Diğerinin Yerini Tutamaz?
  * Ders 6: Şartname Tabanlı Geliştirme (Spec-Driven Development) ve Yaşayan Varlık Olarak Şartname
* **Bölüm 2: Üç Okuyucu Modeli & Yapay Zekâ Çağının 5 Temel İlkesi** (Ders 7-12)
  * Ders 7: Üç Okuyucu: Paydaş, Yazılım Mühendisi ve Yapay Zekâ Ajanı
  * Ders 8: Belirsizliğin Yeni Maliyeti ve Harfi Harfine (Literal) Okuyan AI
  * Ders 9: 11. İlke: Şartname Koddan Daha Uzun Yaşar (The Specification Outlives the Code)
  * Ders 10: 12. İlke: Üç Okuyucunun Hiyerarşisi (Paydaş -> Mühendis -> AI)
  * Ders 11: 13. ve 14. İlkeler: Gözlemlenebilirlik ve Gerçeği Testlerin Taşıması
  * Ders 12: 15. İlke: Önce Şartnameyi Değiştirin (Change the Specification First)
* **Bölüm 3: Temel Esaslar: Aktörler, Deniz Seviyesi Hedefler & Paydaş Sözleşmeleri** (Ders 13-18)
  * Ders 13: Aktörler ve Roller: İnsanlar, Sistemler ve Birincil/İkincil Aktör Ayrımı
  * Ders 14: Use Case Bir Sözleşmedir: Klavyede Olmayan Paydaşların Haklarını Korumak
  * Ders 15: Bir Adımın 3 Çeşidi: Etkileşim, Doğrulama ve Durum Değişimi
  * Ders 16: Hedef Seviyeleri: Deniz Seviyesinde Yazmak (Sea-Level Goals)
  * Ders 17: Kapsam Sınırı ve Cockburn'ün In/Out Listesi
  * Ders 18: CRUD Tuzağı: 'Manage X' Kuralı ve Kullanıcı Diliyle İsimlendirme
* **Bölüm 4: Eser Zinciri (Artifact Chain) & PlantUML Mimarisi** (Ders 19-24)
  * Ders 19: 6 Halkalı Eser Zinciri (Vision -> Requirements -> Entity -> Diagram -> Spec -> Tests)
  * Ders 20: Göbek ve Parmaklar (Hub and Spokes): Use Case Neden Merkezdedir?
  * Ders 21: PlantUML ile Sistemin İçindekiler Tablosu (use_cases.puml)
  * Ders 22: `<<include>>` ve `<<extend>>` Hakkındaki Çıplak Gerçek: Neden Neredeyse Hiç Kullanılmaz?
  * Ders 23: Tanımlayıcılar Birer Arayüzdür: Mekanik İzlenebilirlik (Traceability)
  * Ders 24: Zinciri Denetleme: `/spec-review` Deterministik ve Danışman Geçişleri
* **Bölüm 5: Ana Şartname Şablonu & Alan Alan Derinlemesine İnceleme** (Ders 25-30)
  * Ders 25: AIUP Şartname Şablonu Anatomisi: Neden Tek Bir Tip?
  * Ders 26: Ön Koşullar vs Tetikleyiciler: Bekleyen Durumdan Koşan Duruma Geçiş
  * Ders 27: Ana Başarı Senaryosu (Happy Path): 3-9 Adım Arasında Kusursuz Ritim
  * Ders 28: Son Koşullar (Postconditions): Başarı Garantileri vs Başarısızlık Asgari Garantileri
  * Ders 29: İş Kuralları (BR-XXX): Yerel Numaralandırma ve Nitelikli Çapraz Çağrılar
  * Ders 30: Büyük Örnek: 'Borrow Book' Şartnamesinin Satır Satır Otopsisi
* **Bölüm 6: Senaryolar ve Alternatif Akışlar Yazma Sanatı** (Ders 31-36)
  * Ders 31: Bir Adımın Anatomisi: Özne-Yüklem-Nesne, Kuşbakışı Bakış & 'Top Kimde?' Kuralı
  * Ders 32: 'Validates' vs 'Checks Whether': Ana Akışta Başarıyı Mühürleme Sanatı
  * Ders 33: Niyet vs Mekanik: Tıklamaları Değil İradeyi Paketlemek
  * Ders 34: Alternatif Akışları Bulmak: Cockburn'ün 3 Turlu Beyin Fırtınası
  * Ders 35: Alternatif Akış Yazımı: Adıma Çapalanmış Tetikleyici ve Kesin Bitiş
  * Ders 36: Kapalı Döngü Şartname Ritmi: Boşta Kalan İplik Bırakmamak
* **Bölüm 7: Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?** (Ders 37-42)
  * Ders 37: Hassasiyet Paradoksu: Gözlemlenebilir Davranış vs Mekanizma Detayı
  * Ders 38: Zone 1 (Gözlemlenebilir Davranış): Somut Arayüz Yapısı, Kolonlar ve İş Miktarları
  * Ders 39: Zone 2 (Alan Modeli): Referans Ver, Asla Tekrarlama (entity_model.md)
  * Ders 40: Zone 3 (Mekanizma - YASAK!): Kara Liste (JWT, SQL, bcrypt, Regex, SMTP)
  * Ders 41: UI Tasarımcısı Nereye Gitti? Üçlü Sorumluluk Bölünmesi
  * Ders 42: 3 Soruluk Revizyon Filtresi: Şartnameyi Yeniden Üretilebilirliğe Karşı Denetleme
* **Bölüm 8: Dilimler (Slices), Testler ve İterasyon Döngüsü** (Ders 43-48)
  * Ders 43: 10. İlke: Sistemi Dilimlerle İnşa Etmek (Use-Case Slices)
  * Ders 44: Dilimleme Hiyerarşisi: Önce Temel Akış, Sonra Alternatifler (Bazıları Asla Yapılmaz!)
  * Ders 45: 14. İlke: Gerçeği Testler Taşır (AIUP Test Piramidi)
  * Ders 46: Test Senaryoları (TC-XXX): Use Case'leri Birbirine Bağlayan Uçtan Uca Yolculuklar
  * Ders 47: Test Verisi Disiplini: Somut Veri ('Acme Corp', '5') vs Ölümcül Yer Tutucular
  * Ders 48: İterasyon Döngüsü ve BPMN Süreçlerinden Test Yolculuğu Türetme
* **Bölüm 9: Değişiklik Talepleri, Hatalar (Bugs) ve Mevcut (Brownfield) Sistemler** (Ders 49-54)
  * Ders 49: 15. İlke: Tüm İşler Bir Use Case Değişikliğidir (Özellik, Değişiklik, Hata)
  * Ders 50: İmza Testi (Sign-Off Test): Hata (Bug) ile Geliştirme (Enhancement) Ayrımı
  * Ders 51: Tek Bir Döngü, Özel Komut Yok: Neden /bug Komutu Bulunmaz?
  * Ders 52: Mevcut Sistemleri Kurtarma (Brownfield): Kodu Değil, Niyeti Kurtarın!
  * Ders 53: Uç Noktaları Birleştirme: 40 REST Endpoint'ini 4-8 Use Case'e İndirgeme
  * Ders 54: Taban Çizgisi İncelemesi (Baseline Review): SE ve RE Ortak Eşleşmesi
* **Bölüm 10: Kontrol Listeleri, Yaygın Hatalar ve MAANG Mimar Seviyesi Ustalık** (Ders 55-60)
  * Ders 55: 24 Maddelik Şartname Kontrol Listesi: Reviewed ve Approved Eşiği
  * Ders 56: En Yaygın 10 Hata: 5 Klasik Tuzak vs 5 AI Çağı Felaketi
  * Ders 57: Masaüstü Adım Yazma Kartı (Step-Writing Desk Card): Bölünmüş Ekranda Hızlı Rehber
  * Ders 58: MAANG Sistem Tasarımı Mülakatı: Yüksek Seviye Mimariden AIUP Şartnamesine
  * Ders 59: Otonom Çoklu Ajan (Multi-Agent) İş Akışları ve Şartname Tabanlı Kod Üretimi
  * Ders 60: Staff+ Seviye Gereksinim Mimarlığı: Yönetişim, İzlenebilirlik ve AIUP Çağı

---

## 📦 Yayınlanan PDF Kütüphanesi (71 PDF)

Tüm dokümanlar modern **Typst 0.15** dizgi motoru ile basılmış, çift dilli sütunlar, ASCII diyagramlar ve şık Cyber-Teal kapaklarla donatılmıştır:

* 📖 **Master Unified Mega-Book:** [`output/book/Writing_Use_Cases_for_AI_ELI5.pdf`](output/book/Writing_Use_Cases_for_AI_ELI5.pdf) (Tüm 60 Ders Tek Ciltte, 3.0 MB)
* 📦 **10 Bölüm Paketleri:** `output/modules/module_01.pdf` ... `output/modules/module_10.pdf`
* 📄 **60 Tekil Ders PDF'leri:** `output/individual/lesson_01.pdf` ... `output/individual/lesson_60.pdf`

---

## 🌐 Web Companion Reader (İnteraktif Web Okuyucu)

Geliştiricilerin müfredatı çevrimdışı veya tarayıcı üzerinden kolayca okuyabilmesi için modern bir Single Page Application (SPA) sunulmuştur:
* **Canlı Arama:** Ders başlıklarında, ELI5 analojilerinde ve teknik terimlerde (Örn: *Zone 3, Slices, Brownfield*) anlık filtreleme.
* **Dil Seçici:** 🌐 İkisi (Yan Yana Çift Dilli), 🇹🇷 Sadece Türkçe, 🇬🇧 Only English.
* **PDF İndirme Modalı:** 71 PDF dosyasını tek tıkla açma ve indirme.
* **Kopyalama Araçları:** ASCII şemalarını ve Java 25 kod bloklarını tek tuşla panoya kopyalama.

Yerel olarak çalıştırmak için:
```bash
python3 -m http.server 4598
# Tarayıcıda açın: http://localhost:4598/web/index.html
```

---

## ☕ Çalıştırılabilir Java 25 Örnekleri

Kitaptaki mimari ilkeleri doğrudan test etmek için `examples/` klasöründe 4 adet çalıştırılabilir Java 25 referans kodu hazırlanmıştır:

1. **`BorrowBookUseCase.java`:** Clean Architecture Use Case Interactor, Record Request/Response ve Port Soyutlamaları.
2. **`BusinessRuleEngine.java`:** BR-004, BR-005, BR-006 yerel kural motoru ve Result monadı.
3. **`UseCaseSliceTest.java`:** 10. ve 14. İlkeleri doğrulayan Dilimleme (Slice 1, Slice 2) test koşucusu.
4. **`SpecDrivenAgentHarness.java`:** Zone 3 kara listesini denetleyen deterministik `/spec-review` linter motoru.

Tüm örnekleri çalıştırmak için:
```bash
java examples/com/maang/aiup/usecase/BorrowBookUseCase.java
java examples/com/maang/aiup/rules/BusinessRuleEngine.java
java -ea examples/com/maang/aiup/slices/UseCaseSliceTest.java
java -ea examples/com/maang/aiup/agent/SpecDrivenAgentHarness.java
```

---

## 🛠️ Kurulum ve Derleme (Build & Compile)

### Gereksinimler
* Python 3.10+
* [Typst](https://typst.app) 0.15+ (`brew install typst`)
* OpenJDK 25 LTS

### Tüm PDF'leri Baştan Derleme
```bash
python3 build_all.py --all
```

---

## 📜 Lisans & Kaynakça
* Kaynak Kitap: Simon Martinelli, *"Writing Use Cases for AI: How to write use cases for stakeholders, engineers, and AI agents"* (Leanpub & Apress, 2026).
* Temel Metodolojiler: Ivar Jacobson (Use-Case 3.0, 2024), Alistair Cockburn (*Writing Effective Use Cases*, 2001).
* Hazırlayan: Antigravity AI Unified Process Guild.
