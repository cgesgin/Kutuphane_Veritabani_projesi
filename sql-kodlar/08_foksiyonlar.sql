
create function fn_emanetSayisi(@uyeNo int)
RETURNS int
AS
BEGIN
  Declare @toplamEmanet int
  Set @toplamEmanet = ( SELECT COUNT(*) FROM tbl_emanet WHERE uye_no=@uyeNo)
  RETURN @toplamEmanet
END

Select [dbo].fn_emanetSayisi(3);
