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