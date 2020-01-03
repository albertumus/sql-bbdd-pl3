SELECT t.id_ticket, t.nombre as nombreCajero, tienda.ciudad FROM tienda INNER JOIN ( SELECT * FROM  trabajador  
																					INNER JOIN ( SELECT * FROM cajero INNER JOIN ticket 
ON cajero.dni_trabajador = ticket.dni_trabajador_cajero ) as p ON trabajador.dni
= p.dni_trabajador_cajero ) as t ON tienda.nombre = t.nombre_tienda WHERE t.nombre LIKE 'A%' 
AND tienda.ciudad LIKE 'M%'