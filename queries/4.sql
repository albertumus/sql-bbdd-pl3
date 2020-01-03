SELECT SUM(precio_iva*cantidad) FROM productos_comprados INNER JOIN producto 
ON producto.codigo = productos_comprados.codigo_producto