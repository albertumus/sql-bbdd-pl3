SELECT nombre FROM opinion INNER JOIN socio ON opinion.numero_socio = socio.numero
WHERE opinion.puntuacion >= ( SELECT MAX(puntuacion) FROM opinion)