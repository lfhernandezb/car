SELECT 
    id_usuario AS id,
    id_comuna,
    nombre,
    correo,
    fecha_nacimiento,
    hombre,
    telefono,
    fecha_vencimiento_licencia,
    fecha_modificacion,
    borrado
FROM usuario
WHERE id_usuario = ?;

SELECT 
    id_mantencion_usuario,
    id_usuario,
    id_vehiculo,
    nombre,
    descripcion,
    beneficios,
    URL,
    DependeKm,
    KmEntreMantenciones,
    DiasEntreMantenciones,
    id_mantencion_base,
    mantecion_base,
    fecha_modificacion,
    borrado
FROM mantencion_usuario
WHERE id_mantencion_usuario = ?;

SELECT 
    id_mantencion_usuario_hecha,
    id_usuario,
    id_mantencion_usuario,
    km,
    fecha,
    costo,
    fecha_modificacion,
    borrado
FROM mantencion_usuario_hecha
WHERE id_mantencion_usuario_hecha = ?;

SELECT id_recordatorio,
    id_usuario,
    id_vehiculo,
    recordar_fecha,
    recordar_km,
    fecha,
    km,
    titulo,
    descripcion,
    fecha_modificacion,
    borrado
FROM car.recordatorio
WHERE id_recordatorio = ?;

SELECT id_reparacion,
    id_usuario,
    id_vehiculo,
    titulo,
    descripcion,
    costo,
    fecha_modificacion,
    borrado
FROM reparacion
WHERE id_reparacion = ?;

SELECT id_vehiculo,
    id_usuario,
    id_modelo,
    id_tipo_transmision,
    id_combustible,
    id_traccion,
    alias,
    patente,
    anio,
    km,
    aire_acondicionado,
    alza_vidrios,
    fecha_modificacion,
    borrado
FROM vehiculo
WHERE id_vehiculo = ?;

SELECT    us.nombre AS nombre,    strftime(us.fecha_modificacion, '%Y-%m-%d %H:%M:%S') AS fecha_modificacion,    strftime(us.fecha_vencimiento_licencia, '%Y-%m-%d %H:%M:%S') AS fecha_vencimiento_licencia,    us.id_usuario AS id,    us.hombre AS hombre,    us.id_comuna AS id_comuna,    us.borrado AS borrado,    us.telefono AS telefono,    us.correo AS correo,    strftime(us.fecha_nacimiento, '%Y-%m-%d %H:%M:%S') AS fecha_nacimiento    FROM usuario us WHERE us.id_usuario = 1 AND us.fecha_modificacion > '1900-01-01'  LIMIT 0, 1



