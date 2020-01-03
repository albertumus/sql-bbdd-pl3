SELECT contador.nombre_tienda, contador.ticket, tickets.id_ticket, tickets.nombre, tickets.ciudad
FROM ( SELECT trabajador.nombre_tienda, COUNT(trabajador.nombre_tienda) AS ticket
FROM ticket, cajero, trabajador
WHERE ticket.dni_trabajador_cajero = cajero.dni_trabajador
AND cajero.dni_trabajador = trabajador.dni
GROUP BY trabajador.nombre_tienda ) AS contador
INNER JOIN (SELECT trabajador.nombre_tienda, ticket.id_ticket, trabajador.nombre, tienda.ciudad
FROM ticket, cajero, trabajador, tienda 
WHERE ticket.dni_trabajador_cajero = cajero.dni_trabajador
AND cajero.dni_trabajador = trabajador.dni AND trabajador.nombre_tienda = tienda.nombre
GROUP BY trabajador.nombre_tienda, ticket.id_ticket, trabajador.nombre, tienda.ciudad
ORDER BY trabajador.nombre_tienda) AS tickets ON contador.nombre_tienda = tickets.nombre_tienda 