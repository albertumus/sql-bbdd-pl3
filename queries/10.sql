SELECT dni, nombre, telefono, movil 
FROM 
(SELECT dni_trabajador1, CAST(AVG(puntuacion) AS decimal(10,2)) as media
FROM trabajador_puntua_trabajador
GROUP BY dni_trabajador1 ORDER BY media DESC LIMIT 1) AS mejor_empleado
INNER JOIN trabajador ON dni_trabajador1 = dni
