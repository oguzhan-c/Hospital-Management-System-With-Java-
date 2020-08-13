
 CREATE SCHEMA "Oda Şema";

 CREATE  SCHEMA "Çalışan Şema";
 
 CREATE SCHEMA "Tedavi Şema";
 
 CREATE SCHEMA "Tedavi Ücret Şema";
 
 CREATE SCHEMA "Ürün Yönetimi Şema";
 
 CREATE SCHEMA "Bilgi Şema";
 

  CREATE TABLE  "Bilgi Şema"."Adres"
 (
    "Adres ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Adres" VARCHAR(200) NOT NULL ,
    "Ilçe" VARCHAR(50) NOT NULL ,
    "Il" VARCHAR(50) NOT NULL ,
    "Ülke" VARCHAR(50) NOT NULL ,
    "Posta Kodu" VARCHAR(10) NOT NULL ,
    CONSTRAINT pk_Adresler_AdresID PRIMARY KEY 
    (
        "Adres ID"
    )
 );
 
CREATE TABLE "Tedavi Ücret Şema"."Sigorta"
( 
    "Sigorta ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Sigorta Tipi" VARCHAR(50) NOT NULL ,
    "Sigorta Şirketi" VARCHAR(50) NOT NULL ,
    "Şirket Telefon Numarası" VARCHAR(20) NOT NULL ,
    "Teminat" INTEGER ,
    CONSTRAINT pk_Sigorta_SigortaID PRIMARY KEY
    (
        "Sigorta ID"
    )
);

CREATE TABLE "Oda Şema"."Hasta Odası"(
    "Oda ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Oda Tipi" VARCHAR(255) NOT NULL ,
    "Oda Durumu" VARCHAR(255) NOT NULL ,
    CONSTRAINT pk_HastaOdasi_OdaID PRIMARY KEY
    (
        "Oda ID"
    )
);

CREATE TABLE "Ürün Yönetimi Şema"."Envanter"(
    "Envanter ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Envanter Ismi" VARCHAR(250) NOT NULL ,
    "Envanter Marka" VARCHAR(250) NOT NULL ,
    "Envanter Model" VARCHAR(250) NOT NULL ,
    "Envanter Seri No" VARCHAR(250) NOT NULL ,
    "Envanter Durumu" VARCHAR(100) NOT NULL ,
    "Birim Fiyat" money NOT NULL ,
    "Envanter Sayısı" INTEGER NOT NULL , 
    CONSTRAINT pk_Envanter_EnvanterID PRIMARY KEY 
    (
        "Envanter ID"
    )
);


CREATE TABLE "Tedavi Ücret Şema"."Ödeme"
( 
    "Ödeme ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL NOT NULL ,
    "Sigorta ID" INTEGER NOT NULL ,
    "Ödeme Tipi" VARCHAR(50) NOT NULL ,
    "Ödeme Metodu" VARCHAR(50) NOT NULL ,
    "Ödenecek Tutar" INTEGER NOT NULL  ,
    "Ödeme Durumu" VARCHAR(10) NOT NULL ,
    CONSTRAINT pk_Odeme_OdemeID PRIMARY KEY
    (
        "Ödeme ID"
    ),
    CONSTRAINT fk_Odeme_Sigorta_SigortaID FOREIGN KEY
    (
        "Sigorta ID" 
    )
    REFERENCES "Tedavi Ücret Şema"."Sigorta"
    (
        "Sigorta ID"
    )
);

CREATE TABLE  "Bilgi Şema"."Hasta"
( 
    "Hasta ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Sigorta ID" INTEGER NOT NULL ,
    "Adres ID" INTEGER NOT NULL ,
    "Tc Kimlik No" VARCHAR(50) NOT NULL ,
    "Hasta Adı"  VARCHAR(50) NOT NULL,
    "Hasta Soyadı" VARCHAR(50) NOT NULL ,
    "Baba Adı" VARCHAR(50) NOT NULL ,
    "Doğum Tarihi" DATE NOT NULL ,
    "Cinsiyet" VARCHAR(50)  NOT NULL ,
    "Telefon Numarası" VARCHAR(50) NOT NULL ,
    "Acil Durumda Aranacak Kişi" VARCHAR(50) NOT NULL ,
    "Acil Durumda Aranacak Numara" VARCHAR(50) NOT NULL ,
    "Yaş" INTEGER ,
    CONSTRAINT PK_Hasta_HastaID PRIMARY KEY 
    (
        "Hasta ID"
    ) ,
    CONSTRAINT FK_Hasta_Sigorta_SigortaID FOREIGN KEY
    (
        "Sigorta ID"
    )
    REFERENCES "Tedavi Ücret Şema"."Sigorta"
    (
        "Sigorta ID"
    ),
    CONSTRAINT fk_Hasta_Adres FOREIGN KEY 
    (
        "Adres ID"
    )
    REFERENCES "Bilgi Şema"."Adres"
    (
        "Adres ID"
    )
);

CREATE TABLE  "Tedavi Şema"."Tanı"(
    "Tanı ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Tanı Tipi" VARCHAR(250) NOT NULL ,
    "Sonuç" VARCHAR(250) NOT NULL ,
    CONSTRAINT pk_Tanı_TanıID PRIMARY KEY 
    (
        "Tanı ID"
    ) 
);

CREATE TABLE "Tedavi Şema"."Test Sonuçları"(
    "Test ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Hasta ID" INTEGER NOT NULL ,
    "Tanı ID" integer not null ,
    "Kan Grubu" VARCHAR(250) NOT NULL ,
    "Hemoglobin" DECIMAL NOT NULL ,
    "WBC" DECIMAL NOT NULL ,
    "RBC" DECIMAL NOT NULL ,
    "Kolestrol" INTEGER NOT NULL ,
    "Buyük Tansiyon" INTEGER NOT NULL ,
    "Kuçük Tansiyon" INTEGER NOT NULL ,
    CONSTRAINT pk_TestSonuçları_TestID PRIMARY KEY
    (
        "Test ID"
    ) ,
    CONSTRAINT fk_TestSonucları_HastaID FOREIGN KEY 
    (
        "Hasta ID"
    ) 
    REFERENCES "Bilgi Şema"."Hasta"
    (
        "Hasta ID"
    ) ,
    constraint fk_Tedabi_Tanı_TanıID foreign key 
    (
        "Tanı ID"
    )
    REFERENCES "Tedavi Şema"."Tanı"
    (
        "Tanı ID"
    )
);

CREATE TABLE "Oda Şema"."Operasyon Oda"(
    "Operasyon Oda ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Oda ID" INTEGER NOT NULL ,
    "Tipi" VARCHAR(255) NOT NULL ,
    "Durum" VARCHAR(255) NOT NULL ,
    CONSTRAINT pk_OperasyonOda_OperasyonOdaID PRIMARY KEY 
    (
      "Operasyon Oda ID"  
    ),
    CONSTRAINT FK_HastaOdası_OdaID FOREIGN KEY 
    (
        "Oda ID"
    )
    REFERENCES "Oda Şema"."Hasta Odası"
    (
        "Oda ID"
    )
);

CREATE TABLE "Tedavi Şema"."Yatan Hasta Bilgi"
( 
    "Hasta ID" INTEGER NOT NULL ,
    "Oda ID" INTEGER NOT NULL ,
    "Kabul Tarihi" Date NOT NULL,
    "Taburcu Tarihi"Date NULL ,
    CONSTRAINT pk_YatanHB_HastaID PRIMARY KEY
    (
     "Hasta ID"
    ) ,
    CONSTRAINT  fk_YatanHB_Hasta FOREIGN KEY 
    (
        "Hasta ID"   
    ) 
    REFERENCES "Bilgi Şema"."Hasta"
    (
       "Hasta ID"
    ),
    CONSTRAINT fk_YatanHB_HastaOdasi FOREIGN KEY
    (
        "Oda ID"
    ) 
    REFERENCES "Oda Şema"."Hasta Odası"
    (
        "Oda ID"
    )
);


CREATE TABLE "Tedavi Şema"."Ayakta Tedavi"
( 
    "Hasta ID" INTEGER NOT NULL ,
    CONSTRAINT pk_AyaktaTedavi_HastaID PRIMARY KEY 
    (
        "Hasta ID"
    ),
    CONSTRAINT fk_AyaktaTedavi_Hasta FOREIGN KEY
    (
        "Hasta ID"
    )
    REFERENCES "Bilgi Şema"."Hasta"
    (
        "Hasta ID"
    )
);

CREATE TABLE  "Çalışan Şema"."Doktor"(
    "Doktor ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Adres ID" INTEGER NOT NULL ,
    "Doktor Adı" VARCHAR(255) NOT NULL ,
    "Doktor Soyadı" VARCHAR(50) NOT NULL ,
    "Doktor Unvan" VARCHAR(50) NOT NULL , 
    "Uzmanlık" VARCHAR(255) NOT NULL ,
    "Cinsiyet" VARCHAR(50) NOT NULL ,
    "Dogum Tarihi" DATE NOT NULL,
    "DoktorUrl" VARCHAR(200) NOT NULL ,	
    "Yaş" INTEGER ,
    CONSTRAINT pk_Doktor_DoktorId PRIMARY KEY 
    (
        "Doktor ID"
    ) ,
    CONSTRAINT fk_Doktor_Adres FOREIGN KEY 
    (
        "Adres ID"
    )
    REFERENCES "Bilgi Şema"."Adres"
    (
        "Adres ID"
    )
    
);

CREATE TABLE "Tedavi Şema"."Randevu"
( 
    "Randevu ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Doktor ID" INTEGER NOT NULL ,
    "Hasta ID" INTEGER NOT NULL ,
    "Başlangıç Zamanı" varchar(15) NOT NULL ,
    "Bitiş Zamanı" varchar(15) NOt NULL ,
    "Randevu Tarihi" varchar(15) NOT NULL ,
    "Geldimi" VARCHAR(50) NOT NULL , 
    CONSTRAINT pk_Randevu_RandevuID PRIMARY KEY 
    (
        "Randevu ID"
    ),
    CONSTRAINT fk_Randevu_Doktor FOREIGN KEY
    (
        "Doktor ID"
    )
    REFERENCES "Çalışan Şema"."Doktor"
    (
        "Doktor ID"
    ),
    CONSTRAINT fk_Randevu_Hasta FOREIGN KEY 
    (
        "Hasta ID"
    )
    REFERENCES "Bilgi Şema"."Hasta"
    (
        "Hasta ID"
    )
);

CREATE TABLE "Çalışan Şema"."Hemşire"
(
    "Hemşire ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Doktor ID" INTEGER NOT NULL ,
    "Adres ID" INTEGER NOT NULL ,
    "Hemşire Adı" VARCHAR(50) NOT NULL ,
    "Hemşire Soyadı" VARCHAR(50) NOT NULL ,
    "Cinsiyet" VARCHAR(50) NOT NULL ,
    "Seviye" INTEGER NOT NULL ,
    "Dogum Tarihi" DATE NOT NULL,
    "Yaş" INTEGER ,
    CONSTRAINT pk_Hemsire_HemsireID PRIMARY KEY 
    (
        "Hemşire ID"
    ), 
    CONSTRAINT fk_Hemsire_Doktor FOREIGN KEY 
    (
        "Doktor ID"  
    )
    REFERENCES "Çalışan Şema"."Doktor"
    (
        "Doktor ID"
    ) ,
     CONSTRAINT fk_Hemşire_Adres FOREIGN KEY 
    (
        "Adres ID"
    )
    REFERENCES "Bilgi Şema"."Adres"
    (
        "Adres ID"
    )
);

CREATE TABLE "Ürün Yönetimi Şema"."Stok Yonetimi"(
    "Stok Yonetimi ID"  INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Envanter ID" INTEGER NOT NULL ,
    "Hemşire ID" INTEGER  NOT NULL ,
    CONSTRAINT pk_StokYönetimi_StokYönetimiID PRIMARY KEY
    (
        "Stok Yonetimi ID" 
    ) ,
    CONSTRAINT fk_StokYonetimi_Envanter FOREIGN KEY 
    (
        "Envanter ID"
    )
    REFERENCES "Ürün Yönetimi Şema"."Envanter"
    (
        "Envanter ID"
    ),
    CONSTRAINT fk_StokYonetimi_Hemşire FOREIGN KEY 
    (
        "Hemşire ID"
    )
    REFERENCES "Çalışan Şema"."Hemşire"
    (
        "Hemşire ID"
    )
);  




ALTER TABLE "Tedavi Ücret Şema"."Sigorta" 
ADD CONSTRAINT Check_Sigorta_Teminat
CHECK("Teminat" > 50000) ;

ALTER TABLE "Ürün Yönetimi Şema"."Envanter"
ADD CONSTRAINT Check_Envanter_EnvanterDurumu
CHECK("Envanter Durumu" IN ('Yeterli Sayıda Var', 'Sipariş Edildi', 'Sipariş Edilecek')) ;

ALTER TABLE "Tedavi Şema"."Tanı"
ADD CONSTRAINT Check_Tanı_Sonuç
CHECK("Sonuç" IN ('Pozitif', 'Negatif', 'Yetersiz Sonuc')) ;

ALTER TABLE "Tedavi Ücret Şema"."Ödeme"
ADD CONSTRAINT Check_Ödeme_ÖdeneceekTutar_ÖdemeDurumu 
CHECK("Ödenecek Tutar" > 60000 AND ("Ödeme Durumu" = 'Evet' OR "Ödeme Durumu" = 'Hayır')) ;	
		
ALTER TABLE "Bilgi Şema"."Hasta"
ADD CONSTRAINT Check_Hasta_Cinsiyet
CHECK("Cinsiyet" IN ('Erkek','Kadın')) ;

ALTER TABLE "Çalışan Şema"."Doktor"
ADD CONSTRAINT  Check_Doktor_Cinsiyet
CHECK("Cinsiyet" IN ('Erkek', 'Kadın')) ;

ALTER TABLE "Tedavi Şema"."Randevu"
ADD CONSTRAINT Check_Randevu_Geldimi
CHECK("Geldimi" = 'Evet' OR "Geldimi" = 'Hayır') ;
	
ALTER TABLE "Çalışan Şema"."Hemşire"
ADD CONSTRAINT Check_HemşireCinsiyet_Seviye
CHECK("Cinsiyet" IN ('Erkek','Kadın') AND "Seviye" IN (1,2,3) ) ;

-- 4 Tane Fonksiyon
		--Yatan Hasta Yönetimi Function :Created-06/08/2020
CREATE OR REPLACE FUNCTION "Tedavi Şema"."Yatan Hasta Yönetimi"()
RETURNS TABLE 
(
    "Hasta ID" INTEGER ,
    "Hasta Adı" VARCHAR(50) ,
    "Hasta Soyadı" VARCHAR(50) ,
    "Tanı Tipi" VARCHAR(50) , 
    "Yatış Tarihi" DATE , 
    "Taburcu Tarihi" DATE     
)
AS 
$function$
BEGIN
     RETURN QUERY SELECT
    "Hasta"."Hasta ID","Hasta"."Hasta Adı","Hasta"."Hasta Soyadı",
    "Tanı"."Tanı Tipi" , "Yatan Hasta Bilgi"."Kabul Tarihi" ,
    "Yatan Hasta Bilgi"."Taburcu Tarihi"
    FROM "Tedavi Şema"."Yatan Hasta Bilgi" 
    INNER JOIN "Bilgi Şema"."Hasta"
    ON "Yatan Hasta Bilgi"."Hasta ID" = "Hasta"."Hasta ID"
    INNER JOIN "Tedavi Şema"."Tanı"
    ON "Hasta"."Hasta ID" = "Tanı"."Tanı ID" ;
END ;
$function$
LANGUAGE 'plpgsql' ;


		--Hemşire Bul Fonksiyon : Created-31/07/2020
CREATE OR REPLACE FUNCTION "Çalışan Şema"."Hemşire Bul Fonksiyon"("Hemşire Bul ID" INTEGER)
RETURNS TABLE ("Hemşire ID" INTEGER ,"Doktor ID" INTEGER ,"Adres ID" INTEGER ,"Hemşire Adı" VARCHAR(50) ,"Hemşire Soyadı" VARCHAR(50) ,"Cinsiyet" VARCHAR(50) ,"Seviye" INTEGER ,"Dogum Tarihi" DATE ,"Yaş" INTEGER 
)
AS
$$
BEGIN
    RETURN QUERY SELECT * FROM "Çalışan Şema"."Hemşire" 
    WHERE "Hemşire"."Hemşire ID" = "Hemşire Bul ID" ;
END ;
$$
LANGUAGE "plpgsql";

		--Acil Durum Yönetimi Fonksiyon : Created-02/08/2020
CREATE OR REPLACE FUNCTION "Bilgi Şema"."Acil Durum Yönetimi"()
RETURNS TABLE ("Hasta ID" INTEGER ,"Hasta Adı" VARCHAR,"Acil Durumda Aranacak Kişi" VARCHAR ,"Acil Durumda Aranacak Numara" VARCHAR)
AS
$function$
    BEGIN
            RETURN QUERY SELECT 
            "Hasta"."Hasta ID","Hasta"."Hasta Adı","Hasta"."Acil Durumda Aranacak Kişi",
            "Hasta"."Acil Durumda Aranacak Numara"
            FROM "Bilgi Şema"."Hasta" ;
    END ; 
$function$
LANGUAGE "plpgsql";

		--Doktor Ünvan Yönetimi Function : Created-06/08/2020
CREATE OR REPLACE FUNCTION "Çalışan Şema"."Doktor Ünvan Yönetimi"()
RETURNS TABLE 
(
    "Doktor ID" INTEGER ,
    "Doktor Adı" VARCHAR(50) ,
    "Doktor Soyadı" VARCHAR(50) ,
    "Doktor Unvan" VARCHAR(10) 
)
AS
$function$
BEGIN
    RETURN QUERY SELECT "Doktor"."Doktor ID","Doktor"."Doktor Adı",
    "Doktor"."Doktor Soyadı" , "Doktor"."Doktor Unvan"
    FROM "Çalışan Şema"."Doktor" ;
END ;    
$function$
LANGUAGE 'plpgsql' ;

--2 tane view trigger için
        -- view : Created-04/08/2020
        --Created for Trigger 
CREATE VIEW "Oda Şema"."Boş Oda Listeleme" AS
SELECT "Oda ID", "Oda Tipi", "Oda Durumu"
FROM "Oda Şema"."Hasta Odası"
WHERE "Oda Durumu"= 'Boş' ;

CREATE VIEW "Tedavi Ücret Şema"."Ödeme Bilgi" AS
SELECT "Ödeme"."Ödeme ID","Sigorta Şirketi","Ödeme Durumu"
FROM "Tedavi Ücret Şema"."Ödeme" 
INNER JOIN "Tedavi Ücret Şema"."Sigorta" 
ON "Ödeme"."Sigorta ID" = "Sigorta"."Sigorta ID" 
ORDER BY "Ödeme ID" ;

--4 tane trigger ve trigger için yazılmış fonksiyonlar
		--Hasta Geçmiş Table : Created-05/08/2020
--Hastaların Bir güncelleme yapması sonucunda eski bilgilerinin tutulması için yapılmış bir tablodur
CREATE TABLE "Bilgi Şema"."Hasta Geçmiş"
(
    "Hasta Geçmiş ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Hasta ID" INTEGER NOT NULL  ,
    "Sigorta ID" INTEGER NOT NULL ,
    "Adres ID" INTEGER NOT NULL ,
    "Tc Kimlik No" VARCHAR(50) NOT NULL ,
    "Hasta Adı"  VARCHAR(50) NOT NULL,
    "Hasta Soyadı" VARCHAR(50) NOT NULL ,
    "Baba Adı" VARCHAR(50) NOT NULL ,
    "Doğum Tarihi" DATE NOT NULL ,
    "Cinsiyet" VARCHAR(50)  NOT NULL ,
    "Telefon Numarası" VARCHAR(50) NOT NULL ,
    "Acil Durumda Aranacak Kişi" VARCHAR(50) NOT NULL ,
    "Acil Durumda Aranacak Numara" VARCHAR(50) NOT NULL ,
    "Yaş" INTEGER ,
    "Değiştirilme Zamanı" TIMESTAMP(4)
);

		--Hasta Bilgi Yönetimi Fonksiyonu  : Created-05/08/2020
		--Hastaların Geçmiş Bilgilerini Tutan Trigger İçin Yazılan Fonksiyon
CREATE OR REPLACE FUNCTION "Bilgi Şema"."Hasta Bilgi Yönetimi"()
RETURNS TRIGGER 
AS
$function$
BEGIN
    IF  new."Hasta Adı" <> old."Hasta Adı" 
        OR new."Hasta Soyadı" <> old."Hasta Soyadı"
        OR new."Telefon Numarası" <> old."Telefon Numarası"
        OR new."Acil Durumda Aranacak Kişi" <> old."Acil Durumda Aranacak Kişi"
        OR new."Acil Durumda Aranacak Numara" <> old."Acil Durumda Aranacak Numara"
        THEN
        INSERT INTO "Bilgi Şema"."Hasta Geçmiş"
        (   "Hasta ID" , 
            "Sigorta ID" ,
            "Adres ID" ,
            "Tc Kimlik No" ,
            "Hasta Adı" ,
            "Hasta Soyadı" ,
            "Baba Adı" ,
            "Doğum Tarihi" ,
            "Cinsiyet" ,
            "Telefon Numarası" ,
            "Acil Durumda Aranacak Kişi" ,
            "Acil Durumda Aranacak Numara" ,
            "Yaş" ,
            "Değiştirilme Zamanı"
        )
        VALUES
        (
            old."Hasta ID" , 
            old."Sigorta ID" ,
            old."Adres ID" ,
            old."Tc Kimlik No" ,
            old."Hasta Adı" ,
            old."Hasta Soyadı" ,
            old."Baba Adı" ,
            old."Doğum Tarihi" ,
            old."Cinsiyet" ,
            old."Telefon Numarası" ,
            old."Acil Durumda Aranacak Kişi" ,
            old."Acil Durumda Aranacak Numara" ,
            old."Yaş" ,
            now()
        );
    END IF ;
    
    RETURN NEW ;
        
END;
$function$
LANGUAGE 'plpgsql';
		
		-- Trigger Tanımlama : Created-05/08/2020
CREATE TRIGGER "Hasta Bilgi Yönetimi"
BEFORE UPDATE ON "Bilgi Şema"."Hasta" 
FOR EACH ROW
EXECUTE PROCEDURE "Bilgi Şema"."Hasta Bilgi Yönetimi"() ;

		--Envanter Satın Alma Table : Created-05/08/2020
		/*Envantere bir ürün eklendiğinde o üerünle ilgili ücret hesabı ve ne zaman eklendiği bilgisini depolamak için üretilen tablo ...*/
CREATE TABLE "Ürün Yönetimi Şema"."Envanter Satın Alma"
(
    "Satın Alma ID" INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "Envanter ID" INTEGER NOT NULL ,
    "Envanter Adı" VARCHAR(50) NOT NULL ,
    "Toplam Ücret" money NOT NULL ,
    "Satın Alım Zamanı" TIMESTAMP(4) ,
    CONSTRAINT pk_EnvanterSatınAlma_SatınAlmaID PRIMARY KEY
    (
        "Satın Alma ID"
    )     
);

		--Envanter Yönetimi Function : Created-05/08/2020
		--Envantere bir ürün eklendiğinde o üerünle ilgili ücret hesabı ve nezaman eklendiği bilgisini veren fonksiyon
CREATE OR REPLACE FUNCTION "Ürün Yönetimi Şema"."Envanter Yönetimi"()
RETURNS TRIGGER
AS
$function$
BEGIN 
        INSERT INTO "Ürün Yönetimi Şema"."Envanter Satın Alma"
        (   
            "Envanter ID" ,
            "Envanter Adı" ,
            "Toplam Ücret" ,
            "Satın Alım Zamanı"
        )
        VALUES
        (
            new."Envanter ID" ,
            new."Envanter Ismi" ,
            new."Birim Fiyat" * new."Envanter Sayısı" ,
            now()
        );
    
    RETURN NEW ;
    
END ;
$function$
LANGUAGE 'plpgsql' ;

		--Envanter Yönetimi Trigger : Created-05/08/2020
CREATE TRIGGER "Envanter Yönetimi"
BEFORE INSERT ON "Ürün Yönetimi Şema"."Envanter"
FOR EACH ROW 
EXECUTE PROCEDURE "Ürün Yönetimi Şema"."Envanter Yönetimi"();

		--Ödeme Bilgi View Trigger : created-06/08/2020
		--Bu fonksiyon view de kayıt silme sorununun giderilmesi için yapılmış trigger  
CREATE OR REPLACE FUNCTION "Tedavi Ücret Şema"."Ödeme View Silme"()
 RETURNS TRIGGER
AS $function$
BEGIN 
        DELETE FROM "Tedavi Ücret Şema"."Ödeme"
        WHERE "Ödeme ID" = old."Ödeme ID" ;
        RETURN OLD ;
END ;
$function$
 LANGUAGE plpgsql ;

CREATE TRIGGER "Ödeme View Silme"
INSTEAD OF DELETE ON "Tedavi Ücret Şema"."Ödeme Bilgi"
FOR EACH ROW
EXECUTE PROCEDURE "Tedavi Ücret Şema"."Ödeme View Silme"() ;

        --Boş Oda Listeleme View : created-06/08/2020
		--Bu fonksiyon view de kayıt ekleme yapılmamasını sağlamak için yazılmıştır...  
CREATE OR REPLACE FUNCTION "Oda Şema"."Boş Oda Listeleme View Eayıt Ekleme"()
 RETURNS TRIGGER
AS $function$
BEGIN 
        RAISE EXCEPTION 'Bu view e Kayıt ekleme yapılamamaktadır...' ;        
END ;
$function$
LANGUAGE plpgsql;


CREATE TRIGGER "Boş Oda Listeleme View Eayıt Ekleme"
INSTEAD OF INSERT ON "Oda Şema"."Boş Oda Listeleme"
FOR EACH ROW
EXECUTE PROCEDURE "Oda Şema"."Boş Oda Listeleme View Eayıt Ekleme"();

        --Adresler : İnserted-28/07/2020
        --Adresler : ilk 10 Hasta Son 10 Hemşire Ve Doktor 
INSERT INTO  "Bilgi Şema"."Adres"
("Adres","Ilçe","Il","Ülke","Posta Kodu")
VALUES
('Aydın/Aydın Merkez /Efeler Mahallesi No:5/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez /Mimarsinan Mahallesi No:10/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Didim Mrkez/Yeni Mahallesi No:4/A','Didim','Aydın','Türkiye','09500') ,
('Aydın/Didim Merkez /Denizköy Mahallesi No:5/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Didim Merkez /Altınkum Mahallesi No:6/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Didim Merkez /Balat Mahallesi No:7/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Kuşadası Merkez /Cumhuriyet Mahallesi No:8/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Kuşadası Merkez /Türkşanlı Mahallesi No:9/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Kuşadası Merkez /Yavansu Mahallesi No:10/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Kuşadası Merkez /Kadıkalesi Mahallesi No:11/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez/Cumhuriyet Mahallesi İzmir Bulvarı No:38/1' ,'Efeler','Aydın','Türkiye','09500'),
('Aydın/Aydın Merkez/Kurtuluş Mah. No:32A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez/Efeler Mahallesi İzmir Yolu No: 107/2,' ,'Efeler','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez/Güzelhisar Mahallesi 35. Sokak No:8/A','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez/Güzelhisar Mahallesi  No:91 Kat:2','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Yenipazar Merkez/Asyo Binası Kat:3' ,'Yenipazar','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez/Mimar Sinan Mahallesi 2383. Sokak No:1/3','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez/Mimar Sinan mahallesi  B blok / No: 67 /4' ,'Efeler','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez/Argos Plaza Cumhuriyet Mahallesi 1955.Sok No:1','Efeler','Aydın','Türkiye','09500') ,
('Aydın/Aydın Merkez/Kurtuluş Mahallesi Adnan Menderes Bulvarı No:56/9','Efeler','Aydın','Türkiye','09500');

        --Sigorta : İnserted-28/07/2020 	
INSERT INTO "Tedavi Ücret Şema"."Sigorta" ( "Sigorta Tipi", "Sigorta Şirketi", "Şirket Telefon Numarası", "Teminat") 
VALUES 
('Çalışan','SGK','0212 372 10 00','61000') ,
('Bireysel','AXA SİGORTA A.Ş.','444 2727','100000') ,
('Emekli','SGK','0 216 170 11 22','60001') ,
('Çalışan','Allianz Sigorta A.Ş.','0850 399 9999','100000') ,
('Bireysel','SGK','0212 372 10 00','70000') ,
('Emekli','Allianz Hayat ve Emeklilik A.Ş.','0850 399 9999','150000') ,
('Çalışan','Groupama Sigorta A.Ş.','0 850 250 50 50','90000') ,
('Seyahat Sağlık Sigortası','Allianz Sigorta A.Ş.','0850 399 9999','300000') ,
('Hayat Sigortası','Allianz Sigorta A.Ş.','0850 399 9999','1000000') ,
('Hayat Sigortası','SGK','0212 372 10 00','100000') ;

		--Hasta Odası : İnserted -28/07/2020 
INSERT INTO "Oda Şema"."Hasta Odası"
("Oda Tipi","Oda Durumu")
VALUES 
('Operasyon Odası','Müsait') ,
('Operasyon Odası','Müsait') ,
('Operasyon Odası','Müsait') ,
('Operasyon Odası','Müsait') , 
('Hasta Odası','Müsait') ,
('Operasyon Odası','Boş') ,
('Operasyon Odası','Boş') ,
('Hasta Odası','Dolu') ,
('Hasta Odası','Boş') ,
('Hasta Odası','Dolu') ;

		--Envanter : Insert-28/07/2020 
INSERT INTO "Ürün Yönetimi Şema"."Envanter" 
("Envanter Ismi", "Envanter Marka", "Envanter Model", "Envanter Seri No", "Envanter Durumu" , "Birim Fiyat" , "Envanter Sayısı") 
VALUES 
('HCT Cihazı','Nüve','NF 048','01-2741','Yeterli Sayıda Var',20000,10) ,
('İdrar santrifüj cihazı','Nüve','NF 200','23553','Sipariş Edilecek',200,1) ,
('Kan santrifüj cihazı ','Nüve','NF 200','NF 200','Sipariş Edildi',10000,3) ,
('Biyokimya otoanalizatörü','Tokyo Boeki ','Prestige 24i','2016810107','Yeterli Sayıda Var',10000,10) ,
('Hormon cihazı ','Diamerıeux','Mınıvidas','SUD1204486','Sipariş Edildi',25000,5) ,
('Kan sayım cihazı','Boule','Swelab Alfa Sampler','13015','Yeterli Sayıda Var',252000,20) ,
('Bilüribinmetre','Optima','BİL-REA','104','Sipariş Edildi',500000,5) ,
('Hemoglobin A1C ','EKF Diagnostics','DUO-Lab Model No:0110','2B0393','Sipariş Edilecek',1000,1) ,
('Glukometre','Rheomed','SC126-AA','NK2401-0362','Yeterli Sayıda Var',124005,10) ,
('Otomatik pipet','Socorex','Acura 825','181125586','Sipariş Edilecek',15,50) ;

/*Envanter Listesi Url : https://cevrehastanesi.com.tr/upload/dosya/biyls10-laboratuvar-tibbi-cihaz-envanter-listesi-rev02pdf_20191129111833.pdf 
*/
        --Ödeme  : İnsert-28/07/2020  
INSERT INTO "Tedavi Ücret Şema"."Ödeme" 
( "Sigorta ID", "Ödeme Tipi", "Ödeme Metodu", "Ödenecek Tutar", "Ödeme Durumu") 
VALUES 
('1','Tam','Çek','61000','Evet') ,
('2','Tam','Online','60100','Evet') ,
('3','Tam','Çek','70000','Evet') ,
('4','Tam','Kredi Kartı','75000','Evet') ,
('5','Tam','Çek','70000','Hayır') ,
('6','Eksik','Online','80000','Hayır') ,
('7','Eksik','Çek','60010','Hayır') ,
('8','Eksik','Online','70000','Hayır') ,
('9','Eksik','Çek','90000','Hayır') ,
('10','Eksik','Kredi Kartı','100000','Hayır') ;

        --Hasta : İnsert-28/07/2020 		
INSERT INTO "Bilgi Şema"."Hasta" 
( "Sigorta ID", "Adres ID","Tc Kimlik No", "Hasta Adı", "Hasta Soyadı", "Baba Adı", "Doğum Tarihi", "Cinsiyet","Telefon Numarası","Acil Durumda Aranacak Kişi","Acil Durumda Aranacak Numara", "Yaş") 
VALUES (1,1,'11111111111','Oğuzhan','Can','Mustafa','1999-01-04','Erkek','05121212121','Mustafa','05111111111','21') ,
(2,2,'22222222222','Denizhan','Sea','Cemal','1997-07-24','Erkek','05131313131','Cemal','05222222222','23') ,
(3,3,'33333333333','Salih','Dem','Fazıl','1995-04-24','Erkek','05141414141','Kemal','05333333333','25') ,
(4,4,'44444444444','Kemal','Lal','Remzi','1994-02-12','Erkek','05151515151','Remzi','05444444444','26') ,
(5,5,'55555555555','Cemal','Şen','Selim','1993-12-30','Erkek','05161616161','Selim','05555555555','27') ,
(6,6,'66666666666','Lale','Han','Mert','1992-11-12','Kadın','05171717171','Mert','05666666666','28') ,
(7,7,'77777777777','Zeynep','Alemdar','Olcay','1991-10-09','Kadın','05181818181','Olcay','05777777777','29') ,
(8,8,'88888888888','Demir','Jel','Turgut','1990-09-24','Erkek','05191919191','Turgut','05888888888','30') ,
(9,9,'99999999999','Emre','AL','Remzi','1989-10-29','Erkek','05212121212','Remzi','05999999999','31') ,
(10,10,'10101010101','Veysal','Teneke','Ferit','1988-03-07','Erkek','05222222222','Ferit','05101010101','32') ;

        --Tanı Tipi : İnserted-28/07/2020
INSERT INTO "Tedavi Şema"."Tanı" 
( "Tanı Tipi", "Sonuç") 
VALUES 
('Kovid 19','Pozitif') ,
('Kovid 19','Negatif') ,
('HİV','Pozitif') ,
('Hepatit C','Negatif') ,
('Kaba Kulak','Pozitif') ,
('Böbrek Yetmezliği','Negatif') ,
('Hepatit B','Pozitif') ,
('Astım','Negatif') ,
('Grip','Pozitif') ,
('Enfeksiyon','Negatif') ;

		--Test Sonuçları : İnserted-30/07/2020
INSERT INTO "Tedavi Şema"."Test Sonuçları" 
( "Hasta ID","Tanı ID", "Kan Grubu", "Hemoglobin", "WBC", "RBC", "Kolestrol", "Buyük Tansiyon", "Kuçük Tansiyon") 
VALUES 
(1,1,'0 RH Pozitif',13.5,5.8,8.9,210,113,50) ,
(2,2,'0 RH Negatif',12.5,5.7,7.9,100,150,90) ,
(3,3,'A RH Pozitif',11.5,5.7,6.9,120,90,40) ,
(4,4,'A RH Negatif',10.5,5.5,5.3,180,150,99) ,
(5,5,'B RH Pozitif',9.5,5.9,5.5,135,130,78) ,
(6,6,'B RH Negatif',8.5,5.1,5.7,160,140,88) ,
(7,7,'AB RH Pozitif',7.5,5.3,5.3,180,100,54) ,
(8,8,'AB RH Negatif',6.5,5.1,5.6,160,110,69) ,
(9,9,'A RH Pozitif',5.5,5.3,5.8,205,120,72) ,
(10,10,'B RH Pozitif',4.5,9.7,5.6,190,130,80) ;

        --Operasyon Oda : İnserted-28/07/2020	
INSERT INTO "Oda Şema"."Operasyon Oda" 
( "Oda ID", "Tipi", "Durum") 
VALUES 
(1,'Acil Yoğun Bakım','Müsait') ,
(2,'Acil Muayene ','Müsait') ,
(3,'Yoğun Bakım Odası','Müsait') ,
(4,'Ameliyat Odası','Müsait') ,
(5,'Poliklinik','Müsait') ;
	
		--Yatan Hasta Bilgi:İnserted-28/07/2020
INSERT INTO "Tedavi Şema"."Yatan Hasta Bilgi" 
( "Hasta ID", "Oda ID", "Kabul Tarihi", "Taburcu Tarihi") 
VALUES  
(1,1,'2020/07/25','2020/07/28') ,
(2,2,'2020/07/28','2020/07/28') ,
(3,3,'2020/07/28','2020/07/30') ,
(4,4,'2020/07/28','2020/07/28') ,
(5,4,'2020/07/27','2020/08/07') ;

		--Ayakta Tedavi : İnserted-28/07/2020
INSERT INTO "Tedavi Şema"."Ayakta Tedavi" 
( "Hasta ID") 
VALUES 
(6) ,
(7) ,
(8) ,
(9) ,
(10) ;
		
		--Doktor : İnserted-28/07/2020 
INSERT INTO "Çalışan Şema"."Doktor" 
( "Adres ID", "Doktor Adı", "Doktor Soyadı", "Doktor Unvan", "Uzmanlık", "Cinsiyet", "Dogum Tarihi", "Yaş","DoktorUrl") 
VALUES 
(11,'Emre','Çullu','Prof. Dr.','Ortopedi Ve Travmatoloji','Erkek','1976-07-24','44','https://www.doktortakvimi.com/emre-cullu/ortopedi-ve-travmatoloji/aydin#fid=3901') ,
(12,'Ferah','Sönmez','Prof. Dr.','Çocuk Nefrolojisi','Erkek','1980-04-22','40','https://www.doktortakvimi.com/ferah-sonmez/cocuk-nefrolojisi/aydin#fid=3901') ,
(13,' H. Alper','Tanrıverdi','Prof. Dr.','Kadın Hastalıkları Ve Doğum,','Erkek','1980-04-07','40','https://www.doktortakvimi.com/h-alper-tanriverdi/kadin-hastaliklari-ve-dogum-perinatoloji/aydin#fid=3901') ,
(14,'Seyhan Bahar','Özkan','Prof. Dr.','Göz Hastalıkları','Kadın','1980-07-08','40','https://www.doktortakvimi.com/seyhan-bahar-ozkan/goz-hastaliklari/aydin#fid=3901') ,
(15,' Ali Zahit','Bolaman','Prof. Dr.','İç Hastalıkları','Erkek','1980-08-06','40','https://www.doktortakvimi.com/ali-zahit-bolaman/hematoloji-ic-hastaliklari/aydin#fid=3901') ,
(16,'Erdal ','Beşer','Prof. Dr.','Halk Sağlığı','Erkek','1980-10-22','40','https://www.doktortakvimi.com/erdal-beser/halk-sagligi/aydin#fid=3901') ,
(17,'Faruk ','Demir ','Uzm. Dr. ','Çocuk Sağlığı Ve Hastalıkları','Erkek','1980-12-23','40','https://www.doktortakvimi.com/faruk-demir-3/cocuk-alerjisi-cocuk-immunolojisi-cocuk-sagligi-ve-hastaliklari/aydin') ,
(18,'Elif Pelin','Özbay ','Op. Dr.','Kadın Hastalıkları Ve Doğum','Kadın','1980-12-01','40','https://www.doktortakvimi.com/elif-pelin-ozbay/kadin-hastaliklari-ve-dogum/aydin') ,
(19,'Olcay','Barış ','Uzm. Dyt.','Diyetisyen','Kadın','1980-05-24','40','https://www.doktortakvimi.com/olcay-baris/diyetisyen/aydin') ,
(20,'Ezgi Avkan','Bilgiç ','Uzm. Psk. ','Psikoloji','Kadın','1980-07-28','40','https://www.doktortakvimi.com/ezgi-avkan-bilgic/psikoloji/aydin') ;

		--Randevu : İnserted-28/07/2020
INSERT INTO "Tedavi Şema"."Randevu" 
( "Doktor ID", "Hasta ID", "Başlangıç Zamanı", "Bitiş Zamanı", "Randevu Tarihi", "Geldimi") 
VALUES 
(1,1,'09:10 AM','09:30 AM','2020-07-28','Evet') ,
(2,2,'09:40 AM','10:00 AM','2020-07-28','Evet') ,
(3,3,'10:10 AM','10:30 AM','2020-07-28','Hayır') ,
(4,4,'10:40 AM','11:00 AM','2020-07-28','Evet') ,
(5,5,'11:10 AM','11:30 AM','2020-07-28','Hayır') ,
(6,6,'09:10 AM','09:30 AM','2020-07-29','Hayır') ,
(7,7,'09:40 AM','10:00 AM','2020-07-29','Evet') ,
(8,8,'10:10 AM','10:30 AM','2020-07-29','Evet') ,
(9,9,'10:40 AM','11:00 AM','2020-07-29','Evet') ,
(10,10,'11:10 AM','11:30 AM','2020-07-29','Hayır') ;

        --Hemşire : İnserted-30/07/2020
INSERT INTO "Çalışan Şema"."Hemşire" 
( "Doktor ID", "Adres ID", "Hemşire Adı", "Hemşire Soyadı", "Cinsiyet", "Seviye", "Dogum Tarihi", "Yaş") 
VALUES 
(1,11,'Selin','Gem','Kadın',2,'1980-04-12','40') ,
(2,12,'Ali','Demirci','Erkek',1,'1980-07-13','40') ,
(3,13,'Furkan','Gültin','Erkek',1,'1980-12-04','40') ,
(4,14,'Salim Can','Han','Erkek',3,'1980-12-06','40') ,
(5,15,'İrem','Deri','Kadın',1,'1980-04-03','40') ,
(6,16,'Hasan','Tel','Erkek',1,'1980-07-19','40') ,
(7,17,'Gürkan','Can','Erkek',2,'1980-11-07','40') ,
(8,18,'Seda','Lal','Kadın',3,'1980-10-07','40') ,
(9,19,'Remzi','Fal','Erkek',3,'1980-01-04','40') ,
(10,20,'Nergiz','Gül','Kadın',3,'1980-01-07','40') ;

        --Stok Yönetimi : İnserted-30/07/2020
INSERT INTO "Ürün Yönetimi Şema"."Stok Yonetimi"(
"Envanter ID","Hemşire ID")
VALUES
(1,1) ,
(2,2) ,
(3,3) ,
(4,4) ,
(5,5) ,
(6,6) ,
(7,7) ,
(8,8) ,
(9,9) ,
(10,10) ;


--fonksiyon kullanımı : Klasik sorgu yöntemi  
SELECT * FROM  "Tedavi Şema"."Yatan Hasta Yönetimi"();

--fonksiyonu kullanımı : Foksiyon içine hemşire ID değerini almak zorunda
SELECT * FROM "Çalışan Şema"."Hemşire Bul Fonksiyon"(5) ;

--Foksiyon kullanımı : Klasik sorgu yöntemi
SELECT * FROM "Bilgi Şema"."Acil Durum Yönetimi"() ;

--fonksiyon kullanımı : Klasik sorgu yöntemi
SELECT * FROM "Çalışan Şema"."Doktor Ünvan Yönetimi"() ;

--View Kullanımı : Klasik sorgu yöntemi
SELECT * FROM "Oda Şema"."Boş Oda Listeleme" ;

-- vieew Kullanımı : Klasik sorgu yöntemi
SELECT * FROM "Tedavi Ücret Şema"."Ödeme Bilgi" ;

/*Trigger Kullanımı : Trigger için yaratılmış Hasta Geçmiş tablosu kullanılarak  klasik sorgu yöntemi kullanılır .*/
/*Fakat Trigger kullanılabilmei için öncelikle update işlemi yapılmalıdır*/
update "Bilgi Şema"."Hasta"
set 
"Telefon Numarası" = '05423572345' ,
"Acil Durumda Aranacak Numara" = '05412792156'
where "Hasta ID" = 1;
SELECT * FROM "Bilgi Şema"."Hasta Geçmiş" ;

/*Trigger Kullanımı : Trigger için yaratılmış Envater Satın alma tablosu kullanılarak  klasik sorgu yöntemi kullanılır .*/
SELECT * FROM "Ürün Yönetimi Şema"."Envanter Satın Alma" ;

/* Trigger Kullanımım : Bu trigger View Silme işlemini aktif eder.Kullanımı Klasik view Silme
    yöntemi.*/
DELETE FROM "Tedavi Ücret Şema"."Ödeme Bilgi" WHERE "Ödeme ID"= 5;

/*  Trigger Kullanımı : Bu trigger de viewe veri girişi yapılasının önüne geçiliiyor.
    Kulanımı: klasik viewden veri ekleme metodu */
/*insert into "Oda Şema"."Boş Oda Listeleme"("Oda Tipi", "Oda Durumu") 
values('Operasyon Oda','Boş') ;
Bu inserti yaptığımda hata mesajı döndüğü için tablolar veritabanına kayedilmiyoro yüzden  yorum satırı içinde bıraktım .*/


