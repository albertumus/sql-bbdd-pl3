CREATE TRIGGER tg_actualizar_ticket_saldo_socio AFTER UPDATE
  ON TICKET FOR EACH ROW
  EXECUTE PROCEDURE fn_actualizar_ticket_saldo_socio();