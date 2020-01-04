CREATE TRIGGER tg_comprobacion_ticket_devolucion BEFORE INSERT OR UPDATE
  ON PRODUCTOS_DEVUELTOS FOR EACH ROW
  EXECUTE PROCEDURE fn_comprobacion_ticket_devolucion();