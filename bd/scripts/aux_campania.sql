
SELECT STR_TO_DATE('2015-02-14 01:00:00', '%Y-%m-%d %H:%i:%s') < CURRENT_TIMESTAMP;

SELECT TIMESTAMPDIFF(HOUR, STR_TO_DATE('2015-02-14 01:00:00', '%Y-%m-%d %H:%i:%s'), CURRENT_TIMESTAMP);

INSERT INTO campania (descripcion, por_sql, condicion_sql, texto_correo, inicio, periodicidad_dias, activa)
VALUES ('Primera', 0, null, 'hola', STR_TO_DATE('2015-02-14 01:00:00', '%Y-%m-%d %H:%i:%s'), null, true);

UPDATE campania
SET inicio = STR_TO_DATE('2014-02-13 23:00:00', '%Y-%m-%d %H:%i:%s'),
periodicidad_dias = 1
WHERE id_campania = 32;
