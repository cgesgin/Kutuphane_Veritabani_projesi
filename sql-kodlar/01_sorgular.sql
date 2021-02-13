-- Veri tabanı oluşturuldu. Tablolar ve yabancıl anahtar tanımlamaları yapıldı.

--veri tabanı oluşturulmasu
create database db_kutuphane;

-- tablo oluşturulma işlermleri
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

create table tbl_kitap_kutuphane(
	kutuphane_no int not null,
	isbn int not null,
	adet int,
	constraint "tbl_kitap_kutuphane_pk"
	primary key("kutuphane_no","isbn")
);

create table tbl_kitap_yazar(
	isbn int not null,
	yazar_no int not null,
	constraint "tbl_kitap_yazar_pk"
		primary key("isbn","yazar_no")
);


create table tbl_kitap_kategori(
	isbn int not null ,
	kategori_no int not null, 
	constraint "ktp_ktg_pk"
		primary key("isbn","kategori_no")
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


create table tbl_kitaplar(
	isbn int primary key,
	kitap_adi varchar(20),
	yayin_tarihi datetime,
	sayfa_sayisi int	
);

create table tbl_kategoriler(
	kategori_no int identity(1,1) primary key,
	kategori_adi varchar(20)
);


-- yabancıl anahtar tanımlamarı  ve cascade işlemleri

alter table tbl_uyeler add constraint adresler_uyerler_fk
		foreign key (adres_no) references tbl_adresler (adres_no)
		on delete set null
		on update cascade;


alter table tbl_emanet add constraint uyeler_emanet_fk
		foreign key (uye_no) references tbl_uyeler (uye_no)
		on delete cascade
		on update cascade;


alter table tbl_emanet add constraint kutuphane_emanet_fk
		foreign key (kutuphane_no) references tbl_kutuphane (kutuphane_no)
		on delete cascade
		on update cascade;


alter table tbl_kitap_kategori add constraint kategoriler_kitap_kategori_fk
		foreign key (kategori_no) references tbl_kategoriler (kategori_no)
		on delete cascade
		on update cascade;



alter table tbl_kitap_yazar add constraint yazarlar_kitap_yazar_fk
		foreign key (yazar_no) references tbl_yazarlar (yazar_no)
		on delete cascade;


alter table tbl_kitap_kutuphane add constraint kitaplar_kitap_kutuphane_fk
		foreign key (isbn) references tbl_kitaplar (isbn)
		on delete cascade;


alter table tbl_kutuphane add constraint kutuphane_adresler_fk
		foreign key (adres_no) references tbl_adresler (adres_no);


alter table tbl_emanet add constraint emanet_kitaplar_fk
		foreign key (isbn) references tbl_kitaplar (isbn)
		on delete cascade
		on update cascade;
		

alter table tbl_kitap_kategori add constraint kitap_kategori_kitaplar_fk
		foreign key (isbn) references tbl_kitaplar (isbn)
		on delete cascade
		on update cascade;


alter table tbl_kitap_yazar add constraint kitap_yazar_kitaplar_fk
		foreign key (isbn) references tbl_kitaplar (isbn)
		on delete cascade
		on update cascade;

alter table tbl_kitap_kutuphane add constraint kitap_kutuphane_kutuphane_fk
		foreign key (kutuphane_no) references tbl_kutuphane(kutuphane_no)
		on delete cascade;




