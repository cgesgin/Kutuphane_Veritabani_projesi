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
