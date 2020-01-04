CREATE TRIGGER tg_trabajador_no_es_reponedor BEFORE INSERT or UPDATE
  ON REPONEDOR FOR EACH ROW
  EXECUTE PROCEDURE fn_trabajador_no_es_reponedor();