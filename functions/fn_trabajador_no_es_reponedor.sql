CREATE OR REPLACE FUNCTION fn_trabajador_no_es_reponedor() RETURNS TRIGGER AS $fn_trabajador_no_es_reponedor$
  DECLARE

  BEGIN    
   IF NEW.dni_trabajador IN ( SELECT dni_trabajador FROM cajero ) THEN RAISE EXCEPTION 'EL TRABAJADOR YA EXISTE EN CAJERO';
   END IF;
   RETURN NEW;
  END;
$fn_trabajador_no_es_reponedor$ LANGUAGE plpgsql;