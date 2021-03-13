# Kütüphane Veri tabanı

* Proje : Kütüphane veri tabanının modellenmesi
* Kullanılan veri tabanı [Microsof SQL SERVER 2019](https://www.microsoft.com/tr-tr/sql-server/sql-server-downloads) ' dir
* E-R Diyagram Çizimi için [Umlet](https://www.umlet.com/) kullanılmıştır.

# Veri tabanı yapısı ve özellikleri

 Veri tabanı birden fazla kütüphane, kütphanelerin içerdiği kitaplar ve üyeler temeline dayanmaktadır.


| Tablolar     | İşlevi        |
| -------------| ------------- |
|ÜYELER	|Kütüphaneye kayıt olan kişilerin bilgilerini tutar.
|EMANET|Üyelerin emanet aldığı ve nereden aldığı gibi verileri tutar.
|YAZARLAR	|Yazarlarla ilgili verileri tutar.
|KÜTÜPHANE|Kütüphane adı da dahil olmak üzere ilgili verileri tutar.
|KİTAP_KÜTÜPHANE	|kitap ve kütüphane arasındaki ilişkileri tutar.
|KİTAP_YAZAR	|Kitapların hangi yazarın yazdığı bilgileri tutar.
|KİTAP_KATEGORİ	|Kitapların hangi kategoriye girdikleri verileri tutar.
|ADRESLER	|Adres bilgilerini tutar.
|KİTAPLAR|Kitaplar ile ilgili verileri tutar.
|KATEGORİLER	|Kategori türlerini tutar.


### E-R Diyagram

---

![](https://github.com/cgesgin/SQL-Kutuphane_Veritabani_projesi/blob/main/E-R%20Diyagram/K%C3%BCt%C3%BCphane_veritaban%C4%B1_E_R_Diyagram.png)

---
### Veri tabanında bulunan nesneler

*	10 adet Tablo
*	1 adet view
*	1 adet stored procedure
*	1 adet trigger
*	1 adet fonksiyon
