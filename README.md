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

### CPU İç Yapısı ve Fetch–Decode–Execute Akışı
<img width="495" height="426" alt="Şekil 2-2" src="https://github.com/user-attachments/assets/bda3906f-c515-4cf8-8db0-35c2e9e528e7" />

*CPU’nun iç yapısı gösterilmiştir. CPU, Control Unit ve Data Path olmak üzere iki ana bölümden oluşmaktadır. Control Unit, fetch-decode-execute akışını yöneten sonlu durum makinesi yapısındadır. Data Path içerisinde IR, MAR, PC, A ve B registerları, ALU ve CCR bloğu bulunmaktadır. Control Unit, Data Path’e kontrol sinyalleri gönderirken, Data Path içerisindeki durum bilgileri Control Unit’e status sinyalleri olarak geri dönmektedir.*
Bu çalışmada Control Unit, komutların sırasıyla alınması, çözülmesi ve çalıştırılması için gerekli kontrol sinyallerini üretmektedir. Data Path ise register transferleri, ALU işlemleri ve bellek adresleme işlemlerini gerçekleştirmektedir.

### CPU ve Memory-Mapped Memory System Bağlantısı
<img width="950" height="623" alt="Şekil 2-4" src="https://github.com/user-attachments/assets/10ba66c4-cf0a-4768-913a-1368ae40d35e" />

*CPU ile memory-mapped Memory System arasındaki bağlantı gösterilmiştir. CPU, Memory System’e address, data ve control hatları üzerinden erişmektedir. Memory System içerisinde Program Memory, Data Memory ve Input/Output Ports blokları yer almaktadır. Bu yapı sayesinde bellek ve giriş/çıkış birimleri aynı adres uzayı üzerinden kontrol edilmektedir.*
Bu tasarımda output portlara erişim memory-mapped olarak gerçekleştirilmiştir. Bu nedenle belirli adreslere yapılan yazma işlemleri doğrudan ilgili output portların güncellenmesini sağlamaktadır.

### Memory Map Yapısı
<img width="339" height="637" alt="Şekil 2-5" src="https://github.com/user-attachments/assets/c9d0e624-c585-46a8-82a4-cac8286c304d" />

*8-bit adres alanına sahip sistemin memory map yapısı verilmiştir. x"00"–x"7F" adres aralığı Program Memory için, x"80"–x"DF" adres aralığı Data Memory için, x"E0"–x"EF" adres aralığı output portlar için ve x"F0"–x"FF" adres aralığı input portlar için ayrılmıştır.*
Bu adresleme yapısına göre x"E0" adresi port_out_0 çıkışına karşılık gelmektedir. Bu nedenle test programında A register’daki sonuç x"E0" adresine yazıldığında port_out_0 üzerinde gözlemlenmektedir.

### VHDL Sistem Gerçeklemesi
<img width="815" height="782" alt="Şekil 4-1" src="https://github.com/user-attachments/assets/efc44b6e-a36f-470a-83de-ec06433ad165" />

*Top-level computer modülünün VHDL seviyesindeki blok yapısı verilmiştir. Bu yapıda CPU ve Memory System modülleri aynı üst modül içerisinde birbirine bağlanmaktadır. CPU’dan çıkan address, write ve to_memory sinyalleri Memory System’e iletilirken, Memory System’den gelen from_memory sinyali CPU’ya geri dönmektedir. Input portlar Memory System’e giriş olarak bağlanırken, output portlar sistem çıkışı olarak dışarıya verilmektedir.*
Bu çalışmada COMPUTER modülü, CPU ile Memory System arasındaki veri, adres ve kontrol bağlantılarını sağlayan üst seviye modül olarak tasarlanmıştır.

### Memory System İç Yapısı
<img width="960" height="789" alt="Şekil 4-3" src="https://github.com/user-attachments/assets/e6f0740f-f519-47f8-b79e-9c592a4e1e74" />

*Memory System modülünün iç yapısı gösterilmiştir. Memory System içerisinde Program Memory, Data Memory, Output Ports ve Input Ports blokları yer almaktadır. CPU’dan gelen address sinyali tüm bellek ve port bloklarına iletilmektedir. data_in ve write sinyalleri Data Memory ve Output Ports bloklarında yazma işlemi için kullanılmaktadır. data_out hattı ise seçilen bellek veya input port verisini CPU’ya geri taşımaktadır.*
Output Ports bloğunda x"E0"–x"EF" adres aralığı 16 adet 8-bit output port için ayrılmıştır. Test programında x"E0" adresine yazma yapıldığında port_out_0 çıkışı güncellenmektedir.

### CPU Data Path ve Control Unit Bağlantısı
<img width="658" height="722" alt="Şekil 4-4" src="https://github.com/user-attachments/assets/bfc886ae-d832-4dab-b29a-7f6fe78df698" />

*CPU içerisindeki Control Unit ve Data Path bağlantısı gösterilmiştir. Control Unit, IR_Load, MAR_Load, PC_Load, PC_Inc, A_Load, B_Load, ALU_Sel, Bus1_Sel, Bus2_Sel, CCR_Load ve write gibi kontrol sinyallerini üretmektedir. Data Path içerisinde IR, MAR, PC, A ve B registerları, ALU, CCR ve veri yolları bulunmaktadır. CPU’nun address çıkışı MAR üzerinden, to_memory çıkışı ise Bus1 üzerinden oluşturulmaktadır.*
Bu yapıda komutlar önce Program Memory’den okunarak IR register’a yüklenir. Ardından Control Unit, IR içerisindeki opcode değerine göre uygun state geçişlerini ve kontrol sinyallerini üretir. ALU işlemleri sonucunda oluşan NZVC bayrakları CCR register’da tutulur ve gerektiğinde branch komutlarında kullanılır.



