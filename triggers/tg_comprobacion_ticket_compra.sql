CREATE TRIGGER tg_comprobacion_ticket_compra BEFORE UPDATE OR INSERT
  ON PRODUCTOS_COMPRADOS FOR EACH ROW
  EXECUTE PROCEDURE fn_comprobacion_ticket_compra();