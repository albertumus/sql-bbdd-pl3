CREATE OR REPLACE FUNCTION fn_trabajador_no_es_cajero() RETURNS TRIGGER AS $fn_trabajador_no_es_cajero$
  DECLARE

  BEGIN    
   IF NEW.dni_trabajador IN ( SELECT dni_trabajador FROM reponedor ) THEN RAISE EXCEPTION 'EL TRABAJADOR YA EXISTE EN REPONEDOR';
   END IF;
   RETURN NEW;
  END;
$fn_trabajador_no_es_cajero$ LANGUAGE plpgsql;