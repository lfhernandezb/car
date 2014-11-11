-- correcciones

UPDATE mantencion_base
SET depende_km = 'true'
WHERE depende_km = 1;
UPDATE mantencion_base
SET depende_km = 'false'
WHERE depende_km = 0;

-- se borran las tablas no necesarias en la app movil

DROP TABLE alerta;

