
ALTER TABLE `car`.`vehiculo` 
ADD COLUMN `km_anuales` INT(11) NULL AFTER `id_traccion`,
ADD COLUMN `fecha_ultimo_km` DATE NULL AFTER `km_anuales`,
ADD COLUMN `km_calibrados` INT(11) NULL AFTER `fecha_ultimo_km`,
ADD COLUMN `fecha_ultima_calibracion` DATE NULL AFTER `km_calibrados`;
  
-- -----------------------------------------------------
-- Table `mantencion_pospuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantencion_pospuesta` (
  `id_mantencion_pospuesta` INT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `id_mantencion_base` BIGINT NOT NULL,
  `km` INT NULL,
  `fecha` DATE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_mantencion_pospuesta`, `id_usuario`),
  CONSTRAINT `fk_mantencion_pospuesta_mantencion_base1`
    FOREIGN KEY (`id_mantencion_base`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mantencion_pospuesta_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mantencion_pospuesta_mantencion_base1_idx` ON `mantencion_pospuesta` (`id_mantencion_base` ASC);

CREATE INDEX `fk_mantencion_pospuesta_vehiculo1_idx` ON `mantencion_pospuesta` (`id_vehiculo` ASC, `id_usuario` ASC);

-- -----------------------------------------------------
-- Table `parametro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parametro` (
  `id_parametro` BIGINT NOT NULL,
  `llave` VARCHAR(64) NOT NULL,
  `valor` VARCHAR(64) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_parametro`))
ENGINE = InnoDB;

INSERT INTO red_social (id_red_social, red_social) VALUES (0, 'default');

ALTER TABLE `car`.`traccion` 
CHANGE COLUMN `descripcion` `descripcion` VARCHAR(40) NOT NULL ;

UPDATE traccion SET descripcion = 'DOBLE TRACCION PERMAMENTE (AWD)' WHERE id_traccion = 1;
UPDATE traccion SET descripcion = 'TRACCION DELANTERA' WHERE id_traccion = 2;
UPDATE traccion SET descripcion = 'DOBLE TRACCION NO PERMAMENTE (4WD)' WHERE id_traccion = 3;
UPDATE traccion SET descripcion = 'TRACCION TRASERA' WHERE id_traccion = 4;

-- -----------------------------------------------------
-- Table `notificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notificacion` (
  `id_notificacion` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT NOT NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `periodicidad` SMALLINT NULL,
  `numero_impresiones` SMALLINT NULL,
  `detalle` TEXT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id_notificacion`),
  CONSTRAINT `fk_notificacion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_notificacion_usuario1_idx` ON `notificacion` (`id_usuario` ASC);

-- -----------------------------------------------------
-- Table `proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proveedor` (
  `id_proveedor` INT NOT NULL,
  `nombre` VARCHAR(256) NULL,
  `direccion` VARCHAR(512) NULL,
  `correo` VARCHAR(128) NULL,
  `telefono` VARCHAR(128) NULL,
  `latitud` DOUBLE NULL,
  `longitud` DOUBLE NULL,
  `existen_valores` TINYINT(1) NULL,
  `valor_minimo` FLOAT NULL,
  `valor_maximo` FLOAT NULL,
  `detalle_html` TEXT NULL,
  `calificacion` TINYINT NULL,
  `url` VARCHAR(256) NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `proveedor_mantencion_base`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proveedor_mantencion_base` (
  `id_proveedor_mantencion_base` INT NOT NULL,
  `id_proveedor` INT NOT NULL,
  `id_mantencion_base` BIGINT NOT NULL,
  PRIMARY KEY (`id_proveedor_mantencion_base`),
  CONSTRAINT `fk_proveedor_mantencion_base_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_mantencion_base_mantencion_base1`
    FOREIGN KEY (`id_mantencion_base`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_proveedor_mantencion_base_proveedor1_idx` ON `proveedor_mantencion_base` (`id_proveedor` ASC);

CREATE INDEX `fk_proveedor_mantencion_base_mantencion_base1_idx` ON `proveedor_mantencion_base` (`id_mantencion_base` ASC);


-- -----------------------------------------------------
-- Table `consulta_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_proveedor` (
  `id_consulta_proveedor` INT NOT NULL AUTO_INCREMENT,
  `id_vehiculo` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_mantencion_base` BIGINT NOT NULL,
  `latitud` DOUBLE NULL,
  `longitud` DOUBLE NULL,
  PRIMARY KEY (`id_consulta_proveedor`, `id_vehiculo`, `id_usuario`),
  CONSTRAINT `fk_consulta_proveedor_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_proveedor_mantencion_base1`
    FOREIGN KEY (`id_mantencion_base`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_consulta_proveedor_vehiculo1_idx` ON `consulta_proveedor` (`id_vehiculo` ASC, `id_usuario` ASC);

CREATE INDEX `fk_consulta_proveedor_mantencion_base1_idx` ON `consulta_proveedor` (`id_mantencion_base` ASC);


-- -----------------------------------------------------
-- Table `respuesta_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `respuesta_proveedor` (
  `id_respuesta_proveedor` INT NOT NULL AUTO_INCREMENT,
  `id_vehiculo` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_proveedor` INT NOT NULL,
  `id_consulta_proveedor` INT NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_respuesta_proveedor`),
  CONSTRAINT `fk_respuesta_proveedor_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuesta_proveedor_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuesta_proveedor_consulta_proveedor1`
    FOREIGN KEY (`id_consulta_proveedor`)
    REFERENCES `consulta_proveedor` (`id_consulta_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_respuesta_proveedor_vehiculo1_idx` ON `respuesta_proveedor` (`id_vehiculo` ASC, `id_usuario` ASC);

CREATE INDEX `fk_respuesta_proveedor_proveedor1_idx` ON `respuesta_proveedor` (`id_proveedor` ASC);

CREATE INDEX `fk_respuesta_proveedor_consulta_proveedor1_idx` ON `respuesta_proveedor` (`id_consulta_proveedor` ASC);

