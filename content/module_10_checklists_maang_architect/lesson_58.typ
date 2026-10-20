#import "/template.typ": *

#show: doc => setup_book(title: "Ders 58: MAANG Sistem Tasarımı Mülakatı: Yüksek Seviye Mimariden AIUP Şartnamesine", doc)

#lesson_header(
  58,
  "MAANG Sistem Tasarımı Mülakatı: Yüksek Seviye Mimariden AIUP Şartnamesine",
  "MAANG System Design Interview: Translating High-Level Architecture into AIUP Specs",
  "Kontrol Listeleri, Yaygın Hatalar ve MAANG Mimar Seviyesi Ustalık",
  "Checklists, Common Mistakes & MAANG Architect Mastery"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                 MAANG SYSTEM DESIGN MÜLAKATINDA AIUP DÖNÜŞÜMÜ                │
└─────────────────────────────────────────────────────────────────────────────┘
  
  MÜLAKAT SORUSU (Meta / Google / Amazon):
  "Bize ölçeklenebilir bir Twitter / X veya Uber rezervasyon sistemi tasarlayın."
  
  GELENEKSEL ADAY (Bocalayan):
  - Hemen beyaz tahtaya 'Redis', 'Kafka', 'Cassandra' kutuları çizer.
  - Hangi aktörlerin ne yaptığını, hangi iş kurallarının olduğunu unutur.
  - Mülakatçı sorar: "Peki bakiye yetersizse ne olacak?" Aday tıkanır!
  
  🌟 MAANG STAFF+ ADAY (AIUP ile Kazanan):
  1. ADIM: Aktörleri ve Deniz Seviyesi Hedefleri Belirler (UC-001, UC-002).
  2. ADIM: Kapsamı In/Out Tablosu ile Netleştirir (Scope Boundary).
  3. ADIM: 3-9 Adımlı Ana Senaryoyu ve Alternatif Akışları (A1, A2) Yazar.
  4. ADIM: Mekanizmayı (Kafka, Redis) Zone 3 olarak şartnameden soyutlar;
           mimaride bu bileşenleri iş kurallarının (BR) altına birer Adapter olarak bağlar!
  
  🎯 MÜLAKATÇININ YORUMU:
  "Bu aday sadece kutu çizmeyi değil; bir sistemi yaşayan, test edilebilir ve
   otonom ekiplerce üretilebilir bir şartname zincirine oturtmayı biliyor!" 
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir inşaat mühendisliği sınavını düşünün: Acemi aday hemen 'Ben 50 tonluk çimento mikseri getireceğim' diye aletleri anlatmaya başlar. Usta mimar ise önce binada kimlerin yaşayacağını, kapıların nereye açılacağını, deprem anında nereye kaçılacağını (Use Case) çizer! Mikser zaten çağrılır. MAANG mülakatında önce hayatı ve kuralları çizmek sizi birinci yapar!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[Think of an architectural board exam: An amateur candidate immediately brags: 'I will order 50 tons of hydraulic concrete mixers!' The master architect first presents the residential floor plan, primary fire escape egress routes, and earthquake load specs (Use Cases). The concrete mixer is just plumbing. In a MAANG interview, framing user-goal invariants first earns the Staff+ offer!]
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
      MAANG Sistem Tasarımı Mülakatlarında AIUP Yaklaşımı: Meta, Amazon, Apple, Netflix ve Google (MAANG) mülakatlarında Staff ve Principal seviyesindeki adaylardan sadece dağınık kutular ve 'Redis cache koyalım' demeleri beklenmez. Mülakatçıların aradığı en kritik yetkinlik 'Sistemik Netlik' (Systemic Clarity) ve 'Sınırları Doğru Çizebilme' (Bounded Contexts) kabiliyetidir. AIUP disiplini adaya şu muazzam avantajları sağlar: 1) Gereksinim Netleştirme: Mülakatın ilk 5 dakikasında aktörleri ve deniz seviyesi hedefleri belirleyip bir In/Out tablosu çizen aday, kontrolü eline alır. 2) Senaryo ve Hata Hakimiyeti: Ana akışı 'validates' kalıbıyla kurup alternatif akışları (stok yetersiz, ödeme zaman aşımı) numaralı adımlara bağlayan aday, mülakatçının en sevdiği 'Peki ya sistem çökerse?' sorularının tamamını önceden yanıtlamış olur. 3) Temiz Mimari Ayrımı: Mekanizmayı (Zone 3: Kafka, DynamoDB) iş kurallarından (Zone 1) ayrı bir katmanda sunarak, sistemin teknoloji bağımsızlığını ve test edilebilirliğini kanıtlar.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[AIUP Strategy in MAANG System Design Interviews: In Staff- and Principal-level design loops at Google, Meta, or Amazon, whiteboarding arbitrary distributed components (Kafka, Cassandra, Redis) without behavioral boundaries signals architectural immaturity. Interviewers assess an architect's ability to tame ambiguity, define bounded contexts, and enforce operational resilience. Applying the AI Unified Process establishes immediate command of the interview: 1) Scoping with In/Out Lists: The candidate partitions the problem space within 5 minutes, eliminating scope creep. 2) Explicit Behavioral Workflows: Presenting sea-level use cases where each validation is paired with an alternative failure flow demonstrates failure-domain mastery. 3) Strict Separation of Zones: By cleanly isolating business rules (BR-XXX) and observable outcomes (Zone 1) from underlying infrastructure adapters (Zone 3: distributed cache, write-ahead log), the candidate demonstrates clean architectural rigor.]
    ]
  )
]

#java25_box[
```java
// Java 25: MAANG Seviyesi Ölçeklenebilir Sistem Tasarımı Use Case Mimarisi
package com.maang.aiup.maangdesign;

import java.util.concurrent.CompletableFuture;

public class MaangSystemDesignDemo {
    // 1. USE CASE MODELİ (Teknoloji bağımsız iş mantığı)
    public record RideRequest(String riderId, double pickupLat, double pickupLon) {}
    public record RideMatched(String rideId, String driverId, double estimatedFare) {}

    public interface DriverMatchingPort {
        CompletableFuture<String> matchNearestDriver(double lat, double lon);
    }

    public static class RequestRideUseCase {
        private final DriverMatchingPort matchingPort;

        public RequestRideUseCase(DriverMatchingPort matchingPort) {
            this.matchingPort = matchingPort;
        }

        public CompletableFuture<RideMatched> requestRide(RideRequest request) {
            // Şartname Kuralı: En yakın sürücüyü bul, eşleşirse başarı döndür
            return matchingPort.matchNearestDriver(request.pickupLat(), request.pickupLon())
                .thenApply(driverId -> new RideMatched("RIDE-101", driverId, 45.50));
        }
    }

    void main() {
        DriverMatchingPort mockKafkaPort = (lat, lon) -> CompletableFuture.completedFuture("DRIVER-ALICE");
        var useCase = new RequestRideUseCase(mockKafkaPort);

        useCase.requestRide(new RideRequest("RIDER-1", 41.0, 29.0))
            .thenAccept(res -> System.out.println("✅ MAANG Mülakat Mimarisi Çalıştı: " + res));
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
      Sistem tasarımı mülakatında hemen veritabanı şeması veya Kafka topic'i çizmeye başlamayın; önce aktörleri, hedefleri ve In/Out kapsamını netleştirin.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Do not dive straight into Kafka partitions or database schemas during a system design interview. Pin down actors, user goals, and the In/Out boundary first.]
    ]
  )
]

#takeaways_box((
    ("MAANG mülakatlarında kutu çizmeden önce aktörler, hedefler ve In/Out listesi sunulur.", "Present actors, user goals, and an In/Out boundary before drawing architecture boxes."),
    ("Ana akış ve alternatif akış disiplini, mülakatçının 'Peki ya hata olursa?' sorularını peşinen çözer.", "Scenario and alternative flow discipline preemptively resolves failure-mode questions."),
    ("Zone 1 iş mantığını Zone 3 altyapısından ayırmak adayı Staff+ mimar seviyesine taşır.", "Decoupling Zone 1 business invariants from Zone 3 plumbing signals Staff+ design maturity."),
))
