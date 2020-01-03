SELECT nombre FROM socio WHERE numero in (SELECT numero_socio FROM ticket INNER JOIN productos_comprados ON id_ticket = id_ticket_ticket
WHERE fecha >= '2019-05-24' AND fecha <= '2019-05-31' AND codigo_producto IN
(SELECT codigo_producto FROM producto_en_oferta INNER JOIN oferta ON id_oferta = id_oferta_oferta
WHERE fecha_inicio >= '2019-05-24' AND fecha_fin <= '2019-05-31' ORDER BY fecha_inicio))