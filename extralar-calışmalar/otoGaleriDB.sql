
--sql sorgu çalışmaları

create database db_otogaleri;

create table tbl_arac(
	arac_no int identity(1,1) primary key,
	model varchar(20), 
	marka varchar(20),
	plaka varchar(20),
	fiyat int
);


create table tbl_musteri(
	musteri_no int identity(1,1) primary key,
	ad varchar(20), 
	soyad varchar(20),
	adres varchar(20),
	telefon int
);


create table tbl_satıs(
	satis_no int identity(1,1) primary key,
	musteri_no int, 
	arac_no int,
	satis_tarih datetime,
	fiyat int
);


create table tbl_alım(
	alim_no int identity(1,1) primary key,
	musteri_no int, 
	arac_no int,
	alim_tarih datetime,
	fiyat int
);

alter table tbl_satıs add constraint musteri_satis_fk 
	foreign key (musteri_no) references tbl_musteri(musteri_no);

alter table tbl_satıs add constraint arac_satis_fk 
	foreign key (arac_no) references tbl_arac(arac_no);


alter table tbl_alım add constraint musteri_alım_fk 
	foreign key (musteri_no) references tbl_musteri(musteri_no);

alter table tbl_alım add constraint arac_alım_fk 
	foreign key (arac_no) references tbl_arac(arac_no);

alter table tbl_arac alter column model int ;

alter table tbl_arac  add constraint chk_model  check (model like '[1-9] 9 [0-9] [0-9]');

alter table tbl_arac  add constraint chk_plaka  check ((plaka like '[0-1] [0-1] [A-Z] [A-Z] [0-9][0-9][0-9][0-9]'));

alter table tbl_arac  add constraint chk_plaka2  check ((plaka like '[0-1] [0-1] [A-Z] [A-Z] [0-9][0-9][0-9]')
	OR plaka like ('[0-1] [0-1] [A-Z] [A-Z] [0-9][0-9][0-9][0-9]'));

alter table tbl_satıs alter column fiyat int not null;

alter table tbl_alım alter column fiyat int not null;

alter table tbl_satıs add constraint df_satis_tarihi default '01.01.1900' for satis_tarih;

alter table tbl_alım add constraint df_alim_tarihi default '01.01.1900' for alim_tarih;

insert into tbl_musteri values('turgut','özseven','meram/konya',12345);
insert into tbl_musteri values('mustafa','çağlayan','meram/konya',99345);
insert into tbl_musteri values('ayşe','uçar','taşova/amasya',88345);
insert into tbl_musteri values('elif','kurt','beşiktaş/istanbul',77345);
insert into tbl_musteri values('murat','beyaz','turhal/tokat',66345);
insert into tbl_musteri values('bület','ayar','turhal/tokat',55345);
insert into tbl_musteri values('ahmet','kara','zile/tokat',33345);

ALTER TABLE tbl_arac
DROP CONSTRAINT chk_model;
ALTER TABLE tbl_arac
DROP CONSTRAINT chk_plaka;
ALTER TABLE tbl_arac
DROP CONSTRAINT chk_plaka2;

insert into tbl_arac values(2904,'Fiat','60TT6060',16000);
insert into tbl_arac values(2900,'Renault','60TT6061',14000);
insert into tbl_arac values(2907,'Ford','60TT6062',12000);
insert into tbl_arac values(2905,'Volkswagen','60TT6063',26000);
insert into tbl_arac values(2912,'Opel','60TT6064',17000);


insert into tbl_satıs values(3,26,'04.05.2010',16000);
insert into tbl_satıs values(4,27,'05.06.2010',14000);
insert into tbl_satıs values(9,29,'02.07.2010',26000);

insert into tbl_alım values(3,26,'04.05.2010',16000);
insert into tbl_alım values(4,27,'05.06.2010',14000);
insert into tbl_alım values(9,29,'02.07.2010',26000);


---drop table tbl_satıs;
---drop table tbl_alım;
---drop table tbl_musteri;
---drop table tbl_arac;


select model,marka,fiyat from tbl_arac where model<=2004;
select model,marka,fiyat from tbl_arac where model>=2000 and model<=2900;
select * from tbl_satıs where satis_tarih>'01.05.2010' and fiyat>10000;
select * from tbl_musteri where ad like '%y%' and adres='turhal';
select arac_no,model,plaka,fiyat from tbl_arac where (marka='Fiat' or marka='Opel') and (model>2000);
select * from tbl_musteri order by ad ;
select * from tbl_arac order by model desc ,fiyat asc;
select arac_no,satis_tarih,fiyat as "Satış fiyatı" from tbl_satıs; 
select * from tbl_arac where fiyat>16000 order by fiyat asc;
select * from tbl_satıs where fiyat>10000 or musteri_no=4;
select * from tbl_satıs where satis_tarih>='01.05.2010';
select alim_tarih,fiyat,arac_no from tbl_alım
		where alim_tarih>='02.01.2010' and alim_tarih<='06.01.2010' and fiyat>10000 order by alim_tarih,fiyat asc;
select * from tbl_satıs where fiyat>=10000 and fiyat<=20000 and musteri_no in(4,2);
select * from tbl_satıs where musteri_no in(select musteri_no from tbl_musteri where adres like'%turhal%');
select * from tbl_musteri where adres like'%tokat%' and telefon like '%6%';
select adres,telefon from tbl_musteri where ad like'%A%';
select model,marka,fiyat from tbl_arac where marka in('Opel','Fiat') order by marka asc;
select * from tbl_arac where model in(1998,2005,2007);



