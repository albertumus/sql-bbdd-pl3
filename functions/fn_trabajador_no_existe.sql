CREATE OR REPLACE FUNCTION fn_trabajador_existe() RETURNS TRIGGER AS $fn_trabajador_existe$
  DECLARE

  BEGIN    
   IF NEW.nombre IN ( SELECT nombre FROM trabajador ) THEN RAISE EXCEPTION 'EL TRABAJADOR YA EXISTE';
   END IF;
   RETURN NEW;
  END;
$fn_trabajador_existe$ LANGUAGE plpgsql;