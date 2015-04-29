-- correcciones

UPDATE mantencion_base
SET depende_km = 'true'
WHERE depende_km = 1;
UPDATE mantencion_base
SET depende_km = 'false'
WHERE depende_km = 0;

-- se borran las tablas no necesarias en la app movil

DROP TABLE alerta;
-- DROP TABLE aux_correo;
DROP TABLE campania;
DROP TABLE campania_usuario;
DROP TABLE usuario_web;
DROP TABLE proveedor;
DROP TABLE proveedor_mantencion_base;
DROP TABLE consulta_proveedor;
DROP TABLE respuesta_proveedor;

