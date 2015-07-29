SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `car2` DEFAULT CHARACTER SET latin1 ;
USE `car2` ;

-- -----------------------------------------------------
-- Table `pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pais` ;

CREATE TABLE IF NOT EXISTS `pais` (
  `id_pais` BIGINT NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `id_region` BIGINT NOT NULL,
  `id_pais` BIGINT NOT NULL,
  `region` VARCHAR(64) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_region`),
  CONSTRAINT `fk_Region_Pais`
    FOREIGN KEY (`id_pais`)
    REFERENCES `pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_Region_Pais_idx` ON `region` (`id_pais` ASC);


-- -----------------------------------------------------
-- Table `comuna`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comuna` ;

CREATE TABLE IF NOT EXISTS `comuna` (
  `id_comuna` BIGINT NOT NULL,
  `id_region` BIGINT NOT NULL,
  `comuna` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comuna`),
  CONSTRAINT `fk_comuna_region1`
    FOREIGN KEY (`id_region`)
    REFERENCES `region` (`id_region`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_comuna_region1_idx` ON `comuna` (`id_region` ASC);


-- -----------------------------------------------------
-- Table `tipo_vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo_vehiculo` ;

CREATE TABLE IF NOT EXISTS `tipo_vehiculo` (
  `id_tipo_vehiculo` TINYINT NOT NULL,
  `descripcion` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tipo_vehiculo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `marca` ;

CREATE TABLE IF NOT EXISTS `marca` (
  `id_marca` SMALLINT NOT NULL,
  `id_tipo_vehiculo` TINYINT NOT NULL,
  `id_pais` BIGINT NOT NULL,
  `descripcion` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_marca`),
  CONSTRAINT `fk_marca_pais1`
    FOREIGN KEY (`id_pais`)
    REFERENCES `pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_marca_tipo_vehiculo1`
    FOREIGN KEY (`id_tipo_vehiculo`)
    REFERENCES `tipo_vehiculo` (`id_tipo_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_marca_pais1_idx` ON `marca` (`id_pais` ASC);

CREATE INDEX `fk_marca_tipo_vehiculo1_idx` ON `marca` (`id_tipo_vehiculo` ASC);


-- -----------------------------------------------------
-- Table `modelo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `modelo` ;

CREATE TABLE IF NOT EXISTS `modelo` (
  `id_modelo` BIGINT NOT NULL,
  `id_marca` SMALLINT NOT NULL,
  `descripcion` VARCHAR(64) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_modelo`),
  CONSTRAINT `fk_Modelo_Marca1`
    FOREIGN KEY (`id_marca`)
    REFERENCES `marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_Modelo_Marca1_idx` ON `modelo` (`id_marca` ASC);


-- -----------------------------------------------------
-- Table `red_social`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `red_social` ;

CREATE TABLE IF NOT EXISTS `red_social` (
  `id_red_social` BIGINT NOT NULL,
  `red_social` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_red_social`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usuario` ;

CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` BIGINT NOT NULL AUTO_INCREMENT,
  `id_comuna` BIGINT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NULL,
  `fecha_nacimiento` DATE NULL,
  `hombre` TINYINT(1) NULL,
  `telefono` VARCHAR(20) NULL,
  `fecha_vencimiento_licencia` DATE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_Usuario_Comuna1`
    FOREIGN KEY (`id_comuna`)
    REFERENCES `comuna` (`id_comuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_Usuario_Comuna1_idx` ON `usuario` (`id_comuna` ASC);


-- -----------------------------------------------------
-- Table `usuario_web`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usuario_web` ;

CREATE TABLE IF NOT EXISTS `usuario_web` (
  `id_usuario_web` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(16) NOT NULL,
  `contrasena` VARCHAR(32) NOT NULL,
  `nombre` VARCHAR(16) NOT NULL,
  `apellidos` VARCHAR(32) NOT NULL,
  `email` VARCHAR(32) NOT NULL,
  `activo` BIT(1) NOT NULL DEFAULT b'0',
  `borrado` BIT(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id_usuario_web`))
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = latin1;

CREATE UNIQUE INDEX `idx_usuario_web_nombre_usuario` USING BTREE ON `usuario_web` (`nombre_usuario` ASC);

CREATE UNIQUE INDEX `idx_usuario_web_email` USING BTREE ON `usuario_web` (`email` ASC);


-- -----------------------------------------------------
-- Table `combustible`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `combustible` ;

CREATE TABLE IF NOT EXISTS `combustible` (
  `id_combustible` TINYINT NOT NULL,
  `descripcion` VARCHAR(16) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_combustible`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tipo_transmision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo_transmision` ;

CREATE TABLE IF NOT EXISTS `tipo_transmision` (
  `id_tipo_transmision` TINYINT NOT NULL,
  `descripcion` VARCHAR(16) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tipo_transmision`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `traccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `traccion` ;

CREATE TABLE IF NOT EXISTS `traccion` (
  `id_traccion` TINYINT NOT NULL,
  `descripcion` VARCHAR(40) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_traccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehiculo` ;

CREATE TABLE IF NOT EXISTS `vehiculo` (
  `id_vehiculo` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_modelo` BIGINT NOT NULL,
  `id_tipo_transmision` TINYINT NOT NULL,
  `id_combustible` TINYINT NOT NULL,
  `id_traccion` TINYINT NOT NULL,
  `alias` VARCHAR(20) NOT NULL,
  `km_anuales` INT(11) NULL DEFAULT NULL,
  `fecha_ultimo_km` DATE NULL DEFAULT NULL,
  `km_calibrados` INT(11) NULL DEFAULT NULL,
  `fecha_ultima_calibracion` DATE NULL DEFAULT NULL,
  `patente` VARCHAR(10) NULL,
  `anio` INT NULL,
  `km` INT NULL,
  `aire_acondicionado` TINYINT(1) NULL,
  `alza_vidrios` TINYINT(1) NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_vehiculo`, `id_usuario`),
  CONSTRAINT `fk_vehiculo_combustible1`
    FOREIGN KEY (`id_combustible`)
    REFERENCES `combustible` (`id_combustible`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehiculo_Modelo1`
    FOREIGN KEY (`id_modelo`)
    REFERENCES `modelo` (`id_modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehiculo_tipo_transmision1`
    FOREIGN KEY (`id_tipo_transmision`)
    REFERENCES `tipo_transmision` (`id_tipo_transmision`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehiculo_traccion1`
    FOREIGN KEY (`id_traccion`)
    REFERENCES `traccion` (`id_traccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehiculo_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Vehiculo_Usuario1_idx` ON `vehiculo` (`id_usuario` ASC);

CREATE INDEX `fk_Vehiculo_Modelo1_idx` ON `vehiculo` (`id_modelo` ASC);

CREATE INDEX `fk_vehiculo_tipo_transmision_idx` ON `vehiculo` (`id_tipo_transmision` ASC);

CREATE INDEX `fk_vehiculo_combustible_idx` ON `vehiculo` (`id_combustible` ASC);

CREATE INDEX `fk_vehiculo_traccion_idx` ON `vehiculo` (`id_traccion` ASC);


-- -----------------------------------------------------
-- Table `autenticacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autenticacion` ;

CREATE TABLE IF NOT EXISTS `autenticacion` (
  `id_autenticacion` BIGINT NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT NOT NULL,
  `id_red_social` BIGINT NOT NULL,
  `token` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_autenticacion`),
  CONSTRAINT `fk_autenticacion_red_social1`
    FOREIGN KEY (`id_red_social`)
    REFERENCES `red_social` (`id_red_social`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_Autenticacion_Usuario1_idx` ON `autenticacion` (`id_usuario` ASC);

CREATE INDEX `fk_autenticacion_red_social1_idx` ON `autenticacion` (`id_red_social` ASC);


-- -----------------------------------------------------
-- Table `mantencion_base`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mantencion_base` ;

CREATE TABLE IF NOT EXISTS `mantencion_base` (
  `id_mantencion_base` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `traccion` VARCHAR(3) NOT NULL,
  `combustible` VARCHAR(16) NOT NULL,
  `accion` VARCHAR(64) NULL COMMENT 'Detalla el trabajo a realizar. Es un listado de las tareas a realizar.',
  `beneficios` TEXT NULL COMMENT 'Contiene la descripciÃ³n de los beneficios de esta mantenciÃ³n.',
  `descripcion_item` TEXT NULL COMMENT 'Describe en quÃ© consiste la mantenciÃ³n y cuÃ¡les son los trabajos asociados.',
  `url` VARCHAR(256) NULL COMMENT 'Contiene la URL a un sitio en el que se encuentra mayor detalle de esta mantenciÃ³n.',
  `depende_km` TINYINT(1) NULL COMMENT 'Indica si esta mantenciÃ³n depende de los Km recorridos o bien del tiempo.',
  `km_entre_mantenciones` INT NULL COMMENT 'Indica la periocidad en Km entre las cuales debe volverse a realizarse esta mantenciÃ³n',
  `meses_entre_mantenciones` INT NULL COMMENT 'Indica los dÃ­as entre los cuales debe realizarse esta mantenciÃ³n',
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_mantencion_base`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mantencion_pospuesta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mantencion_pospuesta` ;

CREATE TABLE IF NOT EXISTS `mantencion_pospuesta` (
  `id_mantencion_pospuesta` INT(11) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `id_mantencion_base` BIGINT(20) NOT NULL,
  `km` INT(11) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
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
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_mantencion_pospuesta_mantencion_base1_idx` ON `mantencion_pospuesta` (`id_mantencion_base` ASC);

CREATE INDEX `fk_mantencion_pospuesta_vehiculo1_idx` ON `mantencion_pospuesta` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `mantencion_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mantencion_usuario` ;

CREATE TABLE IF NOT EXISTS `mantencion_usuario` (
  `id_mantencion_usuario` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `descripcion` VARCHAR(1024) NULL,
  `beneficios` TEXT NULL,
  `url` VARCHAR(256) NULL,
  `depende_km` TINYINT(1) NULL,
  `km_entre_mantenciones` INT NULL,
  `meses_entre_mantenciones` INT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_mantencion_usuario`, `id_usuario`),
  CONSTRAINT `fk_mantencion_usuario_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_mantencion_usuario_usuario1_idx` ON `mantencion_usuario` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `mantencion_usuario_hecha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mantencion_usuario_hecha` ;

CREATE TABLE IF NOT EXISTS `mantencion_usuario_hecha` (
  `id_mantencion_usuario_hecha` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `id_mantencion_usuario` BIGINT NOT NULL,
  `km` INT NULL,
  `fecha` DATE NULL,
  `costo` INT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_mantencion_usuario_hecha`, `id_usuario`),
  CONSTRAINT `fk_mantencion_usuario_hecha_mantencion_usuario1`
    FOREIGN KEY (`id_mantencion_usuario` , `id_usuario`)
    REFERENCES `mantencion_usuario` (`id_mantencion_usuario` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mantencion_usuario_hecha_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_mantencion_usuario_hecha_mantencion_usuario1_idx` ON `mantencion_usuario_hecha` (`id_mantencion_usuario` ASC, `id_usuario` ASC);

CREATE INDEX `fk_mantencion_usuario_hecha_vehiculo1_idx` ON `mantencion_usuario_hecha` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `parametro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parametro` ;

CREATE TABLE IF NOT EXISTS `parametro` (
  `id_parametro` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `llave` VARCHAR(64) NOT NULL,
  `valor` TEXT NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_parametro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE UNIQUE INDEX `index2` USING BTREE ON `parametro` (`llave` ASC);


-- -----------------------------------------------------
-- Table `recordatorio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recordatorio` ;

CREATE TABLE IF NOT EXISTS `recordatorio` (
  `id_recordatorio` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `recordar_fecha` TINYINT(1) NULL,
  `recordar_km` TINYINT(1) NULL,
  `fecha` DATE NULL,
  `km` INT NULL,
  `titulo` VARCHAR(30) NULL,
  `descripcion` TEXT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_recordatorio`, `id_usuario`),
  CONSTRAINT `fk_recordatorio_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_recordatorio_vehiculo1_idx` ON `recordatorio` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `log` ;

CREATE TABLE IF NOT EXISTS `log` (
  `id_log` BIGINT NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `latitud` DOUBLE NOT NULL,
  `longitud` DOUBLE NOT NULL,
  `data` TEXT NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_usuario`, `id_log`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_log_usuario1_idx` ON `log` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `reparacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reparacion` ;

CREATE TABLE IF NOT EXISTS `reparacion` (
  `id_reparacion` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `titulo` VARCHAR(30) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `costo` INT NULL,
  `fecha` DATE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_reparacion`, `id_usuario`),
  CONSTRAINT `fk_reparacion_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_reparacion_vehiculo1_idx` ON `reparacion` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `carga_combustible`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `carga_combustible` ;

CREATE TABLE IF NOT EXISTS `carga_combustible` (
  `id_carga_combustible` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `km` INT NULL,
  `litros` INT NULL,
  `fecha` DATE NULL,
  `estanque_lleno` TINYINT(1) NULL,
  `costo` INT NULL,
  `latitud` DOUBLE NULL,
  `longitud` DOUBLE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_carga_combustible`, `id_usuario`),
  CONSTRAINT `fk_rendimiento_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_rendimiento_vehiculo1_idx` ON `carga_combustible` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `info_sincro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `info_sincro` ;

CREATE TABLE IF NOT EXISTS `info_sincro` (
  `id_info_sincro` INT NOT NULL AUTO_INCREMENT,
  `usuario_id_usuario` BIGINT NOT NULL,
  `sentido` TINYINT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id_info_sincro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_info_sincro_usuario1_idx` ON `info_sincro` (`usuario_id_usuario` ASC);


-- -----------------------------------------------------
-- Table `mantencion_base_hecha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mantencion_base_hecha` ;

CREATE TABLE IF NOT EXISTS `mantencion_base_hecha` (
  `id_mantencion_base_hecha` INT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `id_mantencion_base` BIGINT NOT NULL,
  `km` INT NULL,
  `fecha` DATE NULL,
  `costo` INT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_mantencion_base_hecha`, `id_usuario`),
  CONSTRAINT `fk_mantencion_base_hecha_mantencion_base1`
    FOREIGN KEY (`id_mantencion_base`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mantencion_base_hecha_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_mantencion_base_hecha_mantencion_base1_idx` ON `mantencion_base_hecha` (`id_mantencion_base` ASC);

CREATE INDEX `fk_mantencion_base_hecha_vehiculo1_idx` ON `mantencion_base_hecha` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `cambio_revision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cambio_revision` ;

CREATE TABLE IF NOT EXISTS `cambio_revision` (
  `id_cambio_revision` INT NOT NULL AUTO_INCREMENT,
  `id_cambio` BIGINT NULL,
  `id_revision` BIGINT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cambio_revision`),
  CONSTRAINT `fk_cambio_revision_mantencion_base1`
    FOREIGN KEY (`id_cambio`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cambio_revision_mantencion_base2`
    FOREIGN KEY (`id_revision`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_cambio_revision_mantencion_base1_idx` ON `cambio_revision` (`id_cambio` ASC);

CREATE INDEX `fk_cambio_revision_mantencion_base2_idx` ON `cambio_revision` (`id_revision` ASC);


-- -----------------------------------------------------
-- Table `alerta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alerta` ;

CREATE TABLE IF NOT EXISTS `alerta` (
  `id_alerta` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `id_mantencion_base` BIGINT NOT NULL,
  `km` INT NULL,
  `fecha` DATE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_alerta`),
  CONSTRAINT `fk_mantencion_base_hecha_mantencion_base10`
    FOREIGN KEY (`id_mantencion_base`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mantencion_base_hecha_vehiculo10`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_alerta_mantencion_base_idx` ON `alerta` (`id_mantencion_base` ASC);

CREATE INDEX `fk_alerta_vehiculo_idx` ON `alerta` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `cia_seguros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cia_seguros` ;

CREATE TABLE IF NOT EXISTS `cia_seguros` (
  `id_cia_seguros` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(256) NOT NULL,
  `datos_anexos` TEXT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cia_seguros`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tipo_seguro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo_seguro` ;

CREATE TABLE IF NOT EXISTS `tipo_seguro` (
  `id_tipo_seguro` INT NOT NULL,
  `descripcion` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id_tipo_seguro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `seguro_vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seguro_vehiculo` ;

CREATE TABLE IF NOT EXISTS `seguro_vehiculo` (
  `id_seguro_vehiculo` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_cia_seguros` INT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `id_tipo_seguro` INT(11) NOT NULL,
  `poliza` TEXT NULL,
  `observaciones` TEXT NULL,
  `fecha_vencimiento` DATE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_seguro_vehiculo`, `id_usuario`),
  CONSTRAINT `fk_seguro_vehiculo_cia_seguros1`
    FOREIGN KEY (`id_cia_seguros`)
    REFERENCES `cia_seguros` (`id_cia_seguros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seguro_vehiculo_tipo_seguro1`
    FOREIGN KEY (`id_tipo_seguro`)
    REFERENCES `tipo_seguro` (`id_tipo_seguro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seguro_vehiculo_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_seguro_vehiculo_cia_seguros1_idx` ON `seguro_vehiculo` (`id_cia_seguros` ASC);

CREATE INDEX `fk_seguro_vehiculo_vehiculo1_idx` ON `seguro_vehiculo` (`id_vehiculo` ASC, `id_usuario` ASC);

CREATE INDEX `fk_seguro_vehiculo_tipo_seguro1_idx` ON `seguro_vehiculo` (`id_tipo_seguro` ASC);


-- -----------------------------------------------------
-- Table `proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proveedor` ;

CREATE TABLE IF NOT EXISTS `proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
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
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `proveedor_mantencion_base`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proveedor_mantencion_base` ;

CREATE TABLE IF NOT EXISTS `proveedor_mantencion_base` (
  `id_proveedor_mantencion_base` INT NOT NULL AUTO_INCREMENT,
  `id_proveedor` INT NOT NULL,
  `id_mantencion_base` BIGINT NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
DROP TABLE IF EXISTS `consulta_proveedor` ;

CREATE TABLE IF NOT EXISTS `consulta_proveedor` (
  `id_consulta_proveedor` INT NOT NULL AUTO_INCREMENT,
  `id_vehiculo` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_mantencion_base` BIGINT NOT NULL,
  `latitud` DOUBLE NULL,
  `longitud` DOUBLE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_consulta_proveedor`),
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
DROP TABLE IF EXISTS `respuesta_proveedor` ;

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


-- -----------------------------------------------------
-- Table `campania`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campania` ;

CREATE TABLE IF NOT EXISTS `campania` (
  `id_campania` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(64) NOT NULL,
  `activa` TINYINT(1) NOT NULL DEFAULT '0',
  `condicion` TEXT NULL,
  `detalle` TEXT NOT NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `periodicidad` SMALLINT NULL,
  `numero_impresiones` SMALLINT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_campania`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campania_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campania_usuario` ;

CREATE TABLE IF NOT EXISTS `campania_usuario` (
  `id_campania_usuario` BIGINT NOT NULL AUTO_INCREMENT,
  `id_campania` INT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_campania_usuario`),
  CONSTRAINT `fk_campania_usuario_campania1`
    FOREIGN KEY (`id_campania`)
    REFERENCES `campania` (`id_campania`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campania_usuario_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_campania_usuario_campania1_idx` ON `campania_usuario` (`id_campania` ASC);

CREATE INDEX `fk_campania_usuario_usuario1_idx` ON `campania_usuario` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `usuario_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usuario_info` ;

CREATE TABLE IF NOT EXISTS `usuario_info` (
  `id_usuario_info` BIGINT NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT NOT NULL,
  `latitud` DOUBLE NULL,
  `longitud` DOUBLE NULL,
  `house_number` VARCHAR(16) NULL,
  `road` VARCHAR(256) NULL,
  `neighbourhood` VARCHAR(256) NULL,
  `suburb` VARCHAR(256) NULL,
  `city` VARCHAR(256) NULL,
  `county` VARCHAR(256) NULL,
  `state` VARCHAR(256) NULL,
  `country` VARCHAR(256) NULL,
  `country_code` VARCHAR(8) NULL,
  `android` VARCHAR(16) NULL,
  `app_version` VARCHAR(16) NULL,
  PRIMARY KEY (`id_usuario_info`),
  CONSTRAINT `fk_usuario_posicion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_usuario_posicion_usuario1_idx` ON `usuario_info` (`id_usuario` ASC);

USE `car2` ;

-- -----------------------------------------------------
-- View `vw_campania_usuario`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vw_campania_usuario` ;
DROP TABLE IF EXISTS `vw_campania_usuario`;
USE `car2`;
CREATE  OR REPLACE VIEW `vw_campania_usuario` AS
    SELECT 
        cu.id_campania_usuario AS id,
        cu.id_usuario AS id_usuario,
        c.fecha_inicio AS fecha_inicio,
        c.fecha_fin AS fecha_fin,
        c.periodicidad AS periodicidad,
        c.numero_impresiones AS numero_impresiones,
        c.detalle AS detalle,
        cu.fecha_modificacion AS fecha_modificacion
    FROM
        campania c
            JOIN
        campania_usuario cu ON cu.id_campania = c.id_campania;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `red_social`
-- -----------------------------------------------------
START TRANSACTION;
USE `car2`;
INSERT INTO `red_social` (`id_red_social`, `red_social`, `fecha_modificacion`) VALUES (1, 'facebook', '2014-01-01 12:00:00');
INSERT INTO `red_social` (`id_red_social`, `red_social`, `fecha_modificacion`) VALUES (0, 'default', '2015-03-01 12:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `combustible`
-- -----------------------------------------------------
START TRANSACTION;
USE `car2`;
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (1, 'GASOLINA', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (2, 'DIESEL', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (3, 'GAS GLP', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (4, 'GAS GNC', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (5, 'ELECTRICO', '2014-01-01 12:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tipo_transmision`
-- -----------------------------------------------------
START TRANSACTION;
USE `car2`;
INSERT INTO `tipo_transmision` (`id_tipo_transmision`, `descripcion`, `fecha_modificacion`) VALUES (1, 'MANUAL', '2014-01-01 12:00:00');
INSERT INTO `tipo_transmision` (`id_tipo_transmision`, `descripcion`, `fecha_modificacion`) VALUES (2, 'AUTOMATICA', '2014-01-01 12:00:00');
INSERT INTO `tipo_transmision` (`id_tipo_transmision`, `descripcion`, `fecha_modificacion`) VALUES (3, 'SEMI AUTOMATICA', '2014-01-01 12:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `traccion`
-- -----------------------------------------------------
START TRANSACTION;
USE `car2`;
INSERT INTO `traccion` (`id_traccion`, `descripcion`, `fecha_modificacion`) VALUES (1, 'DOBLE TRACCION PERMAMENTE (AWD)', '2014-01-01 12:00:00');
INSERT INTO `traccion` (`id_traccion`, `descripcion`, `fecha_modificacion`) VALUES (2, 'TRACCION DELANTERA', '2014-01-01 12:00:00');
INSERT INTO `traccion` (`id_traccion`, `descripcion`, `fecha_modificacion`) VALUES (3, 'DOBLE TRACCION NO PERMAMENTE (4WD)', '2014-01-01 12:00:00');
INSERT INTO `traccion` (`id_traccion`, `descripcion`, `fecha_modificacion`) VALUES (4, 'TRACCION TRASERA', '2014-01-01 12:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tipo_seguro`
-- -----------------------------------------------------
START TRANSACTION;
USE `car2`;
INSERT INTO `tipo_seguro` (`id_tipo_seguro`, `descripcion`) VALUES (1, 'SOAP');
INSERT INTO `tipo_seguro` (`id_tipo_seguro`, `descripcion`) VALUES (2, 'GENERAL');

COMMIT;

