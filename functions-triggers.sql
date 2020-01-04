-- TRABAJADOR NO EXISTE --
CREATE OR REPLACE FUNCTION fn_trabajador_existe() RETURNS TRIGGER AS $fn_trabajador_existe$
  DECLARE

  BEGIN    
   IF NEW.nombre IN ( SELECT nombre FROM trabajador ) THEN RAISE EXCEPTION 'EL TRABAJADOR YA EXISTE';
   END IF;
   RETURN NEW;
  END;
$fn_trabajador_existe$ LANGUAGE plpgsql;

CREATE TRIGGER tg_trabajador_no_existe BEFORE INSERT
  ON TRABAJADOR FOR EACH ROW
  EXECUTE PROCEDURE fn_trabajador_existe();

-- TRABAJADOR NO ES CAJERO --
CREATE OR REPLACE FUNCTION fn_trabajador_no_es_cajero() RETURNS TRIGGER AS $fn_trabajador_no_es_cajero$
  DECLARE

  BEGIN    
   IF NEW.dni_trabajador IN ( SELECT dni_trabajador FROM reponedor ) THEN RAISE EXCEPTION 'EL TRABAJADOR YA EXISTE EN REPONEDOR';
   END IF;
   RETURN NEW;
  END;
$fn_trabajador_no_es_cajero$ LANGUAGE plpgsql;

CREATE TRIGGER tg_trabajador_no_es_cajero BEFORE INSERT or UPDATE
  ON CAJERO FOR EACH ROW
  EXECUTE PROCEDURE fn_trabajador_no_es_cajero();

-- TRABAJADOR NO ES REPONEDOR --

CREATE OR REPLACE FUNCTION fn_trabajador_no_es_reponedor() RETURNS TRIGGER AS $fn_trabajador_no_es_reponedor$
  DECLARE

  BEGIN    
   IF NEW.dni_trabajador IN ( SELECT dni_trabajador FROM cajero ) THEN RAISE EXCEPTION 'EL TRABAJADOR YA EXISTE EN CAJERO';
   END IF;
   RETURN NEW;
  END;
$fn_trabajador_no_es_reponedor$ LANGUAGE plpgsql;

CREATE TRIGGER tg_trabajador_no_es_reponedor BEFORE INSERT or UPDATE
  ON REPONEDOR FOR EACH ROW
  EXECUTE PROCEDURE fn_trabajador_no_es_reponedor();

-- COMPROBAR EVALUCION --
CREATE OR REPLACE FUNCTION fn_evalua_nota_media() RETURNS TRIGGER AS $fn_evalua_nota_media$
  DECLARE
  nota SMALLINT := 0;
  BEGIN    
   IF NEW.dni_trabajador1 NOT IN (SELECT DISTINCT dni_trabajador1 FROM trabajador_puntua_trabajador)
   	THEN UPDATE trabajador SET nota_media = NEW.puntuacion WHERE trabajador.dni = NEW.dni_trabajador1;
   END IF;
   
   IF NEW.dni_trabajador1 = NEW.dni_trabajador
   	THEN RAISE EXCEPTION 'UN TRABAJADOR NO SE PUEDE PUNTUA A SI MISMO';
   END IF;
   RETURN NEW;
  END;
$fn_evalua_nota_media$ LANGUAGE plpgsql;

CREATE TRIGGER tg_evalua_nota_media BEFORE INSERT or UPDATE
  ON TRABAJADOR_PUNTUA_TRABAJADOR FOR EACH ROW
  EXECUTE PROCEDURE fn_evalua_nota_media();

-- CALCULAR EVALUCION -- 
CREATE OR REPLACE FUNCTION fn_calcula_nota_media() RETURNS TRIGGER AS $fn_calcula_nota_media$
  DECLARE
  nota SMALLINT := 0;
  BEGIN    
   
   UPDATE trabajador SET nota_media = (SELECT CAST(AVG(puntuacion) AS decimal(10,2)) as media
	FROM trabajador_puntua_trabajador WHERE dni_trabajador1 = NEW.dni_trabajador1
	GROUP BY dni_trabajador1 ) WHERE trabajador.dni = NEW.dni_trabajador1;
   
   RETURN NEW;
  END;
$fn_calcula_nota_media$ LANGUAGE plpgsql;

CREATE TRIGGER tg_calcula_nota_media AFTER INSERT or UPDATE
  ON TRABAJADOR_PUNTUA_TRABAJADOR FOR EACH ROW
  EXECUTE PROCEDURE fn_calcula_nota_media();

-- COMPRABACION TICKET COMPRA -- 
CREATE OR REPLACE FUNCTION fn_comprobacion_ticket_compra() RETURNS TRIGGER AS $fn_comprobacion_ticket_compra$
  DECLARE
  BEGIN     
   
	IF ( NEW.cantidad ) < 0 THEN RAISE EXCEPTION 'NO PUEDES COMPRAR CANTIDAD NEGATIVAS ALGO';
	END IF;
		
   RETURN NEW;
  END;
$fn_comprobacion_ticket_compra$ LANGUAGE plpgsql;

CREATE TRIGGER tg_comprobacion_ticket_compra BEFORE UPDATE OR INSERT
  ON PRODUCTOS_COMPRADOS FOR EACH ROW
  EXECUTE PROCEDURE fn_comprobacion_ticket_compra();

-- SUMA TICKET COMPRA -- 
CREATE OR REPLACE FUNCTION fn_suma_total_ticket() RETURNS TRIGGER AS $fn_suma_total_ticket$
  DECLARE
  BEGIN     
   
   UPDATE ticket SET total = ( SELECT DISTINCT total FROM ticket 
		INNER JOIN productos_comprados ON id_ticket = id_ticket_ticket 
		WHERE id_ticket = NEW.id_ticket_ticket ) + (SELECT precio*NEW.cantidad
		FROM producto WHERE codigo = NEW.codigo_producto)
   		WHERE id_ticket = NEW.id_ticket_ticket;
   
   RETURN NEW;
  END;
$fn_suma_total_ticket$ LANGUAGE plpgsql;

CREATE TRIGGER tg_suma_total_ticket AFTER INSERT
  ON PRODUCTOS_COMPRADOS FOR EACH ROW
  EXECUTE PROCEDURE fn_suma_total_ticket();

-- ACTUALIZACION TICKET COMPRA --
CREATE OR REPLACE FUNCTION fn_actualizacion_ticket_compra() RETURNS TRIGGER AS $fn_actualizacion_ticket_compra$
  DECLARE
  BEGIN     
   
   UPDATE ticket SET total = ( SELECT DISTINCT total FROM ticket 
		INNER JOIN productos_comprados ON id_ticket = id_ticket_ticket 
		WHERE id_ticket = NEW.id_ticket_ticket ) + ( SELECT (NEW.cantidad - OLD.cantidad)*precio FROM producto 
		WHERE codigo = NEW.codigo_producto )
   		WHERE id_ticket = NEW.id_ticket_ticket;
   
   RETURN NEW;
  END;
$fn_actualizacion_ticket_compra$ LANGUAGE plpgsql;

CREATE TRIGGER tg_actualizacion_ticket_compra AFTER UPDATE
  ON PRODUCTOS_COMPRADOS FOR EACH ROW
  EXECUTE PROCEDURE fn_actualizacion_ticket_compra();

-- COMPROBACION TICKET DEVOLUCION --
CREATE OR REPLACE FUNCTION fn_comprobacion_ticket_devolucion() RETURNS TRIGGER AS $fn_comprobacion_ticket_devolucion$
  DECLARE
  BEGIN     
   
	IF ( NEW.cantidad ) < 0 THEN RAISE EXCEPTION 'NO PUEDES DEVOLVER CANTIDAD NEGATIVAS ALGO';
	END IF;
		
   RETURN NEW;
  END;
$fn_comprobacion_ticket_devolucion$ LANGUAGE plpgsql;

CREATE TRIGGER tg_comprobacion_ticket_devolucion BEFORE INSERT OR UPDATE
  ON PRODUCTOS_DEVUELTOS FOR EACH ROW
  EXECUTE PROCEDURE fn_comprobacion_ticket_devolucion();

--RESTA TICKET --
CREATE OR REPLACE FUNCTION fn_resta_total_ticket() RETURNS TRIGGER AS $fn_resta_total_ticket$
  DECLARE
  BEGIN     
   
   UPDATE ticket SET total = ( SELECT DISTINCT total FROM ticket 
		INNER JOIN productos_comprados ON id_ticket = id_ticket_ticket 
		WHERE id_ticket = OLD.id_ticket_ticket ) - (SELECT precio*OLD.cantidad
		FROM producto WHERE codigo = OLD.codigo_producto)
   		WHERE id_ticket = OLD.id_ticket_ticket;
   
   RETURN NEW;
  END;
$fn_resta_total_ticket$ LANGUAGE plpgsql;


CREATE TRIGGER tg_resta_total_ticket AFTER DELETE
  ON PRODUCTOS_COMPRADOS FOR EACH ROW
  EXECUTE PROCEDURE fn_resta_total_ticket();

-- DEVOLUCION PRODUCTO --
CREATE OR REPLACE FUNCTION fn_producto_devuelto_ticket() RETURNS TRIGGER AS $fn_producto_devuelto_ticket$
  DECLARE
  BEGIN     
   
   IF NEW.codigo_producto NOT IN ( SELECT codigo_producto FROM productos_comprados 
								  INNER JOIN ticket ON id_ticket = id_ticket_ticket 
									WHERE id_ticket = NEW.id_ticket_ticket ) 
	THEN RAISE EXCEPTION 'EL PRODUCTO NO ESTÁ EN EL TICKET';
   END IF;
   
   IF NEW.cantidad > ( SELECT cantidad FROM productos_comprados 
								  INNER JOIN ticket ON id_ticket = id_ticket_ticket 
									WHERE id_ticket = NEW.id_ticket_ticket AND codigo_producto = NEW.codigo_producto ) 
	THEN RAISE EXCEPTION 'LA CANTIDAD A DEVOLVER SUPERA A LA COMPRADA';
   END IF;
   
   UPDATE productos_comprados SET cantidad = ( SELECT cantidad FROM productos_comprados 
		INNER JOIN ticket ON id_ticket = id_ticket_ticket 
		WHERE id_ticket = NEW.id_ticket_ticket AND codigo_producto = NEW.codigo_producto ) - NEW.cantidad
   WHERE id_ticket_ticket = NEW.id_ticket_ticket AND codigo_producto = NEW.codigo_producto;
   
   RETURN NEW;
  END;
$fn_producto_devuelto_ticket$ LANGUAGE plpgsql;

CREATE TRIGGER tg_productos_devuelto_ticket BEFORE INSERT
  ON PRODUCTOS_DEVUELTOS FOR EACH ROW
  EXECUTE PROCEDURE fn_producto_devuelto_ticket();

-- ACTUALIZACION TICKET DEVOULCION --

CREATE OR REPLACE FUNCTION fn_actualizacion_ticket_devuelto() RETURNS TRIGGER AS $fn_actualizacion_ticket_devuelto$
  DECLARE
  BEGIN     
   
	UPDATE productos_comprados SET cantidad = ( SELECT cantidad FROM productos_comprados
		WHERE id_ticket_ticket = NEW.id_ticket_ticket AND codigo_producto = NEW.codigo_producto ) - ( NEW.cantidad - OLD.cantidad )
		WHERE NEW.codigo_producto = codigo_producto AND id_ticket_ticket = NEW.id_ticket_ticket; 
   
   	UPDATE ticket SET total = ( SELECT DISTINCT total FROM ticket INNER JOIN productos_comprados ON id_ticket = id_ticket_ticket 
		WHERE id_ticket = OLD.id_ticket_ticket ) + ( SELECT (OLD.CANTIDAD - NEW.CANTIDAD)*precio FROM producto 
		WHERE codigo = NEW.codigo_producto )
   		WHERE id_ticket = NEW.id_ticket_ticket;
		
   RETURN NEW;
  END;
$fn_actualizacion_ticket_devuelto$ LANGUAGE plpgsql;

CREATE TRIGGER tg_actualizacion_ticket_devuelto AFTER UPDATE
  ON PRODUCTOS_DEVUELTOS FOR EACH ROW
  EXECUTE PROCEDURE fn_actualizacion_ticket_devuelto();

-- NUEVO TICKET SOCIO --
CREATE OR REPLACE FUNCTION fn_nuevo_ticket_saldo_socio() RETURNS TRIGGER AS $fn_nuevo_ticket_saldo_socio$
  DECLARE
  BEGIN    
   IF NEW.numero_socio IN ( SELECT numero FROM socio ) THEN UPDATE socio 
   SET saldo_acumulado = saldo_acumulado + NEW.total WHERE socio.numero = NEW.numero_socio ;
   END IF;
   RETURN NEW;
  END;
$fn_nuevo_ticket_saldo_socio$ LANGUAGE plpgsql;


CREATE TRIGGER tg_nuevo_ticket_saldo_socio AFTER INSERT
  ON TICKET FOR EACH ROW
  EXECUTE PROCEDURE fn_nuevo_ticket_saldo_socio();

-- ACTUALIZACION TICKET SOCIO --
CREATE OR REPLACE FUNCTION fn_actualizar_ticket_saldo_socio() RETURNS TRIGGER AS $fn_actualizar_ticket_saldo_socio$
  DECLARE
  BEGIN    
   
   IF NEW.numero_socio IN ( SELECT numero FROM socio )
   THEN UPDATE socio SET saldo_acumulado = saldo_acumulado + ( NEW.total - OLD.total ) WHERE socio.numero = NEW.numero_socio ;
   END IF;
   
   RETURN NEW;
  END;
$fn_actualizar_ticket_saldo_socio$ LANGUAGE plpgsql;

CREATE TRIGGER tg_actualizar_ticket_saldo_socio AFTER UPDATE
  ON TICKET FOR EACH ROW
  EXECUTE PROCEDURE fn_actualizar_ticket_saldo_socio();