SELECT producto_cupon.codigo_producto FROM socios_cupon INNER JOIN producto_cupon 
ON socios_cupon.id_cupon_cupon =  producto_cupon.id_cupon_cupon LIMIT 5