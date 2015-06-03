  DROP TRIGGER IF EXISTS actualiza_alerta;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'alerta'
  DELIMITER $$
  CREATE TRIGGER actualiza_alerta BEFORE UPDATE ON alerta
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_autenticacion;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'autenticacion'
  DELIMITER $$
  CREATE TRIGGER actualiza_autenticacion BEFORE UPDATE ON autenticacion
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_cambio_revision;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'cambio_revision'
  DELIMITER $$
  CREATE TRIGGER actualiza_cambio_revision BEFORE UPDATE ON cambio_revision
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_campania;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'campania'
  DELIMITER $$
  CREATE TRIGGER actualiza_campania BEFORE UPDATE ON campania
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_campania_usuario;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'campania_usuario'
  DELIMITER $$
  CREATE TRIGGER actualiza_campania_usuario BEFORE UPDATE ON campania_usuario
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_carga_combustible;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'carga_combustible'
  DELIMITER $$
  CREATE TRIGGER actualiza_carga_combustible BEFORE UPDATE ON carga_combustible
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_cia_seguros;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'cia_seguros'
  DELIMITER $$
  CREATE TRIGGER actualiza_cia_seguros BEFORE UPDATE ON cia_seguros
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_combustible;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'combustible'
  DELIMITER $$
  CREATE TRIGGER actualiza_combustible BEFORE UPDATE ON combustible
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_comuna;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'comuna'
  DELIMITER $$
  CREATE TRIGGER actualiza_comuna BEFORE UPDATE ON comuna
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_consulta_proveedor;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'consulta_proveedor'
  DELIMITER $$
  CREATE TRIGGER actualiza_consulta_proveedor BEFORE UPDATE ON consulta_proveedor
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_log;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'log'
  DELIMITER $$
  CREATE TRIGGER actualiza_log BEFORE UPDATE ON log
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_mantencion_base;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_base'
  DELIMITER $$
  CREATE TRIGGER actualiza_mantencion_base BEFORE UPDATE ON mantencion_base
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_mantencion_base_hecha;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_base_hecha'
  DELIMITER $$
  CREATE TRIGGER actualiza_mantencion_base_hecha BEFORE UPDATE ON mantencion_base_hecha
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_mantencion_pospuesta;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_pospuesta'
  DELIMITER $$
  CREATE TRIGGER actualiza_mantencion_pospuesta BEFORE UPDATE ON mantencion_pospuesta
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_mantencion_usuario;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_usuario'
  DELIMITER $$
  CREATE TRIGGER actualiza_mantencion_usuario BEFORE UPDATE ON mantencion_usuario
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_mantencion_usuario_hecha;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_usuario_hecha'
  DELIMITER $$
  CREATE TRIGGER actualiza_mantencion_usuario_hecha BEFORE UPDATE ON mantencion_usuario_hecha
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_marca;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'marca'
  DELIMITER $$
  CREATE TRIGGER actualiza_marca BEFORE UPDATE ON marca
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_modelo;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'modelo'
  DELIMITER $$
  CREATE TRIGGER actualiza_modelo BEFORE UPDATE ON modelo
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_pais;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'pais'
  DELIMITER $$
  CREATE TRIGGER actualiza_pais BEFORE UPDATE ON pais
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_parametro;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'parametro'
  DELIMITER $$
  CREATE TRIGGER actualiza_parametro BEFORE UPDATE ON parametro
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_proveedor;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'proveedor'
  DELIMITER $$
  CREATE TRIGGER actualiza_proveedor BEFORE UPDATE ON proveedor
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_proveedor_mantencion_base;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'proveedor_mantencion_base'
  DELIMITER $$
  CREATE TRIGGER actualiza_proveedor_mantencion_base BEFORE UPDATE ON proveedor_mantencion_base
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_recordatorio;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'recordatorio'
  DELIMITER $$
  CREATE TRIGGER actualiza_recordatorio BEFORE UPDATE ON recordatorio
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_red_social;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'red_social'
  DELIMITER $$
  CREATE TRIGGER actualiza_red_social BEFORE UPDATE ON red_social
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_region;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'region'
  DELIMITER $$
  CREATE TRIGGER actualiza_region BEFORE UPDATE ON region
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_reparacion;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'reparacion'
  DELIMITER $$
  CREATE TRIGGER actualiza_reparacion BEFORE UPDATE ON reparacion
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_respuesta_proveedor;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'respuesta_proveedor'
  DELIMITER $$
  CREATE TRIGGER actualiza_respuesta_proveedor BEFORE UPDATE ON respuesta_proveedor
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_seguro_vehiculo;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'seguro_vehiculo'
  DELIMITER $$
  CREATE TRIGGER actualiza_seguro_vehiculo BEFORE UPDATE ON seguro_vehiculo
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_tipo_transmision;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'tipo_transmision'
  DELIMITER $$
  CREATE TRIGGER actualiza_tipo_transmision BEFORE UPDATE ON tipo_transmision
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_tipo_vehiculo;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'tipo_vehiculo'
  DELIMITER $$
  CREATE TRIGGER actualiza_tipo_vehiculo BEFORE UPDATE ON tipo_vehiculo
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_traccion;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'traccion'
  DELIMITER $$
  CREATE TRIGGER actualiza_traccion BEFORE UPDATE ON traccion
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_usuario;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'usuario'
  DELIMITER $$
  CREATE TRIGGER actualiza_usuario BEFORE UPDATE ON usuario
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_vehiculo;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'vehiculo'
  DELIMITER $$
  CREATE TRIGGER actualiza_vehiculo BEFORE UPDATE ON vehiculo
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END;$$
  DELIMITER ;

