SELECT * FROM producto_en_oferta INNER JOIN oferta ON id_oferta = id_oferta_oferta
WHERE fecha_inicio >= '2019-05-01' AND fecha_fin <= '2019-05-07' ORDER BY fecha_inicio