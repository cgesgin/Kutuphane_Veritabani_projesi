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
