SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `pais`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `pais` (
  `id_pais` BIGINT NOT NULL ,
  `pais` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_pais`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `region` (
  `id_region` BIGINT NOT NULL ,
  `id_pais` BIGINT NULL ,
  `region` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_region`) ,
  CONSTRAINT `fk_Region_Pais`
    FOREIGN KEY (`id_pais` )
    REFERENCES `pais` (`id_pais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Region_Pais_idx` ON `region` (`id_pais` ASC) ;


-- -----------------------------------------------------
-- Table `ciudad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ciudad` (
  `id_ciudad` BIGINT NOT NULL ,
  `id_region` BIGINT NULL ,
  `Ciudad` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_ciudad`) ,
  CONSTRAINT `fk_Ciudad_Region1`
    FOREIGN KEY (`id_region` )
    REFERENCES `region` (`id_region` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ciudad_Region1_idx` ON `ciudad` (`id_region` ASC) ;


-- -----------------------------------------------------
-- Table `comuna`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `comuna` (
  `id_comuna` BIGINT NOT NULL ,
  `id_ciudad` BIGINT NULL ,
  `Comuna` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_comuna`) ,
  CONSTRAINT `fk_Comuna_Ciudad1`
    FOREIGN KEY (`id_ciudad` )
    REFERENCES `ciudad` (`id_ciudad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Comuna_Ciudad1_idx` ON `comuna` (`id_ciudad` ASC) ;


-- -----------------------------------------------------
-- Table `tipo_vehiculo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tipo_vehiculo` (
  `id_tipo_vehiculo` BIGINT NOT NULL ,
  `tipo_vehiculo` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_tipo_vehiculo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `marca`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `marca` (
  `id_marca` BIGINT NOT NULL ,
  `id_tipo_vehiculo` BIGINT NULL ,
  `marca` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_marca`) ,
  CONSTRAINT `fk_Marca_TipoVehiculo1`
    FOREIGN KEY (`id_tipo_vehiculo` )
    REFERENCES `tipo_vehiculo` (`id_tipo_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Marca_TipoVehiculo1_idx` ON `marca` (`id_tipo_vehiculo` ASC) ;


-- -----------------------------------------------------
-- Table `modelo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `modelo` (
  `id_modelo` BIGINT NOT NULL ,
  `id_marca` BIGINT NULL ,
  `modelo` VARCHAR(30) NULL ,
  PRIMARY KEY (`id_modelo`) ,
  CONSTRAINT `fk_Modelo_Marca1`
    FOREIGN KEY (`id_marca` )
    REFERENCES `marca` (`id_marca` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Modelo_Marca1_idx` ON `modelo` (`id_marca` ASC) ;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `usuario` (
  `id_usuario` BIGINT NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `correo` VARCHAR(45) NULL ,
  `fecha_nacimiento` DATE NULL ,
  `hombre` TINYINT(1) NULL ,
  `telefono` VARCHAR(20) NULL ,
  `fecha_vencimiento_licencia` DATE NULL ,
  `id_comuna` BIGINT NULL ,
  PRIMARY KEY (`id_usuario`) ,
  CONSTRAINT `fk_Usuario_Comuna1`
    FOREIGN KEY (`id_comuna` )
    REFERENCES `comuna` (`id_comuna` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario_Comuna1_idx` ON `usuario` (`id_comuna` ASC) ;


-- -----------------------------------------------------
-- Table `autenticacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `autenticacion` (
  `id_autenticacion` BIGINT NOT NULL ,
  `id_usuario` BIGINT NULL ,
  `id_red_social` BIGINT NULL ,
  `token` VARCHAR(45) NULL ,
  `fecha` DATE NULL ,
  PRIMARY KEY (`id_autenticacion`) ,
  CONSTRAINT `fk_Autenticacion_Usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `usuario` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Autenticacion_Usuario1_idx` ON `autenticacion` (`id_usuario` ASC) ;


-- -----------------------------------------------------
-- Table `red_social`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `red_social` (
  `id_red_social` BIGINT NOT NULL ,
  `red_social` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_red_social`) ,
  CONSTRAINT `fk_RedSocial_Autenticacion1`
    FOREIGN KEY (`id_red_social` )
    REFERENCES `autenticacion` (`id_red_social` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehiculo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `vehiculo` (
  `id_vehiculo` BIGINT NOT NULL ,
  `id_usuario` BIGINT NULL ,
  `id_modelo` BIGINT NULL ,
  `alias` VARCHAR(20) NULL ,
  `patente` VARCHAR(10) NULL ,
  `ano` INT NULL ,
  `km` INT NULL ,
  `bencinero` TINYINT(1) NULL ,
  `manual` TINYINT(1) NULL ,
  `automatico` TINYINT(1) NULL ,
  `tiptronic` TINYINT(1) NULL ,
  `aire_acondicionado` TINYINT(1) NULL ,
  `alza_vidrios` TINYINT(1) NULL ,
  `traccion_trasera` TINYINT(1) NULL ,
  `eliminado` TINYINT(1) NULL ,
  PRIMARY KEY (`id_vehiculo`) ,
  CONSTRAINT `fk_Vehiculo_Usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `usuario` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehiculo_Modelo1`
    FOREIGN KEY (`id_modelo` )
    REFERENCES `modelo` (`id_modelo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Vehiculo_Usuario1_idx` ON `vehiculo` (`id_usuario` ASC) ;

CREATE INDEX `fk_Vehiculo_Modelo1_idx` ON `vehiculo` (`id_modelo` ASC) ;


-- -----------------------------------------------------
-- Table `tipo_mantencion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tipo_mantencion` (
  `id_tipo_mantencion` BIGINT NOT NULL ,
  `id_tipo_vehiculo` BIGINT NULL ,
  `nombre` VARCHAR(30) NULL ,
  `descripcion` TEXT NULL ,
  `beneficios` TEXT NULL ,
  `url` VARCHAR(256) NULL ,
  PRIMARY KEY (`id_tipo_mantencion`) ,
  CONSTRAINT `fk_TipoMantencion_TipoVehiculo1`
    FOREIGN KEY (`id_tipo_vehiculo` )
    REFERENCES `tipo_vehiculo` (`id_tipo_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_TipoMantencion_TipoVehiculo1_idx` ON `tipo_mantencion` (`id_tipo_vehiculo` ASC) ;


-- -----------------------------------------------------
-- Table `mantencion_base`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mantencion_base` (
  `id_mantencion_base` BIGINT NOT NULL ,
  `id_tipo_vehiculo` BIGINT NULL ,
  `id_marca` BIGINT NULL COMMENT 'IdMarca = 0 -> Mantención general para todas las marcas.\nIdModelo = 0 -> Mantención general para todos los modelos de la marca definida.\nIdVehiculo = 0 -> Mantención general para todos los vehículos de la marca y modelo especificado,\nIdVehiculo != 0 -> Mantención específica del vehículo especificado. Es registrada por los usuarios.' ,
  `id_modelo` BIGINT NULL ,
  `id_tipo_mantencion` BIGINT NULL ,
  `Descripcion` VARCHAR(1024) NULL ,
  `beneficios` TEXT NULL ,
  `url` VARCHAR(256) NULL ,
  `depende_km` TINYINT(1) NULL ,
  `km_entre_mantenciones` INT NULL ,
  `dias_entre_mantenciones` INT NULL ,
  PRIMARY KEY (`id_mantencion_base`) ,
  CONSTRAINT `fk_Mantencion_TipoVehiculo1`
    FOREIGN KEY (`id_tipo_vehiculo` )
    REFERENCES `tipo_vehiculo` (`id_tipo_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mantencion_Marca1`
    FOREIGN KEY (`id_marca` )
    REFERENCES `marca` (`id_marca` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mantencion_Modelo1`
    FOREIGN KEY (`id_modelo` )
    REFERENCES `modelo` (`id_modelo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MantencionBase_TipoMantencion1`
    FOREIGN KEY (`id_tipo_mantencion` )
    REFERENCES `tipo_mantencion` (`id_tipo_mantencion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Mantencion_TipoVehiculo1_idx` ON `mantencion_base` (`id_tipo_vehiculo` ASC) ;

CREATE INDEX `fk_Mantencion_Marca1_idx` ON `mantencion_base` (`id_marca` ASC) ;

CREATE INDEX `fk_Mantencion_Modelo1_idx` ON `mantencion_base` (`id_modelo` ASC) ;

CREATE INDEX `fk_MantencionBase_TipoMantencion1_idx` ON `mantencion_base` (`id_tipo_mantencion` ASC) ;


-- -----------------------------------------------------
-- Table `mantencion_usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mantencion_usuario` (
  `id_mantencion_usuario` BIGINT NOT NULL ,
  `id_vehiculo` BIGINT NULL ,
  `nombre` VARCHAR(30) NULL ,
  `descripcion` VARCHAR(1024) NULL ,
  `beneficios` TEXT NULL ,
  `URL` VARCHAR(256) NULL ,
  `DependeKm` TINYINT(1) NULL ,
  `KmEntreMantenciones` INT NULL ,
  `DiasEntreMantenciones` INT NULL ,
  `MantencionUsuariocol` VARCHAR(45) NULL ,
  `id_mantencion_base` BIGINT NULL ,
  `mantecion_base` TINYINT(1) NULL ,
  PRIMARY KEY (`id_mantencion_usuario`) ,
  CONSTRAINT `fk_MantencionUsuario_Vehiculo1`
    FOREIGN KEY (`id_vehiculo` )
    REFERENCES `vehiculo` (`id_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_MantencionUsuario_Vehiculo1_idx` ON `mantencion_usuario` (`id_vehiculo` ASC) ;


-- -----------------------------------------------------
-- Table `mantencion_usuario_hecha`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mantencion_usuario_hecha` (
  `id_mantencion_usuario_hecha` BIGINT NOT NULL ,
  `id_mantencion_usuario` BIGINT NULL ,
  `km` INT NULL ,
  `fecha` DATE NULL ,
  `costo` INT NULL ,
  PRIMARY KEY (`id_mantencion_usuario_hecha`) ,
  CONSTRAINT `fk_MantencionUsuarioHecha_MantencionUsuario1`
    FOREIGN KEY (`id_mantencion_usuario` )
    REFERENCES `mantencion_usuario` (`id_mantencion_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_MantencionUsuarioHecha_MantencionUsuario1_idx` ON `mantencion_usuario_hecha` (`id_mantencion_usuario` ASC) ;


-- -----------------------------------------------------
-- Table `recordatorio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recordatorio` (
  `id_recordatorio` BIGINT NOT NULL ,
  `id_vehiculo` VARCHAR(45) NULL ,
  `recordar_fecha` TINYINT(1) NULL ,
  `recordar_km` TINYINT(1) NULL ,
  `fecha` DATE NULL ,
  `km` INT NULL ,
  `titulo` VARCHAR(30) NULL ,
  `descripcion` TEXT NULL ,
  PRIMARY KEY (`id_recordatorio`) ,
  CONSTRAINT `fk_Recordatorio_Vehiculo1`
    FOREIGN KEY (`id_vehiculo` )
    REFERENCES `vehiculo` (`id_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Recordatorio_Vehiculo1_idx` ON `recordatorio` (`id_vehiculo` ASC) ;


-- -----------------------------------------------------
-- Table `log`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `log` (
  `id_log` BIGINT NOT NULL ,
  `id_usuario` BIGINT NULL ,
  `id_tipo_vehiculo` BIGINT NULL ,
  `id_marca` BIGINT NULL ,
  `id_modelo` BIGINT NULL ,
  `id_vehiculo` BIGINT NULL ,
  `latitud` FLOAT NULL ,
  `longitud` FLOAT NULL ,
  `accion` VARCHAR(45) NULL ,
  `fecha_hora`  NULL ,
  `km` INT NULL ,
  PRIMARY KEY (`id_log`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reparacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `reparacion` (
  `id_reparacion` BIGINT NOT NULL ,
  `id_vehiculo` BIGINT NULL ,
  `titulo` VARCHAR(30) NULL ,
  `descripcion` TEXT NULL ,
  `costo` INT NULL ,
  PRIMARY KEY (`id_reparacion`) ,
  CONSTRAINT `fk_Reparacion_Vehiculo1`
    FOREIGN KEY (`id_vehiculo` )
    REFERENCES `vehiculo` (`id_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Reparacion_Vehiculo1_idx` ON `reparacion` (`id_vehiculo` ASC) ;


-- -----------------------------------------------------
-- Table `rendimiento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rendimiento` (
  `id_rendimiento` BIGINT NOT NULL ,
  `id_vehiculo` BIGINT NULL ,
  `km` INT NULL ,
  `litros` INT NULL ,
  `estanque_lleno` TINYINT(1) NULL ,
  `fecha` DATE NULL ,
  `costo` INT NULL ,
  `latitud` INT NULL ,
  `longitud` INT NULL ,
  PRIMARY KEY (`id_rendimiento`) ,
  CONSTRAINT `fk_Rendimiento_Vehiculo1`
    FOREIGN KEY (`id_vehiculo` )
    REFERENCES `vehiculo` (`id_vehiculo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Rendimiento_Vehiculo1_idx` ON `rendimiento` (`id_vehiculo` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
