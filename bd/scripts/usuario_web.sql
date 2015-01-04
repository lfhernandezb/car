-- -----------------------------------------------------
-- Table `car`.`usuario_web`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car`.`usuario_web` ;

CREATE  TABLE IF NOT EXISTS `car`.`usuario_web` (
  `id_usuario_web` INT(11) NOT NULL AUTO_INCREMENT ,
  `nombre_usuario` VARCHAR(16) NOT NULL ,
  `contrasena` VARCHAR(32) NOT NULL ,
  `nombre` VARCHAR(16) NOT NULL ,
  `apellidos` VARCHAR(32) NOT NULL ,
  `email` VARCHAR(32) NOT NULL ,
  `activo` BIT(1) NOT NULL DEFAULT b'0' ,
  `borrado` BIT(1) NOT NULL DEFAULT b'0' ,
  PRIMARY KEY (`id_usuario_web`) )
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = latin1;

CREATE UNIQUE INDEX `idx_usuario_web_nombre_usuario` USING BTREE ON `car`.`usuario_web` (`nombre_usuario` ASC) ;

CREATE UNIQUE INDEX `idx_usuario_web_email` USING BTREE ON `car`.`usuario_web` (`email` ASC) ;

INSERT INTO `car`.`usuario_web` (`id_usuario_web`, `nombre_usuario`, `contrasena`, `nombre`, `apellidos`, `email`, `activo`, `borrado`) VALUES (NULL, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrador', 'Sistema', 'admin@localhost', 1, 0);

