SELECT tienda.nombre, COUNT (trabajador.nombre_tienda) FROM tienda INNER JOIN trabajador
ON trabajador.nombre_tienda = tienda.nombre GROUP BY tienda.nombre ORDER BY COUNT (trabajador.nombre_tienda)