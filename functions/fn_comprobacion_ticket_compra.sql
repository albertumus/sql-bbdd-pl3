CREATE OR REPLACE FUNCTION fn_comprobacion_ticket_compra() RETURNS TRIGGER AS $fn_comprobacion_ticket_compra$
  DECLARE
  BEGIN     
   
	IF ( NEW.cantidad ) < 0 THEN RAISE EXCEPTION 'NO PUEDES COMPRAR CANTIDAD NEGATIVAS ALGO';
	END IF;
		
   RETURN NEW;
  END;
$fn_comprobacion_ticket_compra$ LANGUAGE plpgsql;