#import "/template.typ": *

#show: doc => setup_book(title: "Ders 40: Zone 3 (Mekanizma - YASAK!): Kara Liste (JWT, SQL, bcrypt, Regex, SMTP)", doc)

#lesson_header(
  40,
  "Zone 3 (Mekanizma - YASAK!): Kara Liste (JWT, SQL, bcrypt, Regex, SMTP)",
  "Zone 3 (Mechanism - BANNED): The Blocklist (JWT, SQL, bcrypt, Regex, SMTP)",
  "Yapay Zekâ İçin Hassasiyet: Ne Söylenmeli, Ne Dışarıda Bırakılmalı?",
  "Precision for AI — What to Say and What to Leave Out"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 ZONE 3: ŞARTNAMEDE KESİNLİKLE YASAKLI KELİMELER             │
└─────────────────────────────────────────────────────────────────────────────┘
  
  🛑 ŞARTNAME DOĞRULAMA MOTORU TARAFINDAN ENGELLENEN BLOKLİST:
  ┌─────────────────────────────────────────────────────────────────────────┐
  │ SMTP, email server, JWT, token, bcrypt, hash, salt, SHA, SQL, SELECT,   │
  │ INSERT, HTTP verbs (GET, POST), regex patterns, class names, exceptions │
  └─────────────────────────────────────────────────────────────────────────┘
  
  ❌ YASAKLI YAZIM (ZONE 3 MEKANİZMA):      ✅ DOĞRU YAZIM (ZONE 1 İŞ İRADESİ):
  ────────────────────────────────────      ───────────────────────────────────
  "Sistem şifreyi bcrypt ile hash'ler."     "Sistem parolayı güvenli şekilde saklar."
  "Sistem kullanıcıya JWT token verir."     "Sistem kullanıcı oturumunu açar."
  "Sistem reservations tablosuna INSERT     "Sistem rezervasyon kaydını oluşturur."
   sorgusu fırlatır."
  "Sistem SMTP port 587 üzerinden mail atar" "Sistem onay e-postası gönderir."
  "Sistem ValidationException fırlatır."    "Sistem hata mesajı görüntüler."
  
  🎯 NEDEN?: Bugün bcrypt olan yarın argon2 olur! Şartname teknolojiyi değil
             iş hedefini mühürler; teknoloji değişse de şartname hayatta kalır!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Birine mektup gönderirken postacıya 'Mektubu al, dizel motorlu Fiat Doblo marka aracın sağ ön koltuğuna koy, 2. viteste git' demezsiniz! 'Bu mektubu Ankara'daki adrese teslim et' dersiniz. Postacı arabayla mı gider, bisikletle mi gider onun işidir. Zone 3 yasakları, postacının motor markasını use case'e yazmayı yasaklar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[When posting a letter, you never instruct the postal carrier: 'Put this envelope in a diesel Fiat van, drive in second gear, and make 3 right turns.' You simply say: 'Deliver this letter to the address in Ankara.' Whether they drive a truck or pedal a bicycle is their operational choice. Zone 3 forbids specifying the carrier's engine model in your contract.]
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
      Zone 3 Mekanizma Yasağının Mimari Sebepleri: Simon Martinelli'nin AIUP modelinde şartname doğrulama komutları (`/spec-review`) şartnamelerde geçen belirli teknik terimleri katı bir 'Blacklist' (Kara Liste) ile tarar ve bulduğunda build'i kırar. Bu kelimeler şunlardır: SMTP, JWT, bcrypt, hash, salt, SQL, SELECT, INSERT, UPDATE, HTTP verbs (GET/POST), regex, sınıf adları ve exception isimleri. Bu yasağın arkasında iki hayati neden vardır: 1) İnsan ve AI Ayrımı: İnsan yazılımcı kötü bir şartnamede gördüğü saçma bir SQL tüyosunu görmezden gelip doğru mimariyi kurabilir; ancak yapay zekâ şartnamede gördüğü her kelimeyi kanun kabul eder! 'Şifreyi bcrypt ile hash'le' yazdığınızda, yarın Argon2id standardına geçmek istediğinizde şartname kodla çatışır. 2) Yeniden Üretilebilirlik (Regenerability): Şartname kodun ömründen daha uzun yaşayacaksa (İlke 11), şartname bir teknoloji yığınına (Spring Boot, NestJS, .NET Blazor) göbekten bağlanamaz. Şartname iş hedefini belirtir ('parolayı güvenli şekilde saklar'), mekanizma ise stack plugin'inin sorumluluğundadır.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Architectural Rationale for the Zone 3 Blocklist: In the AI Unified Process, `/spec-review` scans use case specifications against a strict lexical blocklist: SMTP, email server, JWT, token, bcrypt, hash, salt, SHA, SQL, SELECT, INSERT, HTTP verbs, regex patterns, class names, exception names. The existence of this blocklist stems from two fundamental realities: 1) Literal AI Execution: Unlike human senior engineers who ignore poor architectural hints in a spec, an LLM adheres slavishly to written text. Specifying 'hash password with bcrypt and salt' prevents the AI from upgrading to Argon2id without spec refactoring. 2) Framework Portability: The specification outlives the implementation (Principle 11). If an organization migrates from Spring Boot to Quarkus, .NET, or Go, a specification free of Zone 3 leaks remains 100% valid and immediately regenerable.]
    ]
  )
]

#java25_box[
```java
// Java 25: Mekanizmanın (Zone 3) İş Mantığından Soyutlanması (Port & Adapter)
package com.maang.aiup.zone3;

public class MechanismDecouplingDemo {
    // 1. ŞARTNAME TANIMI: "Sistem parolayı güvenli şekilde saklar"
    // Mekanizma bir port arayüzünün arkasına gizlenir; use case mekanizmayı bilmez!
    public interface PasswordHasherPort {
        String secureHash(String rawPassword);
    }

    // 2. MEKANİZMA UYGULAMASI (Bugün PBKDF2/Bcrypt, yarın Argon2)
    public static class ModernPasswordHasher implements PasswordHasherPort {
        @Override
        public String secureHash(String rawPassword) {
            // Şartnamede 'Argon2' veya 'bcrypt' adı ASLA anılmaz!
            return "SECURE_HASH::" + rawPassword.hashCode(); 
        }
    }

    public static class UserAccountService {
        private final PasswordHasherPort hasher;

        public UserAccountService(PasswordHasherPort hasher) {
            this.hasher = hasher;
        }

        public void registerUser(String username, String rawPassword) {
            // İş mantığı: Güvenli sakla
            String hashed = hasher.secureHash(rawPassword);
            System.out.println("✅ Kullanıcı '" + username + "' kaydedildi. Güvenli özet oluşturuldu.");
        }
    }

    void main() {
        var service = new UserAccountService(new ModernPasswordHasher());
        service.registerUser("bozkurt", "SuperSecret2026!");
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
      E-posta doğrulama için regex desenini (/^[\w]+\@[\w]+\.[a-z]+\$/) şartnameye kopyalamayın! 'Sistem e-posta formatını doğrular' yazın; regex'i stack plugin'i veya entity model halleder.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never inline regex validation patterns into use case steps. State 'System validates email format'; let the stack plugin or entity model supply the RFC-compliant pattern.]
    ]
  )
]

#takeaways_box((
    ("Kara listedeki kelimeler (JWT, SQL, bcrypt, regex, SMTP) use case içinde KESİNLİKLE yasaktır.", "Blocklist keywords (JWT, SQL, bcrypt, regex, SMTP) are strictly prohibited in use cases."),
    ("Şartname iş hedefini söyler ('güvenli saklar'); teknolojiyi stack plugin'ine bırakır.", "Specifications state business goals ('securely stores'); technical stacks determine mechanisms."),
    ("Mekanizmadan arındırılmış şartnameler, teknoloji yığını değişse bile 10 yıl sonra dahi çalışır.", "Mechanism-free specs survive stack migrations, enabling flawless code regeneration years later."),
))
