--parametreli procedure
CREATE PROCEDURE stp_KitapBilgi
@isbn int
AS
SELECT isbn,kitap_adi,sayfa_sayisi FROM tbl_kitaplar WHERE isbn = @isbn;

execute stp_KitapBilgi 123456780;

--DROP PROCEDURE [procedure_adı] var olan yordamı silmek için kullanılır.
--ALTER PROCEDURE [procedure_adı] var olan yordam üzerinde değişiklik yapmak için kullanılır.

alter proc stp_KitapBilgi
as
SELECT isbn,kitap_adi,sayfa_sayisi FROM tbl_kitaplar

execute stp_KitapBilgi;
