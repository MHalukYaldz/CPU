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

8-bit bilgisayar sisteminin temel blok yapısı verilmiştir. Sistem; CPU, program belleği, veri belleği ve giriş/çıkış portlarından oluşmaktadır.

### CPU İç Yapısı ve Fetch–Decode–Execute Akışı
<img width="495" height="426" alt="Şekil 2-2" src="https://github.com/user-attachments/assets/bda3906f-c515-4cf8-8db0-35c2e9e528e7" />

CPU’nun iç yapısı gösterilmiştir. CPU, Control Unit ve Data Path olmak üzere iki ana bölümden oluşmaktadır. Control Unit, fetch-decode-execute akışını yöneten sonlu durum makinesi yapısındadır. Data Path içerisinde IR, MAR, PC, A ve B registerları, ALU ve CCR bloğu bulunmaktadır. Control Unit, Data Path’e kontrol sinyalleri gönderirken, Data Path içerisindeki durum bilgileri Control Unit’e status sinyalleri olarak geri dönmektedir.

Bu çalışmada Control Unit, komutların sırasıyla alınması, çözülmesi ve çalıştırılması için gerekli kontrol sinyallerini üretmektedir. Data Path ise register transferleri, ALU işlemleri ve bellek adresleme işlemlerini gerçekleştirmektedir.

### CPU ve Memory-Mapped Memory System Bağlantısı
<img width="950" height="623" alt="Şekil 2-4" src="https://github.com/user-attachments/assets/10ba66c4-cf0a-4768-913a-1368ae40d35e" />

CPU ile memory-mapped Memory System arasındaki bağlantı gösterilmiştir. CPU, Memory System’e address, data ve control hatları üzerinden erişmektedir. Memory System içerisinde Program Memory, Data Memory ve Input/Output Ports blokları yer almaktadır. Bu yapı sayesinde bellek ve giriş/çıkış birimleri aynı adres uzayı üzerinden kontrol edilmektedir.

Bu tasarımda output portlara erişim memory-mapped olarak gerçekleştirilmiştir. Bu nedenle belirli adreslere yapılan yazma işlemleri doğrudan ilgili output portların güncellenmesini sağlamaktadır.

### Memory Map Yapısı
<img width="339" height="637" alt="Şekil 2-5" src="https://github.com/user-attachments/assets/c9d0e624-c585-46a8-82a4-cac8286c304d" />

8-bit adres alanına sahip sistemin memory map yapısı verilmiştir. x"00"–x"7F" adres aralığı Program Memory için, x"80"–x"DF" adres aralığı Data Memory için, x"E0"–x"EF" adres aralığı output portlar için ve x"F0"–x"FF" adres aralığı input portlar için ayrılmıştır.

Bu adresleme yapısına göre x"E0" adresi port_out_0 çıkışına karşılık gelmektedir. Bu nedenle test programında A register’daki sonuç x"E0" adresine yazıldığında port_out_0 üzerinde gözlemlenmektedir.

### VHDL Sistem Gerçeklemesi
<img width="815" height="782" alt="Şekil 4-1" src="https://github.com/user-attachments/assets/efc44b6e-a36f-470a-83de-ec06433ad165" />

Top-level computer modülünün VHDL seviyesindeki blok yapısı verilmiştir. Bu yapıda CPU ve Memory System modülleri aynı üst modül içerisinde birbirine bağlanmaktadır. CPU’dan çıkan address, write ve to_memory sinyalleri Memory System’e iletilirken, Memory System’den gelen from_memory sinyali CPU’ya geri dönmektedir. Input portlar Memory System’e giriş olarak bağlanırken, output portlar sistem çıkışı olarak dışarıya verilmektedir.

Bu çalışmada COMPUTER modülü, CPU ile Memory System arasındaki veri, adres ve kontrol bağlantılarını sağlayan üst seviye modül olarak tasarlanmıştır.

### Memory System İç Yapısı
<img width="960" height="789" alt="Şekil 4-3" src="https://github.com/user-attachments/assets/e6f0740f-f519-47f8-b79e-9c592a4e1e74" />

Memory System modülünün iç yapısı gösterilmiştir. Memory System içerisinde Program Memory, Data Memory, Output Ports ve Input Ports blokları yer almaktadır. CPU’dan gelen address sinyali tüm bellek ve port bloklarına iletilmektedir. data_in ve write sinyalleri Data Memory ve Output Ports bloklarında yazma işlemi için kullanılmaktadır. data_out hattı ise seçilen bellek veya input port verisini CPU’ya geri taşımaktadır.

Output Ports bloğunda x"E0"–x"EF" adres aralığı 16 adet 8-bit output port için ayrılmıştır. Test programında x"E0" adresine yazma yapıldığında port_out_0 çıkışı güncellenmektedir.

### CPU Data Path ve Control Unit Bağlantısı
<img width="658" height="722" alt="Şekil 4-4" src="https://github.com/user-attachments/assets/bfc886ae-d832-4dab-b29a-7f6fe78df698" />

CPU içerisindeki Control Unit ve Data Path bağlantısı gösterilmiştir. Control Unit, IR_Load, MAR_Load, PC_Load, PC_Inc, A_Load, B_Load, ALU_Sel, Bus1_Sel, Bus2_Sel, CCR_Load ve write gibi kontrol sinyallerini üretmektedir. Data Path içerisinde IR, MAR, PC, A ve B registerları, ALU, CCR ve veri yolları bulunmaktadır. CPU’nun address çıkışı MAR üzerinden, to_memory çıkışı ise Bus1 üzerinden oluşturulmaktadır.

Bu yapıda komutlar önce Program Memory’den okunarak IR register’a yüklenir. Ardından Control Unit, IR içerisindeki opcode değerine göre uygun state geçişlerini ve kontrol sinyallerini üretir. ALU işlemleri sonucunda oluşan NZVC bayrakları CCR register’da tutulur ve gerektiğinde branch komutlarında kullanılır.

## Test Programı ve Beklenen Sonuç
### Kullanılan Test Programı
<img width="630" height="261" alt="GITHUB_GÖRSELİ" src="https://github.com/user-attachments/assets/449b6aaa-cfd4-44d6-a6ab-53e9bdeaaeb5" />

Test programında öncelikle A register’a x"A2" değeri, ardından B register’a x"C5" değeri yüklenmiştir. Daha sonra c_AtopB komutu ile A ve B register değerleri toplanmıştır. x"A2" + x"C5" işleminin sonucu x"167" olup, sistem 8-bit genişliğinde çalıştığı için düşük 8-bit sonuç x"67" olarak elde edilmektedir. Sonuç c_A_yaz komutu ile x"E0" adresine yazılmıştır. Memory map yapısına göre x"E0" adresi port_out_0 çıkışına karşılık geldiğinden, simülasyon sonucunda port_out_0 = x"67" olması beklenmektedir.

## Davranışsal Simülasyon Sonuçları
### A Register’a Immediate Veri Yüklenmesi
<img width="1908" height="1029" alt="S_A_yukle_sbt sinyali" src="https://github.com/user-attachments/assets/93fd820a-2c3e-4ab8-ac3f-81eaecfc39bb" />

Program Memory’den c_A_yukle_sbt komutu okunmakta ve ardından x"A2" immediate değeri A register’a yüklenmektedir. Fetch ve decode adımlarından sonra S_A_yukle_sbt_4, S_A_yukle_sbt_5 ve S_A_yukle_sbt_6 durumları sırasıyla çalışmaktadır.

### B Register’a Immediate Veri Yüklenmesi
<img width="1907" height="1029" alt="S_B_yukle_sbt sinyali" src="https://github.com/user-attachments/assets/9e9d7e89-ffe3-452f-abfc-5ebf2e1d1ff1" />

c_B_yukle_sbt komutu ile x"C5" immediate değeri B register’a yüklenmektedir. Bu aşamada işlemci fetch-decode akışından sonra B register yükleme durumlarına geçmektedir.

### A ve B Register Değerlerinin Toplanması
<img width="1910" height="1030" alt="S_AtopB Sinyali_1" src="https://github.com/user-attachments/assets/ff61daa1-55d3-458a-b9a9-b932b9236627" />

c_AtopB komutu çalıştırılmaktadır. A register’daki x"A2" değeri ile B register’daki x"C5" değeri ALU tarafından toplanmakta ve 8-bit sonuç olarak x"67" elde edilmektedir. Sonuç A register’a geri yazılmaktadır. x"42" değeri toplama sonucu değil, c_AtopB komutunun opcode değeridir. Toplama sonucu ALU_Result üzerinde x"67" olarak görülmektedir.

### A Register Değerinin Output Port’a Yazılması
<img width="1907" height="1027" alt="S_A_yaz Sinyali_1" src="https://github.com/user-attachments/assets/4a684f6c-5480-42a0-bb84-b296e359e8e5" />

c_A_yaz komutu ile A register’daki x"67" değeri x"E0" adresine yazılmaktadır. Memory-mapped output yapısında x"E0" adresi port_out_0 çıkışına karşılık geldiği için port_out_0 değeri x"67" olmaktadır.

### Koşulsuz Atlama Komutu ile Program Döngüsü
<img width="1909" height="1027" alt="S_ATLA Sinyali_1" src="https://github.com/user-attachments/assets/dec5b793-490b-4cbf-8eae-69c3e3ffc7ea" />

c_ATLA komutu çalıştırılarak program akışı tekrar başlangıç adresine yönlendirilmektedir. Operand olarak x"00" değeri okunmakta ve PC yeniden x"00" adresine yüklenmektedir.
