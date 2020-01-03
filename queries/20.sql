SELECT id_ticket, trabajador.nombre, tienda.ciudad, tienda.nombre, fecha FROM ticket, cajero, trabajador, tienda 
WHERE ticket.dni_trabajador_cajero = cajero.dni_trabajador AND
cajero.dni_trabajador = trabajador.dni AND trabajador.nombre_tienda = tienda.nombre 
AND tienda.ciudad = 'Alcala' AND id_ticket NOT IN 
((SELECT id_ticket FROM ticket WHERE numero_socio NOT IN ( SELECT numero_socio FROM producto_cupon INNER JOIN
( SELECT id_cupon, numero_socio FROM socios_cupon INNER JOIN cupon ON id_cupon_cupon = id_cupon ) 
AS cupones_de_socios ON cupones_de_socios.id_cupon = producto_cupon.id_cupon_cupon ) )
INTERSECT
(SELECT id_ticket_ticket FROM productos_comprados INNER JOIN ( SELECT codigo_producto FROM producto_cupon INNER JOIN
( SELECT id_cupon, numero_socio FROM socios_cupon INNER JOIN cupon ON id_cupon_cupon = id_cupon ) 
AS cupones_de_socios ON cupones_de_socios.id_cupon = producto_cupon.id_cupon_cupon ) as p 
ON p.codigo_producto = productos_comprados.codigo_producto)
) AND id_ticket NOT IN (SELECT DISTINCT id_ticket FROM ticket, ( SELECT * FROM producto, oferta,productos_comprados, 
																producto_en_oferta
					   WHERE producto_en_oferta.codigo_producto = producto.codigo
AND productos_comprados.codigo_producto = producto.codigo ) as k WHERE id_ticket_ticket = id_ticket
AND ticket.fecha BETWEEN k.fecha_inicio AND k.fecha_fin)