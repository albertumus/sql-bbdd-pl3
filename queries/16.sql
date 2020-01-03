SELECT dni_trabajador, COUNT(dni_trabajador) as total
FROM ticket, cajero WHERE ticket.dni_trabajador_cajero = dni_trabajador
GROUP BY dni_trabajador ORDER BY total DESC
LIMIT 1
