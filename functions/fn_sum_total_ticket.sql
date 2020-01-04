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