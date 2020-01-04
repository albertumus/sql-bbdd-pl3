CREATE TRIGGER tg_productos_devuelto_ticket BEFORE INSERT
  ON PRODUCTOS_DEVUELTOS FOR EACH ROW
  EXECUTE PROCEDURE fn_producto_devuelto_ticket();