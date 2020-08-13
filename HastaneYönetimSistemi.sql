--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: Bilgi Şema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Bilgi Şema";


ALTER SCHEMA "Bilgi Şema" OWNER TO postgres;

--
-- Name: Oda Şema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Oda Şema";


ALTER SCHEMA "Oda Şema" OWNER TO postgres;

--
-- Name: Tedavi Ücret Şema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Tedavi Ücret Şema";


ALTER SCHEMA "Tedavi Ücret Şema" OWNER TO postgres;

--
-- Name: Tedavi Şema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Tedavi Şema";


ALTER SCHEMA "Tedavi Şema" OWNER TO postgres;

--
-- Name: Çalışan Şema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Çalışan Şema";


ALTER SCHEMA "Çalışan Şema" OWNER TO postgres;

--
-- Name: Ürün Yönetimi Şema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Ürün Yönetimi Şema";


ALTER SCHEMA "Ürün Yönetimi Şema" OWNER TO postgres;

--
-- Name: Acil Durum Yönetimi(); Type: FUNCTION; Schema: Bilgi Şema; Owner: postgres
--

CREATE FUNCTION "Bilgi Şema"."Acil Durum Yönetimi"() RETURNS TABLE("Hasta ID" integer, "Hasta Adı" character varying, "Acil Durumda Aranacak Kişi" character varying, "Acil Durumda Aranacak Numara" character varying)
    LANGUAGE plpgsql
    AS $$
    BEGIN
            RETURN QUERY SELECT 
            "Hasta"."Hasta ID","Hasta"."Hasta Adı","Hasta"."Acil Durumda Aranacak Kişi",
            "Hasta"."Acil Durumda Aranacak Numara"
            FROM "Bilgi Şema"."Hasta" ;
    END ; 
$$;


ALTER FUNCTION "Bilgi Şema"."Acil Durum Yönetimi"() OWNER TO postgres;

--
-- Name: Hasta Bilgi Yönetimi(); Type: FUNCTION; Schema: Bilgi Şema; Owner: postgres
--

CREATE FUNCTION "Bilgi Şema"."Hasta Bilgi Yönetimi"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION "Bilgi Şema"."Hasta Bilgi Yönetimi"() OWNER TO postgres;

--
-- Name: Boş Oda Listeleme View Eayıt Ekleme(); Type: FUNCTION; Schema: Oda Şema; Owner: postgres
--

CREATE FUNCTION "Oda Şema"."Boş Oda Listeleme View Eayıt Ekleme"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
        RAISE EXCEPTION 'Bu view e Kayıt ekleme yapılamamaktadır...' ;        
END ;
$$;


ALTER FUNCTION "Oda Şema"."Boş Oda Listeleme View Eayıt Ekleme"() OWNER TO postgres;

--
-- Name: Ödeme View Silme(); Type: FUNCTION; Schema: Tedavi Ücret Şema; Owner: postgres
--

CREATE FUNCTION "Tedavi Ücret Şema"."Ödeme View Silme"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
        DELETE FROM "Tedavi Ücret Şema"."Ödeme"
        WHERE "Ödeme ID" = old."Ödeme ID" ;
        RETURN OLD ;
END ;
$$;


ALTER FUNCTION "Tedavi Ücret Şema"."Ödeme View Silme"() OWNER TO postgres;

--
-- Name: Yatan Hasta Yönetimi(); Type: FUNCTION; Schema: Tedavi Şema; Owner: postgres
--

CREATE FUNCTION "Tedavi Şema"."Yatan Hasta Yönetimi"() RETURNS TABLE("Hasta ID" integer, "Hasta Adı" character varying, "Hasta Soyadı" character varying, "Tanı Tipi" character varying, "Yatış Tarihi" date, "Taburcu Tarihi" date)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION "Tedavi Şema"."Yatan Hasta Yönetimi"() OWNER TO postgres;

--
-- Name: Doktor Ünvan Yönetimi(); Type: FUNCTION; Schema: Çalışan Şema; Owner: postgres
--

CREATE FUNCTION "Çalışan Şema"."Doktor Ünvan Yönetimi"() RETURNS TABLE("Doktor ID" integer, "Doktor Adı" character varying, "Doktor Soyadı" character varying, "Doktor Unvan" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "Doktor"."Doktor ID","Doktor"."Doktor Adı",
    "Doktor"."Doktor Soyadı" , "Doktor"."Doktor Unvan"
    FROM "Çalışan Şema"."Doktor" ;
END ;    
$$;


ALTER FUNCTION "Çalışan Şema"."Doktor Ünvan Yönetimi"() OWNER TO postgres;

--
-- Name: Hemşire Bul Fonksiyon(integer); Type: FUNCTION; Schema: Çalışan Şema; Owner: postgres
--

CREATE FUNCTION "Çalışan Şema"."Hemşire Bul Fonksiyon"("Hemşire Bul ID" integer) RETURNS TABLE("Hemşire ID" integer, "Doktor ID" integer, "Adres ID" integer, "Hemşire Adı" character varying, "Hemşire Soyadı" character varying, "Cinsiyet" character varying, "Seviye" integer, "Dogum Tarihi" date, "Yaş" integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT * FROM "Çalışan Şema"."Hemşire" 
    WHERE "Hemşire"."Hemşire ID" = "Hemşire Bul ID" ;
END ;
$$;


ALTER FUNCTION "Çalışan Şema"."Hemşire Bul Fonksiyon"("Hemşire Bul ID" integer) OWNER TO postgres;

--
-- Name: Envanter Yönetimi(); Type: FUNCTION; Schema: Ürün Yönetimi Şema; Owner: postgres
--

CREATE FUNCTION "Ürün Yönetimi Şema"."Envanter Yönetimi"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION "Ürün Yönetimi Şema"."Envanter Yönetimi"() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Adres; Type: TABLE; Schema: Bilgi Şema; Owner: postgres
--

CREATE TABLE "Bilgi Şema"."Adres" (
    "Adres ID" integer NOT NULL,
    "Adres" character varying(200) NOT NULL,
    "Ilçe" character varying(50) NOT NULL,
    "Il" character varying(50) NOT NULL,
    "Ülke" character varying(50) NOT NULL,
    "Posta Kodu" character varying(10) NOT NULL
);


ALTER TABLE "Bilgi Şema"."Adres" OWNER TO postgres;

--
-- Name: Adres_Adres ID_seq; Type: SEQUENCE; Schema: Bilgi Şema; Owner: postgres
--

ALTER TABLE "Bilgi Şema"."Adres" ALTER COLUMN "Adres ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Bilgi Şema"."Adres_Adres ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Hasta; Type: TABLE; Schema: Bilgi Şema; Owner: postgres
--

CREATE TABLE "Bilgi Şema"."Hasta" (
    "Hasta ID" integer NOT NULL,
    "Sigorta ID" integer NOT NULL,
    "Adres ID" integer NOT NULL,
    "Tc Kimlik No" character varying(50) NOT NULL,
    "Hasta Adı" character varying(50) NOT NULL,
    "Hasta Soyadı" character varying(50) NOT NULL,
    "Baba Adı" character varying(50) NOT NULL,
    "Doğum Tarihi" date NOT NULL,
    "Cinsiyet" character varying(50) NOT NULL,
    "Telefon Numarası" character varying(50) NOT NULL,
    "Acil Durumda Aranacak Kişi" character varying(50) NOT NULL,
    "Acil Durumda Aranacak Numara" character varying(50) NOT NULL,
    "Yaş" integer,
    CONSTRAINT check_hasta_cinsiyet CHECK ((("Cinsiyet")::text = ANY ((ARRAY['Erkek'::character varying, 'Kadın'::character varying])::text[])))
);


ALTER TABLE "Bilgi Şema"."Hasta" OWNER TO postgres;

--
-- Name: Hasta Geçmiş; Type: TABLE; Schema: Bilgi Şema; Owner: postgres
--

CREATE TABLE "Bilgi Şema"."Hasta Geçmiş" (
    "Hasta Geçmiş ID" integer NOT NULL,
    "Hasta ID" integer NOT NULL,
    "Sigorta ID" integer NOT NULL,
    "Adres ID" integer NOT NULL,
    "Tc Kimlik No" character varying(50) NOT NULL,
    "Hasta Adı" character varying(50) NOT NULL,
    "Hasta Soyadı" character varying(50) NOT NULL,
    "Baba Adı" character varying(50) NOT NULL,
    "Doğum Tarihi" date NOT NULL,
    "Cinsiyet" character varying(50) NOT NULL,
    "Telefon Numarası" character varying(50) NOT NULL,
    "Acil Durumda Aranacak Kişi" character varying(50) NOT NULL,
    "Acil Durumda Aranacak Numara" character varying(50) NOT NULL,
    "Yaş" integer,
    "Değiştirilme Zamanı" timestamp(4) without time zone
);


ALTER TABLE "Bilgi Şema"."Hasta Geçmiş" OWNER TO postgres;

--
-- Name: Hasta Geçmiş_Hasta Geçmiş ID_seq; Type: SEQUENCE; Schema: Bilgi Şema; Owner: postgres
--

ALTER TABLE "Bilgi Şema"."Hasta Geçmiş" ALTER COLUMN "Hasta Geçmiş ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Bilgi Şema"."Hasta Geçmiş_Hasta Geçmiş ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Hasta_Hasta ID_seq; Type: SEQUENCE; Schema: Bilgi Şema; Owner: postgres
--

ALTER TABLE "Bilgi Şema"."Hasta" ALTER COLUMN "Hasta ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Bilgi Şema"."Hasta_Hasta ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Hasta Odası; Type: TABLE; Schema: Oda Şema; Owner: postgres
--

CREATE TABLE "Oda Şema"."Hasta Odası" (
    "Oda ID" integer NOT NULL,
    "Oda Tipi" character varying(255) NOT NULL,
    "Oda Durumu" character varying(255) NOT NULL
);


ALTER TABLE "Oda Şema"."Hasta Odası" OWNER TO postgres;

--
-- Name: Boş Oda Listeleme; Type: VIEW; Schema: Oda Şema; Owner: postgres
--

CREATE VIEW "Oda Şema"."Boş Oda Listeleme" AS
 SELECT "Hasta Odası"."Oda ID",
    "Hasta Odası"."Oda Tipi",
    "Hasta Odası"."Oda Durumu"
   FROM "Oda Şema"."Hasta Odası"
  WHERE (("Hasta Odası"."Oda Durumu")::text = 'Boş'::text);


ALTER TABLE "Oda Şema"."Boş Oda Listeleme" OWNER TO postgres;

--
-- Name: Hasta Odası_Oda ID_seq; Type: SEQUENCE; Schema: Oda Şema; Owner: postgres
--

ALTER TABLE "Oda Şema"."Hasta Odası" ALTER COLUMN "Oda ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Oda Şema"."Hasta Odası_Oda ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Operasyon Oda; Type: TABLE; Schema: Oda Şema; Owner: postgres
--

CREATE TABLE "Oda Şema"."Operasyon Oda" (
    "Operasyon Oda ID" integer NOT NULL,
    "Oda ID" integer NOT NULL,
    "Tipi" character varying(255) NOT NULL,
    "Durum" character varying(255) NOT NULL
);


ALTER TABLE "Oda Şema"."Operasyon Oda" OWNER TO postgres;

--
-- Name: Operasyon Oda_Operasyon Oda ID_seq; Type: SEQUENCE; Schema: Oda Şema; Owner: postgres
--

ALTER TABLE "Oda Şema"."Operasyon Oda" ALTER COLUMN "Operasyon Oda ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Oda Şema"."Operasyon Oda_Operasyon Oda ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Sigorta; Type: TABLE; Schema: Tedavi Ücret Şema; Owner: postgres
--

CREATE TABLE "Tedavi Ücret Şema"."Sigorta" (
    "Sigorta ID" integer NOT NULL,
    "Sigorta Tipi" character varying(50) NOT NULL,
    "Sigorta Şirketi" character varying(50) NOT NULL,
    "Şirket Telefon Numarası" character varying(20) NOT NULL,
    "Teminat" integer,
    CONSTRAINT check_sigorta_teminat CHECK (("Teminat" > 50000))
);


ALTER TABLE "Tedavi Ücret Şema"."Sigorta" OWNER TO postgres;

--
-- Name: Sigorta_Sigorta ID_seq; Type: SEQUENCE; Schema: Tedavi Ücret Şema; Owner: postgres
--

ALTER TABLE "Tedavi Ücret Şema"."Sigorta" ALTER COLUMN "Sigorta ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Tedavi Ücret Şema"."Sigorta_Sigorta ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Ödeme; Type: TABLE; Schema: Tedavi Ücret Şema; Owner: postgres
--

CREATE TABLE "Tedavi Ücret Şema"."Ödeme" (
    "Ödeme ID" integer NOT NULL,
    "Sigorta ID" integer NOT NULL,
    "Ödeme Tipi" character varying(50) NOT NULL,
    "Ödeme Metodu" character varying(50) NOT NULL,
    "Ödenecek Tutar" integer NOT NULL,
    "Ödeme Durumu" character varying(10) NOT NULL,
    CONSTRAINT "check_Ödeme_Ödeneceektutar_Ödemedurumu" CHECK ((("Ödenecek Tutar" > 60000) AND ((("Ödeme Durumu")::text = 'Evet'::text) OR (("Ödeme Durumu")::text = 'Hayır'::text))))
);


ALTER TABLE "Tedavi Ücret Şema"."Ödeme" OWNER TO postgres;

--
-- Name: Ödeme Bilgi; Type: VIEW; Schema: Tedavi Ücret Şema; Owner: postgres
--

CREATE VIEW "Tedavi Ücret Şema"."Ödeme Bilgi" AS
 SELECT "Ödeme"."Ödeme ID",
    "Sigorta"."Sigorta Şirketi",
    "Ödeme"."Ödeme Durumu"
   FROM ("Tedavi Ücret Şema"."Ödeme"
     JOIN "Tedavi Ücret Şema"."Sigorta" ON (("Ödeme"."Sigorta ID" = "Sigorta"."Sigorta ID")))
  ORDER BY "Ödeme"."Ödeme ID";


ALTER TABLE "Tedavi Ücret Şema"."Ödeme Bilgi" OWNER TO postgres;

--
-- Name: Ödeme_Ödeme ID_seq; Type: SEQUENCE; Schema: Tedavi Ücret Şema; Owner: postgres
--

ALTER TABLE "Tedavi Ücret Şema"."Ödeme" ALTER COLUMN "Ödeme ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Tedavi Ücret Şema"."Ödeme_Ödeme ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Ayakta Tedavi; Type: TABLE; Schema: Tedavi Şema; Owner: postgres
--

CREATE TABLE "Tedavi Şema"."Ayakta Tedavi" (
    "Hasta ID" integer NOT NULL
);


ALTER TABLE "Tedavi Şema"."Ayakta Tedavi" OWNER TO postgres;

--
-- Name: Randevu; Type: TABLE; Schema: Tedavi Şema; Owner: postgres
--

CREATE TABLE "Tedavi Şema"."Randevu" (
    "Randevu ID" integer NOT NULL,
    "Doktor ID" integer NOT NULL,
    "Hasta ID" integer NOT NULL,
    "Başlangıç Zamanı" character varying(15) NOT NULL,
    "Bitiş Zamanı" character varying(15) NOT NULL,
    "Randevu Tarihi" character varying(15) NOT NULL,
    "Geldimi" character varying(50) NOT NULL,
    CONSTRAINT check_randevu_geldimi CHECK (((("Geldimi")::text = 'Evet'::text) OR (("Geldimi")::text = 'Hayır'::text)))
);


ALTER TABLE "Tedavi Şema"."Randevu" OWNER TO postgres;

--
-- Name: Randevu_Randevu ID_seq; Type: SEQUENCE; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE "Tedavi Şema"."Randevu" ALTER COLUMN "Randevu ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Tedavi Şema"."Randevu_Randevu ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Tanı; Type: TABLE; Schema: Tedavi Şema; Owner: postgres
--

CREATE TABLE "Tedavi Şema"."Tanı" (
    "Tanı ID" integer NOT NULL,
    "Tanı Tipi" character varying(250) NOT NULL,
    "Sonuç" character varying(250) NOT NULL,
    CONSTRAINT "check_tanı_sonuç" CHECK ((("Sonuç")::text = ANY ((ARRAY['Pozitif'::character varying, 'Negatif'::character varying, 'Yetersiz Sonuc'::character varying])::text[])))
);


ALTER TABLE "Tedavi Şema"."Tanı" OWNER TO postgres;

--
-- Name: Tanı_Tanı ID_seq; Type: SEQUENCE; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE "Tedavi Şema"."Tanı" ALTER COLUMN "Tanı ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Tedavi Şema"."Tanı_Tanı ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Test Sonuçları; Type: TABLE; Schema: Tedavi Şema; Owner: postgres
--

CREATE TABLE "Tedavi Şema"."Test Sonuçları" (
    "Test ID" integer NOT NULL,
    "Hasta ID" integer NOT NULL,
    "Tanı ID" integer NOT NULL,
    "Kan Grubu" character varying(250) NOT NULL,
    "Hemoglobin" numeric NOT NULL,
    "WBC" numeric NOT NULL,
    "RBC" numeric NOT NULL,
    "Kolestrol" integer NOT NULL,
    "Buyük Tansiyon" integer NOT NULL,
    "Kuçük Tansiyon" integer NOT NULL
);


ALTER TABLE "Tedavi Şema"."Test Sonuçları" OWNER TO postgres;

--
-- Name: Test Sonuçları_Test ID_seq; Type: SEQUENCE; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE "Tedavi Şema"."Test Sonuçları" ALTER COLUMN "Test ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Tedavi Şema"."Test Sonuçları_Test ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Yatan Hasta Bilgi; Type: TABLE; Schema: Tedavi Şema; Owner: postgres
--

CREATE TABLE "Tedavi Şema"."Yatan Hasta Bilgi" (
    "Hasta ID" integer NOT NULL,
    "Oda ID" integer NOT NULL,
    "Kabul Tarihi" date NOT NULL,
    "Taburcu Tarihi" date
);


ALTER TABLE "Tedavi Şema"."Yatan Hasta Bilgi" OWNER TO postgres;

--
-- Name: Doktor; Type: TABLE; Schema: Çalışan Şema; Owner: postgres
--

CREATE TABLE "Çalışan Şema"."Doktor" (
    "Doktor ID" integer NOT NULL,
    "Adres ID" integer NOT NULL,
    "Doktor Adı" character varying(255) NOT NULL,
    "Doktor Soyadı" character varying(50) NOT NULL,
    "Doktor Unvan" character varying(50) NOT NULL,
    "Uzmanlık" character varying(255) NOT NULL,
    "Cinsiyet" character varying(50) NOT NULL,
    "Dogum Tarihi" date NOT NULL,
    "DoktorUrl" character varying(200) NOT NULL,
    "Yaş" integer,
    CONSTRAINT check_doktor_cinsiyet CHECK ((("Cinsiyet")::text = ANY ((ARRAY['Erkek'::character varying, 'Kadın'::character varying])::text[])))
);


ALTER TABLE "Çalışan Şema"."Doktor" OWNER TO postgres;

--
-- Name: Doktor_Doktor ID_seq; Type: SEQUENCE; Schema: Çalışan Şema; Owner: postgres
--

ALTER TABLE "Çalışan Şema"."Doktor" ALTER COLUMN "Doktor ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Çalışan Şema"."Doktor_Doktor ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Hemşire; Type: TABLE; Schema: Çalışan Şema; Owner: postgres
--

CREATE TABLE "Çalışan Şema"."Hemşire" (
    "Hemşire ID" integer NOT NULL,
    "Doktor ID" integer NOT NULL,
    "Adres ID" integer NOT NULL,
    "Hemşire Adı" character varying(50) NOT NULL,
    "Hemşire Soyadı" character varying(50) NOT NULL,
    "Cinsiyet" character varying(50) NOT NULL,
    "Seviye" integer NOT NULL,
    "Dogum Tarihi" date NOT NULL,
    "Yaş" integer,
    CONSTRAINT "check_hemşirecinsiyet_seviye" CHECK (((("Cinsiyet")::text = ANY ((ARRAY['Erkek'::character varying, 'Kadın'::character varying])::text[])) AND ("Seviye" = ANY (ARRAY[1, 2, 3]))))
);


ALTER TABLE "Çalışan Şema"."Hemşire" OWNER TO postgres;

--
-- Name: Hemşire_Hemşire ID_seq; Type: SEQUENCE; Schema: Çalışan Şema; Owner: postgres
--

ALTER TABLE "Çalışan Şema"."Hemşire" ALTER COLUMN "Hemşire ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Çalışan Şema"."Hemşire_Hemşire ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Envanter; Type: TABLE; Schema: Ürün Yönetimi Şema; Owner: postgres
--

CREATE TABLE "Ürün Yönetimi Şema"."Envanter" (
    "Envanter ID" integer NOT NULL,
    "Envanter Ismi" character varying(250) NOT NULL,
    "Envanter Marka" character varying(250) NOT NULL,
    "Envanter Model" character varying(250) NOT NULL,
    "Envanter Seri No" character varying(250) NOT NULL,
    "Envanter Durumu" character varying(100) NOT NULL,
    "Birim Fiyat" money NOT NULL,
    "Envanter Sayısı" integer NOT NULL,
    CONSTRAINT check_envanter_envanterdurumu CHECK ((("Envanter Durumu")::text = ANY ((ARRAY['Yeterli Sayıda Var'::character varying, 'Sipariş Edildi'::character varying, 'Sipariş Edilecek'::character varying])::text[])))
);


ALTER TABLE "Ürün Yönetimi Şema"."Envanter" OWNER TO postgres;

--
-- Name: Envanter Satın Alma; Type: TABLE; Schema: Ürün Yönetimi Şema; Owner: postgres
--

CREATE TABLE "Ürün Yönetimi Şema"."Envanter Satın Alma" (
    "Satın Alma ID" integer NOT NULL,
    "Envanter ID" integer NOT NULL,
    "Envanter Adı" character varying(50) NOT NULL,
    "Toplam Ücret" money NOT NULL,
    "Satın Alım Zamanı" timestamp(4) without time zone
);


ALTER TABLE "Ürün Yönetimi Şema"."Envanter Satın Alma" OWNER TO postgres;

--
-- Name: Envanter Satın Alma_Satın Alma ID_seq; Type: SEQUENCE; Schema: Ürün Yönetimi Şema; Owner: postgres
--

ALTER TABLE "Ürün Yönetimi Şema"."Envanter Satın Alma" ALTER COLUMN "Satın Alma ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Ürün Yönetimi Şema"."Envanter Satın Alma_Satın Alma ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Envanter_Envanter ID_seq; Type: SEQUENCE; Schema: Ürün Yönetimi Şema; Owner: postgres
--

ALTER TABLE "Ürün Yönetimi Şema"."Envanter" ALTER COLUMN "Envanter ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Ürün Yönetimi Şema"."Envanter_Envanter ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Stok Yonetimi; Type: TABLE; Schema: Ürün Yönetimi Şema; Owner: postgres
--

CREATE TABLE "Ürün Yönetimi Şema"."Stok Yonetimi" (
    "Stok Yonetimi ID" integer NOT NULL,
    "Envanter ID" integer NOT NULL,
    "Hemşire ID" integer NOT NULL
);


ALTER TABLE "Ürün Yönetimi Şema"."Stok Yonetimi" OWNER TO postgres;

--
-- Name: Stok Yonetimi_Stok Yonetimi ID_seq; Type: SEQUENCE; Schema: Ürün Yönetimi Şema; Owner: postgres
--

ALTER TABLE "Ürün Yönetimi Şema"."Stok Yonetimi" ALTER COLUMN "Stok Yonetimi ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "Ürün Yönetimi Şema"."Stok Yonetimi_Stok Yonetimi ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: Adres; Type: TABLE DATA; Schema: Bilgi Şema; Owner: postgres
--

INSERT INTO "Bilgi Şema"."Adres" ("Adres ID", "Adres", "Ilçe", "Il", "Ülke", "Posta Kodu") OVERRIDING SYSTEM VALUE VALUES
	(1, 'Aydın/Aydın Merkez /Efeler Mahallesi No:5/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(2, 'Aydın/Aydın Merkez /Mimarsinan Mahallesi No:10/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(3, 'Aydın/Didim Mrkez/Yeni Mahallesi No:4/A', 'Didim', 'Aydın', 'Türkiye', '09500'),
	(4, 'Aydın/Didim Merkez /Denizköy Mahallesi No:5/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(5, 'Aydın/Didim Merkez /Altınkum Mahallesi No:6/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(6, 'Aydın/Didim Merkez /Balat Mahallesi No:7/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(7, 'Aydın/Kuşadası Merkez /Cumhuriyet Mahallesi No:8/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(8, 'Aydın/Kuşadası Merkez /Türkşanlı Mahallesi No:9/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(9, 'Aydın/Kuşadası Merkez /Yavansu Mahallesi No:10/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(10, 'Aydın/Kuşadası Merkez /Kadıkalesi Mahallesi No:11/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(11, 'Aydın/Aydın Merkez/Cumhuriyet Mahallesi İzmir Bulvarı No:38/1', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(12, 'Aydın/Aydın Merkez/Kurtuluş Mah. No:32A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(13, 'Aydın/Aydın Merkez/Efeler Mahallesi İzmir Yolu No: 107/2,', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(14, 'Aydın/Aydın Merkez/Güzelhisar Mahallesi 35. Sokak No:8/A', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(15, 'Aydın/Aydın Merkez/Güzelhisar Mahallesi  No:91 Kat:2', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(16, 'Aydın/Yenipazar Merkez/Asyo Binası Kat:3', 'Yenipazar', 'Aydın', 'Türkiye', '09500'),
	(17, 'Aydın/Aydın Merkez/Mimar Sinan Mahallesi 2383. Sokak No:1/3', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(18, 'Aydın/Aydın Merkez/Mimar Sinan mahallesi  B blok / No: 67 /4', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(19, 'Aydın/Aydın Merkez/Argos Plaza Cumhuriyet Mahallesi 1955.Sok No:1', 'Efeler', 'Aydın', 'Türkiye', '09500'),
	(20, 'Aydın/Aydın Merkez/Kurtuluş Mahallesi Adnan Menderes Bulvarı No:56/9', 'Efeler', 'Aydın', 'Türkiye', '09500');


--
-- Data for Name: Hasta; Type: TABLE DATA; Schema: Bilgi Şema; Owner: postgres
--

INSERT INTO "Bilgi Şema"."Hasta" ("Hasta ID", "Sigorta ID", "Adres ID", "Tc Kimlik No", "Hasta Adı", "Hasta Soyadı", "Baba Adı", "Doğum Tarihi", "Cinsiyet", "Telefon Numarası", "Acil Durumda Aranacak Kişi", "Acil Durumda Aranacak Numara", "Yaş") OVERRIDING SYSTEM VALUE VALUES
	(2, 2, 2, '22222222222', 'Denizhan', 'Sea', 'Cemal', '1997-07-24', 'Erkek', '05131313131', 'Cemal', '05222222222', 23),
	(3, 3, 3, '33333333333', 'Salih', 'Dem', 'Fazıl', '1995-04-24', 'Erkek', '05141414141', 'Kemal', '05333333333', 25),
	(4, 4, 4, '44444444444', 'Kemal', 'Lal', 'Remzi', '1994-02-12', 'Erkek', '05151515151', 'Remzi', '05444444444', 26),
	(5, 5, 5, '55555555555', 'Cemal', 'Şen', 'Selim', '1993-12-30', 'Erkek', '05161616161', 'Selim', '05555555555', 27),
	(6, 6, 6, '66666666666', 'Lale', 'Han', 'Mert', '1992-11-12', 'Kadın', '05171717171', 'Mert', '05666666666', 28),
	(7, 7, 7, '77777777777', 'Zeynep', 'Alemdar', 'Olcay', '1991-10-09', 'Kadın', '05181818181', 'Olcay', '05777777777', 29),
	(8, 8, 8, '88888888888', 'Demir', 'Jel', 'Turgut', '1990-09-24', 'Erkek', '05191919191', 'Turgut', '05888888888', 30),
	(9, 9, 9, '99999999999', 'Emre', 'AL', 'Remzi', '1989-10-29', 'Erkek', '05212121212', 'Remzi', '05999999999', 31),
	(10, 10, 10, '10101010101', 'Veysal', 'Teneke', 'Ferit', '1988-03-07', 'Erkek', '05222222222', 'Ferit', '05101010101', 32),
	(1, 1, 1, '11111111111', 'Oğuzhan', 'Can', 'Mustafa', '1999-01-04', 'Erkek', '05423572345', 'Mustafa', '05412792156', 21);


--
-- Data for Name: Hasta Geçmiş; Type: TABLE DATA; Schema: Bilgi Şema; Owner: postgres
--

INSERT INTO "Bilgi Şema"."Hasta Geçmiş" ("Hasta Geçmiş ID", "Hasta ID", "Sigorta ID", "Adres ID", "Tc Kimlik No", "Hasta Adı", "Hasta Soyadı", "Baba Adı", "Doğum Tarihi", "Cinsiyet", "Telefon Numarası", "Acil Durumda Aranacak Kişi", "Acil Durumda Aranacak Numara", "Yaş", "Değiştirilme Zamanı") OVERRIDING SYSTEM VALUE VALUES
	(1, 1, 1, 1, '11111111111', 'Oğuzhan', 'Can', 'Mustafa', '1999-01-04', 'Erkek', '05121212121', 'Mustafa', '05111111111', 21, '2020-08-13 13:25:17.6714');


--
-- Data for Name: Hasta Odası; Type: TABLE DATA; Schema: Oda Şema; Owner: postgres
--

INSERT INTO "Oda Şema"."Hasta Odası" ("Oda ID", "Oda Tipi", "Oda Durumu") OVERRIDING SYSTEM VALUE VALUES
	(1, 'Operasyon Odası', 'Müsait'),
	(2, 'Operasyon Odası', 'Müsait'),
	(3, 'Operasyon Odası', 'Müsait'),
	(4, 'Operasyon Odası', 'Müsait'),
	(5, 'Hasta Odası', 'Müsait'),
	(6, 'Operasyon Odası', 'Boş'),
	(7, 'Operasyon Odası', 'Boş'),
	(8, 'Hasta Odası', 'Dolu'),
	(9, 'Hasta Odası', 'Boş'),
	(10, 'Hasta Odası', 'Dolu');


--
-- Data for Name: Operasyon Oda; Type: TABLE DATA; Schema: Oda Şema; Owner: postgres
--

INSERT INTO "Oda Şema"."Operasyon Oda" ("Operasyon Oda ID", "Oda ID", "Tipi", "Durum") OVERRIDING SYSTEM VALUE VALUES
	(1, 1, 'Acil Yoğun Bakım', 'Müsait'),
	(2, 2, 'Acil Muayene ', 'Müsait'),
	(3, 3, 'Yoğun Bakım Odası', 'Müsait'),
	(4, 4, 'Ameliyat Odası', 'Müsait'),
	(5, 5, 'Poliklinik', 'Müsait');


--
-- Data for Name: Sigorta; Type: TABLE DATA; Schema: Tedavi Ücret Şema; Owner: postgres
--

INSERT INTO "Tedavi Ücret Şema"."Sigorta" ("Sigorta ID", "Sigorta Tipi", "Sigorta Şirketi", "Şirket Telefon Numarası", "Teminat") OVERRIDING SYSTEM VALUE VALUES
	(1, 'Çalışan', 'SGK', '0212 372 10 00', 61000),
	(2, 'Bireysel', 'AXA SİGORTA A.Ş.', '444 2727', 100000),
	(3, 'Emekli', 'SGK', '0 216 170 11 22', 60001),
	(4, 'Çalışan', 'Allianz Sigorta A.Ş.', '0850 399 9999', 100000),
	(5, 'Bireysel', 'SGK', '0212 372 10 00', 70000),
	(6, 'Emekli', 'Allianz Hayat ve Emeklilik A.Ş.', '0850 399 9999', 150000),
	(7, 'Çalışan', 'Groupama Sigorta A.Ş.', '0 850 250 50 50', 90000),
	(8, 'Seyahat Sağlık Sigortası', 'Allianz Sigorta A.Ş.', '0850 399 9999', 300000),
	(9, 'Hayat Sigortası', 'Allianz Sigorta A.Ş.', '0850 399 9999', 1000000),
	(10, 'Hayat Sigortası', 'SGK', '0212 372 10 00', 100000);


--
-- Data for Name: Ödeme; Type: TABLE DATA; Schema: Tedavi Ücret Şema; Owner: postgres
--

INSERT INTO "Tedavi Ücret Şema"."Ödeme" ("Ödeme ID", "Sigorta ID", "Ödeme Tipi", "Ödeme Metodu", "Ödenecek Tutar", "Ödeme Durumu") OVERRIDING SYSTEM VALUE VALUES
	(1, 1, 'Tam', 'Çek', 61000, 'Evet'),
	(2, 2, 'Tam', 'Online', 60100, 'Evet'),
	(3, 3, 'Tam', 'Çek', 70000, 'Evet'),
	(4, 4, 'Tam', 'Kredi Kartı', 75000, 'Evet'),
	(6, 6, 'Eksik', 'Online', 80000, 'Hayır'),
	(7, 7, 'Eksik', 'Çek', 60010, 'Hayır'),
	(8, 8, 'Eksik', 'Online', 70000, 'Hayır'),
	(9, 9, 'Eksik', 'Çek', 90000, 'Hayır'),
	(10, 10, 'Eksik', 'Kredi Kartı', 100000, 'Hayır');


--
-- Data for Name: Ayakta Tedavi; Type: TABLE DATA; Schema: Tedavi Şema; Owner: postgres
--

INSERT INTO "Tedavi Şema"."Ayakta Tedavi" ("Hasta ID") VALUES
	(6),
	(7),
	(8),
	(9),
	(10);


--
-- Data for Name: Randevu; Type: TABLE DATA; Schema: Tedavi Şema; Owner: postgres
--

INSERT INTO "Tedavi Şema"."Randevu" ("Randevu ID", "Doktor ID", "Hasta ID", "Başlangıç Zamanı", "Bitiş Zamanı", "Randevu Tarihi", "Geldimi") OVERRIDING SYSTEM VALUE VALUES
	(1, 1, 1, '09:10 AM', '09:30 AM', '2020-07-28', 'Evet'),
	(2, 2, 2, '09:40 AM', '10:00 AM', '2020-07-28', 'Evet'),
	(3, 3, 3, '10:10 AM', '10:30 AM', '2020-07-28', 'Hayır'),
	(4, 4, 4, '10:40 AM', '11:00 AM', '2020-07-28', 'Evet'),
	(5, 5, 5, '11:10 AM', '11:30 AM', '2020-07-28', 'Hayır'),
	(6, 6, 6, '09:10 AM', '09:30 AM', '2020-07-29', 'Hayır'),
	(7, 7, 7, '09:40 AM', '10:00 AM', '2020-07-29', 'Evet'),
	(8, 8, 8, '10:10 AM', '10:30 AM', '2020-07-29', 'Evet'),
	(9, 9, 9, '10:40 AM', '11:00 AM', '2020-07-29', 'Evet'),
	(10, 10, 10, '11:10 AM', '11:30 AM', '2020-07-29', 'Hayır');


--
-- Data for Name: Tanı; Type: TABLE DATA; Schema: Tedavi Şema; Owner: postgres
--

INSERT INTO "Tedavi Şema"."Tanı" ("Tanı ID", "Tanı Tipi", "Sonuç") OVERRIDING SYSTEM VALUE VALUES
	(1, 'Kovid 19', 'Pozitif'),
	(2, 'Kovid 19', 'Negatif'),
	(3, 'HİV', 'Pozitif'),
	(4, 'Hepatit C', 'Negatif'),
	(5, 'Kaba Kulak', 'Pozitif'),
	(6, 'Böbrek Yetmezliği', 'Negatif'),
	(7, 'Hepatit B', 'Pozitif'),
	(8, 'Astım', 'Negatif'),
	(9, 'Grip', 'Pozitif'),
	(10, 'Enfeksiyon', 'Negatif');


--
-- Data for Name: Test Sonuçları; Type: TABLE DATA; Schema: Tedavi Şema; Owner: postgres
--

INSERT INTO "Tedavi Şema"."Test Sonuçları" ("Test ID", "Hasta ID", "Tanı ID", "Kan Grubu", "Hemoglobin", "WBC", "RBC", "Kolestrol", "Buyük Tansiyon", "Kuçük Tansiyon") OVERRIDING SYSTEM VALUE VALUES
	(1, 1, 1, '0 RH Pozitif', 13.5, 5.8, 8.9, 210, 113, 50),
	(2, 2, 2, '0 RH Negatif', 12.5, 5.7, 7.9, 100, 150, 90),
	(3, 3, 3, 'A RH Pozitif', 11.5, 5.7, 6.9, 120, 90, 40),
	(4, 4, 4, 'A RH Negatif', 10.5, 5.5, 5.3, 180, 150, 99),
	(5, 5, 5, 'B RH Pozitif', 9.5, 5.9, 5.5, 135, 130, 78),
	(6, 6, 6, 'B RH Negatif', 8.5, 5.1, 5.7, 160, 140, 88),
	(7, 7, 7, 'AB RH Pozitif', 7.5, 5.3, 5.3, 180, 100, 54),
	(8, 8, 8, 'AB RH Negatif', 6.5, 5.1, 5.6, 160, 110, 69),
	(9, 9, 9, 'A RH Pozitif', 5.5, 5.3, 5.8, 205, 120, 72),
	(10, 10, 10, 'B RH Pozitif', 4.5, 9.7, 5.6, 190, 130, 80);


--
-- Data for Name: Yatan Hasta Bilgi; Type: TABLE DATA; Schema: Tedavi Şema; Owner: postgres
--

INSERT INTO "Tedavi Şema"."Yatan Hasta Bilgi" ("Hasta ID", "Oda ID", "Kabul Tarihi", "Taburcu Tarihi") VALUES
	(1, 1, '2020-07-25', '2020-07-28'),
	(2, 2, '2020-07-28', '2020-07-28'),
	(3, 3, '2020-07-28', '2020-07-30'),
	(4, 4, '2020-07-28', '2020-07-28'),
	(5, 4, '2020-07-27', '2020-08-07');


--
-- Data for Name: Doktor; Type: TABLE DATA; Schema: Çalışan Şema; Owner: postgres
--

INSERT INTO "Çalışan Şema"."Doktor" ("Doktor ID", "Adres ID", "Doktor Adı", "Doktor Soyadı", "Doktor Unvan", "Uzmanlık", "Cinsiyet", "Dogum Tarihi", "DoktorUrl", "Yaş") OVERRIDING SYSTEM VALUE VALUES
	(1, 11, 'Emre', 'Çullu', 'Prof. Dr.', 'Ortopedi Ve Travmatoloji', 'Erkek', '1976-07-24', 'https://www.doktortakvimi.com/emre-cullu/ortopedi-ve-travmatoloji/aydin#fid=3901', 44),
	(2, 12, 'Ferah', 'Sönmez', 'Prof. Dr.', 'Çocuk Nefrolojisi', 'Erkek', '1980-04-22', 'https://www.doktortakvimi.com/ferah-sonmez/cocuk-nefrolojisi/aydin#fid=3901', 40),
	(3, 13, ' H. Alper', 'Tanrıverdi', 'Prof. Dr.', 'Kadın Hastalıkları Ve Doğum,', 'Erkek', '1980-04-07', 'https://www.doktortakvimi.com/h-alper-tanriverdi/kadin-hastaliklari-ve-dogum-perinatoloji/aydin#fid=3901', 40),
	(4, 14, 'Seyhan Bahar', 'Özkan', 'Prof. Dr.', 'Göz Hastalıkları', 'Kadın', '1980-07-08', 'https://www.doktortakvimi.com/seyhan-bahar-ozkan/goz-hastaliklari/aydin#fid=3901', 40),
	(5, 15, ' Ali Zahit', 'Bolaman', 'Prof. Dr.', 'İç Hastalıkları', 'Erkek', '1980-08-06', 'https://www.doktortakvimi.com/ali-zahit-bolaman/hematoloji-ic-hastaliklari/aydin#fid=3901', 40),
	(6, 16, 'Erdal ', 'Beşer', 'Prof. Dr.', 'Halk Sağlığı', 'Erkek', '1980-10-22', 'https://www.doktortakvimi.com/erdal-beser/halk-sagligi/aydin#fid=3901', 40),
	(7, 17, 'Faruk ', 'Demir ', 'Uzm. Dr. ', 'Çocuk Sağlığı Ve Hastalıkları', 'Erkek', '1980-12-23', 'https://www.doktortakvimi.com/faruk-demir-3/cocuk-alerjisi-cocuk-immunolojisi-cocuk-sagligi-ve-hastaliklari/aydin', 40),
	(8, 18, 'Elif Pelin', 'Özbay ', 'Op. Dr.', 'Kadın Hastalıkları Ve Doğum', 'Kadın', '1980-12-01', 'https://www.doktortakvimi.com/elif-pelin-ozbay/kadin-hastaliklari-ve-dogum/aydin', 40),
	(9, 19, 'Olcay', 'Barış ', 'Uzm. Dyt.', 'Diyetisyen', 'Kadın', '1980-05-24', 'https://www.doktortakvimi.com/olcay-baris/diyetisyen/aydin', 40),
	(10, 20, 'Ezgi Avkan', 'Bilgiç ', 'Uzm. Psk. ', 'Psikoloji', 'Kadın', '1980-07-28', 'https://www.doktortakvimi.com/ezgi-avkan-bilgic/psikoloji/aydin', 40);


--
-- Data for Name: Hemşire; Type: TABLE DATA; Schema: Çalışan Şema; Owner: postgres
--

INSERT INTO "Çalışan Şema"."Hemşire" ("Hemşire ID", "Doktor ID", "Adres ID", "Hemşire Adı", "Hemşire Soyadı", "Cinsiyet", "Seviye", "Dogum Tarihi", "Yaş") OVERRIDING SYSTEM VALUE VALUES
	(1, 1, 11, 'Selin', 'Gem', 'Kadın', 2, '1980-04-12', 40),
	(2, 2, 12, 'Ali', 'Demirci', 'Erkek', 1, '1980-07-13', 40),
	(3, 3, 13, 'Furkan', 'Gültin', 'Erkek', 1, '1980-12-04', 40),
	(4, 4, 14, 'Salim Can', 'Han', 'Erkek', 3, '1980-12-06', 40),
	(5, 5, 15, 'İrem', 'Deri', 'Kadın', 1, '1980-04-03', 40),
	(6, 6, 16, 'Hasan', 'Tel', 'Erkek', 1, '1980-07-19', 40),
	(7, 7, 17, 'Gürkan', 'Can', 'Erkek', 2, '1980-11-07', 40),
	(8, 8, 18, 'Seda', 'Lal', 'Kadın', 3, '1980-10-07', 40),
	(9, 9, 19, 'Remzi', 'Fal', 'Erkek', 3, '1980-01-04', 40),
	(10, 10, 20, 'Nergiz', 'Gül', 'Kadın', 3, '1980-01-07', 40);


--
-- Data for Name: Envanter; Type: TABLE DATA; Schema: Ürün Yönetimi Şema; Owner: postgres
--

INSERT INTO "Ürün Yönetimi Şema"."Envanter" ("Envanter ID", "Envanter Ismi", "Envanter Marka", "Envanter Model", "Envanter Seri No", "Envanter Durumu", "Birim Fiyat", "Envanter Sayısı") OVERRIDING SYSTEM VALUE VALUES
	(1, 'HCT Cihazı', 'Nüve', 'NF 048', '01-2741', 'Yeterli Sayıda Var', '?20.000,00', 10),
	(2, 'İdrar santrifüj cihazı', 'Nüve', 'NF 200', '23553', 'Sipariş Edilecek', '?200,00', 1),
	(3, 'Kan santrifüj cihazı ', 'Nüve', 'NF 200', 'NF 200', 'Sipariş Edildi', '?10.000,00', 3),
	(4, 'Biyokimya otoanalizatörü', 'Tokyo Boeki ', 'Prestige 24i', '2016810107', 'Yeterli Sayıda Var', '?10.000,00', 10),
	(5, 'Hormon cihazı ', 'Diamerıeux', 'Mınıvidas', 'SUD1204486', 'Sipariş Edildi', '?25.000,00', 5),
	(6, 'Kan sayım cihazı', 'Boule', 'Swelab Alfa Sampler', '13015', 'Yeterli Sayıda Var', '?252.000,00', 20),
	(7, 'Bilüribinmetre', 'Optima', 'BİL-REA', '104', 'Sipariş Edildi', '?500.000,00', 5),
	(8, 'Hemoglobin A1C ', 'EKF Diagnostics', 'DUO-Lab Model No:0110', '2B0393', 'Sipariş Edilecek', '?1.000,00', 1),
	(9, 'Glukometre', 'Rheomed', 'SC126-AA', 'NK2401-0362', 'Yeterli Sayıda Var', '?124.005,00', 10),
	(10, 'Otomatik pipet', 'Socorex', 'Acura 825', '181125586', 'Sipariş Edilecek', '?15,00', 50);


--
-- Data for Name: Envanter Satın Alma; Type: TABLE DATA; Schema: Ürün Yönetimi Şema; Owner: postgres
--

INSERT INTO "Ürün Yönetimi Şema"."Envanter Satın Alma" ("Satın Alma ID", "Envanter ID", "Envanter Adı", "Toplam Ücret", "Satın Alım Zamanı") OVERRIDING SYSTEM VALUE VALUES
	(1, 1, 'HCT Cihazı', '?200.000,00', '2020-08-13 13:25:17.6714'),
	(2, 2, 'İdrar santrifüj cihazı', '?200,00', '2020-08-13 13:25:17.6714'),
	(3, 3, 'Kan santrifüj cihazı ', '?30.000,00', '2020-08-13 13:25:17.6714'),
	(4, 4, 'Biyokimya otoanalizatörü', '?100.000,00', '2020-08-13 13:25:17.6714'),
	(5, 5, 'Hormon cihazı ', '?125.000,00', '2020-08-13 13:25:17.6714'),
	(6, 6, 'Kan sayım cihazı', '?5.040.000,00', '2020-08-13 13:25:17.6714'),
	(7, 7, 'Bilüribinmetre', '?2.500.000,00', '2020-08-13 13:25:17.6714'),
	(8, 8, 'Hemoglobin A1C ', '?1.000,00', '2020-08-13 13:25:17.6714'),
	(9, 9, 'Glukometre', '?1.240.050,00', '2020-08-13 13:25:17.6714'),
	(10, 10, 'Otomatik pipet', '?750,00', '2020-08-13 13:25:17.6714');


--
-- Data for Name: Stok Yonetimi; Type: TABLE DATA; Schema: Ürün Yönetimi Şema; Owner: postgres
--

INSERT INTO "Ürün Yönetimi Şema"."Stok Yonetimi" ("Stok Yonetimi ID", "Envanter ID", "Hemşire ID") OVERRIDING SYSTEM VALUE VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3),
	(4, 4, 4),
	(5, 5, 5),
	(6, 6, 6),
	(7, 7, 7),
	(8, 8, 8),
	(9, 9, 9),
	(10, 10, 10);


--
-- Name: Adres_Adres ID_seq; Type: SEQUENCE SET; Schema: Bilgi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Bilgi Şema"."Adres_Adres ID_seq"', 20, true);


--
-- Name: Hasta Geçmiş_Hasta Geçmiş ID_seq; Type: SEQUENCE SET; Schema: Bilgi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Bilgi Şema"."Hasta Geçmiş_Hasta Geçmiş ID_seq"', 1, true);


--
-- Name: Hasta_Hasta ID_seq; Type: SEQUENCE SET; Schema: Bilgi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Bilgi Şema"."Hasta_Hasta ID_seq"', 10, true);


--
-- Name: Hasta Odası_Oda ID_seq; Type: SEQUENCE SET; Schema: Oda Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Oda Şema"."Hasta Odası_Oda ID_seq"', 10, true);


--
-- Name: Operasyon Oda_Operasyon Oda ID_seq; Type: SEQUENCE SET; Schema: Oda Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Oda Şema"."Operasyon Oda_Operasyon Oda ID_seq"', 5, true);


--
-- Name: Sigorta_Sigorta ID_seq; Type: SEQUENCE SET; Schema: Tedavi Ücret Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Tedavi Ücret Şema"."Sigorta_Sigorta ID_seq"', 10, true);


--
-- Name: Ödeme_Ödeme ID_seq; Type: SEQUENCE SET; Schema: Tedavi Ücret Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Tedavi Ücret Şema"."Ödeme_Ödeme ID_seq"', 10, true);


--
-- Name: Randevu_Randevu ID_seq; Type: SEQUENCE SET; Schema: Tedavi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Tedavi Şema"."Randevu_Randevu ID_seq"', 10, true);


--
-- Name: Tanı_Tanı ID_seq; Type: SEQUENCE SET; Schema: Tedavi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Tedavi Şema"."Tanı_Tanı ID_seq"', 10, true);


--
-- Name: Test Sonuçları_Test ID_seq; Type: SEQUENCE SET; Schema: Tedavi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Tedavi Şema"."Test Sonuçları_Test ID_seq"', 10, true);


--
-- Name: Doktor_Doktor ID_seq; Type: SEQUENCE SET; Schema: Çalışan Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Çalışan Şema"."Doktor_Doktor ID_seq"', 10, true);


--
-- Name: Hemşire_Hemşire ID_seq; Type: SEQUENCE SET; Schema: Çalışan Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Çalışan Şema"."Hemşire_Hemşire ID_seq"', 10, true);


--
-- Name: Envanter Satın Alma_Satın Alma ID_seq; Type: SEQUENCE SET; Schema: Ürün Yönetimi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Ürün Yönetimi Şema"."Envanter Satın Alma_Satın Alma ID_seq"', 10, true);


--
-- Name: Envanter_Envanter ID_seq; Type: SEQUENCE SET; Schema: Ürün Yönetimi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Ürün Yönetimi Şema"."Envanter_Envanter ID_seq"', 10, true);


--
-- Name: Stok Yonetimi_Stok Yonetimi ID_seq; Type: SEQUENCE SET; Schema: Ürün Yönetimi Şema; Owner: postgres
--

SELECT pg_catalog.setval('"Ürün Yönetimi Şema"."Stok Yonetimi_Stok Yonetimi ID_seq"', 10, true);


--
-- Name: Adres pk_adresler_adresid; Type: CONSTRAINT; Schema: Bilgi Şema; Owner: postgres
--

ALTER TABLE ONLY "Bilgi Şema"."Adres"
    ADD CONSTRAINT pk_adresler_adresid PRIMARY KEY ("Adres ID");


--
-- Name: Hasta pk_hasta_hastaid; Type: CONSTRAINT; Schema: Bilgi Şema; Owner: postgres
--

ALTER TABLE ONLY "Bilgi Şema"."Hasta"
    ADD CONSTRAINT pk_hasta_hastaid PRIMARY KEY ("Hasta ID");


--
-- Name: Hasta Odası pk_hastaodasi_odaid; Type: CONSTRAINT; Schema: Oda Şema; Owner: postgres
--

ALTER TABLE ONLY "Oda Şema"."Hasta Odası"
    ADD CONSTRAINT pk_hastaodasi_odaid PRIMARY KEY ("Oda ID");


--
-- Name: Operasyon Oda pk_operasyonoda_operasyonodaid; Type: CONSTRAINT; Schema: Oda Şema; Owner: postgres
--

ALTER TABLE ONLY "Oda Şema"."Operasyon Oda"
    ADD CONSTRAINT pk_operasyonoda_operasyonodaid PRIMARY KEY ("Operasyon Oda ID");


--
-- Name: Ödeme pk_odeme_odemeid; Type: CONSTRAINT; Schema: Tedavi Ücret Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Ücret Şema"."Ödeme"
    ADD CONSTRAINT pk_odeme_odemeid PRIMARY KEY ("Ödeme ID");


--
-- Name: Sigorta pk_sigorta_sigortaid; Type: CONSTRAINT; Schema: Tedavi Ücret Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Ücret Şema"."Sigorta"
    ADD CONSTRAINT pk_sigorta_sigortaid PRIMARY KEY ("Sigorta ID");


--
-- Name: Ayakta Tedavi pk_ayaktatedavi_hastaid; Type: CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Ayakta Tedavi"
    ADD CONSTRAINT pk_ayaktatedavi_hastaid PRIMARY KEY ("Hasta ID");


--
-- Name: Randevu pk_randevu_randevuid; Type: CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Randevu"
    ADD CONSTRAINT pk_randevu_randevuid PRIMARY KEY ("Randevu ID");


--
-- Name: Tanı pk_tanı_tanıid; Type: CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Tanı"
    ADD CONSTRAINT "pk_tanı_tanıid" PRIMARY KEY ("Tanı ID");


--
-- Name: Test Sonuçları pk_testsonuçları_testid; Type: CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Test Sonuçları"
    ADD CONSTRAINT "pk_testsonuçları_testid" PRIMARY KEY ("Test ID");


--
-- Name: Yatan Hasta Bilgi pk_yatanhb_hastaid; Type: CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Yatan Hasta Bilgi"
    ADD CONSTRAINT pk_yatanhb_hastaid PRIMARY KEY ("Hasta ID");


--
-- Name: Doktor pk_doktor_doktorid; Type: CONSTRAINT; Schema: Çalışan Şema; Owner: postgres
--

ALTER TABLE ONLY "Çalışan Şema"."Doktor"
    ADD CONSTRAINT pk_doktor_doktorid PRIMARY KEY ("Doktor ID");


--
-- Name: Hemşire pk_hemsire_hemsireid; Type: CONSTRAINT; Schema: Çalışan Şema; Owner: postgres
--

ALTER TABLE ONLY "Çalışan Şema"."Hemşire"
    ADD CONSTRAINT pk_hemsire_hemsireid PRIMARY KEY ("Hemşire ID");


--
-- Name: Envanter pk_envanter_envanterid; Type: CONSTRAINT; Schema: Ürün Yönetimi Şema; Owner: postgres
--

ALTER TABLE ONLY "Ürün Yönetimi Şema"."Envanter"
    ADD CONSTRAINT pk_envanter_envanterid PRIMARY KEY ("Envanter ID");


--
-- Name: Envanter Satın Alma pk_envantersatınalma_satınalmaid; Type: CONSTRAINT; Schema: Ürün Yönetimi Şema; Owner: postgres
--

ALTER TABLE ONLY "Ürün Yönetimi Şema"."Envanter Satın Alma"
    ADD CONSTRAINT "pk_envantersatınalma_satınalmaid" PRIMARY KEY ("Satın Alma ID");


--
-- Name: Stok Yonetimi pk_stokyönetimi_stokyönetimiid; Type: CONSTRAINT; Schema: Ürün Yönetimi Şema; Owner: postgres
--

ALTER TABLE ONLY "Ürün Yönetimi Şema"."Stok Yonetimi"
    ADD CONSTRAINT "pk_stokyönetimi_stokyönetimiid" PRIMARY KEY ("Stok Yonetimi ID");


--
-- Name: Hasta Hasta Bilgi Yönetimi; Type: TRIGGER; Schema: Bilgi Şema; Owner: postgres
--

CREATE TRIGGER "Hasta Bilgi Yönetimi" BEFORE UPDATE ON "Bilgi Şema"."Hasta" FOR EACH ROW EXECUTE FUNCTION "Bilgi Şema"."Hasta Bilgi Yönetimi"();


--
-- Name: Boş Oda Listeleme Boş Oda Listeleme View Eayıt Ekleme; Type: TRIGGER; Schema: Oda Şema; Owner: postgres
--

CREATE TRIGGER "Boş Oda Listeleme View Eayıt Ekleme" INSTEAD OF INSERT ON "Oda Şema"."Boş Oda Listeleme" FOR EACH ROW EXECUTE FUNCTION "Oda Şema"."Boş Oda Listeleme View Eayıt Ekleme"();


--
-- Name: Ödeme Bilgi Ödeme View Silme; Type: TRIGGER; Schema: Tedavi Ücret Şema; Owner: postgres
--

CREATE TRIGGER "Ödeme View Silme" INSTEAD OF DELETE ON "Tedavi Ücret Şema"."Ödeme Bilgi" FOR EACH ROW EXECUTE FUNCTION "Tedavi Ücret Şema"."Ödeme View Silme"();


--
-- Name: Envanter Envanter Yönetimi; Type: TRIGGER; Schema: Ürün Yönetimi Şema; Owner: postgres
--

CREATE TRIGGER "Envanter Yönetimi" BEFORE INSERT ON "Ürün Yönetimi Şema"."Envanter" FOR EACH ROW EXECUTE FUNCTION "Ürün Yönetimi Şema"."Envanter Yönetimi"();


--
-- Name: Hasta fk_hasta_adres; Type: FK CONSTRAINT; Schema: Bilgi Şema; Owner: postgres
--

ALTER TABLE ONLY "Bilgi Şema"."Hasta"
    ADD CONSTRAINT fk_hasta_adres FOREIGN KEY ("Adres ID") REFERENCES "Bilgi Şema"."Adres"("Adres ID");


--
-- Name: Hasta fk_hasta_sigorta_sigortaid; Type: FK CONSTRAINT; Schema: Bilgi Şema; Owner: postgres
--

ALTER TABLE ONLY "Bilgi Şema"."Hasta"
    ADD CONSTRAINT fk_hasta_sigorta_sigortaid FOREIGN KEY ("Sigorta ID") REFERENCES "Tedavi Ücret Şema"."Sigorta"("Sigorta ID");


--
-- Name: Operasyon Oda fk_hastaodası_odaid; Type: FK CONSTRAINT; Schema: Oda Şema; Owner: postgres
--

ALTER TABLE ONLY "Oda Şema"."Operasyon Oda"
    ADD CONSTRAINT "fk_hastaodası_odaid" FOREIGN KEY ("Oda ID") REFERENCES "Oda Şema"."Hasta Odası"("Oda ID");


--
-- Name: Ödeme fk_odeme_sigorta_sigortaid; Type: FK CONSTRAINT; Schema: Tedavi Ücret Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Ücret Şema"."Ödeme"
    ADD CONSTRAINT fk_odeme_sigorta_sigortaid FOREIGN KEY ("Sigorta ID") REFERENCES "Tedavi Ücret Şema"."Sigorta"("Sigorta ID");


--
-- Name: Ayakta Tedavi fk_ayaktatedavi_hasta; Type: FK CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Ayakta Tedavi"
    ADD CONSTRAINT fk_ayaktatedavi_hasta FOREIGN KEY ("Hasta ID") REFERENCES "Bilgi Şema"."Hasta"("Hasta ID");


--
-- Name: Randevu fk_randevu_doktor; Type: FK CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Randevu"
    ADD CONSTRAINT fk_randevu_doktor FOREIGN KEY ("Doktor ID") REFERENCES "Çalışan Şema"."Doktor"("Doktor ID");


--
-- Name: Randevu fk_randevu_hasta; Type: FK CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Randevu"
    ADD CONSTRAINT fk_randevu_hasta FOREIGN KEY ("Hasta ID") REFERENCES "Bilgi Şema"."Hasta"("Hasta ID");


--
-- Name: Test Sonuçları fk_tedabi_tanı_tanıid; Type: FK CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Test Sonuçları"
    ADD CONSTRAINT "fk_tedabi_tanı_tanıid" FOREIGN KEY ("Tanı ID") REFERENCES "Tedavi Şema"."Tanı"("Tanı ID");


--
-- Name: Test Sonuçları fk_testsonucları_hastaid; Type: FK CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Test Sonuçları"
    ADD CONSTRAINT "fk_testsonucları_hastaid" FOREIGN KEY ("Hasta ID") REFERENCES "Bilgi Şema"."Hasta"("Hasta ID");


--
-- Name: Yatan Hasta Bilgi fk_yatanhb_hasta; Type: FK CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Yatan Hasta Bilgi"
    ADD CONSTRAINT fk_yatanhb_hasta FOREIGN KEY ("Hasta ID") REFERENCES "Bilgi Şema"."Hasta"("Hasta ID");


--
-- Name: Yatan Hasta Bilgi fk_yatanhb_hastaodasi; Type: FK CONSTRAINT; Schema: Tedavi Şema; Owner: postgres
--

ALTER TABLE ONLY "Tedavi Şema"."Yatan Hasta Bilgi"
    ADD CONSTRAINT fk_yatanhb_hastaodasi FOREIGN KEY ("Oda ID") REFERENCES "Oda Şema"."Hasta Odası"("Oda ID");


--
-- Name: Doktor fk_doktor_adres; Type: FK CONSTRAINT; Schema: Çalışan Şema; Owner: postgres
--

ALTER TABLE ONLY "Çalışan Şema"."Doktor"
    ADD CONSTRAINT fk_doktor_adres FOREIGN KEY ("Adres ID") REFERENCES "Bilgi Şema"."Adres"("Adres ID");


--
-- Name: Hemşire fk_hemsire_doktor; Type: FK CONSTRAINT; Schema: Çalışan Şema; Owner: postgres
--

ALTER TABLE ONLY "Çalışan Şema"."Hemşire"
    ADD CONSTRAINT fk_hemsire_doktor FOREIGN KEY ("Doktor ID") REFERENCES "Çalışan Şema"."Doktor"("Doktor ID");


--
-- Name: Hemşire fk_hemşire_adres; Type: FK CONSTRAINT; Schema: Çalışan Şema; Owner: postgres
--

ALTER TABLE ONLY "Çalışan Şema"."Hemşire"
    ADD CONSTRAINT "fk_hemşire_adres" FOREIGN KEY ("Adres ID") REFERENCES "Bilgi Şema"."Adres"("Adres ID");


--
-- Name: Stok Yonetimi fk_stokyonetimi_envanter; Type: FK CONSTRAINT; Schema: Ürün Yönetimi Şema; Owner: postgres
--

ALTER TABLE ONLY "Ürün Yönetimi Şema"."Stok Yonetimi"
    ADD CONSTRAINT fk_stokyonetimi_envanter FOREIGN KEY ("Envanter ID") REFERENCES "Ürün Yönetimi Şema"."Envanter"("Envanter ID");


--
-- Name: Stok Yonetimi fk_stokyonetimi_hemşire; Type: FK CONSTRAINT; Schema: Ürün Yönetimi Şema; Owner: postgres
--

ALTER TABLE ONLY "Ürün Yönetimi Şema"."Stok Yonetimi"
    ADD CONSTRAINT "fk_stokyonetimi_hemşire" FOREIGN KEY ("Hemşire ID") REFERENCES "Çalışan Şema"."Hemşire"("Hemşire ID");


--
-- PostgreSQL database dump complete
--

