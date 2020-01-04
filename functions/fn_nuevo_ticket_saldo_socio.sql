CREATE OR REPLACE FUNCTION fn_nuevo_ticket_saldo_socio() RETURNS TRIGGER AS $fn_nuevo_ticket_saldo_socio$
  DECLARE
  BEGIN    
   IF NEW.numero_socio IN ( SELECT numero FROM socio ) THEN UPDATE socio 
   SET saldo_acumulado = saldo_acumulado + NEW.total WHERE socio.numero = NEW.numero_socio ;
   END IF;
   RETURN NEW;
  END;
$fn_nuevo_ticket_saldo_socio$ LANGUAGE plpgsql;