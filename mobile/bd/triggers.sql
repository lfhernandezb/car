  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'pais'
  CREATE TRIGGER actualiza_pais
  BEFORE UPDATE OF
    pais
  ON pais FOR EACH ROW
  BEGIN
    UPDATE pais
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_pais = NEW.id_pais;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'region'
  CREATE TRIGGER actualiza_region
  BEFORE UPDATE OF
    region,
    id_pais
  ON region FOR EACH ROW
  BEGIN
    UPDATE region
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_region = NEW.id_region;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'comuna'
  CREATE TRIGGER actualiza_comuna
  BEFORE UPDATE OF
    id_region,
    comuna
  ON comuna FOR EACH ROW
  BEGIN
    UPDATE comuna
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_comuna = NEW.id_comuna;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'tipo_vehiculo'
  CREATE TRIGGER actualiza_tipo_vehiculo
  BEFORE UPDATE OF
    descripcion
  ON tipo_vehiculo FOR EACH ROW
  BEGIN
    UPDATE tipo_vehiculo
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_tipo_vehiculo = NEW.id_tipo_vehiculo;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'marca'
  CREATE TRIGGER actualiza_marca
  BEFORE UPDATE OF
    id_tipo_vehiculo,
    id_pais,
    descripcion
  ON marca FOR EACH ROW
  BEGIN
    UPDATE marca
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_marca = NEW.id_marca;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'modelo'
  CREATE TRIGGER actualiza_modelo
  BEFORE UPDATE OF
    descripcion,
    id_marca
  ON modelo FOR EACH ROW
  BEGIN
    UPDATE modelo
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_modelo = NEW.id_modelo;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'red_social'
  CREATE TRIGGER actualiza_red_social
  BEFORE UPDATE OF
    red_social
  ON red_social FOR EACH ROW
  BEGIN
    UPDATE red_social
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_red_social = NEW.id_red_social;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'usuario'
  CREATE TRIGGER actualiza_usuario
  AFTER UPDATE OF
    nombre,
    fecha_vencimiento_licencia,
    hombre,
    id_comuna,
    borrado,
    telefono,
    correo,
    fecha_nacimiento
  ON usuario FOR EACH ROW
  BEGIN
    UPDATE usuario
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'combustible'
  CREATE TRIGGER actualiza_combustible
  BEFORE UPDATE OF
    descripcion
  ON combustible FOR EACH ROW
  BEGIN
    UPDATE combustible
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_combustible = NEW.id_combustible;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'tipo_transmision'
  CREATE TRIGGER actualiza_tipo_transmision
  BEFORE UPDATE OF
    descripcion
  ON tipo_transmision FOR EACH ROW
  BEGIN
    UPDATE tipo_transmision
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_tipo_transmision = NEW.id_tipo_transmision;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'traccion'
  CREATE TRIGGER actualiza_traccion
  BEFORE UPDATE OF
    descripcion
  ON traccion FOR EACH ROW
  BEGIN
    UPDATE traccion
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_traccion = NEW.id_traccion;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'vehiculo'
  CREATE TRIGGER actualiza_vehiculo
  BEFORE UPDATE OF
    anio,
    km_calibrados,
    km_anuales,
    aire_acondicionado,
    alias,
    borrado,
    fecha_ultimo_km,
    id_traccion,
    km,
    alza_vidrios,
    fecha_ultima_calibracion,
    patente,
    id_modelo,
    id_tipo_transmision,
    id_combustible
  ON vehiculo FOR EACH ROW
  BEGIN
    UPDATE vehiculo
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_vehiculo = NEW.id_vehiculo;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'autenticacion'
  CREATE TRIGGER actualiza_autenticacion
  BEFORE UPDATE OF
    fecha,
    id_red_social,
    token,
    id_usuario
  ON autenticacion FOR EACH ROW
  BEGIN
    UPDATE autenticacion
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_autenticacion = NEW.id_autenticacion;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_base'
  CREATE TRIGGER actualiza_mantencion_base
  BEFORE UPDATE OF
    combustible,
    km_entre_mantenciones,
    meses_entre_mantenciones,
    depende_km,
    accion,
    url,
    nombre,
    descripcion_item,
    traccion,
    beneficios
  ON mantencion_base FOR EACH ROW
  BEGIN
    UPDATE mantencion_base
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_mantencion_base = NEW.id_mantencion_base;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_pospuesta'
  CREATE TRIGGER actualiza_mantencion_pospuesta
  BEFORE UPDATE OF
    fecha,
    borrado,
    km,
    id_mantencion_base,
    id_vehiculo
  ON mantencion_pospuesta FOR EACH ROW
  BEGIN
    UPDATE mantencion_pospuesta
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_mantencion_pospuesta = NEW.id_mantencion_pospuesta;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_usuario'
  CREATE TRIGGER actualiza_mantencion_usuario
  BEFORE UPDATE OF
    borrado,
    descripcion,
    km_entre_mantenciones,
    meses_entre_mantenciones,
    depende_km,
    url,
    nombre,
    beneficios
  ON mantencion_usuario FOR EACH ROW
  BEGIN
    UPDATE mantencion_usuario
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_mantencion_usuario = NEW.id_mantencion_usuario;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_usuario_hecha'
  CREATE TRIGGER actualiza_mantencion_usuario_hecha
  BEFORE UPDATE OF
    fecha,
    borrado,
    id_mantencion_usuario,
    costo,
    km,
    id_vehiculo
  ON mantencion_usuario_hecha FOR EACH ROW
  BEGIN
    UPDATE mantencion_usuario_hecha
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_mantencion_usuario_hecha = NEW.id_mantencion_usuario_hecha;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'parametro'
  CREATE TRIGGER actualiza_parametro
  BEFORE UPDATE OF
    valor,
    llave
  ON parametro FOR EACH ROW
  BEGIN
    UPDATE parametro
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_parametro = NEW.id_parametro;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'recordatorio'
  CREATE TRIGGER actualiza_recordatorio
  BEFORE UPDATE OF
    fecha,
    borrado,
    descripcion,
    recordar_km,
    km,
    recordar_fecha,
    titulo,
    id_vehiculo
  ON recordatorio FOR EACH ROW
  BEGIN
    UPDATE recordatorio
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_recordatorio = NEW.id_recordatorio AND
    id_usuario = NEW.id_usuario;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'log'
  CREATE TRIGGER actualiza_log
  BEFORE UPDATE OF
    borrado,
    data,
    latitud,
    longitud
  ON log FOR EACH ROW
  BEGIN
    UPDATE log
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_log = NEW.id_log;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'reparacion'
  CREATE TRIGGER actualiza_reparacion
  BEFORE UPDATE OF
    fecha,
    borrado,
    descripcion,
    costo,
    titulo,
    id_vehiculo
  ON reparacion FOR EACH ROW
  BEGIN
    UPDATE reparacion
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_reparacion = NEW.id_reparacion;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'carga_combustible'
  CREATE TRIGGER actualiza_carga_combustible
  BEFORE UPDATE OF
    estanque_lleno,
    fecha,
    borrado,
    costo,
    km,
    litros,
    id_vehiculo,
    latitud,
    longitud
  ON carga_combustible FOR EACH ROW
  BEGIN
    UPDATE carga_combustible
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_carga_combustible = NEW.id_carga_combustible;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_base_hecha'
  CREATE TRIGGER actualiza_mantencion_base_hecha
  BEFORE UPDATE OF
    fecha,
    borrado,
    costo,
    km,
    id_mantencion_base,
    id_vehiculo
  ON mantencion_base_hecha FOR EACH ROW
  BEGIN
    UPDATE mantencion_base_hecha
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_mantencion_base_hecha = NEW.id_mantencion_base_hecha;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'cambio_revision'
  CREATE TRIGGER actualiza_cambio_revision
  BEFORE UPDATE OF
    id_cambio,
    id_revision
  ON cambio_revision FOR EACH ROW
  BEGIN
    UPDATE cambio_revision
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_cambio_revision = NEW.id_cambio_revision;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'cia_seguros'
  CREATE TRIGGER actualiza_cia_seguros
  BEFORE UPDATE OF
    datos_anexos,
    nombre
  ON cia_seguros FOR EACH ROW
  BEGIN
    UPDATE cia_seguros
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_cia_seguros = NEW.id_cia_seguros;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'seguro_vehiculo'
  CREATE TRIGGER actualiza_seguro_vehiculo
  BEFORE UPDATE OF
    id_cia_seguros,
    poliza,
    borrado,
    observaciones,
    fecha_vencimiento,
    id_vehiculo,
    id_tipo_seguro
  ON seguro_vehiculo FOR EACH ROW
  BEGIN
    UPDATE seguro_vehiculo
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_seguro_vehiculo = NEW.id_seguro_vehiculo;
  END;

  -- marca como borrados los registros de lablas relacionadas con 'vehiculo'
  CREATE TRIGGER borra_vehiculo 
  AFTER UPDATE OF borrado 
  ON vehiculo 
  FOR EACH ROW 
  WHEN NEW.borrado = 'true'
  BEGIN
    UPDATE reparacion SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE recordatorio SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE mantencion_base_hecha SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE mantencion_usuario_hecha SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE carga_combustible SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;
  END;
  
  -- marca como borrados los registros de lablas relacionadas con 'mantencion_usuario'
  CREATE TRIGGER borra_mantencion_usuario
  AFTER UPDATE OF borrado 
  ON mantencion_usuario 
  FOR EACH ROW 
  WHEN NEW.borrado = 'true'
  BEGIN
    UPDATE mantencion_usuario_hecha SET borrado = 'true' 
    WHERE id_mantencion_usuario = NEW.id_mantencion_usuario 
    AND id_usuario = NEW.id_usuario;
  END;




