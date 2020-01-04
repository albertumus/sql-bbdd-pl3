CREATE TRIGGER tg_actualizacion_ticket_compra AFTER UPDATE
  ON PRODUCTOS_COMPRADOS FOR EACH ROW
  EXECUTE PROCEDURE fn_actualizacion_ticket_compra();