SELECT codigo_producto, SUM(cantidad) as total
FROM productos_devueltos
GROUP BY codigo_producto HAVING SUM(cantidad) >= 
(SELECT MAX(total) FROM (SELECT SUM(cantidad) as total FROM productos_devueltos GROUP BY 
codigo_producto) as t)
ORDER BY total desc

