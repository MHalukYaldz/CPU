## ROM Tabanlı ALU Sonuç Gösterimi

Bu çalışmada, 8-bit bilgisayar tasarımı içerisinde ALU işleminin sonucu Basys 3 FPGA kartı üzerindeki LED’ler kullanılarak görselleştirilmiştir. Test senaryosunda A ve B değerleri program belleği içerisinde sabit olarak tanımlanmış ve işlemci akışı üzerinden ALU’ya aktarılmıştır.

Bu gösterimde amaç, tasarlanan veri yolu, kontrol birimi, register yapısı, program belleği ve ALU arasındaki temel çalışma akışının donanım üzerinde gözlemlenebilmesidir. ALU sonucu doğrudan Basys 3 üzerindeki LED’lere yönlendirilerek işlem sonucunun fiziksel olarak takip edilmesi sağlanmıştır.

Bu uygulama, Brock J. LaMeres’in *Introduction to Logic Circuits & Logic Design with VHDL* kitabında yer alan temel 8-bit bilgisayar projesi referans alınarak geliştirilmiştir.

**Video Bağlantısı:**  
[ROM tabanlı ALU sonuç gösterimi videosu](https://youtube.com/shorts/BRV2C9rPbGI?feature=share)


## Switch Kontrollü ALU Girişleri ve Carry Flag Gösterimi

Bu çalışmada, Basys 3 FPGA kartı üzerindeki switch’ler kullanılarak ALU’nun A ve B giriş değerlerinin donanım üzerinde değiştirilebilmesi sağlanmıştır. Böylece farklı giriş kombinasyonları gerçek zamanlı olarak denenmiş ve ALU sonucunun LED’ler üzerinden gözlemlenmesi mümkün hale getirilmiştir.

Ek olarak, aritmetik işlemler sonucunda oluşan carry flag değeri ayrı bir LED’e yönlendirilmiştir. Bu sayede toplama işlemlerinde oluşan taşıma durumu doğrudan donanım üzerinde takip edilebilmiştir.

Bu gösterim, ROM’da sabit tanımlı değerlerle yapılan ilk testin ardından, tasarımın daha etkileşimli şekilde doğrulanması amacıyla hazırlanmıştır. Switch girişleri ile A ve B operandlarının değiştirilmesi, ALU davranışının farklı veri kombinasyonları altında gözlemlenmesine olanak sağlamıştır.

**Video Bağlantısı:**  
[Switch kontrollü ALU ve carry flag gösterimi videosu](https://youtube.com/shorts/BRV2C9rPbGI?feature=share)

## Sistem Mimarisi
### 8-bit Bilgisayar Sisteminin Genel Yapısı
<img width="708" height="640" alt="Şekil 2-1" src="https://github.com/user-attachments/assets/c45c5d55-4714-4281-b06a-23fe5a28853f" />

*8-bit bilgisayar sisteminin temel blok yapısı verilmiştir. Sistem; CPU, program belleği, veri belleği ve giriş/çıkış portlarından oluşmaktadır.*

### CPU İç Yapısı
<img width="495" height="426" alt="Şekil 2-2" src="https://github.com/user-attachments/assets/8488c18d-cfea-46ba-b2de-44fd62f9f168" />

*CPU’nun kontrol birimi ve veri yolu yapısı gösterilmiştir. Kontrol birimi fetch-decode-execute akışını yönetirken, data path içerisinde registerlar, ALU ve durum bayraklarını tutan CCR yer almaktadır.*
