#import "/template.typ": *

#show: doc => setup_book(title: "Ders 8: Lafı Harfi Harfine Anlayan Okuyucu: AI Neden Bir Boşluğu Asla Doldurmadan Bırakamaz?", doc)

#lesson_header(
  8,
  "Lafı Harfi Harfine Anlayan Okuyucu: AI Neden Bir Boşluğu Asla Doldurmadan Bırakamaz?",
  "The Literal Reader: Why an AI Cannot Leave a Gap Unfilled",
  "Üç Okuyucu Modeli & Yapay Zekâ Çağının 5 Temel İlkesi",
  "The Three Readers & The 5 AI-Era Principles"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 BOŞLUK DOLDURMA MEKANİZMASI: İNSAN VS YAPAY ZEKÂ            │
└─────────────────────────────────────────────────────────────────────────────┘
  SENARYO: "Sistem başarısız giriş denemelerini yönetir." (Eksik / Muğlak Kural)

  1. İNSAN MÜHENDİS:
     - Durur, düşünür.
     - "3 deneme mi 5 deneme mi? Kaç dakika kilitlenecek?" diye soru sorar.
     - BİLMEDİĞİNİN FARKINDADIR (Aware of Ignorance).

  2. AI AJANI (LLM / Claude Code / Copilot):
     - Asla durmaz! Boşluğu hemen doldurur!
     - Kendi kafasından uydurur: "5 deneme olsun, 15 dakika kilitlensin, SMS atsın!"
     - TAM ÖZGÜVENLE SUNAR (Confident Hallucination).
     - Sonuç: Müşterinin hiç istemediği uydurma bir özellik artık canlı kodunuzda!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir ressama 'Bana bir oturma odası çiz' deyip koltuğun rengini söylemezsen, ressam durup 'Koltuk ne renk olsun?' diye sorar. Ama yapay zekâ fırçayı eline alır almaz boş gördüğü her yere pembe puantiyeli koltuklar, tavana disko topu ve köşeye bir zürafa çizer! Neden? Çünkü yapay zekâ boş tuval görünce dayanamaz, istatistiksel olarak ne denk gelirse doldurur. Boşluk bırakırsan, o boşluğu senin yerine AI'ın zevkleri doldurur!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Ask an interior designer to draw a living room without specifying the sofa color, and they pause to ask your preference. Generative AI cannot tolerate an empty canvas: it instantly paints neon-leopard sofas, hangs a disco ball, and places a giraffe in the corner with total conviction. AI has no capacity to say 'I notice a gap here, what did you mean?' It completes the statistical distribution. Any intent you omit becomes an invented feature.]
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
      Yapay zekanın olasılıksal doğası (Autoregressive Token Generation) ve niyet boşlukları: LLM'ler bir sonraki en olası token'ı tahmin etmek üzere eğitilmiştir. Bu mimari zorunluluk gereği bir LLM 'Burada bir iş kuralı eksik, durup bekleyeyim' diyemez (bunu ancak harici meta-prompting veya /spec-review gibi deterministik araçlarla sağlayabilirsiniz). Use case içinde bir sınır, sıralama veya hata mesajı belirtilmemişse, model eğitim verisindeki binlerce açık kaynak projeden öğrendiği ortalama davranışı uygular. Örneğin: 'Kullanıcı şifresini unuttuysa sistem şifreyi sıfırlar.' AI burada parola sıfırlama linkinin süresini 24 saat mi yapacak, 15 dakika mı? Tek kullanımlık token mı üretecek? Eğer şartname 'BR-021: Parola sıfırlama token'ı 15 dakika geçerlidir' demezse, AI her kod üretiminde farklı bir süre uydurur. Yeniden üretilebilirlik (reproducibility) yok olur.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Autoregressive generation dynamics and the impossibility of omission: LLMs are mathematical prediction engines optimized to generate plausible continuations. By structural design, an LLM cannot autonomously halt on a requirements vacuum and say 'The author omitted a timeout parameter; I shall suspend output.' Instead, it samples from its latent training distribution, selecting standard web defaults. If a use case states 'System blocks abusive IPs', the model will arbitrarily invent an arbitrary threshold (e.g. 10 requests per minute vs 100). The downstream consequence is devastating: the system exhibits behavioral drift across regenerations because implicit rules fluctuate with each prompt run.]
    ]
  )
]

#java25_box[
```java
// Java 25: AI Boşluklarını Kapatan Tip Güvenli ve Parametrik Güvenlik Kuralı
package com.maang.aiup.literal;

import java.time.Duration;

public class LoginPolicyEngine {
    // Şartnameden birebir gelen ve AI'a hiçbir uydurma payı bırakmayan kural record'u
    public record LockoutPolicy(
        int maxFailedAttempts,        // BR-008: Kesin sayı (örn: 3)
        Duration lockoutDuration,      // BR-008: Kesin süre (örn: 15 dakika)
        boolean notifyAdminByEmail    // BR-009: Kesin bayrak
    ) {}

    public static final LockoutPolicy PRODUCTION_POLICY = 
        new LockoutPolicy(3, Duration.ofMinutes(15), true);

    public record LoginAttemptResult(boolean allowed, String statusMessage) {}

    public static LoginAttemptResult evaluate(int consecutiveFails, LockoutPolicy policy) {
        if (consecutiveFails >= policy.maxFailedAttempts()) {
            return new LoginAttemptResult(false, 
                "BR-008: Hesap " + policy.lockoutDuration().toMinutes() + " dakika süreyle kilitlendi.");
        }
        return new LoginAttemptResult(true, "Giriş denemesi geçerli.");
    }

    void main() {
        var result = evaluate(3, PRODUCTION_POLICY);
        System.out.println("Deterministik sonuç: " + result);
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
      Bir use case yazarken 'vb.', 've benzeri', 'gerekirse', 'uygun şekilde' kelimelerini kullanmak, yapay zekaya açık çek vermektir. Bu kelimeleri gördüğünüz yerde şartnameyi silip somut sınırları yazın.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Using words like 'etc.', 'and so on', 'as appropriate', or 'if necessary' is writing a blank check to an AI agent. Every ambiguous clause is an architectural decision delegated to an algorithm.]
    ]
  )
]

#takeaways_box((
    ("Yapay zekâ bir boşluğu asla boş bırakamaz; en olası gördüğü varsayımla sessizce doldurur.", "An AI agent cannot leave a gap unfilled; it fills every omission with plausible invention."),
    ("Yazılmayan gereksinim soru olarak dönmez; hatalı üretilmiş bir özellik olarak canlıya sızar.", "Unwritten requirements return as hallucinated features, not polite clarifying questions."),
    ("Tüm limitler, süreler ve hata akışları şartnamede eksiksiz ve somut olarak belirtilmelidir.", "All thresholds, durations, and failure paths must be explicitly bound within the specification."),
))
