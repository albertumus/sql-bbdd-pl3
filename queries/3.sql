SELECT nombre 
FROM trabajador INNER JOIN reponedor ON trabajador.dni = reponedor.dni_trabajador
WHERE jornada > 20