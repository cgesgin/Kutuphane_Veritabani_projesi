--Transaction her iki işlemi de tek bir işlem olarak ele alacağı için herhangi birisi gerçekleşmediği zaman
--diğer gerçekleşen işlemleri de yok sayacaktır.
--Yani gerçekleşen işlemi geri alacaktır(rollback)

BEGIN transaction--yapılan işleme butunluk sağlamak
UPDATE tbl_kitaplar SET sayfa_sayisi=0
UPDATE tbl_kitaplar SET kitap_adi='Deneme'
SELECT * FROM tbl_kitaplar
ROLLBACK--işlemi geri alma
SELECT * fROM tbl_kitaplar

--Eğer transaction işlemi ROLLBACK yerine COIMMIT ile bitirilirse yapılan değişikliklerin
--tamamı kalıcı olarak veritabanına aktarılacaktır.

BEGIN transaction--yapılan işleme butunluk sağlamak
UPDATE tbl_kitaplar SET sayfa_sayisi=0
UPDATE tbl_kitaplar SET kitap_adi='Deneme'
SELECT * FROM tbl_kitaplar
commit--kalıcı olarak veri tabanına veri aktarıldı
SELECT * fROM tbl_kitaplar

--Uzun transaction işlemleri için transaction kendi içerisinde savepoints adı verilen küçük
--bölümlere ayniabiiir. Her bir bölüm commit ile veritabanına transfer edilebilir veya
--rollback ile yapılan değişiklik geri alınabilir.

BEGIN TRANSACTION
	SAVE TRANSACTION deneme
		UPDATE tbl_kitaplar SET sayfa_sayisi=0
		SELECT * FROM tbl_kitaplar
	ROLLBACK TRANSACTION deneme
		SELECT * FROM tbl_kitaplar
		UPDATE tbl_kitaplar SET kitap_adi='Deneme'
		SELECT * FROM tbl_kitaplar
ROLLBACK
	SELECT * FROM tbl_kitaplar
