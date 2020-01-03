SELECT trabajador.nombre, nombre_tienda, ciudad FROM tienda INNER JOIN 
trabajador ON nombre_tienda = tienda.nombre WHERE tienda.ciudad LIKE 'M%'