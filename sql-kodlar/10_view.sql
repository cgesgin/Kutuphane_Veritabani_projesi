create view vw_yazarkitapSayfa
as
  select y.yazar_adi,y.yazar_soyadi,k.kitap_adi,SUM (sayfa_sayisi) as "sayfa sayisi" from tbl_yazarlar y 
  inner join tbl_kitap_yazar ky on ky.yazar_no=y.yazar_no
  inner join tbl_kitaplar k on k.isbn=ky.isbn
  group by y.yazar_adi,y.yazar_soyadi,k.kitap_adi
