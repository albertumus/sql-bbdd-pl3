CREATE OR REPLACE FUNCTION fn_comprobacion_ticket_devolucion() RETURNS TRIGGER AS $fn_comprobacion_ticket_devolucion$
  DECLARE
  BEGIN     
   
	IF ( NEW.cantidad ) < 0 THEN RAISE EXCEPTION 'NO PUEDES DEVOLVER CANTIDAD NEGATIVAS ALGO';
	END IF;
		
   RETURN NEW;
  END;
$fn_comprobacion_ticket_devolucion$ LANGUAGE plpgsql;