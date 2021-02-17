
--sql sorgu çalışmaları

create database db_otogaleri;

				--Tablo tanımlamaları 

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

			--Tablolarda constraint işlemleri

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


		       --Tablolara veri girişleri		       
		       
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


		       --Tek tablo üzerinden sorgulamalar
		       
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

		       --Aritmetik operatorler ve fonksiyonlar üzerinden işlemler

 select *,fiyat*20/100 as "%20 arrtılmıs fiyatlar"  from tbl_arac;
 select *,DATEDIFF(YEAR,model,getdate()) as "yeni tarih" from tbl_arac where DATEDIFF(YEAR,model,getdate())<=3;
 select ad+soyad as "Ad Soyad" from tbl_musteri order by [Ad Soyad];
 select upper(SUBSTRING(ad,1,1))+'.'+soyad as adSoyad from tbl_musteri;
 select * from tbl_alım order by fiyat desc,datename(month,alim_tarih) asc;
 select UPPER(SUBSTRING(ad,1,1))+SUBSTRING(soyad,1,5) as "ad soyad" from tbl_musteri where LEN(soyad)>5;
 select SUBSTRING(adres,CHARINDEX('/',adres)+1,LEN(adres))as "il" from tbl_musteri order by il asc;
 select * from tbl_satıs where (datepart(YEAR,satis_tarih)=2008 or DATEPART(YEAR,satis_tarih)=2010) and (3=DATEPART(MONTH,satis_tarih) or 4=DATEPART(MONTH,satis_tarih));
 select sum(fiyat)as "2008 ve 2010 yılları arası 4. ve 3. ay toplam fiyat" from tbl_satıs where (datepart(YEAR,satis_tarih)=2008 or DATEPART(YEAR,satis_tarih)=2010) and (3=DATEPART(MONTH,satis_tarih) or 4=DATEPART(MONTH,satis_tarih));
 select sum(fiyat)as "fiyat",AVG(fiyat)as "orta",(sum(fiyat)-AVG(fiyat)) as"toplam-ortalama=fark" from tbl_satıs where (datepart(YEAR,satis_tarih)=2008 or DATEPART(YEAR,satis_tarih)=2010) and (1=DATEPART(MONTH,satis_tarih) or 8=DATEPART(MONTH,satis_tarih));
 select model,marka,fiyat from tbl_arac where fiyat=(select  max(fiyat)  from tbl_arac );
 select  max(fiyat)-MIN(fiyat)  from tbl_arac ;
 select * from tbl_arac where fiyat<=(select  max(fiyat)-MIN(fiyat)  from tbl_arac) ;
 select COUNT(*) from tbl_alım where DATEPART(YEAR,alim_tarih)=2010;
 select * from tbl_satıs where satis_tarih between  '2010.03.01'   and  '2010.12.31' ;
 select * from tbl_alım where 6>DATEDIFF(MONTH,alim_tarih,GETDATE());
 select datename(WEEKDAY,satis_tarih)as "satılan günler" , datename(DAY,satis_tarih) from tbl_satıs;
					 

					 --Gruplandırarak sorgulama

select count(adres),adres from tbl_musteri  group by adres having adres like '%tokat%';
select avg(fiyat),datediff(year,model,getdate()) as "a" from tbl_arac where datediff(year,model,getdate())>3 group by fiyat;
select avg(fiyat) from tbl_satıs group by fiyat;
select fiyat from tbl_alım group by fiyat having AVG(fiyat)>10000;
select max(fiyat)-MIN(fiyat) from tbl_arac group by fiyat ;


					--Birden fazla tablolar üzerinde sorgulama işlemleri(join işlemleri)

select ad,soyad from tbl_musteri m inner join tbl_satıs s on m.musteri_no=s.musteri_no;

select m.ad,m.soyad,ar.marka from tbl_musteri m 
				inner join tbl_alım a on m.musteri_no=a.musteri_no
				inner join tbl_arac ar on ar.arac_no=a.arac_no;

insert into tbl_alım values(3,26,'2020.12.31',18000);

select m.ad,count(a.musteri_no) as "alınan arac sayısı" from tbl_musteri m
			inner join tbl_alım a on m.musteri_no=a.musteri_no
			group by a.musteri_no,m.ad;

select * from tbl_alım;

select marka,model,s.satis_tarih from tbl_arac a inner join tbl_satıs s on a.arac_no=s.arac_no

select SUM(a.fiyat) as " toplam alım", SUM(s.fiyat) as "toplam satılan fiyat",SUM(s.fiyat)-SUM(a.fiyat) as "satılan-alınan" from tbl_alım a,tbl_satıs s;

select * from tbl_arac left outer join tbl_satıs on tbl_arac.arac_no=tbl_satıs.arac_no where tbl_satıs.musteri_no is null;
insert into tbl_satıs values (3,26,'2020.12.31',32000);

select ar.marka,AVG(a.fiyat) as "satilan aracın ortalama fiyatı" ,count(a.musteri_no) as "alan kişi sayısı" from tbl_arac ar
			inner join tbl_satıs a on ar.arac_no=a.arac_no
			group by a.arac_no,ar.arac_no,ar.marka;

select distinct  ar.marka,COUNT(al.musteri_no) as "alım sayısı" , count(sa.satis_no)
		from tbl_arac ar inner join tbl_alım al on ar.arac_no=al.arac_no 
		inner join tbl_satıs sa on sa.arac_no=ar.arac_no
	group by ar.marka;

select ar.marka,mu.ad,sa.fiyat from tbl_satıs sa 
	inner join tbl_musteri mu on sa.musteri_no=mu.musteri_no
	inner join tbl_arac ar on ar.arac_no=sa.arac_no where sa.fiyat>20000;

select mu.ad,mu.adres,ar.marka from tbl_musteri mu 
		inner join tbl_satıs sa on sa.musteri_no=mu.musteri_no
		inner join tbl_arac ar on ar.arac_no=sa.arac_no 
	where mu.adres like '%tokat%'; 

							
										     --Alt sorgular
select ad,soyad from tbl_musteri m inner join tbl_satıs s on m.musteri_no=s.musteri_no and s.arac_no in ((select arac_no from tbl_satıs where musteri_no=
	(select musteri_no from tbl_musteri where ad='Turgut' and soyad ='özseven' )
));

select *from tbl_arac where arac_no in(select arac_no from tbl_satıs);

select * from tbl_arac where arac_no in (select arac_no from tbl_satıs s where s.fiyat > all (select fiyat from tbl_alım));
											      
select a.adSoyad "opel marka alım yapan" , s.adSoyad"opel marka satın alan" from (select ad+soyad as"adSoyad" from tbl_musteri where musteri_no in (select musteri_no from tbl_alım 
	where arac_no in((select arac_no from tbl_arac where marka='opel')))) as a,(select ad+soyad as"adSoyad" from tbl_musteri where musteri_no in (select musteri_no from tbl_satıs 
	where arac_no in((select arac_no from tbl_arac where marka='opel')))) s

select s.arac_no , s.fiyat from  tbl_satıs s  where s.arac_no in (select arac_no from tbl_arac where fiyat>20000);
																		      
select SUM(fiyat) from tbl_satıs 
where musteri_no in (
	select musteri_no from tbl_musteri where adres like '%turhal%' or adres like '%amasya%'
	) group by fiyat order by fiyat asc ;
																		      
select ad+soyad as adSoyad from tbl_musteri where musteri_no not in(select musteri_no from tbl_satıs) or
 musteri_no not in(select musteri_no from tbl_alım);
																		      
select*from tbl_musteri where musteri_no in (select musteri_no from tbl_satıs where 5=DATEPART(MONTH,satis_tarih) or 6=DATEPART(MONTH,satis_tarih));																		      

 select * from tbl_arac where arac_no in 
 (
	select arac_no from tbl_alım 
 ) and arac_no not in
 (
	select arac_no from tbl_satıs
 );
															
