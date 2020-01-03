SELECT id_cupon, p.codigo_producto, descuento
FROM cupon INNER JOIN ( SELECT socios_cupon.id_cupon_cupon, producto_cupon.codigo_producto 
FROM socios_cupon INNER JOIN producto_cupon 
ON producto_cupon.id_cupon_cupon  = socios_cupon.id_cupon_cupon) AS p
ON p.id_cupon_cupon = cupon.id_cupon 