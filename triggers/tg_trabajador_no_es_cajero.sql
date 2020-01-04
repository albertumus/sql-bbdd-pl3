CREATE TRIGGER tg_trabajador_no_es_cajero BEFORE INSERT or UPDATE
  ON CAJERO FOR EACH ROW
  EXECUTE PROCEDURE fn_trabajador_no_es_cajero();