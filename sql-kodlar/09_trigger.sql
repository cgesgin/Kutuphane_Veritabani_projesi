create trigger tgr_kitapEmanet
ON tbl_kitaplar
after INSERT
AS
	update tbl_emanet set emanet_tarihi=GETDATE() where emanet_tarihi is null;
