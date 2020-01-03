SELECT id_ticket, trabajador.nombre, tienda.ciudad, tienda.nombre FROM ticket, cajero, trabajador, tienda 
WHERE ticket.dni_trabajador_cajero = cajero.dni_trabajador AND
cajero.dni_trabajador = trabajador.dni AND trabajador.nombre_tienda = tienda.nombre AND tienda.ciudad = 'Alcala'