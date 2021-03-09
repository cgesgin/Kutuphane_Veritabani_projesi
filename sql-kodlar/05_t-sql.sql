declare @sayi int;	
--DECLARE @ad nvarchar(25), @soyad nvarchar(25), @tarih datetime
set @sayi=200;--select @sayi=200;
select * from tbl_kitaplar where sayfa_sayisi=@sayi;

Print @@error;
Print @@rowcount;

-- case kullanımı
DECLARE @sayi2 INT=5
SELECT
CASE @sayi2
WHEN 1 THEN 'Zayıf'
WHEN 2 THEN 'Geçer'
WHEN 3 THEN 'Orta'
WHEN 4 THEN 'İyi'
WHEN 5 THEN 'Pekiyi'
ELSE 'Aralık Dışı Değer'
END

-- tablo içinde case kullanımı


SELECT *,
	CASE 
		WHEN sayfa_sayisi>0 and sayfa_sayisi<=200 THEN 'ince'
		WHEN sayfa_sayisi>200 and sayfa_sayisi<=500  THEN 'kalın'
		ELSE 'extra kalınlar'
	END as "Kalınlıklar"
from tbl_kitaplar;

-- if kullanımı
IF((SELECT COUNT(*)FROM tbl_kitaplar k WHERE k.sayfa_sayisi IS NULL)>0)
	DELETE FROM tbl_kitaplar WHERE sayfa_sayisi IS NULL
ELSE
	SELECT * FROM tbl_kitaplar k

--while kullanımı

DECLARE @say int
SELECT @say =1

WHILE @say <=30
BEGIN
	PRINT @say
	IF @say = 24
		BREAK
	SELECT @say=@say+1
END

-- örnek 2
DECLARE @sayi3 int
SELECT @sayi3=0

WHILE @sayi3 < 30
BEGIN
	SELECT @sayi3=@sayi3+1
	IF @sayi3 between 15 and 20
		continue
	PRINT @sayi3
END
