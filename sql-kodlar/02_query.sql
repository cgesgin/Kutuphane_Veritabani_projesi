--Tablolara veri ekleme işlemleri

--Tablolarda çeşitli şekillerde veri ekleme 
insert into tbl_adresler (cadde,mahalle,bina_no,sehir,posta_kodu,ulke)
				   values('Orhangazi','Esentepe',5,'Tokat',60100,'Türkiye');
           
insert into tbl_adresler (cadde,mahalle,bina_no,sehir,posta_kodu,ulke)
				   values('Sivas','Kemer',34,'Tokat',60100,'Türkiye');
           
insert into tbl_adresler (mahalle,bina_no,sehir,posta_kodu,ulke)
				   values('Evrenköy',21,'Tokat',60100,'Türkiye');    
		   
insert into tbl_adresler (mahalle,bina_no,sehir,posta_kodu,ulke)
				   values('Cumhuriyet',56,'Tokat',60100,'Türkiye');
				   
insert into tbl_adresler (cadde,mahalle,bina_no,sehir,posta_kodu,ulke)
				   values('Atatürk','Barbaros',142,'İstanbul',34200,'Türkiye');
				   
insert into tbl_adresler (cadde,mahalle,bina_no,sehir,posta_kodu,ulke)
				   values('C.Gürsel','Tuna',65,'İzmir',35600,'Türkiye');
				   
insert into tbl_adresler (cadde,mahalle,bina_no,sehir,posta_kodu,ulke)
				   values('Sipahi','Şamlar',85,'Amasya',05200,'Türkiye');
				   
insert into tbl_adresler (mahalle,bina_no,sehir,posta_kodu,ulke)
				   values('Kızılay',114,'Ankara',06400,'Türkiye');

select * from tbl_adresler;
