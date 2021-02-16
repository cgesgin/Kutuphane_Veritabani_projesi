--tablolarda karmaşık sorgulama işlemleri

--alt sorgularda işlemler
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

