
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
DROP TABLE IF EXISTS `parametro` ;

CREATE TABLE IF NOT EXISTS `parametro` (
  `id_parametro` BIGINT(20) NOT NULL,
  `llave` VARCHAR(64) NOT NULL,
  `valor` TEXT NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_parametro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE UNIQUE INDEX `index2` USING BTREE ON `parametro` (`llave` ASC);

INSERT INTO red_social (id_red_social, red_social) VALUES (0, 'default');

ALTER TABLE `car`.`traccion` 
CHANGE COLUMN `descripcion` `descripcion` VARCHAR(40) NOT NULL ;

UPDATE traccion SET descripcion = 'DOBLE TRACCION PERMAMENTE (AWD)' WHERE id_traccion = 1;
UPDATE traccion SET descripcion = 'TRACCION DELANTERA' WHERE id_traccion = 2;
UPDATE traccion SET descripcion = 'DOBLE TRACCION NO PERMAMENTE (4WD)' WHERE id_traccion = 3;
UPDATE traccion SET descripcion = 'TRACCION TRASERA' WHERE id_traccion = 4;

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
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `proveedor_mantencion_base`
-- -----------------------------------------------------
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
  `numero_impresiones` VARCHAR(45) NULL,
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
-- View `v_campania_usuario`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `v_campania_usuario` ;
DROP TABLE IF EXISTS `v_campania_usuario`;

CREATE  OR REPLACE VIEW `v_campania_usuario` AS
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


INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('TALLERES DÍAZ LTDA.','Pedro Ramón Córdova  3837, Puente Alto , santiago, chile','contacto@talleresdiaz.cl','(09) 7335 5372','http://www.talleresdiaz.cl ',-33.6166670,-70.5666670);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('SERVICIO AUTOMOTRIZ CALDERON','Dávila Larraín 1935, Santiago, santiago, chile','','(2) 2544 2681','http://www.automotrizcalderon.cl ',-33.4703664,-70.6354657);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('LUBRICENTRO LA BANDERA','Esperanza 1265, San Ramón, santiago, chile','','(09) 6668 9622','http://www.lubricentrolab.cl/',-33.5501145,-70.6530354);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('MAXIMUS CAR','Pasaje Pedro de Valdivia 5190, Ñuñoa, santiago, chile','','(09) 7497 3842','http://www.maximus-car.cl ',-33.4711445,-70.6064591);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('AUTOMOTRIZ FALCONETTY','Avenida Diego Portales 6352, Puente Alto , santiago, chile','','(09) 5768 7450','',-33.5586120,-70.5540856);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('AUTOMOTORA MIGUEL JACOB HELO','Santa Isabel  1400, Santiago, santiago, chile','repuestos@mjh.cl','(2) 2569 8032','http://www.mjh.cl',-33.4527584,-70.6540056);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('AUTOMOTORA MIGUEL JACOB HELO','Avenida Francisco Bilbao 2626, Providencia, santiago, chile','repuestos@mjh.cl','(2) 2204 7033','http://www.mjh.cl',-33.4360980,-70.5963912);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('AUTOMOTORA MIGUEL JACOB HELO','San Ignacio 531, Santiago, santiago, chile','repuestos@mjh.cl','(2) 2569 8000','http://www.mjh.cl',-33.3310199,-70.7054044);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('AUTOMOTORA MIGUEL JACOB HELO','Avenida 10 de Julio Huamachuco 496, Santiago, santiago, chile','repuestos@mjh.cl','(2) 2634 1499','http://www.mjh.cl',-33.4527110,-70.6406667);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('AUTOMOTORA MIGUEL JACOB HELO','San Ignacio 568, Santiago, santiago, chile','repuestos@mjh.cl','(2) 2569 8000','http://www.mjh.cl',-33.3312925,-70.7057821);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('AUTHIÈVRE MOTORS','Carmen  856, Santiago, santiago, chile','','(2) 2634 6108','http://www.motors.cl ',-33.4545577,-70.6402842);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('FERRER TALAGANTE','Avenida Libertador B.O Higgins 201, Talagante, santiago, chile','','(2) 2815 1224','',-33.5050296,-70.7969006);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('MECÁNICA TOLORZA','Consejo de Indias  1423, Providencia, santiago, chile','','(09) 8360 6379','http://www.mecanicatolorza.cl',-33.4414436,-70.5958033);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('GARAJE FAST SERVICE','Santa Julia 587, La Florida, santiago, chile','','(09) 5404 3793','',-33.5324368,-70.6004703);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('RAM SERVICIO AUTOMOTRIZ ',' , , santiago, chile','','(09) 6800 5611 ','',-33.4691199,-70.6419970);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('SERVICIO AUTOMOTRIZ SEBASTIÁN OLEA ','Avenida Presidente Batlle y Ordóñez  3569, Ñuñoa, santiago, chile','','(09) 6218 7885','http://www.sebastianolea.cl ',-33.4480710,-70.5922428);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('LUBRICENTRO FERNANDO RODRÍGUEZ ','Camino Santa Rosa  Parcela  4 BZ, Lampa, santiago, chile','','(09) 7787 0991','',-33.2827090,-70.8793280);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('LUBRICENTROS LUIS ACEVEDO MUÑOZ','Avenida 5 de Abril 4260, Estación Central, santiago, chile','','(2) 2793 8008','',-33.4593893,-70.6928311);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('AD Lubricentro','Avenida José Manuel Infante  1395, Providencia, santiago, chile','','(09) 8230 8925','http://www.adlubricentro.cl ',-33.4438840,-70.6198903);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('MECÁNICA AUTOMOTRIZ GYS ','Camino al Volcán 7950, Puente Alto, santiago, chile','fsalvatierra@gmail.com','(09) 4225 0293','rodrigoalejandro29@gmail.com',-33.5801188,-70.4616120);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Lubricantes Daroch y Bülher LTDA','Avenida Rodrigo de Araya 2418, Ñuñoa, santiago, chile','','(2) 2238 3840','http://www.cambiodeaceites.cl',-33.4741387,-70.6077665);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Taller Mecánico el Canana','Las Parcelas 1231, Quilicura, santiago, chile','info@tallermecanicoelcanana.cl ','(09) 5667 0010','http://www.tallermecanicoelcanana.cl ',-33.3682738,-70.7159142);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Taller Mecánico Familycar','Monte Palomar 135, Maipú, santiago, chile','','(09) 9864 3035','http://www.familycar.cl ',-33.5266093,-70.7732315);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Carlos Rivero Lubricentros E.I.R.L. ','Tobalaba 11567, Peñalolén, santiago, chile','','(2) 2278 4903 ','',-33.4775657,-70.5572870);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Lubricentro Carrascal','Avenida Carrascal 5651, Quinta Normal, santiago, chile','','(2) 2773 3292','',-33.4189011,-70.7067928);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Lubricentos y Repuestos Juan de la Cruz Cabueque','Da Vinci 1206, Quilicura, santiago, chile','','(2) 2603 8743','',-33.3721734,-70.7181820);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Byrne Inversiones Ltda','Bellavista 135, Recoleta, santiago, chile','','(2) 2777 8026','',-33.4345538,-70.6390098);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Melendes Lubricante','Avenida Manuel Antonio Matta 594, Quilicura, santiago, chile','','(2) 2627 5317','',-33.3632103,-70.7516483);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Lubricentro Jym','Avenida El Peñón 1806, Puente Alto, santiago, chile','','(2) 2875 4482','',-33.5797403,-70.5609548);
INSERT INTO proveedor (nombre, direccion, correo, telefono, url, latitud, longitud) VALUES('Lubri-Stop','Pasaje 12 6489, La Florida, santiago, chile','','(2) 2221 5085','',-33.5133516,-70.5860627);

