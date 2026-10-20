#import "/template.typ": *

#show: doc => setup_book(title: "Ders 13: Aktörü Doğru Tanımlamak: Rol Odaklılık, Birincil Aktörler & İkincil Destekleyici Sistemler", doc)

#lesson_header(
  13,
  "Aktörü Doğru Tanımlamak: Rol Odaklılık, Birincil Aktörler & İkincil Destekleyici Sistemler",
  "Defining the Actor: Roles, Primary Actors & Supporting Systems",
  "Temel Esaslar: Aktörler, Deniz Seviyesi Hedefler & Paydaş Sözleşmeleri",
  "Core Fundamentals: Actors, Sea-Level Goals & Contracts"
)

#diagram_box[
```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                    AKTÖR TÜRLERİ VE SİSTEM ETKİLEŞİM MODELİ                 │
└─────────────────────────────────────────────────────────────────────────────┘
  BİRİNCİL AKTÖR (PRIMARY ACTOR):
  [ Üye / Müşteri / Kütüphaneci ] ──▶ Hedefi başlatır, sonucu bekler!
                                      (Güvenlik rolü ve erişim yetkisi olur)

  SİSTEM (SYSTEM UNDER DESIGN):
  ┌─────────────────────────────────────────────────────────────────────────┐
  │                           KÜTÜPHANE SİSTEMİ                             │
  │  - Kullanıcı isteğini alır                                              │
  │  - İş kurallarını doğrular (BR-XXX)                                     │
  │  - Durum değiştirir                                                     │
  └───────────────────────────────────┬─────────────────────────────────────┘
                                      │
  İKİNCİL / DESTEKLEYİCİ AKTÖRLER:   │ (Sistemin dışarıdan yardım aldığı aktörler)
  ├──▶ [ Ödeme Ağ Geçidi (Stripe) ] ──┘  * Use case'i başlatmazlar!
  └──▶ [ E-posta / SMS Bildirim Servisi ]* Sürece sonradan dahil olurlar!
```
]

#eli5_box[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(weight: "bold", fill: rgb("1e40af"), size: 9pt)[🇹🇷 TÜRKÇE (ELI5)]\
      #v(3pt)
      Bir film çekimini düşünün: Birincil aktör filmin başrol oyuncusudur (Örn: James Bond). Olayları o başlatır, bombayı o imha eder, alkışı o toplar. İkincil aktör ise Bond'a telsizden bilgi veren veya arabasını getiren figüranlardır (Q veya araba kiralama şirketi). Eğer senaryoda başrolü arabayı kiralayan şirkete verirsen film saçma sapan bir hale gelir! Birincil aktör daima hedefin peşinden koşan kişidir!
    ],
    [
      #text(weight: "bold", fill: rgb("1d4ed8"), size: 9pt)[🇬🇧 ENGLISH (ELI5)]\
      #v(3pt)
      #text(fill: rgb("334155"))[In a spy thriller, the Primary Actor is James Bond. He initiates the mission, pursues the objective, and claims the victory. The Secondary Actors are the quartermaster (Q) who equips him with gadgets and the satellite network that relays coordinates. If you write the script from the perspective of the satellite instead of the secret agent, the narrative collapses into incoherence.]
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
      Aktör Tanımlamasının AIUP ve MAANG Mimarilerindeki Kritik Rolü: 1) İsim Değil Rol: Bir aktör asla 'Ahmet Bey' veya 'Muhasebe Departmanı' gibi kişisel veya departman bazlı tanımlanamaz; 'Üye' (Member), 'Kütüphaneci' (Librarian) gibi soyut roller olmalıdır. Çünkü bu roller doğrudan sistemin Güvenlik Modeline (RBAC - Role-Based Access Control) ve Spring Security rollerine dönüşür. AI kod üretirken `\@PreAuthorize("hasRole('MEMBER')")` annotasyonunu bu aktör tanımına göre koyar. 2) Birincil Aktör (Primary Actor): Senaryoyu tetikleyen ve use case'in hedefine ulaşmasından doğrudan fayda sağlayan aktördür. 3) İkincil / Destekleyici Aktörler (Secondary Actors): Senaryoyu başlatmazlar; sistem hedefe yürürken onların bir servisine ihtiyaç duyar (Ödeme Gateway'i, Fraud Kontrol Servisi vb.). Use case şablonunda 'Secondary Actors: Payment Gateway, Email Service' olarak açıkça listelenmelidir; aksi halde AI bu entegrasyonları mock'lamaz veya bağımlılıkları bağlamayı unutur.
    ],
    [
      #text(weight: "bold", fill: rgb("0f766e"), size: 9pt)[🇬🇧 AIUP & MAANG TECHNICAL DEEP-DIVE]\
      #v(3pt)
      #text(fill: rgb("334155"))[Actor semantics in enterprise systems: 1) Roles over Individuals: An actor must represent a systemic role ('Member', 'Underwriter'), never a persona or organizational hierarchy. This designation directly synthesizes the application's authorization boundary: an AI agent translates primary actor metadata into role-based security guards (`\@PreAuthorize`, JWT claims, and integration test credentials). 2) Primary Actor: Initiates the use case to satisfy a measurable goal. 3) Secondary / Supporting Actors: External systems or back-office actors enlisted by the system to complete sub-operations (e.g. Stripe, SendGrid, Fraud Detection APIs). Explicitly declaring secondary actors ensures downstream AI engines generate appropriate outbound ports and client interfaces within a Hexagonal architecture.]
    ]
  )
]

#java25_box[
```java
// Java 25: Aktör Rollerini Güvenlik ve Yetkilendirme Modeline Dönüştürme
package com.maang.aiup.actors;

public class ActorSecurityModel {
    // Şartnamede tanımlanan roller doğrudan Java 25 Enum/Record ile modellenir
    public enum SystemRole {
        MEMBER, LIBRARIAN, SYSTEM_ADMIN
    }

    public record SecurityContext(String userId, SystemRole role) {
        public void requireRole(SystemRole requiredRole) {
            if (this.role != requiredRole) {
                throw new SecurityException("Erişim reddedildi: Bu işlem için " + requiredRole + " rolü zorunludur.");
            }
        }
    }

    // Birincil Aktör: Member
    public static void borrowBook(SecurityContext context, String bookId) {
        context.requireRole(SystemRole.MEMBER);
        System.out.println("Üye yetkisi doğrulandı, işlem başlıyor: " + bookId);
    }

    void main() {
        var memberCtx = new SecurityContext("user-42", SystemRole.MEMBER);
        borrowBook(memberCtx, "BOOK-1984");
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
      Sistemin kendisini asla birincil aktör yapmayın! 'Zamanlanmış Görev (Cron)' veya 'Gece Batch İşlemi' gibi durumlarda aktör 'Sistem' değil, 'Zamanlayıcı Servisi' (Time / Scheduler) olmalıdır.
    ],
    [
      #text(weight: "bold", fill: rgb("be123c"), size: 9pt)[🇬🇧 INTERVIEW TRAP & AI HALLUCINATION]\
      #v(3pt)
      #text(fill: rgb("881337"))[Never designate the system itself as the primary actor. For automated background jobs, the primary actor is 'Time' or the 'Scheduler', which triggers the use case at a designated temporal threshold.]
    ]
  )
]

#takeaways_box((
    ("Aktör bir kişi veya departman değil, bir roldür; bu rol doğrudan güvenlik modelini besler.", "An actor is a role, not a person or department; it directly feeds the security model."),
    ("Birincil aktör hedefi başlatır ve faydayı alır; ikincil aktör ise sisteme destek verir.", "Primary actors pursue goals; secondary actors are external entities enlisted for support."),
    ("İkincil aktörleri açıkça listelemek, AI'ın dış servis entegrasyonlarını doğru modellemesini sağlar.", "Listing secondary actors forces AI to generate clean outbound API client boundaries."),
))
