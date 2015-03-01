-- -----------------------------------------------------
-- Table `perfil_uso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfil_uso` (
  `id_perfil_uso` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `km_anuales` INT NOT NULL,
  `es_perfil_medio` TINYINT(1) NOT NULL,
  `nombre` TEXT NOT NULL,
  `descripcion` TEXT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_perfil_uso`, `id_usuario`),
  CONSTRAINT `fk_perfil_uso_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_perfil_uso_usuario1_idx` ON `perfil_uso` (`id_usuario` ASC);

ALTER TABLE `car`.`vehiculo` 
ADD COLUMN `id_perfil_uso` BIGINT(20) NULL AFTER `id_traccion`,
ADD COLUMN `fecha_ultimo_km` DATE NULL AFTER `borrado`,
ADD COLUMN `km_calibrados` INT(11) NULL AFTER `fecha_ultimo_km`,
ADD COLUMN `fecha_ultima_calibracion` DATE NULL AFTER `km_calibrados`,
ADD INDEX `fk_vehiculo_perfil_uso1_idx` (`id_usuario` ASC, `id_perfil_uso` ASC);
ALTER TABLE `car`.`vehiculo` 
ADD CONSTRAINT `fk_vehiculo_perfil_uso1`
  FOREIGN KEY (`id_usuario` , `id_perfil_uso`)
  REFERENCES `car`.`perfil_uso` (`id_usuario` , `id_perfil_uso`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
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

-- se elimina columna 'id_usuario' de 'perfil_uso'

ALTER TABLE `car`.`perfil_uso` 
DROP FOREIGN KEY `fk_perfil_uso_usuario1`;

ALTER TABLE `car`.`vehiculo` 
DROP FOREIGN KEY `fk_vehiculo_perfil_uso1`;

ALTER TABLE `car`.`perfil_uso` 
DROP COLUMN `id_usuario`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id_perfil_uso`),
DROP INDEX `fk_perfil_uso_usuario1_idx` ;

ALTER TABLE `car`.`vehiculo` 
ADD INDEX `fk_vehiculo_perfil_uso1_idx1` (`id_perfil_uso` ASC);
ALTER TABLE `car`.`vehiculo` 
ADD CONSTRAINT `fk_vehiculo_perfil_uso1`
  FOREIGN KEY (`id_perfil_uso`)
  REFERENCES `car`.`perfil_uso` (`id_perfil_uso`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

INSERT INTO `perfil_uso` (`id_perfil_uso`, `km_anuales`, `es_perfil_medio`, `nombre`, `descripcion`, `fecha_modificacion`, `borrado`) VALUES (1, 12000, 0, 'Lo uso sólo los fines de semana', '12.000 mil Km anuales', '2015-03-01 00:00:00', 0);
INSERT INTO `perfil_uso` (`id_perfil_uso`, `km_anuales`, `es_perfil_medio`, `nombre`, `descripcion`, `fecha_modificacion`, `borrado`) VALUES (2, 20000, 1, 'Voy al trabajo en auto', '20.000 mil Km anuales', '2015-03-01 00:00:00', 0);
INSERT INTO `perfil_uso` (`id_perfil_uso`, `km_anuales`, `es_perfil_medio`, `nombre`, `descripcion`, `fecha_modificacion`, `borrado`) VALUES (3, 30000, 0, 'Hago viajes largos', '30.000 mil Km anuales', '2015-03-01 00:00:00', 0);
INSERT INTO `perfil_uso` (`id_perfil_uso`, `km_anuales`, `es_perfil_medio`, `nombre`, `descripcion`, `fecha_modificacion`, `borrado`) VALUES (4, 60000, 0, 'Trabajo con el auto', '60.000 mil Km anuales', '2015-03-01 00:00:00', 0);
