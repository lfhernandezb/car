  -- marca como borrados los registros de lablas relacionadas con 'vehiculo'
  CREATE TRIGGER borra_vehiculo 
  AFTER UPDATE OF borrado 
  ON vehiculo 
  FOR EACH ROW 
  WHEN NEW.borrado = true
  BEGIN
    UPDATE reparacion SET borrado = true 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE recordatorio SET borrado = true 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE mantencion_usuario SET borrado = true 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE rendimiento SET borrado = true 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;
  END;
  
  -- actualiza fecha_modificacion al actualizar cualquier columna de 'vehiculo'
  CREATE TRIGGER actualiza_vehiculo  
  AFTER UPDATE OF 
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
    borrado
  ON vehiculo FOR EACH ROW 
  BEGIN
    UPDATE vehiculo SET fecha_modificacion = datetime('now', 'localtime') WHERE id_vehiculo = NEW.id_vehiculo AND id_usuario = NEW.id_usuario;
  END;

  -- marca como borrados los registros de lablas relacionadas con 'mantencion_usuario'
  CREATE TRIGGER borra_mantencion_usuario
  AFTER UPDATE OF borrado 
  ON mantencion_usuario 
  FOR EACH ROW 
  WHEN NEW.borrado = true
  BEGIN
    UPDATE mantencion_usuario_hecha SET borrado = true 
    WHERE id_mantencion_usuario = NEW.id_mantencion_usuario 
    AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'mantencion_usuario'
  CREATE TRIGGER actualiza_mantencion_usuario
  AFTER UPDATE OF 
    id_mantencion_usuario,
    km,
    fecha,
    costo,
    borrado
  ON mantencion_usuario FOR EACH ROW 
  BEGIN
    UPDATE mantencion_usuario SET fecha_modificacion = datetime('now', 'localtime') WHERE id_mantencion_usuario = NEW.id_mantencion_usuario AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'reparacion'
  CREATE TRIGGER actualiza_reparacion
  AFTER UPDATE OF 
    id_vehiculo,
    titulo,
    descripcion,
    costo,
    borrado
  ON reparacion FOR EACH ROW 
  BEGIN
    UPDATE reparacion SET fecha_modificacion = datetime('now', 'localtime') WHERE id_reparacion = NEW.id_reparacion AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'recordatorio'
  CREATE TRIGGER actualiza_recordatorio
  AFTER UPDATE OF 
    id_vehiculo,
    recordar_fecha,
    recordar_km,
    fecha,
    km,
    titulo,
    descripcion,
    borrado
  ON recordatorio FOR EACH ROW 
  BEGIN
    UPDATE recordatorio SET fecha_modificacion = datetime('now', 'localtime') WHERE id_recordatorio = NEW.id_recordatorio AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'rendimiento'
  CREATE TRIGGER actualiza_rendimiento
  AFTER UPDATE OF 
    id_vehiculo,
    km,
    litros,
    estanque_lleno,
    costo,
    latitud,
    longitud,
    borrado
  ON rendimiento FOR EACH ROW 
  BEGIN
    UPDATE rendimiento SET fecha_modificacion = datetime('now', 'localtime') WHERE id_rendimiento = NEW.id_rendimiento AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'mantencion_usuario_hecha'
  CREATE TRIGGER actualiza_mantencion_usuario_hecha
  AFTER UPDATE OF 
    id_mantencion_usuario,
    km,
    fecha,
    costo,
    borrado
  ON mantencion_usuario_hecha FOR EACH ROW 
  BEGIN
    UPDATE mantencion_usuario_hecha SET fecha_modificacion = datetime('now', 'localtime') WHERE id_mantencion_usuario_hecha = NEW.id_mantencion_usuario_hecha AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'usuario'
  CREATE TRIGGER actualiza_usuario
  AFTER UPDATE OF 
    id_comuna,
    nombre,
    correo,
    fecha_nacimiento,
    hombre,
    telefono,
    fecha_vencimiento_licencia,
    borrado
  ON usuario FOR EACH ROW 
  BEGIN
    UPDATE usuario SET fecha_modificacion = datetime('now', 'localtime') WHERE id_usuario = NEW.id_usuario;
  END;

