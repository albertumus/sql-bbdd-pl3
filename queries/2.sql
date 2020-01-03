SELECT nombre, 
CASE WHEN jornada IS NULL THEN 'cajero' ELSE 'reponedor' END AS tipo
FROM trabajador FULL JOIN cajero ON cajero.dni_trabajador = trabajador.dni
FULL JOIN reponedor ON reponedor.dni_trabajador = trabajador.dni