  DROP TRIGGER IF EXISTS borra_campania;

  -- borra registros relacionados a campania
  DELIMITER $$
  CREATE TRIGGER borra_campania BEFORE DELETE ON campania
  FOR EACH ROW
  BEGIN
    DELETE FROM campania_usuario
    WHERE id_campania = OLD.id_campania;
  END;$$
  DELIMITER ;
  
  DROP TRIGGER IF EXISTS borra_proveedor;

  -- borra registros relacionados a proveedor
  DELIMITER $$
  CREATE TRIGGER borra_proveedor BEFORE DELETE ON proveedor
  FOR EACH ROW
  BEGIN
    DELETE FROM proveedor_mantencion_base
    WHERE id_proveedor = OLD.id_proveedor;

    DELETE FROM respuesta_proveedor
    WHERE id_proveedor = OLD.id_proveedor;
  END;$$
  DELIMITER ;

  DROP TRIGGER IF EXISTS actualiza_campania;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'campania'
  DELIMITER $$
  CREATE TRIGGER actualiza_campania BEFORE UPDATE ON campania
  FOR EACH ROW
  BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
    
    IF NOT NEW.activa THEN
      DELETE FROM campania_usuario
      WHERE id_campania = NEW.id_campania;
    END IF;  
  END;$$
  DELIMITER ;

-- borra usuario y sus registros relacionados
DELIMITER $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `borra_usuario`
BEFORE DELETE ON `usuario`
FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one
BEGIN
  DELETE FROM mantencion_base_hecha WHERE id_usuario = OLD.id_usuario;
  DELETE FROM mantencion_pospuesta WHERE id_usuario = OLD.id_usuario;
  DELETE FROM mantencion_usuario WHERE id_usuario = OLD.id_usuario;
  DELETE FROM mantencion_usuario_hecha WHERE id_usuario = OLD.id_usuario;
  DELETE FROM recordatorio WHERE id_usuario = OLD.id_usuario;
  DELETE FROM reparacion WHERE id_usuario = OLD.id_usuario;
  DELETE FROM respuesta_proveedor WHERE id_usuario = OLD.id_usuario;
  DELETE FROM seguro_vehiculo WHERE id_usuario = OLD.id_usuario;
  DELETE FROM autenticacion WHERE id_usuario = OLD.id_usuario;
  DELETE FROM campania_usuario WHERE id_usuario = OLD.id_usuario;
  DELETE FROM log WHERE id_usuario = OLD.id_usuario;
  DELETE FROM carga_combustible WHERE id_usuario = OLD.id_usuario;
  DELETE FROM alerta WHERE id_usuario = OLD.id_usuario;
  DELETE FROM consulta_proveedor WHERE id_usuario = OLD.id_usuario;
  DELETE FROM respuesta_proveedor WHERE id_usuario = OLD.id_usuario;
  DELETE FROM vehiculo WHERE id_usuario = OLD.id_usuario;
END;$$
DELIMITER ;
