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

-- gruplandırarak sorgulama
select kategori_no,COUNT(isbn) as "kitap sayisi" from tbl_kitap_kategori group by kategori_no;
select uye_no ,COUNT(kutuphane_no)as"kullanım adedi" from tbl_emanet group by uye_no order by [kullanım adedi]; 
select COUNT(isbn) as adet,yazar_no from tbl_kitap_yazar group by yazar_no;
select kutuphane_no, AVG(DATEDIFF(DAY,emanet_tarihi,teslim_tarihi))as"emanet süresi" from tbl_emanet group by kutuphane_no;
select kutuphane_no,COUNT(isbn) as "kitap sayisi" from tbl_kitap_kutuphane where adet=1 group by kutuphane_no;
select kutuphane_no,SUM(adet)as "toplam kitap sayisi" from tbl_kitap_kutuphane group by kutuphane_no;
select kutuphane_no,COUNT(isbn) as "kitap sayisi" from tbl_kitap_kutuphane group by kutuphane_no;
				  
select adres_no,COUNT(*) as "adres sayısı" from tbl_uyeler group by adres_no having COUNT(*)>1;
select isbn,COUNT(*) from tbl_kitap_kategori group by isbn having COUNT(*)>=1;
select COUNT(yazar_no),isbn from tbl_kitap_yazar group by isbn having COUNT(yazar_no)=1;
select isbn, COUNT(uye_no) as "emanet sayısı" from tbl_emanet group by isbn having COUNT(uye_no)>3;
select kategori_no,COUNT(*) as "kitap sayısı" from tbl_kitap_kategori group by kategori_no having COUNT(*)>3;
select kategori_no ,COUNT(isbn)"kitap sayısı" from tbl_kitap_kategori group by kategori_no; 
select isbn,uye_no,COUNT(uye_no)as"uye adedi" from tbl_emanet group by isbn,uye_no;
select kutuphane_no,isbn from tbl_emanet group by kutuphane_no,isbn order by kutuphane_no,isbn;

				  --birden fazla tablo üzreinde sorgulamalar
select isbn,yazar_adi,yazar_soyadi from	tbl_kitap_yazar ky, tbl_yazarlar y where ky.yazar_no=y.yazar_no;

select isbn,kategori_adi from tbl_kitap_kategori kk ,tbl_kategoriler k where kk.kategori_no=k.kategori_no;

elect isbn,yazar_adi,yazar_soyadi from tbl_yazarlar y inner join tbl_kitap_yazar ky on y.yazar_no=ky.yazar_no
order by yazar_adi,yazar_soyadi;

select kitap_adi,kk.isbn,kk.kutuphane_no from tbl_kitaplar 
inner join tbl_kitap_kutuphane kk on tbl_kitaplar.isbn=kk.isbn;

select kategori_adi,SUM(adet) as "kitap sayisi"  from tbl_kitap_kutuphane kk 
inner join tbl_kitap_kategori kkt on kk.isbn=kkt.isbn
inner join tbl_kategoriler kkg on kkg.kategori_no=kkt.kategori_no
group by kategori_adi;

select y.yazar_adi,y.yazar_soyadi,SUM (sayfa_sayisi) as "sayfa sayisi" from tbl_yazarlar y 
inner join tbl_kitap_yazar ky on ky.yazar_no=y.yazar_no
inner join tbl_kitaplar k on k.isbn=ky.isbn
group by y.yazar_adi,y.yazar_soyadi
order by [sayfa sayisi] desc;

select y.yazar_adi,y.yazar_soyadi, COUNT(kk.adet) as "kitap sayisi" from  tbl_kitap_kutuphane kk
inner join tbl_kitap_yazar ky on ky.isbn=kk.isbn 
inner join tbl_yazarlar y on y.yazar_no=ky.yazar_no
group by y.yazar_adi,y.yazar_soyadi;

select k.kutuphane_ismi,y.yazar_adi,y.yazar_soyadi from tbl_kutuphane k 
inner join tbl_kitap_kutuphane kk on kk.kutuphane_no=k.kutuphane_no
inner join tbl_kitap_yazar ky on ky.isbn=kk.isbn
inner join tbl_yazarlar y on y.yazar_no=ky.yazar_no
where k.kutuphane_ismi='turhal' or k.kutuphane_ismi='zile'
group by k.kutuphane_ismi,y.yazar_adi,y.yazar_soyadi
order by k.kutuphane_ismi,yazar_adi;

select u.uye_adi,u.uye_soyadi,u.telefon from tbl_uyeler u 
inner join  tbl_emanet e on e.uye_no=u.uye_no
where e.teslim_tarihi is null;

select u.uye_adi,u.uye_soyadi,u.telefon,a.* from tbl_uyeler u 
inner join  tbl_emanet e on e.uye_no=u.uye_no
inner join tbl_adresler a on u.adres_no=a.adres_no
where e.teslim_tarihi is null;

select tbl_yazarlar.*, COUNT(tbl_kitap_yazar.isbn) as"kitap sayisi" from tbl_yazarlar
left join tbl_kitap_yazar on tbl_yazarlar.yazar_no=tbl_kitap_yazar.yazar_no
group by tbl_yazarlar.yazar_no,yazar_adi,yazar_soyadi;

select tbl_yazarlar.*, COUNT(tbl_kitap_yazar.isbn) as"kitap sayisi" from tbl_yazarlar
inner join tbl_kitap_yazar on tbl_yazarlar.yazar_no=tbl_kitap_yazar.yazar_no
group by tbl_yazarlar.yazar_no,yazar_adi,yazar_soyadi;

select tbl_kategoriler.*,SUM(tbl_kitap_kutuphane.adet) as "kitap sayisi" from tbl_kitap_kutuphane
inner join tbl_kitap_kategori on tbl_kitap_kutuphane.isbn=tbl_kitap_kategori.isbn
right join tbl_kategoriler on tbl_kategoriler.kategori_no=tbl_kitap_kategori.kategori_no
group by tbl_kategoriler.kategori_no,tbl_kategoriler.kategori_adi;

select isbn from tbl_kitap_kutuphane
intersect 
select isbn from tbl_kitaplar

select kategori_no from tbl_kategoriler
intersect 
select kategori_no from tbl_kitap_kategori
				  
				  --Altsorgular 

select isbn from tbl_kitap_kategori 
where kategori_no=(select kategori_no from tbl_kategoriler where kategori_adi='bilgisayar');

select * from tbl_kitaplar where sayfa_sayisi>(select AVG(sayfa_sayisi) from tbl_kitaplar);

select * from tbl_emanet where kutuphane_no=(select kutuphane_no from tbl_kutuphane where kutuphane_ismi='turhal')

select * from tbl_yazarlar where yazar_no not in(select yazar_no from tbl_kitap_yazar)

select * from tbl_kitap_kategori where 
kategori_no not in(select kategori_no from tbl_kategoriler where kategori_adi='diğer' )

select * from tbl_kitap_yazar where yazar_no in 
(select yazar_no from tbl_yazarlar where (yazar_adi='turgut' and yazar_soyadi='özseven') or (yazar_adi='ebubekir' and yazar_soyadi='yaşar'))

select * from tbl_uyeler where uye_no in (select uye_no from tbl_emanet where teslim_tarihi is null)

select * from tbl_kitaplar where isbn in
(select isbn from tbl_kutuphane where kutuphane_ismi='Turhal' or kutuphane_ismi='Zile')

select * from tbl_kitaplar where sayfa_sayisi >(select SUM(sayfa_sayisi) from tbl_yazarlar y
inner join tbl_kitap_yazar ky on ky.yazar_no=y.yazar_no
inner join tbl_kitaplar k on k.isbn=ky.isbn
where yazar_adi='çebi' and yazar_soyadi='Bal')
