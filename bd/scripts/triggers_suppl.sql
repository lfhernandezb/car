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


