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