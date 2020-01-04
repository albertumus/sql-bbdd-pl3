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