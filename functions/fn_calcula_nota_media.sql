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