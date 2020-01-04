CREATE TRIGGER tg_nuevo_ticket_saldo_socio AFTER INSERT
  ON TICKET FOR EACH ROW
  EXECUTE PROCEDURE fn_nuevo_ticket_saldo_socio();