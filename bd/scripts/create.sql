SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `mantencion_base`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mantencion_base` ;

CREATE TABLE IF NOT EXISTS `mantencion_base` (
  `id_mantencion_base` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `traccion` VARCHAR(3) NOT NULL,
  `combustible` VARCHAR(16) NOT NULL,
  `accion` VARCHAR(64) NULL DEFAULT NULL COMMENT 'Detalla el trabajo a realizar. Es un listado de las tareas a realizar.',
  `beneficios` TEXT NULL DEFAULT NULL COMMENT 'Contiene la descripciÃƒÂ³n de los beneficios de esta mantenciÃƒÂ³n.',
  `descripcion_item` TEXT NULL DEFAULT NULL COMMENT 'Describe en quÃƒÂ© consiste la mantenciÃƒÂ³n y cuÃƒÂ¡les son los trabajos asociados.',
  `url` VARCHAR(256) NULL DEFAULT NULL COMMENT 'Contiene la URL a un sitio en el que se encuentra mayor detalle de esta mantenciÃƒÂ³n.',
  `depende_km` TINYINT(1) NULL DEFAULT NULL COMMENT 'Indica si esta mantenciÃƒÂ³n depende de los Km recorridos o bien del tiempo.',
  `km_entre_mantenciones` INT(11) NULL DEFAULT NULL COMMENT 'Indica la periocidad en Km entre las cuales debe volverse a realizarse esta mantenciÃƒÂ³n',
  `meses_entre_mantenciones` INT(11) NULL DEFAULT NULL COMMENT 'Indica los dÃƒÂ­as entre los cuales debe realizarse esta mantenciÃƒÂ³n',
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_mantencion_base`))
ENGINE = InnoDB
AUTO_INCREMENT = 120
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `combustible`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `combustible` ;

CREATE TABLE IF NOT EXISTS `combustible` (
  `id_combustible` TINYINT(4) NOT NULL,
  `descripcion` VARCHAR(16) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_combustible`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pais` ;

CREATE TABLE IF NOT EXISTS `pais` (
  `id_pais` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `pais` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tipo_vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo_vehiculo` ;

CREATE TABLE IF NOT EXISTS `tipo_vehiculo` (
  `id_tipo_vehiculo` TINYINT(4) NOT NULL,
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
  `id_marca` SMALLINT(6) NOT NULL,
  `id_tipo_vehiculo` TINYINT(4) NOT NULL,
  `id_pais` BIGINT(20) NOT NULL,
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
  `id_modelo` BIGINT(20) NOT NULL,
  `id_marca` SMALLINT(6) NOT NULL,
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
-- Table `tipo_transmision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo_transmision` ;

CREATE TABLE IF NOT EXISTS `tipo_transmision` (
  `id_tipo_transmision` TINYINT(4) NOT NULL,
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
  `id_traccion` TINYINT(4) NOT NULL,
  `descripcion` VARCHAR(40) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_traccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `id_region` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_pais` BIGINT(20) NOT NULL,
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
  `id_comuna` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_region` BIGINT(20) NOT NULL,
  `comuna` VARCHAR(128) NOT NULL,
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
-- Table `usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usuario` ;

CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_comuna` BIGINT(20) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `correo` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `hombre` TINYINT(1) NULL DEFAULT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `fecha_vencimiento_licencia` DATE NULL DEFAULT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_Usuario_Comuna1`
    FOREIGN KEY (`id_comuna`)
    REFERENCES `comuna` (`id_comuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_Usuario_Comuna1_idx` ON `usuario` (`id_comuna` ASC);


-- -----------------------------------------------------
-- Table `vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vehiculo` ;

CREATE TABLE IF NOT EXISTS `vehiculo` (
  `id_vehiculo` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_modelo` BIGINT(20) NOT NULL,
  `id_tipo_transmision` TINYINT(4) NOT NULL,
  `id_combustible` TINYINT(4) NOT NULL,
  `id_traccion` TINYINT(4) NOT NULL,
  `alias` VARCHAR(20) NOT NULL,
  `km_anuales` INT(11) NULL DEFAULT NULL,
  `fecha_ultimo_km` DATE NULL DEFAULT NULL,
  `km_calibrados` INT(11) NULL DEFAULT NULL,
  `fecha_ultima_calibracion` DATE NULL DEFAULT NULL,
  `patente` VARCHAR(10) NULL DEFAULT NULL,
  `anio` INT(11) NULL DEFAULT NULL,
  `km` INT(11) NULL DEFAULT NULL,
  `aire_acondicionado` TINYINT(1) NULL DEFAULT NULL,
  `alza_vidrios` TINYINT(1) NULL DEFAULT NULL,
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
-- Table `alerta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alerta` ;

CREATE TABLE IF NOT EXISTS `alerta` (
  `id_alerta` INT(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `id_mantencion_base` BIGINT(20) NOT NULL,
  `km` INT(11) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
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
-- Table `red_social`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `red_social` ;

CREATE TABLE IF NOT EXISTS `red_social` (
  `id_red_social` BIGINT(20) NOT NULL,
  `red_social` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_red_social`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `autenticacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autenticacion` ;

CREATE TABLE IF NOT EXISTS `autenticacion` (
  `id_autenticacion` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_red_social` BIGINT(20) NOT NULL,
  `token` VARCHAR(45) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_autenticacion`),
  CONSTRAINT `fk_autenticacion_red_social1`
    FOREIGN KEY (`id_red_social`)
    REFERENCES `red_social` (`id_red_social`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autenticacion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_Autenticacion_Usuario1_idx` ON `autenticacion` (`id_usuario` ASC);

CREATE INDEX `fk_autenticacion_red_social1_idx` ON `autenticacion` (`id_red_social` ASC);


-- -----------------------------------------------------
-- Table `cambio_revision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cambio_revision` ;

CREATE TABLE IF NOT EXISTS `cambio_revision` (
  `id_cambio_revision` INT(11) NOT NULL AUTO_INCREMENT,
  `id_cambio` BIGINT(20) NULL DEFAULT NULL,
  `id_revision` BIGINT(20) NULL DEFAULT NULL,
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
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_cambio_revision_mantencion_base1_idx` ON `cambio_revision` (`id_cambio` ASC);

CREATE INDEX `fk_cambio_revision_mantencion_base2_idx` ON `cambio_revision` (`id_revision` ASC);


-- -----------------------------------------------------
-- Table `campania`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campania` ;

CREATE TABLE IF NOT EXISTS `campania` (
  `id_campania` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(64) NOT NULL,
  `activa` TINYINT(1) NOT NULL DEFAULT '0',
  `condicion` TEXT NULL DEFAULT NULL,
  `detalle` TEXT NOT NULL,
  `fecha_inicio` DATE NULL DEFAULT NULL,
  `fecha_fin` DATE NULL DEFAULT NULL,
  `periodicidad` SMALLINT(6) NULL DEFAULT NULL,
  `numero_impresiones` SMALLINT(6) NULL DEFAULT NULL,
  `manual` BIT(1) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_campania`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campania_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campania_usuario` ;

CREATE TABLE IF NOT EXISTS `campania_usuario` (
  `id_campania_usuario` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_campania` INT(11) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `fecha_sincro` DATETIME NULL,
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
-- Table `carga_combustible`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `carga_combustible` ;

CREATE TABLE IF NOT EXISTS `carga_combustible` (
  `id_carga_combustible` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `km` INT(11) NULL DEFAULT NULL,
  `litros` INT(11) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `estanque_lleno` TINYINT(1) NULL DEFAULT NULL,
  `costo` INT(11) NULL DEFAULT NULL,
  `latitud` DOUBLE NULL DEFAULT NULL,
  `longitud` DOUBLE NULL DEFAULT NULL,
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
-- Table `cia_seguros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cia_seguros` ;

CREATE TABLE IF NOT EXISTS `cia_seguros` (
  `id_cia_seguros` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(256) NOT NULL,
  `datos_anexos` TEXT NULL DEFAULT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cia_seguros`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `consulta_proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `consulta_proveedor` ;

CREATE TABLE IF NOT EXISTS `consulta_proveedor` (
  `id_consulta_proveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_mantencion_base` BIGINT(20) NOT NULL,
  `latitud` DOUBLE NULL DEFAULT NULL,
  `longitud` DOUBLE NULL DEFAULT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_consulta_proveedor`),
  CONSTRAINT `fk_consulta_proveedor_mantencion_base1`
    FOREIGN KEY (`id_mantencion_base`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_proveedor_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_consulta_proveedor_vehiculo1_idx` ON `consulta_proveedor` (`id_vehiculo` ASC, `id_usuario` ASC);

CREATE INDEX `fk_consulta_proveedor_mantencion_base1_idx` ON `consulta_proveedor` (`id_mantencion_base` ASC);


-- -----------------------------------------------------
-- Table `info_sincro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `info_sincro` ;

CREATE TABLE IF NOT EXISTS `info_sincro` (
  `id_info_sincro` INT(11) NOT NULL AUTO_INCREMENT,
  `usuario_id_usuario` BIGINT(20) NOT NULL,
  `sentido` TINYINT(4) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id_info_sincro`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_info_sincro_usuario1_idx` ON `info_sincro` (`usuario_id_usuario` ASC);


-- -----------------------------------------------------
-- Table `log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `log` ;

CREATE TABLE IF NOT EXISTS `log` (
  `id_log` BIGINT(20) NOT NULL,
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
-- Table `mantencion_base_hecha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mantencion_base_hecha` ;

CREATE TABLE IF NOT EXISTS `mantencion_base_hecha` (
  `id_mantencion_base_hecha` INT(11) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `id_mantencion_base` BIGINT(20) NOT NULL,
  `km` INT(11) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `costo` INT(11) NULL DEFAULT NULL,
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
  `id_mantencion_usuario` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `nombre` VARCHAR(30) NULL DEFAULT NULL,
  `descripcion` VARCHAR(1024) NULL DEFAULT NULL,
  `beneficios` TEXT NULL DEFAULT NULL,
  `url` VARCHAR(256) NULL DEFAULT NULL,
  `depende_km` TINYINT(1) NULL DEFAULT NULL,
  `km_entre_mantenciones` INT(11) NULL DEFAULT NULL,
  `meses_entre_mantenciones` INT(11) NULL DEFAULT NULL,
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
  `id_mantencion_usuario_hecha` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `id_mantencion_usuario` BIGINT(20) NOT NULL,
  `km` INT(11) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `costo` INT(11) NULL DEFAULT NULL,
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
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;

CREATE UNIQUE INDEX `index2` USING BTREE ON `parametro` (`llave` ASC);


-- -----------------------------------------------------
-- Table `proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proveedor` ;

CREATE TABLE IF NOT EXISTS `proveedor` (
  `id_proveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(256) NULL DEFAULT NULL,
  `direccion` VARCHAR(512) NULL DEFAULT NULL,
  `correo` VARCHAR(128) NULL DEFAULT NULL,
  `telefono` VARCHAR(128) NULL DEFAULT NULL,
  `latitud` DOUBLE NULL DEFAULT NULL,
  `longitud` DOUBLE NULL DEFAULT NULL,
  `existen_valores` TINYINT(1) NULL DEFAULT NULL,
  `valor_minimo` FLOAT NULL DEFAULT NULL,
  `valor_maximo` FLOAT NULL DEFAULT NULL,
  `detalle_html` TEXT NULL DEFAULT NULL,
  `calificacion` TINYINT(4) NULL DEFAULT NULL,
  `url` VARCHAR(256) NULL DEFAULT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `proveedor_mantencion_base`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proveedor_mantencion_base` ;

CREATE TABLE IF NOT EXISTS `proveedor_mantencion_base` (
  `id_proveedor_mantencion_base` INT(11) NOT NULL AUTO_INCREMENT,
  `id_proveedor` INT(11) NOT NULL,
  `id_mantencion_base` BIGINT(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_proveedor_mantencion_base`),
  CONSTRAINT `fk_proveedor_mantencion_base_mantencion_base1`
    FOREIGN KEY (`id_mantencion_base`)
    REFERENCES `mantencion_base` (`id_mantencion_base`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_mantencion_base_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21499
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_proveedor_mantencion_base_proveedor1_idx` ON `proveedor_mantencion_base` (`id_proveedor` ASC);

CREATE INDEX `fk_proveedor_mantencion_base_mantencion_base1_idx` ON `proveedor_mantencion_base` (`id_mantencion_base` ASC);


-- -----------------------------------------------------
-- Table `recordatorio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recordatorio` ;

CREATE TABLE IF NOT EXISTS `recordatorio` (
  `id_recordatorio` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `recordar_fecha` TINYINT(1) NULL DEFAULT NULL,
  `recordar_km` TINYINT(1) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `km` INT(11) NULL DEFAULT NULL,
  `titulo` VARCHAR(30) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
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
-- Table `reparacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reparacion` ;

CREATE TABLE IF NOT EXISTS `reparacion` (
  `id_reparacion` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `titulo` VARCHAR(30) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `costo` INT(11) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
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
-- Table `respuesta_proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `respuesta_proveedor` ;

CREATE TABLE IF NOT EXISTS `respuesta_proveedor` (
  `id_respuesta_proveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_proveedor` INT(11) NOT NULL,
  `id_consulta_proveedor` INT(11) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_respuesta_proveedor`),
  CONSTRAINT `fk_respuesta_proveedor_consulta_proveedor1`
    FOREIGN KEY (`id_consulta_proveedor`)
    REFERENCES `consulta_proveedor` (`id_consulta_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuesta_proveedor_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuesta_proveedor_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_respuesta_proveedor_vehiculo1_idx` ON `respuesta_proveedor` (`id_vehiculo` ASC, `id_usuario` ASC);

CREATE INDEX `fk_respuesta_proveedor_proveedor1_idx` ON `respuesta_proveedor` (`id_proveedor` ASC);

CREATE INDEX `fk_respuesta_proveedor_consulta_proveedor1_idx` ON `respuesta_proveedor` (`id_consulta_proveedor` ASC);


-- -----------------------------------------------------
-- Table `tipo_seguro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo_seguro` ;

CREATE TABLE IF NOT EXISTS `tipo_seguro` (
  `id_tipo_seguro` INT(11) NOT NULL,
  `descripcion` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id_tipo_seguro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `seguro_vehiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seguro_vehiculo` ;

CREATE TABLE IF NOT EXISTS `seguro_vehiculo` (
  `id_seguro_vehiculo` BIGINT(20) NOT NULL,
  `id_usuario` BIGINT(20) NOT NULL,
  `id_cia_seguros` INT(11) NOT NULL,
  `id_vehiculo` BIGINT(20) NOT NULL,
  `id_tipo_seguro` INT(11) NOT NULL,
  `poliza` TEXT NULL DEFAULT NULL,
  `observaciones` TEXT NULL DEFAULT NULL,
  `fecha_vencimiento` DATE NULL DEFAULT NULL,
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
-- Table `usuario_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usuario_info` ;

CREATE TABLE IF NOT EXISTS `usuario_info` (
  `id_usuario_info` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT(20) NOT NULL,
  `latitud` DOUBLE NULL DEFAULT NULL,
  `longitud` DOUBLE NULL DEFAULT NULL,
  `house_number` VARCHAR(16) NULL DEFAULT NULL,
  `road` VARCHAR(256) NULL DEFAULT NULL,
  `neighbourhood` VARCHAR(256) NULL DEFAULT NULL,
  `suburb` VARCHAR(256) NULL DEFAULT NULL,
  `city` VARCHAR(256) NULL DEFAULT NULL,
  `county` VARCHAR(256) NULL DEFAULT NULL,
  `state` VARCHAR(256) NULL DEFAULT NULL,
  `country` VARCHAR(256) NULL DEFAULT NULL,
  `country_code` VARCHAR(8) NULL DEFAULT NULL,
  `android` VARCHAR(16) NULL DEFAULT NULL,
  `app_version` VARCHAR(16) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario_info`),
  CONSTRAINT `fk_usuario_posicion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 617
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;

CREATE INDEX `fk_usuario_posicion_usuario1_idx` ON `usuario_info` (`id_usuario` ASC);


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
-- Table `usuario_creacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usuario_creacion` ;

CREATE TABLE IF NOT EXISTS `usuario_creacion` (
  `id_usuario_creacion` BIGINT NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT(20) NOT NULL,
  `fecha_creacion` DATETIME NULL,
  PRIMARY KEY (`id_usuario_creacion`),
  CONSTRAINT `fk_usuario_creacion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_usuario_creacion_usuario1_idx` ON `usuario_creacion` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `provincia` ;

CREATE TABLE IF NOT EXISTS `provincia` (
  `id_provincia` BIGINT NOT NULL AUTO_INCREMENT,
  `provincia` VARCHAR(128) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_region` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_provincia`),
  CONSTRAINT `fk_provincia_region1`
    FOREIGN KEY (`id_region`)
    REFERENCES `region` (`id_region`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_provincia_region1_idx` ON `provincia` (`id_region` ASC);


-- -----------------------------------------------------
-- Table `provincia_comuna`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `provincia_comuna` ;

CREATE TABLE IF NOT EXISTS `provincia_comuna` (
  `id_provincia_comuna` BIGINT NOT NULL AUTO_INCREMENT,
  `id_provincia` BIGINT NOT NULL,
  `id_comuna` BIGINT(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_provincia_comuna`),
  CONSTRAINT `fk_provincia_comuna_provincia1`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `provincia` (`id_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provincia_comuna_comuna1`
    FOREIGN KEY (`id_comuna`)
    REFERENCES `comuna` (`id_comuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_provincia_comuna_provincia1_idx` ON `provincia_comuna` (`id_provincia` ASC);

CREATE INDEX `fk_provincia_comuna_comuna1_idx` ON `provincia_comuna` (`id_comuna` ASC);


-- -----------------------------------------------------
-- Table `contingencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contingencia` ;

CREATE TABLE IF NOT EXISTS `contingencia` (
  `id_contingencia` BIGINT NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_fin` DATETIME NOT NULL,
  `detalle_html` TEXT NOT NULL,
  `regiones` VARCHAR(64) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_contingencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `permiso_circulacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `permiso_circulacion` ;

CREATE TABLE IF NOT EXISTS `permiso_circulacion` (
  `id_permiso_circulacion` BIGINT NOT NULL AUTO_INCREMENT,
  `mes` TINYINT NOT NULL,
  `alerta_html` TEXT NOT NULL,
  `tip_html` TEXT NOT NULL,
  `regiones` VARCHAR(64) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_permiso_circulacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `evento_mensual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `evento_mensual` ;

CREATE TABLE IF NOT EXISTS `evento_mensual` (
  `id_evento_mensual` BIGINT NOT NULL AUTO_INCREMENT,
  `digito` TINYINT NOT NULL,
  `mes` TINYINT NOT NULL,
  `alerta_html` TEXT NOT NULL,
  `tip_html` TEXT NOT NULL,
  `regiones` VARCHAR(64) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_evento_mensual`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tip_seguro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tip_seguro` ;

CREATE TABLE IF NOT EXISTS `tip_seguro` (
  `id_tip_seguro` BIGINT NOT NULL AUTO_INCREMENT,
  `por_vencer` BIT(1) NOT NULL,
  `alerta_html` TEXT NOT NULL,
  `tip_html` TEXT NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tip_seguro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tip_general`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tip_general` ;

CREATE TABLE IF NOT EXISTS `tip_general` (
  `id_tip_general` BIGINT NOT NULL AUTO_INCREMENT,
  `tip_html` TEXT NOT NULL,
  `regiones` VARCHAR(64) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tip_general`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `revision_tecnica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tecnica` ;

CREATE TABLE IF NOT EXISTS `revision_tecnica` (
  `id_revision_tecnica` BIGINT NOT NULL AUTO_INCREMENT,
  `digito` TINYINT NOT NULL,
  `mes` TINYINT NOT NULL,
  PRIMARY KEY (`id_revision_tecnica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `restriccion_vehicular`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restriccion_vehicular` ;

CREATE TABLE IF NOT EXISTS `restriccion_vehicular` (
  `id_restriccion_vehicular` BIGINT NOT NULL AUTO_INCREMENT,
  `digitos` VARCHAR(10) NOT NULL,
  `fecha` DATE NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_restriccion_vehicular`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- View `vw_campania_usuario`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vw_campania_usuario` ;
DROP TABLE IF EXISTS `vw_campania_usuario`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`car2`@`localhost` SQL SECURITY DEFINER VIEW `vw_campania_usuario` AS select `cu`.`id_campania_usuario` AS `id`,`cu`.`id_usuario` AS `id_usuario`,`c`.`fecha_inicio` AS `fecha_inicio`,`c`.`fecha_fin` AS `fecha_fin`,`c`.`periodicidad` AS `periodicidad`,`c`.`numero_impresiones` AS `numero_impresiones`,`c`.`detalle` AS `detalle`,`cu`.`fecha_modificacion` AS `fecha_modificacion` from (`campania` `c` join `campania_usuario` `cu` on((`cu`.`id_campania` = `c`.`id_campania`))) where cu.fecha_sincro is null;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

DELIMITER $$

DROP TRIGGER IF EXISTS `actualiza_mantencion_base` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_mantencion_base`
BEFORE UPDATE ON `car2`.`mantencion_base`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_combustible` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_combustible`
BEFORE UPDATE ON `car2`.`combustible`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_pais` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_pais`
BEFORE UPDATE ON `car2`.`pais`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_tipo_vehiculo` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_tipo_vehiculo`
BEFORE UPDATE ON `car2`.`tipo_vehiculo`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_marca` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_marca`
BEFORE UPDATE ON `car2`.`marca`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_modelo` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_modelo`
BEFORE UPDATE ON `car2`.`modelo`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_tipo_transmision` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_tipo_transmision`
BEFORE UPDATE ON `car2`.`tipo_transmision`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_traccion` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_traccion`
BEFORE UPDATE ON `car2`.`traccion`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_region` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_region`
BEFORE UPDATE ON `car2`.`region`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_comuna` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_comuna`
BEFORE UPDATE ON `car2`.`comuna`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_usuario` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_usuario`
BEFORE UPDATE ON `car2`.`usuario`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `borra_usuario` $$
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
END
$$


DROP TRIGGER IF EXISTS `usuario_AINS` $$
CREATE TRIGGER `usuario_AINS` AFTER INSERT ON `usuario` FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one
BEGIN
  INSERT INTO usuario_creacion (id_usuario, fecha_creacion)
  VALUES (NEW.id_usuario, NEW.fecha_modificacion);
END$$


DROP TRIGGER IF EXISTS `actualiza_vehiculo` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_vehiculo`
BEFORE UPDATE ON `car2`.`vehiculo`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_alerta` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_alerta`
BEFORE UPDATE ON `car2`.`alerta`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_red_social` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_red_social`
BEFORE UPDATE ON `car2`.`red_social`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_autenticacion` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_autenticacion`
BEFORE UPDATE ON `car2`.`autenticacion`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_cambio_revision` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_cambio_revision`
BEFORE UPDATE ON `car2`.`cambio_revision`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_campania` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_campania`
BEFORE UPDATE ON `car2`.`campania`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
END$$


DROP TRIGGER IF EXISTS `borra_campania` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`borra_campania`
BEFORE DELETE ON `car2`.`campania`
FOR EACH ROW
BEGIN
    DELETE FROM campania_usuario
    WHERE id_campania = OLD.id_campania;
  END$$


DROP TRIGGER IF EXISTS `campania_AUPD` $$
CREATE TRIGGER `campania_AUPD` AFTER UPDATE ON `campania` FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one
BEGIN
    IF NEW.activa THEN
      UPDATE campania_usuario
      SET fecha_modificacion = NEW.fecha_modificacion
      WHERE id_campania = NEW.id_campania;
    END IF;  
END$$


DROP TRIGGER IF EXISTS `actualiza_campania_usuario` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_campania_usuario`
BEFORE UPDATE ON `car2`.`campania_usuario`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_carga_combustible` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_carga_combustible`
BEFORE UPDATE ON `car2`.`carga_combustible`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_cia_seguros` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_cia_seguros`
BEFORE UPDATE ON `car2`.`cia_seguros`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_consulta_proveedor` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_consulta_proveedor`
BEFORE UPDATE ON `car2`.`consulta_proveedor`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_log` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_log`
BEFORE UPDATE ON `car2`.`log`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_mantencion_base_hecha` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_mantencion_base_hecha`
BEFORE UPDATE ON `car2`.`mantencion_base_hecha`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_mantencion_pospuesta` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_mantencion_pospuesta`
BEFORE UPDATE ON `car2`.`mantencion_pospuesta`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_mantencion_usuario` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_mantencion_usuario`
BEFORE UPDATE ON `car2`.`mantencion_usuario`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_mantencion_usuario_hecha` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_mantencion_usuario_hecha`
BEFORE UPDATE ON `car2`.`mantencion_usuario_hecha`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_parametro` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_parametro`
BEFORE UPDATE ON `car2`.`parametro`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_proveedor` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_proveedor`
BEFORE UPDATE ON `car2`.`proveedor`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `borra_proveedor` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`borra_proveedor`
BEFORE DELETE ON `car2`.`proveedor`
FOR EACH ROW
BEGIN
    DELETE FROM proveedor_mantencion_base
    WHERE id_proveedor = OLD.id_proveedor;

    DELETE FROM respuesta_proveedor
    WHERE id_proveedor = OLD.id_proveedor;
  END$$


DROP TRIGGER IF EXISTS `actualiza_proveedor_mantencion_base` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_proveedor_mantencion_base`
BEFORE UPDATE ON `car2`.`proveedor_mantencion_base`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_recordatorio` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_recordatorio`
BEFORE UPDATE ON `car2`.`recordatorio`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_reparacion` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_reparacion`
BEFORE UPDATE ON `car2`.`reparacion`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_respuesta_proveedor` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_respuesta_proveedor`
BEFORE UPDATE ON `car2`.`respuesta_proveedor`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DROP TRIGGER IF EXISTS `actualiza_seguro_vehiculo` $$
CREATE
DEFINER=`car2`@`localhost`
TRIGGER `car2`.`actualiza_seguro_vehiculo`
BEFORE UPDATE ON `car2`.`seguro_vehiculo`
FOR EACH ROW
BEGIN
    SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
  END$$


DELIMITER ;
