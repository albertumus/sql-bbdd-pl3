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