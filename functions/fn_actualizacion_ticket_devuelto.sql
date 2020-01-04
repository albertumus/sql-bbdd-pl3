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