-- Veri tabanı oluşturuldu. Tablolar ve yabancıl anahtar tanımlamaları yapıldı.

create database db_library;

create table tbl_uyeler(
	uye_no int identity(1,1) primary key not null,
	uye_adi nvarchar(50) not null ,
	uye_soyadi nvarchar(50)  not null,
	cinsiyet nvarchar(5) ,
	telefon int not null unique,
	e_posta nvarchar(50) unique,
	adres_no int 
);

create table tbl_emanet(
	emanet_no int  identity(1,1) primary key not null,
	isbn int not null,
	uye_no int not null,
	kutuphane_no int not null,
	emanet_tarihi datetime,
	teslim_tarihi datetime,
);

create table tbl_yazarlar(
	yazar_no int identity(1,1) primary key not null,
	yazar_adi varchar(20),
	yazar_soyadi varchar(20)
);

create table tbl_kutuphane(
	kutuphane_no int identity(1,1) primary key not null,
	kutuphane_ismi varchar(20),
	aciklama varchar(20),
	adres_no int
);

create table tbl_kitap_kategori(
	kitap_kategori_id int identity(1,1),
	isbn int not null ,
	kategori_no int not null, 
	constraint "ktp_ktg_pk"
		primary key("kitap_kategori_id","isbn","kategori_no")
);

create table tbl_adresler(
	adres_no int identity(1,1) primary key,
	cadde varchar(20),
	mahalle varchar(20),
	bina_no int,
	sehir varchar(20),
	posta_kodu int,
	ulke varchar(20)	
);


