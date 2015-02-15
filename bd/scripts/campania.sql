-- -----------------------------------------------------
-- Table `car`.`campania`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car`.`campania` ;

CREATE  TABLE IF NOT EXISTS `car`.`campania` (
  `id_campania` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(32) NOT NULL,
  `por_sql` BIT(1) NOT NULL DEFAULT b'0',
  `condicion_sql` TEXT NULL,
  `texto_correo` TEXT NOT NULL,
  `inicio` DATETIME NOT NULL,
  `periodicidad_dias` SMALLINT NULL,
  `activa` BIT(1) NOT NULL DEFAULT b'0',
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` BIT(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id_campania`) )
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = latin1;

CREATE UNIQUE INDEX `idx_campania_descripcion` USING BTREE ON `car`.`campania` (`descripcion` ASC);

-- CREATE UNIQUE INDEX `idx_campania_condicion_sql` USING BTREE ON `car`.`campania` (`condicion_sql` ASC);

-- -----------------------------------------------------
-- Table `car`.`campania_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car`.`campania_usuario` ;

CREATE  TABLE IF NOT EXISTS `car`.`campania_usuario` (
  `id_campania_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `id_campania` INT(11) NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `fecha_envio` DATETIME NOT NULL,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrado` BIT(1) NOT NULL DEFAULT b'0' ,
  PRIMARY KEY (`id_campania_usuario`),
  CONSTRAINT `fk_campania_usuario_id_campania`
    FOREIGN KEY (`id_campania`)
    REFERENCES `campania` (`id_campania`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campania_usuario_id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION )
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = latin1;

CREATE UNIQUE INDEX `idx_campania_usuario` USING BTREE ON `car`.`campania_usuario` (`id_campania` ASC, `id_usuario` ASC);

