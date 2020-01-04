CREATE TRIGGER tg_actualizacion_ticket_devuelto AFTER UPDATE
  ON PRODUCTOS_DEVUELTOS FOR EACH ROW
  EXECUTE PROCEDURE fn_actualizacion_ticket_devuelto();