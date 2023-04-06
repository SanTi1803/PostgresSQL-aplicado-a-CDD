--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 12.0

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

DROP DATABASE platzimovies;
--
-- Name: platzimovies; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE platzimovies WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE platzimovies OWNER TO postgres;

\connect platzimovies

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
-- Name: mpaa_rating; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.mpaa_rating AS ENUM (
    'G',
    'PG',
    'PG-13',
    'R',
    'NC-17'
);


ALTER TYPE public.mpaa_rating OWNER TO postgres;

--
-- Name: year; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.year AS integer
	CONSTRAINT year_check CHECK (((VALUE >= 1901) AND (VALUE <= 2155)));


ALTER DOMAIN public.year OWNER TO postgres;

--
-- Name: _group_concat(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public._group_concat(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CASE
  WHEN $2 IS NULL THEN $1
  WHEN $1 IS NULL THEN $2
  ELSE $1 || ', ' || $2
END
$_$;


ALTER FUNCTION public._group_concat(text, text) OWNER TO postgres;

--
-- Name: last_updated(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    NEW.ultima_actualizacion = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$;


ALTER FUNCTION public.last_updated() OWNER TO postgres;

--
-- Name: ultima_actualizacion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ultima_actualizacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    NEW.ultima_actualizacion = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$;


ALTER FUNCTION public.ultima_actualizacion() OWNER TO postgres;

--
-- Name: group_concat(text); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE public.group_concat(text) (
    SFUNC = public._group_concat,
    STYPE = text
);


ALTER AGGREGATE public.group_concat(text) OWNER TO postgres;

--
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actor_actor_id_seq OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: actores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actores (
    actor_id integer DEFAULT nextval('public.actor_actor_id_seq'::regclass) NOT NULL,
    nombre character varying(45) NOT NULL,
    apellido character varying(45) NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.actores OWNER TO postgres;

--
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_address_id_seq OWNER TO postgres;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO postgres;

--
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    categoria_id integer DEFAULT nextval('public.category_category_id_seq'::regclass) NOT NULL,
    nombre character varying(25) NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_city_id_seq OWNER TO postgres;

--
-- Name: ciudades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudades (
    ciudad_id integer DEFAULT nextval('public.city_city_id_seq'::regclass) NOT NULL,
    ciudad character varying(50) NOT NULL,
    pais_id smallint NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.ciudades OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customer_id_seq OWNER TO postgres;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    cliente_id integer DEFAULT nextval('public.customer_customer_id_seq'::regclass) NOT NULL,
    tienda_id smallint NOT NULL,
    nombre character varying(45) NOT NULL,
    apellido character varying(45) NOT NULL,
    email character varying(50),
    direccion_id smallint NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    fecha_creacion date DEFAULT ('now'::text)::date NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now(),
    active integer
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_country_id_seq OWNER TO postgres;

--
-- Name: direcciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direcciones (
    direccion_id integer DEFAULT nextval('public.address_address_id_seq'::regclass) NOT NULL,
    direccion character varying(50) NOT NULL,
    direccion2 character varying(50),
    distrito character varying(20) NOT NULL,
    ciudad_id smallint NOT NULL,
    codigo_postal character varying(10),
    telefono character varying(20) NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.direcciones OWNER TO postgres;

--
-- Name: staff_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_staff_id_seq OWNER TO postgres;

--
-- Name: empleados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleados (
    empleado_id integer DEFAULT nextval('public.staff_staff_id_seq'::regclass) NOT NULL,
    nombre character varying(45) NOT NULL,
    apellido character varying(45) NOT NULL,
    "dirección_id" smallint NOT NULL,
    email character varying(50),
    tienda_id smallint NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    nombreusuario character varying(16) NOT NULL,
    password character varying(40),
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL,
    foto bytea
);


ALTER TABLE public.empleados OWNER TO postgres;

--
-- Name: film_film_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.film_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.film_film_id_seq OWNER TO postgres;

--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_inventory_id_seq OWNER TO postgres;

--
-- Name: inventarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventarios (
    inventario_id integer DEFAULT nextval('public.inventory_inventory_id_seq'::regclass) NOT NULL,
    pelicula_id smallint NOT NULL,
    tienda_id smallint NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.inventarios OWNER TO postgres;

--
-- Name: language_language_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.language_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_language_id_seq OWNER TO postgres;

--
-- Name: lenguajes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lenguajes (
    lenguaje_id integer DEFAULT nextval('public.language_language_id_seq'::regclass) NOT NULL,
    nombre character(20) NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lenguajes OWNER TO postgres;

--
-- Name: ordenes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordenes (
    id integer NOT NULL,
    info json NOT NULL
);


ALTER TABLE public.ordenes OWNER TO postgres;

--
-- Name: ordenes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordenes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordenes_id_seq OWNER TO postgres;

--
-- Name: ordenes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordenes_id_seq OWNED BY public.ordenes.id;


--
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_payment_id_seq OWNER TO postgres;

--
-- Name: pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos (
    pago_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    cliente_id smallint NOT NULL,
    empleado_id smallint NOT NULL,
    renta_id integer NOT NULL,
    cantidad numeric(5,2) NOT NULL,
    fecha_pago timestamp without time zone NOT NULL
);


ALTER TABLE public.pagos OWNER TO postgres;

--
-- Name: paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paises (
    pais_id integer DEFAULT nextval('public.country_country_id_seq'::regclass) NOT NULL,
    pais character varying(50) NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.paises OWNER TO postgres;

--
-- Name: peliculas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peliculas (
    pelicula_id integer DEFAULT nextval('public.film_film_id_seq'::regclass) NOT NULL,
    titulo character varying(255) NOT NULL,
    "descripción" text,
    anio_publicacion public.year,
    lenguaje_id smallint NOT NULL,
    duracion_renta smallint DEFAULT 3 NOT NULL,
    precio_renta numeric(4,2) DEFAULT 4.99 NOT NULL,
    duracion smallint,
    costo_reemplazo numeric(5,2) DEFAULT 19.99 NOT NULL,
    clasificacion public.mpaa_rating DEFAULT 'G'::public.mpaa_rating,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL,
    caracteristicas_especiales text[],
    textocompleto tsvector NOT NULL
);


ALTER TABLE public.peliculas OWNER TO postgres;

--
-- Name: peliculas_actores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peliculas_actores (
    actor_id smallint NOT NULL,
    pelicula_id smallint NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.peliculas_actores OWNER TO postgres;

--
-- Name: peliculas_categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peliculas_categorias (
    pelicula_id smallint NOT NULL,
    categoria_id smallint NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.peliculas_categorias OWNER TO postgres;

--
-- Name: peliculas_estadisticas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peliculas_estadisticas (
    tipo_estadistica character varying(250) NOT NULL,
    total real NOT NULL
);


ALTER TABLE public.peliculas_estadisticas OWNER TO postgres;

--
-- Name: persona_prueba; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona_prueba (
    nombre text
);


ALTER TABLE public.persona_prueba OWNER TO postgres;

--
-- Name: precio_peliculas_tipo_cambio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.precio_peliculas_tipo_cambio (
    precio_pelicula_tipo_cambio bigint NOT NULL,
    pelicula_id integer NOT NULL,
    tipo_cambio_id integer NOT NULL,
    precio_tipo_cambio numeric(8,2) NOT NULL,
    ultima_actualizacion timestamp without time zone
);


ALTER TABLE public.precio_peliculas_tipo_cambio OWNER TO postgres;

--
-- Name: precio_peliculas_tipo_cambio_precio_pelicula_tipo_cambio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.precio_peliculas_tipo_cambio_precio_pelicula_tipo_cambio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.precio_peliculas_tipo_cambio_precio_pelicula_tipo_cambio_seq OWNER TO postgres;

--
-- Name: precio_peliculas_tipo_cambio_precio_pelicula_tipo_cambio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.precio_peliculas_tipo_cambio_precio_pelicula_tipo_cambio_seq OWNED BY public.precio_peliculas_tipo_cambio.precio_pelicula_tipo_cambio;


--
-- Name: rental_rental_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rental_rental_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rental_rental_id_seq OWNER TO postgres;

--
-- Name: rentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rentas (
    renta_id integer DEFAULT nextval('public.rental_rental_id_seq'::regclass) NOT NULL,
    fecha_renta timestamp without time zone NOT NULL,
    inventario_id integer NOT NULL,
    cliente_id smallint NOT NULL,
    fecha_retorno timestamp without time zone,
    empleado_id smallint NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.rentas OWNER TO postgres;

--
-- Name: store_store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_store_id_seq OWNER TO postgres;

--
-- Name: tiendas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tiendas (
    tienda_id integer DEFAULT nextval('public.store_store_id_seq'::regclass) NOT NULL,
    jefe_tienda_id smallint NOT NULL,
    direccion_id smallint NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tiendas OWNER TO postgres;

--
-- Name: tipos_cambio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_cambio (
    tipo_cambio_id bigint NOT NULL,
    nombre character varying(30) NOT NULL,
    codigo character(3) NOT NULL,
    cambio_usd numeric(8,2) NOT NULL
);


ALTER TABLE public.tipos_cambio OWNER TO postgres;

--
-- Name: tipos_cambio_tipo_cambio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipos_cambio_tipo_cambio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_cambio_tipo_cambio_id_seq OWNER TO postgres;

--
-- Name: tipos_cambio_tipo_cambio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipos_cambio_tipo_cambio_id_seq OWNED BY public.tipos_cambio.tipo_cambio_id;


--
-- Name: ordenes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes ALTER COLUMN id SET DEFAULT nextval('public.ordenes_id_seq'::regclass);


--
-- Name: precio_peliculas_tipo_cambio precio_pelicula_tipo_cambio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_peliculas_tipo_cambio ALTER COLUMN precio_pelicula_tipo_cambio SET DEFAULT nextval('public.precio_peliculas_tipo_cambio_precio_pelicula_tipo_cambio_seq'::regclass);


--
-- Name: tipos_cambio tipo_cambio_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_cambio ALTER COLUMN tipo_cambio_id SET DEFAULT nextval('public.tipos_cambio_tipo_cambio_id_seq'::regclass);


--
-- Data for Name: actores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actores (actor_id, nombre, apellido, ultima_actualizacion) FROM stdin;
\.
COPY public.actores (actor_id, nombre, apellido, ultima_actualizacion) FROM '$$PATH$$/3430.dat';

--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (categoria_id, nombre, ultima_actualizacion) FROM stdin;
\.
COPY public.categorias (categoria_id, nombre, ultima_actualizacion) FROM '$$PATH$$/3432.dat';

--
-- Data for Name: ciudades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ciudades (ciudad_id, ciudad, pais_id, ultima_actualizacion) FROM stdin;
\.
COPY public.ciudades (ciudad_id, ciudad, pais_id, ultima_actualizacion) FROM '$$PATH$$/3440.dat';

--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (cliente_id, tienda_id, nombre, apellido, email, direccion_id, activo, fecha_creacion, ultima_actualizacion, active) FROM stdin;
\.
COPY public.clientes (cliente_id, tienda_id, nombre, apellido, email, direccion_id, activo, fecha_creacion, ultima_actualizacion, active) FROM '$$PATH$$/3428.dat';

--
-- Data for Name: direcciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direcciones (direccion_id, direccion, direccion2, distrito, ciudad_id, codigo_postal, telefono, ultima_actualizacion) FROM stdin;
\.
COPY public.direcciones (direccion_id, direccion, direccion2, distrito, ciudad_id, codigo_postal, telefono, ultima_actualizacion) FROM '$$PATH$$/3438.dat';

--
-- Data for Name: empleados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleados (empleado_id, nombre, apellido, "dirección_id", email, tienda_id, activo, nombreusuario, password, ultima_actualizacion, foto) FROM stdin;
\.
COPY public.empleados (empleado_id, nombre, apellido, "dirección_id", email, tienda_id, activo, nombreusuario, password, ultima_actualizacion, foto) FROM '$$PATH$$/3452.dat';

--
-- Data for Name: inventarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventarios (inventario_id, pelicula_id, tienda_id, ultima_actualizacion) FROM stdin;
\.
COPY public.inventarios (inventario_id, pelicula_id, tienda_id, ultima_actualizacion) FROM '$$PATH$$/3444.dat';

--
-- Data for Name: lenguajes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lenguajes (lenguaje_id, nombre, ultima_actualizacion) FROM stdin;
\.
COPY public.lenguajes (lenguaje_id, nombre, ultima_actualizacion) FROM '$$PATH$$/3446.dat';

--
-- Data for Name: ordenes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordenes (id, info) FROM stdin;
\.
COPY public.ordenes (id, info) FROM '$$PATH$$/3462.dat';

--
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagos (pago_id, cliente_id, empleado_id, renta_id, cantidad, fecha_pago) FROM stdin;
\.
COPY public.pagos (pago_id, cliente_id, empleado_id, renta_id, cantidad, fecha_pago) FROM '$$PATH$$/3448.dat';

--
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paises (pais_id, pais, ultima_actualizacion) FROM stdin;
\.
COPY public.paises (pais_id, pais, ultima_actualizacion) FROM '$$PATH$$/3442.dat';

--
-- Data for Name: peliculas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peliculas (pelicula_id, titulo, "descripción", anio_publicacion, lenguaje_id, duracion_renta, precio_renta, duracion, costo_reemplazo, clasificacion, ultima_actualizacion, caracteristicas_especiales, textocompleto) FROM stdin;
\.
COPY public.peliculas (pelicula_id, titulo, "descripción", anio_publicacion, lenguaje_id, duracion_renta, precio_renta, duracion, costo_reemplazo, clasificacion, ultima_actualizacion, caracteristicas_especiales, textocompleto) FROM '$$PATH$$/3434.dat';

--
-- Data for Name: peliculas_actores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peliculas_actores (actor_id, pelicula_id, ultima_actualizacion) FROM stdin;
\.
COPY public.peliculas_actores (actor_id, pelicula_id, ultima_actualizacion) FROM '$$PATH$$/3435.dat';

--
-- Data for Name: peliculas_categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peliculas_categorias (pelicula_id, categoria_id, ultima_actualizacion) FROM stdin;
\.
COPY public.peliculas_categorias (pelicula_id, categoria_id, ultima_actualizacion) FROM '$$PATH$$/3436.dat';

--
-- Data for Name: peliculas_estadisticas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peliculas_estadisticas (tipo_estadistica, total) FROM stdin;
\.
COPY public.peliculas_estadisticas (tipo_estadistica, total) FROM '$$PATH$$/3459.dat';

--
-- Data for Name: persona_prueba; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona_prueba (nombre) FROM stdin;
\.
COPY public.persona_prueba (nombre) FROM '$$PATH$$/3460.dat';

--
-- Data for Name: precio_peliculas_tipo_cambio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.precio_peliculas_tipo_cambio (precio_pelicula_tipo_cambio, pelicula_id, tipo_cambio_id, precio_tipo_cambio, ultima_actualizacion) FROM stdin;
\.
COPY public.precio_peliculas_tipo_cambio (precio_pelicula_tipo_cambio, pelicula_id, tipo_cambio_id, precio_tipo_cambio, ultima_actualizacion) FROM '$$PATH$$/3458.dat';

--
-- Data for Name: rentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rentas (renta_id, fecha_renta, inventario_id, cliente_id, fecha_retorno, empleado_id, ultima_actualizacion) FROM stdin;
\.
COPY public.rentas (renta_id, fecha_renta, inventario_id, cliente_id, fecha_retorno, empleado_id, ultima_actualizacion) FROM '$$PATH$$/3450.dat';

--
-- Data for Name: tiendas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tiendas (tienda_id, jefe_tienda_id, direccion_id, ultima_actualizacion) FROM stdin;
\.
COPY public.tiendas (tienda_id, jefe_tienda_id, direccion_id, ultima_actualizacion) FROM '$$PATH$$/3454.dat';

--
-- Data for Name: tipos_cambio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipos_cambio (tipo_cambio_id, nombre, codigo, cambio_usd) FROM stdin;
\.
COPY public.tipos_cambio (tipo_cambio_id, nombre, codigo, cambio_usd) FROM '$$PATH$$/3456.dat';

--
-- Name: actor_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actor_actor_id_seq', 200, true);


--
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_address_id_seq', 605, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 16, true);


--
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_city_id_seq', 600, true);


--
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_country_id_seq', 109, true);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 599, true);


--
-- Name: film_film_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.film_film_id_seq', 1000, true);


--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_inventory_id_seq', 4581, true);


--
-- Name: language_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.language_language_id_seq', 6, true);


--
-- Name: ordenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordenes_id_seq', 3, true);


--
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 32098, true);


--
-- Name: precio_peliculas_tipo_cambio_precio_pelicula_tipo_cambio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.precio_peliculas_tipo_cambio_precio_pelicula_tipo_cambio_seq', 65, true);


--
-- Name: rental_rental_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rental_rental_id_seq', 16049, true);


--
-- Name: staff_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_staff_id_seq', 7, true);


--
-- Name: store_store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_store_id_seq', 9, true);


--
-- Name: tipos_cambio_tipo_cambio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_cambio_tipo_cambio_id_seq', 2, true);


--
-- Name: actores actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actores
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


--
-- Name: direcciones address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direcciones
    ADD CONSTRAINT address_pkey PRIMARY KEY (direccion_id);


--
-- Name: categorias category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT category_pkey PRIMARY KEY (categoria_id);


--
-- Name: ciudades city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT city_pkey PRIMARY KEY (ciudad_id);


--
-- Name: paises country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paises
    ADD CONSTRAINT country_pkey PRIMARY KEY (pais_id);


--
-- Name: clientes customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT customer_pkey PRIMARY KEY (cliente_id);


--
-- Name: peliculas_actores film_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_actores
    ADD CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, pelicula_id);


--
-- Name: peliculas_categorias film_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_categorias
    ADD CONSTRAINT film_category_pkey PRIMARY KEY (pelicula_id, categoria_id);


--
-- Name: peliculas film_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT film_pkey PRIMARY KEY (pelicula_id);


--
-- Name: inventarios inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventarios
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventario_id);


--
-- Name: lenguajes language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lenguajes
    ADD CONSTRAINT language_pkey PRIMARY KEY (lenguaje_id);


--
-- Name: ordenes ordenes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT ordenes_pkey PRIMARY KEY (id);


--
-- Name: pagos payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT payment_pkey PRIMARY KEY (pago_id);


--
-- Name: peliculas_estadisticas peliculas_estadisticas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_estadisticas
    ADD CONSTRAINT peliculas_estadisticas_pkey PRIMARY KEY (tipo_estadistica);


--
-- Name: precio_peliculas_tipo_cambio precio_peliculas_tipo_cambio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precio_peliculas_tipo_cambio
    ADD CONSTRAINT precio_peliculas_tipo_cambio_pkey PRIMARY KEY (precio_pelicula_tipo_cambio);


--
-- Name: rentas rental_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rental_pkey PRIMARY KEY (renta_id);


--
-- Name: empleados staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT staff_pkey PRIMARY KEY (empleado_id);


--
-- Name: tiendas store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiendas
    ADD CONSTRAINT store_pkey PRIMARY KEY (tienda_id);


--
-- Name: tipos_cambio tipos_cambio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_cambio
    ADD CONSTRAINT tipos_cambio_pkey PRIMARY KEY (tipo_cambio_id);


--
-- Name: film_fulltext_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX film_fulltext_idx ON public.peliculas USING gist (textocompleto);


--
-- Name: idx_actor_last_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_actor_last_name ON public.actores USING btree (apellido);


--
-- Name: idx_fk_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_address_id ON public.clientes USING btree (direccion_id);


--
-- Name: idx_fk_city_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_city_id ON public.direcciones USING btree (ciudad_id);


--
-- Name: idx_fk_country_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_country_id ON public.ciudades USING btree (pais_id);


--
-- Name: idx_fk_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_customer_id ON public.pagos USING btree (cliente_id);


--
-- Name: idx_fk_film_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_film_id ON public.peliculas_actores USING btree (pelicula_id);


--
-- Name: idx_fk_inventory_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_inventory_id ON public.rentas USING btree (inventario_id);


--
-- Name: idx_fk_language_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_language_id ON public.peliculas USING btree (lenguaje_id);


--
-- Name: idx_fk_rental_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_rental_id ON public.pagos USING btree (renta_id);


--
-- Name: idx_fk_staff_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_staff_id ON public.pagos USING btree (empleado_id);


--
-- Name: idx_fk_store_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fk_store_id ON public.clientes USING btree (tienda_id);


--
-- Name: idx_last_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_last_name ON public.clientes USING btree (apellido);


--
-- Name: idx_store_id_film_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_store_id_film_id ON public.inventarios USING btree (tienda_id, pelicula_id);


--
-- Name: idx_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_title ON public.peliculas USING btree (titulo);


--
-- Name: idx_unq_manager_staff_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_unq_manager_staff_id ON public.tiendas USING btree (jefe_tienda_id);


--
-- Name: idx_unq_rental_rental_date_inventory_id_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_unq_rental_rental_date_inventory_id_customer_id ON public.rentas USING btree (fecha_renta, inventario_id, cliente_id);


--
-- Name: actores last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.actores FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: direcciones last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.direcciones FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: categorias last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.categorias FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: ciudades last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.ciudades FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: paises last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.paises FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: clientes last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.clientes FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: peliculas last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.peliculas FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: peliculas_actores last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.peliculas_actores FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: peliculas_categorias last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.peliculas_categorias FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: inventarios last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.inventarios FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: lenguajes last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.lenguajes FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: rentas last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.rentas FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: empleados last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.empleados FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: tiendas last_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.tiendas FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: clientes customer_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (direccion_id) REFERENCES public.direcciones(direccion_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: peliculas_actores film_actor_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_actores
    ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actores(actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: peliculas_actores film_actor_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_actores
    ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (pelicula_id) REFERENCES public.peliculas(pelicula_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: peliculas_categorias film_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_categorias
    ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias(categoria_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: peliculas_categorias film_category_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_categorias
    ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (pelicula_id) REFERENCES public.peliculas(pelicula_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: peliculas film_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (lenguaje_id) REFERENCES public.lenguajes(lenguaje_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: direcciones fk_address_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direcciones
    ADD CONSTRAINT fk_address_city FOREIGN KEY (ciudad_id) REFERENCES public.ciudades(ciudad_id);


--
-- Name: ciudades fk_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT fk_city FOREIGN KEY (pais_id) REFERENCES public.paises(pais_id);


--
-- Name: inventarios inventory_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventarios
    ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (pelicula_id) REFERENCES public.peliculas(pelicula_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pagos payment_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT payment_customer_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(cliente_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pagos payment_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT payment_rental_id_fkey FOREIGN KEY (renta_id) REFERENCES public.rentas(renta_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: pagos payment_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT payment_staff_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleados(empleado_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rentas rental_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(cliente_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rentas rental_inventory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventario_id) REFERENCES public.inventarios(inventario_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rentas rental_staff_id_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rental_staff_id_key FOREIGN KEY (empleado_id) REFERENCES public.empleados(empleado_id);


--
-- Name: empleados staff_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY ("dirección_id") REFERENCES public.direcciones(direccion_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tiendas store_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiendas
    ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (direccion_id) REFERENCES public.direcciones(direccion_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tiendas store_manager_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiendas
    ADD CONSTRAINT store_manager_staff_id_fkey FOREIGN KEY (jefe_tienda_id) REFERENCES public.empleados(empleado_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

