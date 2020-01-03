-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
-- 

-- object: public.tienda | type: TABLE --
-- DROP TABLE IF EXISTS public.tienda CASCADE;
CREATE TABLE public.tienda(
	nombre varchar(150) NOT NULL,
	ciudad varchar(150) NOT NULL,
	barrio varchar(150),
	CONSTRAINT "Tienda_pk" PRIMARY KEY (nombre)

);
-- ddl-end --
ALTER TABLE public.tienda OWNER TO postgres;
-- ddl-end --

-- object: public.trabajador | type: TABLE --
-- DROP TABLE IF EXISTS public.trabajador CASCADE;
CREATE TABLE public.trabajador(
	dni varchar NOT NULL,
	nombre varchar(150) NOT NULL,
	telefono varchar,
	movil varchar NOT NULL,
	turno boolean NOT NULL,
	nombre_tienda varchar(150) NOT NULL,
	nota_media smallint NOT NULL,
	CONSTRAINT trabajador_pk PRIMARY KEY (dni)

);
-- ddl-end --
ALTER TABLE public.trabajador OWNER TO postgres;
-- ddl-end --

-- object: public.cajero | type: TABLE --
-- DROP TABLE IF EXISTS public.cajero CASCADE;
CREATE TABLE public.cajero(
	dni_trabajador varchar NOT NULL,
	CONSTRAINT cajero_pk PRIMARY KEY (dni_trabajador)

);
-- ddl-end --
ALTER TABLE public.cajero OWNER TO postgres;
-- ddl-end --

-- object: public.reponedor | type: TABLE --
-- DROP TABLE IF EXISTS public.reponedor CASCADE;
CREATE TABLE public.reponedor(
	jornada smallint NOT NULL,
	dni_trabajador varchar NOT NULL,
	CONSTRAINT reponedor_pk PRIMARY KEY (dni_trabajador)

);
-- ddl-end --
ALTER TABLE public.reponedor OWNER TO postgres;
-- ddl-end --

-- object: public.socio | type: TABLE --
-- DROP TABLE IF EXISTS public.socio CASCADE;
CREATE TABLE public.socio(
	numero smallint NOT NULL,
	nombre varchar(150),
	dni varchar(9),
	telefono varchar,
	mail varchar(150),
	direccion varchar(200),
	saldo_acumulado float,
	CONSTRAINT socio_pk PRIMARY KEY (numero)

);
-- ddl-end --
ALTER TABLE public.socio OWNER TO postgres;
-- ddl-end --

-- object: public.producto | type: TABLE --
-- DROP TABLE IF EXISTS public.producto CASCADE;
CREATE TABLE public.producto(
	codigo smallint NOT NULL,
	precio_iva float NOT NULL,
	precio float NOT NULL,
	stock smallint NOT NULL,
	CONSTRAINT producto_pk PRIMARY KEY (codigo)

);
-- ddl-end --
ALTER TABLE public.producto OWNER TO postgres;
-- ddl-end --

-- object: public.cupon | type: TABLE --
-- DROP TABLE IF EXISTS public.cupon CASCADE;
CREATE TABLE public.cupon(
	id_cupon smallint NOT NULL,
	descuento smallint NOT NULL,
	CONSTRAINT cupon_pk PRIMARY KEY (id_cupon)

);
-- ddl-end --
ALTER TABLE public.cupon OWNER TO postgres;
-- ddl-end --

-- object: public.opinion | type: TABLE --
-- DROP TABLE IF EXISTS public.opinion CASCADE;
CREATE TABLE public.opinion(
	id_opinion smallint NOT NULL,
	texto varchar(1000),
	puntuacion smallint,
	fecha date,
	hora time,
	numero_socio smallint NOT NULL,
	nombre_tienda varchar(150) NOT NULL,
	CONSTRAINT opinion_pk PRIMARY KEY (id_opinion)

);
-- ddl-end --
ALTER TABLE public.opinion OWNER TO postgres;
-- ddl-end --

-- object: public.oferta | type: TABLE --
-- DROP TABLE IF EXISTS public.oferta CASCADE;
CREATE TABLE public.oferta(
	id_oferta smallint NOT NULL,
	descuento smallint NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date NOT NULL,
	CONSTRAINT oferta_pk PRIMARY KEY (id_oferta)

);
-- ddl-end --
ALTER TABLE public.oferta OWNER TO postgres;
-- ddl-end --

-- object: public.ticket | type: TABLE --
-- DROP TABLE IF EXISTS public.ticket CASCADE;
CREATE TABLE public.ticket(
	id_ticket smallint NOT NULL,
	fecha date NOT NULL,
	hora time,
	numero_socio smallint,
	dni_trabajador_cajero varchar NOT NULL,
	total smallint NOT NULL,
	CONSTRAINT ticket_pk PRIMARY KEY (id_ticket)

);
-- ddl-end --
ALTER TABLE public.ticket OWNER TO postgres;
-- ddl-end --

-- object: tienda_fk | type: CONSTRAINT --
-- ALTER TABLE public.trabajador DROP CONSTRAINT IF EXISTS tienda_fk CASCADE;
ALTER TABLE public.trabajador ADD CONSTRAINT tienda_fk FOREIGN KEY (nombre_tienda)
REFERENCES public.tienda (nombre) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.trabajador_puntua_trabajador | type: TABLE --
-- DROP TABLE IF EXISTS public.trabajador_puntua_trabajador CASCADE;
CREATE TABLE public.trabajador_puntua_trabajador(
	dni_trabajador varchar NOT NULL,
	dni_trabajador1 varchar NOT NULL,
	puntuacion smallint,
	CONSTRAINT trabajador_puntua_trabajador_pk PRIMARY KEY (dni_trabajador,dni_trabajador1)

);
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.trabajador_puntua_trabajador DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.trabajador_puntua_trabajador ADD CONSTRAINT trabajador_fk FOREIGN KEY (dni_trabajador)
REFERENCES public.trabajador (dni) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: trabajador_fk1 | type: CONSTRAINT --
-- ALTER TABLE public.trabajador_puntua_trabajador DROP CONSTRAINT IF EXISTS trabajador_fk1 CASCADE;
ALTER TABLE public.trabajador_puntua_trabajador ADD CONSTRAINT trabajador_fk1 FOREIGN KEY (dni_trabajador1)
REFERENCES public.trabajador (dni) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.socios_cupon | type: TABLE --
-- DROP TABLE IF EXISTS public.socios_cupon CASCADE;
CREATE TABLE public.socios_cupon(
	numero_socio smallint NOT NULL,
	id_cupon_cupon smallint NOT NULL,
	CONSTRAINT socios_cupon_pk PRIMARY KEY (numero_socio,id_cupon_cupon)

);
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.socios_cupon DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.socios_cupon ADD CONSTRAINT socio_fk FOREIGN KEY (numero_socio)
REFERENCES public.socio (numero) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: cupon_fk | type: CONSTRAINT --
-- ALTER TABLE public.socios_cupon DROP CONSTRAINT IF EXISTS cupon_fk CASCADE;
ALTER TABLE public.socios_cupon ADD CONSTRAINT cupon_fk FOREIGN KEY (id_cupon_cupon)
REFERENCES public.cupon (id_cupon) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.opinion DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.opinion ADD CONSTRAINT socio_fk FOREIGN KEY (numero_socio)
REFERENCES public.socio (numero) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.ticket DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.ticket ADD CONSTRAINT socio_fk FOREIGN KEY (numero_socio)
REFERENCES public.socio (numero) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.producto_cupon | type: TABLE --
-- DROP TABLE IF EXISTS public.producto_cupon CASCADE;
CREATE TABLE public.producto_cupon(
	codigo_producto smallint NOT NULL,
	id_cupon_cupon smallint NOT NULL,
	CONSTRAINT producto_cupon_pk PRIMARY KEY (codigo_producto,id_cupon_cupon)

);
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.producto_cupon DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.producto_cupon ADD CONSTRAINT producto_fk FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: cupon_fk | type: CONSTRAINT --
-- ALTER TABLE public.producto_cupon DROP CONSTRAINT IF EXISTS cupon_fk CASCADE;
ALTER TABLE public.producto_cupon ADD CONSTRAINT cupon_fk FOREIGN KEY (id_cupon_cupon)
REFERENCES public.cupon (id_cupon) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.productos_comprados | type: TABLE --
-- DROP TABLE IF EXISTS public.productos_comprados CASCADE;
CREATE TABLE public.productos_comprados(
	codigo_producto smallint NOT NULL,
	id_ticket_ticket smallint NOT NULL,
	cantidad smallint,
	CONSTRAINT productos_comprados_pk PRIMARY KEY (codigo_producto,id_ticket_ticket)

);
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.productos_comprados DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.productos_comprados ADD CONSTRAINT producto_fk FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: ticket_fk | type: CONSTRAINT --
-- ALTER TABLE public.productos_comprados DROP CONSTRAINT IF EXISTS ticket_fk CASCADE;
ALTER TABLE public.productos_comprados ADD CONSTRAINT ticket_fk FOREIGN KEY (id_ticket_ticket)
REFERENCES public.ticket (id_ticket) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: tienda_fk | type: CONSTRAINT --
-- ALTER TABLE public.opinion DROP CONSTRAINT IF EXISTS tienda_fk CASCADE;
ALTER TABLE public.opinion ADD CONSTRAINT tienda_fk FOREIGN KEY (nombre_tienda)
REFERENCES public.tienda (nombre) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.productos_devueltos | type: TABLE --
-- DROP TABLE IF EXISTS public.productos_devueltos CASCADE;
CREATE TABLE public.productos_devueltos(
	id_ticket_ticket smallint NOT NULL,
	codigo_producto smallint NOT NULL,
	cantidad smallint NOT NULL,
	CONSTRAINT productos_devueltos_pk PRIMARY KEY (id_ticket_ticket,codigo_producto)

);
-- ddl-end --

-- object: ticket_fk | type: CONSTRAINT --
-- ALTER TABLE public.productos_devueltos DROP CONSTRAINT IF EXISTS ticket_fk CASCADE;
ALTER TABLE public.productos_devueltos ADD CONSTRAINT ticket_fk FOREIGN KEY (id_ticket_ticket)
REFERENCES public.ticket (id_ticket) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.productos_devueltos DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.productos_devueltos ADD CONSTRAINT producto_fk FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.reponedor DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.reponedor ADD CONSTRAINT trabajador_fk FOREIGN KEY (dni_trabajador)
REFERENCES public.trabajador (dni) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.cajero DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.cajero ADD CONSTRAINT trabajador_fk FOREIGN KEY (dni_trabajador)
REFERENCES public.trabajador (dni) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: cajero_fk | type: CONSTRAINT --
-- ALTER TABLE public.ticket DROP CONSTRAINT IF EXISTS cajero_fk CASCADE;
ALTER TABLE public.ticket ADD CONSTRAINT cajero_fk FOREIGN KEY (dni_trabajador_cajero)
REFERENCES public.cajero (dni_trabajador) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.producto_en_oferta | type: TABLE --
-- DROP TABLE IF EXISTS public.producto_en_oferta CASCADE;
CREATE TABLE public.producto_en_oferta(
	id_oferta_oferta smallint NOT NULL,
	codigo_producto smallint NOT NULL
);
-- ddl-end --
ALTER TABLE public.producto_en_oferta OWNER TO postgres;
-- ddl-end --

-- object: oferta_fk | type: CONSTRAINT --
-- ALTER TABLE public.producto_en_oferta DROP CONSTRAINT IF EXISTS oferta_fk CASCADE;
ALTER TABLE public.producto_en_oferta ADD CONSTRAINT oferta_fk FOREIGN KEY (id_oferta_oferta)
REFERENCES public.oferta (id_oferta) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.producto_en_oferta DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.producto_en_oferta ADD CONSTRAINT producto_fk FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: producto_en_oferta_uq | type: CONSTRAINT --
-- ALTER TABLE public.producto_en_oferta DROP CONSTRAINT IF EXISTS producto_en_oferta_uq CASCADE;
ALTER TABLE public.producto_en_oferta ADD CONSTRAINT producto_en_oferta_uq UNIQUE (codigo_producto);
-- ddl-end --


