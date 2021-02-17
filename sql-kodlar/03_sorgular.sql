--tablolarda karmaşık sorgulama işlemleri

--alt sorgularla işlemlerde exists kullanı
select * from tbl_kitaplar where sayfa_sayisi> (
		select min(sayfa_sayisi) from tbl_kitaplar group by kitap_adi
		having kitap_adi like '%aa%' 
);
    
    	
select * from tbl_kitaplar where sayfa_sayisi>all(
		select sayfa_sayisi from tbl_kitap_yazar ky
		inner join tbl_kitaplar k on k.isbn=ky.isbn
		inner join tbl_yazarlar y on y.yazar_no=ky.yazar_no
		where y.yazar_adi like '%ç%' and y.yazar_soyadi like '%as%'
);

select * from tbl_yazarlar where not exists (
	select * from tbl_kitap_yazar 
	where tbl_yazarlar.yazar_no=tbl_kitap_yazar.yazar_no
);


select * from tbl_kategoriler where not exists(
	select * from tbl_kitap_kategori 
	where tbl_kategoriler.kategori_no=tbl_kategoriler.kategori_no 
);


select * from tbl_kitaplar k where not exists (
	select *from tbl_emanet e 
	where e.isbn=k.isbn
);

select * from tbl_yazarlar y where not exists(
	select * from tbl_kitap_yazar ky 
	where y.yazar_no=ky.yazar_no
	having count(*)>=5
);


-- bilgisayar kategorisinde kitap yazan yazalar listesi
select * from tbl_yazarlar y where exists (
	select * from tbl_kitap_yazar ky
	inner join tbl_kitap_kategori kk on kk.isbn= ky.isbn
	inner join tbl_kategoriler ka on ka.kategori_no=kk.kategori_no
	where ka.kategori_adi='Bilgisayar' and y.yazar_no=ky.yazar_no
);

--aynı adrese sahip üyelerin olup olmadıgının kontrolü
select distinct 'Aynı adrese sahip üye vardır' where exists (
	select * from tbl_uyeler group by adres_no having count(*)>1
);


select kitap_adi, (
	select yazar_adi from tbl_yazarlar,tbl_kitap_yazar
	where tbl_kitap_yazar.yazar_no=tbl_yazarlar.yazar_no and tbl_kitaplar.isbn=tbl_kitap_yazar.isbn
) as "Yazar"  from tbl_kitaplar ;


--kitapların kagegorilerini listeleyen sql sorgusu
select (select kategori_adi from tbl_kategoriler
		where kategori_no=tbl_kitap_kategori.kategori_no )as "Kategori"	,
		(select  kitap_adi from tbl_kitaplar where isbn=tbl_kitap_kategori.isbn)as "kitap"
		from tbl_kitap_kategori order by kategori;
		

--turhal kütüphanesinde bulunan yazarların kitaplarının sayisini listeleyen sql sorgusu
select yazar_adi,yazar_soyadi,
  ( select SUM(adet) from tbl_kitap_yazar,tbl_kitap_kutuphane
    where yazar_no=tbl_yazarlar.yazar_no 
    AND tbl_kitap_kutuphane.isbn=tbl_kitap_yazar.isbn
    AND kutuphane_no = ( select kutuphane_no from tbl_kutuphane where kutuphane_ismi='Turhal' )
  ) as "Kitap sayisi"
from tbl_yazarlar order by yazar_adi;

--her üyenin kütüphanelerini kaç kez kullandıgını listeleyen sql sorgusu
select uye_adi,uye_soyadi,
	(select count(*) from tbl_emanet where tbl_uyeler.uye_no=tbl_emanet.uye_no) as "alınan kitap sayısı" 
from tbl_uyeler;

--yazarların en fazla kitap sayisina sahip yazarın kitap sayisi
select MAX(yzr.kitap_sayisi) as en_fazla_kitap from 
	(select COUNT(*)as kitap_sayisi from tbl_kitap_yazar group by yazar_no) yzr;


update tbl_uyeler set adres_no=7 where uye_no=3;
--tokat ikamet eden üyelerin ad soyad bilgilerini listeleyen sql solgusu
select uye_adi,uye_soyadi from tbl_uyeler,(select  adres_no from tbl_adresler where sehir like '%amasya%') adres
where adres.adres_no=tbl_uyeler.adres_no;


--ortalama sayfa sayısından daha fazla sayfaya sahip olan kitapları listeleyn sql sorgusu
select * from tbl_kitaplar , (select AVG(sayfa_sayisi) as "sayfa_ort"  from tbl_kitaplar) ort
where tbl_kitaplar.sayfa_sayisi>ort.sayfa_ort;
