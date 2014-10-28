SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `car` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `car` ;

-- -----------------------------------------------------
-- Table `pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pais` (
  `id_pais` BIGINT NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
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
ENGINE = InnoDB;

CREATE INDEX `fk_Region_Pais_idx` ON `region` (`id_pais` ASC);


-- -----------------------------------------------------
-- Table `comuna`
-- -----------------------------------------------------
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
ENGINE = InnoDB;

CREATE INDEX `fk_comuna_region1_idx` ON `comuna` (`id_region` ASC);


-- -----------------------------------------------------
-- Table `tipo_vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_vehiculo` (
  `id_tipo_vehiculo` TINYINT NOT NULL,
  `descripcion` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tipo_vehiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `marca`
-- -----------------------------------------------------
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
ENGINE = InnoDB;

CREATE INDEX `fk_marca_pais1_idx` ON `marca` (`id_pais` ASC);

CREATE INDEX `fk_marca_tipo_vehiculo1_idx` ON `marca` (`id_tipo_vehiculo` ASC);


-- -----------------------------------------------------
-- Table `modelo`
-- -----------------------------------------------------
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
ENGINE = InnoDB;

CREATE INDEX `fk_Modelo_Marca1_idx` ON `modelo` (`id_marca` ASC);


-- -----------------------------------------------------
-- Table `red_social`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `red_social` (
  `id_red_social` BIGINT NOT NULL,
  `red_social` VARCHAR(20) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_red_social`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
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
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_Usuario_Comuna1`
    FOREIGN KEY (`id_comuna`)
    REFERENCES `comuna` (`id_comuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario_Comuna1_idx` ON `usuario` (`id_comuna` ASC);


-- -----------------------------------------------------
-- Table `tipo_transmision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_transmision` (
  `id_tipo_transmision` TINYINT NOT NULL,
  `descripcion` VARCHAR(16) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tipo_transmision`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `combustible`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `combustible` (
  `id_combustible` TINYINT NOT NULL,
  `descripcion` VARCHAR(16) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_combustible`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `traccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `traccion` (
  `id_traccion` TINYINT NOT NULL,
  `descripcion` VARCHAR(16) NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_traccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehiculo` (
  `id_vehiculo` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_modelo` BIGINT NOT NULL,
  `id_tipo_transmision` TINYINT NOT NULL,
  `id_combustible` TINYINT NOT NULL,
  `id_traccion` TINYINT NOT NULL,
  `alias` VARCHAR(20) NOT NULL,
  `patente` VARCHAR(10) NULL,
  `anio` INT NULL,
  `km` INT NULL,
  `aire_acondicionado` TINYINT(1) NULL,
  `alza_vidrios` TINYINT(1) NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_vehiculo`, `id_usuario`),
  CONSTRAINT `fk_Vehiculo_Usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
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
  CONSTRAINT `fk_vehiculo_combustible1`
    FOREIGN KEY (`id_combustible`)
    REFERENCES `combustible` (`id_combustible`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehiculo_traccion1`
    FOREIGN KEY (`id_traccion`)
    REFERENCES `traccion` (`id_traccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Vehiculo_Usuario1_idx` ON `vehiculo` (`id_usuario` ASC);

CREATE INDEX `fk_Vehiculo_Modelo1_idx` ON `vehiculo` (`id_modelo` ASC);

CREATE INDEX `fk_vehiculo_tipo_transmision_idx` ON `vehiculo` (`id_tipo_transmision` ASC);

CREATE INDEX `fk_vehiculo_combustible_idx` ON `vehiculo` (`id_combustible` ASC);

CREATE INDEX `fk_vehiculo_traccion_idx` ON `vehiculo` (`id_traccion` ASC);


-- -----------------------------------------------------
-- Table `autenticacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `autenticacion` (
  `id_autenticacion` BIGINT NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT NOT NULL,
  `id_red_social` BIGINT NOT NULL,
  `token` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_autenticacion`),
  CONSTRAINT `fk_Autenticacion_Usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autenticacion_red_social1`
    FOREIGN KEY (`id_red_social`)
    REFERENCES `red_social` (`id_red_social`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Autenticacion_Usuario1_idx` ON `autenticacion` (`id_usuario` ASC);

CREATE INDEX `fk_autenticacion_red_social1_idx` ON `autenticacion` (`id_red_social` ASC);


-- -----------------------------------------------------
-- Table `mantencion_base`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantencion_base` (
  `id_mantencion_base` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `traccion` VARCHAR(3) NOT NULL,
  `combustible` VARCHAR(16) NOT NULL,
  `accion` VARCHAR(64) NULL COMMENT 'Detalla el trabajo a realizar. Es un listado de las tareas a realizar.',
  `beneficios` TEXT NULL COMMENT 'Contiene la descripción de los beneficios de esta mantención.',
  `descripcion_item` TEXT NULL COMMENT 'Describe en qué consiste la mantención y cuáles son los trabajos asociados.',
  `url` VARCHAR(256) NULL COMMENT 'Contiene la URL a un sitio en el que se encuentra mayor detalle de esta mantención.',
  `depende_km` TINYINT(1) NULL COMMENT 'Indica si esta mantención depende de los Km recorridos o bien del tiempo.',
  `km_entre_mantenciones` INT NULL COMMENT 'Indica la periocidad en Km entre las cuales debe volverse a realizarse esta mantención',
  `meses_entre_mantenciones` INT NULL COMMENT 'Indica los días entre los cuales debe realizarse esta mantención',
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_mantencion_base`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantencion_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantencion_usuario` (
  `id_mantencion_usuario` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `descripcion` VARCHAR(1024) NULL,
  `beneficios` TEXT NULL,
  `url` VARCHAR(256) NULL,
  `depende_km` TINYINT(1) NULL,
  `km_entre_mantenciones` INT NULL,
  `meses_entre_mantenciones` INT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_mantencion_usuario`, `id_usuario`, `id_vehiculo`),
  CONSTRAINT `fk_mantencion_usuario_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mantencion_usuario_vehiculo1_idx` ON `mantencion_usuario` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `mantencion_usuario_hecha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantencion_usuario_hecha` (
  `id_mantencion_usuario_hecha` BIGINT NOT NULL,
  `id_mantencion_usuario` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `km` INT NULL,
  `fecha` DATE NULL,
  `costo` INT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_mantencion_usuario_hecha`, `id_mantencion_usuario`, `id_usuario`, `id_vehiculo`),
  CONSTRAINT `fk_mantencion_usuario_hecha_mantencion_usuario1`
    FOREIGN KEY (`id_mantencion_usuario` , `id_usuario` , `id_vehiculo`)
    REFERENCES `mantencion_usuario` (`id_mantencion_usuario` , `id_usuario` , `id_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mantencion_usuario_hecha_mantencion_usuario1_idx` ON `mantencion_usuario_hecha` (`id_mantencion_usuario` ASC, `id_usuario` ASC, `id_vehiculo` ASC);


-- -----------------------------------------------------
-- Table `recordatorio`
-- -----------------------------------------------------
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
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_recordatorio`, `id_usuario`),
  CONSTRAINT `fk_recordatorio_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_recordatorio_vehiculo1_idx` ON `recordatorio` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `log` (
  `id_log` BIGINT NOT NULL,
  `vehiculo_id_usuario` BIGINT NOT NULL,
  `vehiculo_id_vehiculo` BIGINT NOT NULL,
  `id_tipo_vehiculo` BIGINT NULL,
  `id_marca` BIGINT NULL,
  `id_modelo` BIGINT NULL,
  `id_vehiculo` BIGINT NULL,
  `latitud` DOUBLE NULL,
  `longitud` DOUBLE NULL,
  `accion` VARCHAR(45) NULL,
  `fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `km` INT NULL,
  PRIMARY KEY (`id_log`, `vehiculo_id_usuario`),
  CONSTRAINT `fk_log_vehiculo1`
    FOREIGN KEY (`vehiculo_id_vehiculo` , `vehiculo_id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_log_vehiculo1_idx` ON `log` (`vehiculo_id_vehiculo` ASC, `vehiculo_id_usuario` ASC);


-- -----------------------------------------------------
-- Table `reparacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reparacion` (
  `id_reparacion` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `titulo` VARCHAR(30) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `costo` INT NULL,
  `fecha` DATE NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_reparacion`, `id_usuario`),
  CONSTRAINT `fk_reparacion_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_reparacion_vehiculo1_idx` ON `reparacion` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `carga_combustible`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carga_combustible` (
  `id_carga_combustible` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `km` INT NULL,
  `litros` INT NULL,
  `fecha` DATE NULL,
  `estanque_lleno` TINYINT(1) NULL,
  `costo` INT NULL,
  `latitud` INT NULL,
  `longitud` INT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id_carga_combustible`, `id_usuario`),
  CONSTRAINT `fk_rendimiento_vehiculo1`
    FOREIGN KEY (`id_vehiculo` , `id_usuario`)
    REFERENCES `vehiculo` (`id_vehiculo` , `id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rendimiento_vehiculo1_idx` ON `carga_combustible` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `info_sincro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `info_sincro` (
  `id_info_sincro` INT NOT NULL AUTO_INCREMENT,
  `usuario_id_usuario` BIGINT NOT NULL,
  `sentido` TINYINT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id_info_sincro`),
  CONSTRAINT `fk_info_sincro_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_info_sincro_usuario1_idx` ON `info_sincro` (`usuario_id_usuario` ASC);


-- -----------------------------------------------------
-- Table `mantencion_base_hecha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantencion_base_hecha` (
  `id_mantencion_base_hecha` INT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_vehiculo` BIGINT NOT NULL,
  `id_mantencion_base` BIGINT NOT NULL,
  `km` INT NULL,
  `fecha` DATE NULL,
  `costo` INT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` TINYINT(1) NOT NULL DEFAULT false,
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
ENGINE = InnoDB;

CREATE INDEX `fk_mantencion_base_hecha_mantencion_base1_idx` ON `mantencion_base_hecha` (`id_mantencion_base` ASC);

CREATE INDEX `fk_mantencion_base_hecha_vehiculo1_idx` ON `mantencion_base_hecha` (`id_vehiculo` ASC, `id_usuario` ASC);


-- -----------------------------------------------------
-- Table `cambio_revision`
-- -----------------------------------------------------
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
ENGINE = InnoDB;

CREATE INDEX `fk_cambio_revision_mantencion_base1_idx` ON `cambio_revision` (`id_cambio` ASC);

CREATE INDEX `fk_cambio_revision_mantencion_base2_idx` ON `cambio_revision` (`id_revision` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `red_social`
-- -----------------------------------------------------
START TRANSACTION;
USE `car`;
INSERT INTO `red_social` (`id_red_social`, `red_social`, `fecha_modificacion`) VALUES (1, 'facebook', '2014-01-01 12:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tipo_transmision`
-- -----------------------------------------------------
START TRANSACTION;
USE `car`;
INSERT INTO `tipo_transmision` (`id_tipo_transmision`, `descripcion`, `fecha_modificacion`) VALUES (1, 'ALL', '2014-01-01 12:00:00');
INSERT INTO `tipo_transmision` (`id_tipo_transmision`, `descripcion`, `fecha_modificacion`) VALUES (2, 'AUTOMATIC', '2014-01-01 12:00:00');
INSERT INTO `tipo_transmision` (`id_tipo_transmision`, `descripcion`, `fecha_modificacion`) VALUES (3, 'MANUAL', '2014-01-01 12:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `combustible`
-- -----------------------------------------------------
START TRANSACTION;
USE `car`;
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (1, 'gas', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (2, 'diesel', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (3, 'hybrid', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (4, 'flex-fuel (FFV)', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (5, 'natural gas (CNG)', '2014-01-01 12:00:00');
INSERT INTO `combustible` (`id_combustible`, `descripcion`, `fecha_modificacion`) VALUES (6, 'electric', '2014-01-01 12:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `traccion`
-- -----------------------------------------------------
START TRANSACTION;
USE `car`;
INSERT INTO `traccion` (`id_traccion`, `descripcion`, `fecha_modificacion`) VALUES (1, 'AWD', '2014-01-01 12:00:00');
INSERT INTO `traccion` (`id_traccion`, `descripcion`, `fecha_modificacion`) VALUES (2, 'FWD', '2014-01-01 12:00:00');
INSERT INTO `traccion` (`id_traccion`, `descripcion`, `fecha_modificacion`) VALUES (3, '4WD', '2014-01-01 12:00:00');
INSERT INTO `traccion` (`id_traccion`, `descripcion`, `fecha_modificacion`) VALUES (4, 'RWD', '2014-01-01 12:00:00');

COMMIT;

