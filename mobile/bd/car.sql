PRAGMA foreign_keys = ON;










CREATE TABLE IF NOT EXISTS pais (
  id_pais BIGINT NOT NULL,
  pais VARCHAR(20) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_pais))
;





CREATE TABLE IF NOT EXISTS region (
  id_region BIGINT NOT NULL,
  id_pais BIGINT NOT NULL,
  region VARCHAR(64) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_region),
  CONSTRAINT fk_Region_Pais
    FOREIGN KEY (id_pais)
    REFERENCES pais (id_pais)
    
    )
;

CREATE INDEX fk_Region_Pais_idx ON region (id_pais ASC);





CREATE TABLE IF NOT EXISTS comuna (
  id_comuna BIGINT NOT NULL,
  id_region BIGINT NOT NULL,
  comuna VARCHAR(20) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_comuna),
  CONSTRAINT fk_comuna_region1
    FOREIGN KEY (id_region)
    REFERENCES region (id_region)
    
    )
;

CREATE INDEX fk_comuna_region1_idx ON comuna (id_region ASC);





CREATE TABLE IF NOT EXISTS tipo_vehiculo (
  id_tipo_vehiculo TINYINT NOT NULL,
  descripcion VARCHAR(20) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_tipo_vehiculo))
;





CREATE TABLE IF NOT EXISTS marca (
  id_marca SMALLINT NOT NULL,
  id_tipo_vehiculo TINYINT NOT NULL,
  id_pais BIGINT NOT NULL,
  descripcion VARCHAR(20) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_marca),
  CONSTRAINT fk_marca_pais1
    FOREIGN KEY (id_pais)
    REFERENCES pais (id_pais)
    
    ,
  CONSTRAINT fk_marca_tipo_vehiculo1
    FOREIGN KEY (id_tipo_vehiculo)
    REFERENCES tipo_vehiculo (id_tipo_vehiculo)
    
    )
;

CREATE INDEX fk_marca_pais1_idx ON marca (id_pais ASC);

CREATE INDEX fk_marca_tipo_vehiculo1_idx ON marca (id_tipo_vehiculo ASC);





CREATE TABLE IF NOT EXISTS modelo (
  id_modelo BIGINT NOT NULL,
  id_marca SMALLINT NOT NULL,
  descripcion VARCHAR(64) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_modelo),
  CONSTRAINT fk_Modelo_Marca1
    FOREIGN KEY (id_marca)
    REFERENCES marca (id_marca)
    
    )
;

CREATE INDEX fk_Modelo_Marca1_idx ON modelo (id_marca ASC);





CREATE TABLE IF NOT EXISTS red_social (
  id_red_social BIGINT NOT NULL,
  red_social VARCHAR(20) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_red_social))
;





CREATE TABLE IF NOT EXISTS usuario (
  id_usuario BIGINT NOT NULL,
  id_comuna BIGINT NOT NULL,
  nombre VARCHAR(45) NULL,
  correo VARCHAR(45) NULL,
  fecha_nacimiento DATE NULL,
  hombre BOOLEAN NULL,
  telefono VARCHAR(20) NULL,
  fecha_vencimiento_licencia DATE NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (id_usuario),
  CONSTRAINT fk_Usuario_Comuna1
    FOREIGN KEY (id_comuna)
    REFERENCES comuna (id_comuna)
    
    )
;

CREATE INDEX fk_Usuario_Comuna1_idx ON usuario (id_comuna ASC);





CREATE TABLE IF NOT EXISTS tipo_transmision (
  id_tipo_transmision TINYINT NOT NULL,
  descripcion VARCHAR(16) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_tipo_transmision))
;





CREATE TABLE IF NOT EXISTS combustible (
  id_combustible TINYINT NOT NULL,
  descripcion VARCHAR(32) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_combustible))
;





CREATE TABLE IF NOT EXISTS traccion (
  id_traccion TINYINT NOT NULL,
  descripcion VARCHAR(16) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_traccion))
;





CREATE TABLE IF NOT EXISTS vehiculo (
  id_vehiculo BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_modelo BIGINT NOT NULL,
  id_tipo_transmision TINYINT NOT NULL,
  id_combustible TINYINT NOT NULL,
  id_traccion TINYINT NOT NULL,
  alias VARCHAR(20) NOT NULL,
  patente VARCHAR(10) NULL,
  anio INT NULL,
  km INT NULL,
  aire_acondicionado BOOLEAN NULL,
  alza_vidrios BOOLEAN NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (id_vehiculo, id_usuario),
  CONSTRAINT fk_Vehiculo_Usuario1
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario)
    
    ,
  CONSTRAINT fk_Vehiculo_Modelo1
    FOREIGN KEY (id_modelo)
    REFERENCES modelo (id_modelo)
    
    ,
  CONSTRAINT fk_vehiculo_tipo_transmision1
    FOREIGN KEY (id_tipo_transmision)
    REFERENCES tipo_transmision (id_tipo_transmision)
    
    ,
  CONSTRAINT fk_vehiculo_combustible1
    FOREIGN KEY (id_combustible)
    REFERENCES combustible (id_combustible)
    
    ,
  CONSTRAINT fk_vehiculo_traccion1
    FOREIGN KEY (id_traccion)
    REFERENCES traccion (id_traccion)
    
    )
;

CREATE INDEX fk_Vehiculo_Usuario1_idx ON vehiculo (id_usuario ASC);

CREATE INDEX fk_Vehiculo_Modelo1_idx ON vehiculo (id_modelo ASC);

CREATE INDEX fk_vehiculo_tipo_transmision_idx ON vehiculo (id_tipo_transmision ASC);

CREATE INDEX fk_vehiculo_combustible_idx ON vehiculo (id_combustible ASC);

CREATE INDEX fk_vehiculo_traccion_idx ON vehiculo (id_traccion ASC);





CREATE TABLE IF NOT EXISTS autenticacion (
  id_autenticacion BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_red_social BIGINT NOT NULL,
  token VARCHAR(45) NULL,
  fecha DATE NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_autenticacion),
  CONSTRAINT fk_Autenticacion_Usuario1
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario)
    
    ,
  CONSTRAINT fk_autenticacion_red_social1
    FOREIGN KEY (id_red_social)
    REFERENCES red_social (id_red_social)
    
    )
;

CREATE INDEX fk_Autenticacion_Usuario1_idx ON autenticacion (id_usuario ASC);

CREATE INDEX fk_autenticacion_red_social1_idx ON autenticacion (id_red_social ASC);





CREATE TABLE IF NOT EXISTS mantencion_base (
  id_mantencion_base BIGINT NOT NULL,
  id_traccion TINYINT NOT NULL,
  id_combustible TINYINT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  accion VARCHAR(64) NULL ,
  beneficios TEXT NULL ,
  descripcion_item TEXT NULL ,
  url VARCHAR(256) NULL ,
  depende_km BOOLEAN NULL ,
  km_entre_mantenciones INT NULL ,
  dias_entre_mantenciones INT NULL ,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_mantencion_base),
  CONSTRAINT fk_mantencion_base_traccion1
    FOREIGN KEY (id_traccion)
    REFERENCES traccion (id_traccion)
    
    ,
  CONSTRAINT fk_mantencion_base_combustible1
    FOREIGN KEY (id_combustible)
    REFERENCES combustible (id_combustible)
    
    )
;

CREATE INDEX fk_mantencion_base_traccion1_idx ON mantencion_base (id_traccion ASC);

CREATE INDEX fk_mantencion_base_combustible1_idx ON mantencion_base (id_combustible ASC);





CREATE TABLE IF NOT EXISTS mantencion_usuario (
  id_mantencion_usuario BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  nombre VARCHAR(30) NULL,
  descripcion VARCHAR(1024) NULL,
  beneficios TEXT NULL,
  URL VARCHAR(256) NULL,
  DependeKm BOOLEAN NULL,
  KmEntreMantenciones INT NULL,
  DiasEntreMantenciones INT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (id_mantencion_usuario, id_usuario),
  CONSTRAINT fk_mantencion_usuario_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )
;

CREATE INDEX fk_mantencion_usuario_vehiculo1_idx ON mantencion_usuario (id_vehiculo ASC, id_usuario ASC);





CREATE TABLE IF NOT EXISTS mantencion_usuario_hecha (
  id_mantencion_usuario_hecha BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_mantencion_usuario BIGINT NOT NULL,
  km INT NULL,
  fecha DATE NULL,
  costo INT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (id_mantencion_usuario_hecha, id_usuario),
  CONSTRAINT fk_mantencion_usuario_hecha_mantencion_usuario1
    FOREIGN KEY (id_mantencion_usuario , id_usuario)
    REFERENCES mantencion_usuario (id_mantencion_usuario , id_usuario)
    
    )
;

CREATE INDEX fk_mantencion_usuario_hecha_mantencion_usuario1_idx ON mantencion_usuario_hecha (id_mantencion_usuario ASC, id_usuario ASC);





CREATE TABLE IF NOT EXISTS recordatorio (
  id_recordatorio BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  recordar_fecha BOOLEAN NULL,
  recordar_km BOOLEAN NULL,
  fecha DATE NULL,
  km INT NULL,
  titulo VARCHAR(30) NULL,
  descripcion TEXT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (id_recordatorio, id_usuario),
  CONSTRAINT fk_recordatorio_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )
;

CREATE INDEX fk_recordatorio_vehiculo1_idx ON recordatorio (id_vehiculo ASC, id_usuario ASC);





CREATE TABLE IF NOT EXISTS log (
  id_log BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_tipo_vehiculo BIGINT NULL,
  id_marca BIGINT NULL,
  id_modelo BIGINT NULL,
  id_vehiculo BIGINT NULL,
  latitud DOUBLE NULL,
  longitud DOUBLE NULL,
  accion VARCHAR(45) NULL,
  fecha TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  km INT NULL,
  PRIMARY KEY (id_log, id_usuario))
;





CREATE TABLE IF NOT EXISTS reparacion (
  id_reparacion BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  titulo VARCHAR(30) NOT NULL,
  descripcion TEXT NOT NULL,
  costo INT NULL,
  fecha DATE NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (id_reparacion, id_usuario),
  CONSTRAINT fk_reparacion_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )
;

CREATE INDEX fk_reparacion_vehiculo1_idx ON reparacion (id_vehiculo ASC, id_usuario ASC);





CREATE TABLE IF NOT EXISTS carga_combustible (
  id_carga_combustible BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  km INT NULL,
  litros INT NULL,
  fecha DATE NULL,
  estanque_lleno BOOLEAN NULL,
  costo INT NULL,
  latitud INT NULL,
  longitud INT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (id_carga_combustible, id_usuario),
  CONSTRAINT fk_rendimiento_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )
;

CREATE INDEX fk_rendimiento_vehiculo1_idx ON carga_combustible (id_vehiculo ASC, id_usuario ASC);





CREATE TABLE IF NOT EXISTS info_sincro (
  id_info_sincro INT NOT NULL,
  sentido TINYINT NOT NULL,
  archivo_nombre VARCHAR(256) NOT NULL,
  archivo_tamano BIGINT NOT NULL,
  archivo_md5 VARCHAR(32) NOT NULL,
  fecha DATETIME NOT NULL,
  fecha_lectura DATETIME NULL,
  fecha_fin_procesamiento DATETIME NULL,
  PRIMARY KEY (id_info_sincro))
;





CREATE TABLE IF NOT EXISTS mantencion_base_hecha (
  id_mantencion_base_hecha INT NOT NULL,
  id_mantencion_base BIGINT NOT NULL,
  km INT NULL,
  fecha DATE NULL,
  costo INT NULL,
  fecha_modificacion TIMESTAMP NOT NULL,
  borrado BOOLEAN NOT NULL,
  PRIMARY KEY (id_mantencion_base_hecha),
  CONSTRAINT fk_mantencion_base_hecha_mantencion_base1
    FOREIGN KEY (id_mantencion_base)
    REFERENCES mantencion_base (id_mantencion_base)
    
    )
;

CREATE INDEX fk_mantencion_base_hecha_mantencion_base1_idx ON mantencion_base_hecha (id_mantencion_base ASC);











INSERT INTO tipo_vehiculo (id_tipo_vehiculo, descripcion, fecha_modificacion) VALUES (1, 'vehiculo liviano', '2014-01-01 12:00:00');









INSERT INTO red_social (id_red_social, red_social, fecha_modificacion) VALUES (1, 'facebook', '2014-01-01 12:00:00');









INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (1, 'ALL', '2014-01-01 12:00:00');
INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (2, 'AUTOMATIC', '2014-01-01 12:00:00');
INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (3, 'MANUAL', '2014-01-01 12:00:00');









INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (1, 'gas', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (2, 'diesel', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (3, 'hybrid', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (4, 'flex-fuel (FFV)', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (5, 'natural gas (CNG)', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (6, 'electric', '2014-01-01 12:00:00');









INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (1, 'ALL', '2014-01-01 12:00:00');
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (2, 'AWD', '2014-01-01 12:00:00');
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (3, 'FWD', '2014-01-01 12:00:00');
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (4, '4WD', '2014-01-01 12:00:00');
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (5, 'RWD', '2014-01-01 12:00:00');



INSERT INTO `pais` (`id_pais`, `pais`) VALUES 
(1, 'Chile');


INSERT INTO `region` (`id_region`, `id_pais`, `region`) VALUES 
(1, 1, 'De Tarapacá'),
(2, 1, 'Antofagasta'),
(3, 1, 'Atacama'),
(4, 1, 'Coquimbo'),
(5, 1, 'De Valparaíso'),
(6, 1, 'Del Lib. Bernardo O''Higgins'),
(7, 1, 'Del Maule'),
(8, 1, 'Del Bío  Bío'),
(9, 1, 'De La Araucanía'),
(10, 1, 'De Los Lagos'),
(11, 1, 'Aysén'),
(12, 1, 'De Magallanes y La Antártica Chilena'),
(13, 1, 'Metropolitana'),
(14, 1, 'De Los Ríos'),
(15, 1, 'Arica y Parinacota');


INSERT INTO `comuna` (`id_comuna`, `id_region`, `comuna`) VALUES 
(1, 1, 'Alto Hospicio'),
(2, 1, 'Camiña'),
(3, 1, 'Colchane'),
(4, 1, 'Huara'),
(5, 1, 'Iquique'),
(6, 1, 'Pica'),
(7, 1, 'Pozo Almonte'),
(8, 2, 'Antofagasta'),
(9, 2, 'Calama'),
(10, 2, 'María Elena'),
(11, 2, 'Mejillones'),
(12, 2, 'Ollagüe'),
(13, 2, 'San Pedro de Atacama'),
(14, 2, 'Sierra Gorda'),
(15, 2, 'Taltal'),
(16, 2, 'Tocopilla'),
(17, 3, 'Alto del Carmen'),
(18, 3, 'Caldera'),
(19, 3, 'Chañaral'),
(20, 3, 'Copiapó'),
(21, 3, 'Diego de Almagro'),
(22, 3, 'Freirina'),
(23, 3, 'Huasco'),
(24, 3, 'Tierra Amarilla'),
(25, 3, 'Vallenar'),
(26, 4, 'Andacollo'),
(27, 4, 'Canela'),
(28, 4, 'Combarbalá'),
(29, 4, 'Coquimbo'),
(30, 4, 'Illapel'),
(31, 4, 'La Higuera'),
(32, 4, 'La Serena'),
(33, 4, 'Los Vilos'),
(34, 4, 'Monte Patria'),
(35, 4, 'Ovalle'),
(36, 4, 'Paiguano'),
(37, 4, 'Punitaqui'),
(38, 4, 'Río Hurtado'),
(39, 4, 'Salamanca'),
(40, 4, 'Vicuña'),
(41, 5, 'Algarrobo'),
(42, 5, 'Cabildo'),
(43, 5, 'Calle Larga'),
(44, 5, 'Cartagena'),
(45, 5, 'Casablanca'),
(46, 5, 'Catemu'),
(47, 5, 'Concón'),
(48, 5, 'El Quisco'),
(49, 5, 'El Tabo'),
(50, 5, 'Hijuelas'),
(51, 5, 'Isla de Pascua'),
(52, 5, 'Juan Fernández'),
(53, 5, 'Calera'),
(54, 5, 'La Cruz'),
(55, 5, 'La Ligua'),
(56, 5, 'Limache'),
(57, 5, 'Llaillay'),
(58, 5, 'Los Andes'),
(59, 5, 'Nogales'),
(60, 5, 'Olmué'),
(61, 5, 'Panquehue'),
(62, 5, 'Papudo'),
(63, 5, 'Petorca'),
(64, 5, 'Puchuncaví'),
(65, 5, 'Putaendo'),
(66, 5, 'Quillota'),
(67, 5, 'Quilpué'),
(68, 5, 'Quintero'),
(69, 5, 'Rinconada'),
(70, 5, 'San Antonio'),
(71, 5, 'San Esteban'),
(72, 5, 'San Felipe'),
(73, 5, 'Santa María'),
(74, 5, 'Santo Domingo'),
(75, 5, 'Valparaíso'),
(76, 5, 'Villa Alemana'),
(77, 5, 'Viña del Mar'),
(78, 5, 'Zapallar'),
(79, 6, 'Chépica'),
(80, 6, 'Chimbarongo'),
(81, 6, 'Codegua'),
(82, 6, 'Coinco'),
(83, 6, 'Coltauco'),
(84, 6, 'Doñihue'),
(85, 6, 'Graneros'),
(86, 6, 'La Estrella'),
(87, 6, 'Las Cabras'),
(88, 6, 'Litueche'),
(89, 6, 'Lolol'),
(90, 6, 'Machalí'),
(91, 6, 'Malloa'),
(92, 6, 'Marchihue'),
(93, 6, 'Nancagua'),
(94, 6, 'Navidad'),
(95, 6, 'Olivar'),
(96, 6, 'Palmilla'),
(97, 6, 'Paredones'),
(98, 6, 'Peralillo'),
(99, 6, 'Peumo'),
(100, 6, 'Pichidegua'),
(101, 6, 'Pichilemu'),
(102, 6, 'Placilla'),
(103, 6, 'Pumanque'),
(104, 6, 'Quinta de Tilcoco'),
(105, 6, 'Rancagua'),
(106, 6, 'Rengo'),
(107, 6, 'Requínoa'),
(108, 6, 'San Fernando'),
(109, 6, 'San Vicente'),
(110, 6, 'Santa Cruz'),
(111, 6, 'Mostazal'),
(112, 7, 'Cauquenes'),
(113, 7, 'Chanco'),
(114, 7, 'Colbún'),
(115, 7, 'Constitución'),
(116, 7, 'Curepto'),
(117, 7, 'Curicó'),
(118, 7, 'Empedrado'),
(119, 7, 'Hualañé'),
(120, 7, 'Licantén'),
(121, 7, 'Linares'),
(122, 7, 'Longaví'),
(123, 7, 'Maule'),
(124, 7, 'Molina'),
(125, 7, 'Parral'),
(126, 7, 'Pelarco'),
(127, 7, 'Pelluhue'),
(128, 7, 'Pencahue'),
(129, 7, 'Rauco'),
(130, 7, 'Retiro'),
(131, 7, 'Río Claro'),
(132, 7, 'Romeral'),
(133, 7, 'Sagrada Familia'),
(134, 7, 'San Clemente'),
(135, 7, 'San Javier'),
(136, 7, 'San Rafael'),
(137, 7, 'Talca'),
(138, 7, 'Teno'),
(139, 7, 'Vichuquén'),
(140, 7, 'Villa Alegre'),
(141, 7, 'Yerbas Buenas'),
(142, 8, 'Alto Biobío'),
(143, 8, 'Antuco'),
(144, 8, 'Arauco'),
(145, 8, 'Bulnes'),
(146, 8, 'Cabrero'),
(147, 8, 'Cañete'),
(148, 8, 'Chiguayante'),
(149, 8, 'Chillán'),
(150, 8, 'Chillán Viejo'),
(151, 8, 'Cobquecura'),
(152, 8, 'Coelemu'),
(153, 8, 'Coihueco'),
(154, 8, 'Concepción'),
(155, 8, 'Contulmo'),
(156, 8, 'Coronel'),
(157, 8, 'Curanilahue'),
(158, 8, 'El Carmen'),
(159, 8, 'Florida'),
(160, 8, 'Hualpén'),
(161, 8, 'Hualqui'),
(162, 8, 'Laja'),
(163, 8, 'Lebu'),
(164, 8, 'Los Álamos'),
(165, 8, 'Los Ángeles'),
(166, 8, 'Lota'),
(167, 8, 'Mulchén'),
(168, 8, 'Nacimiento'),
(169, 8, 'Negrete'),
(170, 8, 'Ninhue'),
(171, 8, 'Ñiquén'),
(172, 8, 'Pemuco'),
(173, 8, 'Penco'),
(174, 8, 'Pinto'),
(175, 8, 'Portezuelo'),
(176, 8, 'Quilaco'),
(177, 8, 'Quilleco'),
(178, 8, 'Quillón'),
(179, 8, 'Quirihue'),
(180, 8, 'Ránquil'),
(181, 8, 'San Carlos'),
(182, 8, 'San Fabián'),
(183, 8, 'San Ignacio'),
(184, 8, 'San Nicolás'),
(185, 8, 'San Pedro de la Paz'),
(186, 8, 'San Rosendo'),
(187, 8, 'Santa Bárbara'),
(188, 8, 'Santa Juana'),
(189, 8, 'Talcahuano'),
(190, 8, 'Tirúa'),
(191, 8, 'Tomé'),
(192, 8, 'Treguaco'),
(193, 8, 'Tucapel'),
(194, 8, 'Yumbel'),
(195, 8, 'Yungay'),
(196, 9, 'Angol'),
(197, 9, 'Carahue'),
(198, 9, 'Cholchol'),
(199, 9, 'Collipulli'),
(200, 9, 'Cunco'),
(201, 9, 'Curacautín'),
(202, 9, 'Curarrehue'),
(203, 9, 'Ercilla'),
(204, 9, 'Freire'),
(205, 9, 'Galvarino'),
(206, 9, 'Gorbea'),
(207, 9, 'Lautaro'),
(208, 9, 'Loncoche'),
(209, 9, 'Lonquimay'),
(210, 9, 'Los Sauces'),
(211, 9, 'Lumaco'),
(212, 9, 'Melipeuco'),
(213, 9, 'Nueva Imperial'),
(214, 9, 'Padre las Casas'),
(215, 9, 'Perquenco'),
(216, 9, 'Pitrufquén'),
(217, 9, 'Pucón'),
(218, 9, 'Purén'),
(219, 9, 'Renaico'),
(220, 9, 'Saavedra'),
(221, 9, 'Temuco'),
(222, 9, 'Teodoro Schmidt'),
(223, 9, 'Toltén'),
(224, 9, 'Traiguén'),
(225, 9, 'Victoria'),
(226, 9, 'Vilcún'),
(227, 9, 'Villarrica'),
(228, 10, 'Ancud'),
(229, 10, 'Calbuco'),
(230, 10, 'Castro'),
(231, 10, 'Chaitén'),
(232, 10, 'Chonchi'),
(233, 10, 'Cochamó'),
(234, 10, 'Curaco de Vélez'),
(235, 10, 'Dalcahue'),
(236, 10, 'Fresia'),
(237, 10, 'Frutillar'),
(238, 10, 'Futaleufú'),
(239, 10, 'Hualaihué'),
(240, 10, 'Llanquihue'),
(241, 10, 'Los Muermos'),
(242, 10, 'Maullín'),
(243, 10, 'Osorno'),
(244, 10, 'Palena'),
(245, 10, 'Puerto Montt'),
(246, 10, 'Puerto Octay'),
(247, 10, 'Puerto Varas'),
(248, 10, 'Puqueldón'),
(249, 10, 'Purranque'),
(250, 10, 'Puyehue'),
(251, 10, 'Queilén'),
(252, 10, 'Quellón'),
(253, 10, 'Quemchi'),
(254, 10, 'Quinchao'),
(255, 10, 'Río Negro'),
(256, 10, 'San Juan de la Costa'),
(257, 10, 'San Pablo'),
(258, 11, 'Aisén'),
(259, 11, 'Chile Chico'),
(260, 11, 'Cisnes'),
(261, 11, 'Cochrane'),
(262, 11, 'Coihaique'),
(263, 11, 'Guaitecas'),
(264, 11, 'Lago Verde'),
(265, 11, 'O&acute;Higgins'),
(266, 11, 'Río Ibáñez'),
(267, 11, 'Tortel'),
(268, 12, 'Cabo de Hornos'),
(269, 12, 'Laguna Blanca'),
(270, 12, 'Natales'),
(271, 12, 'Porvenir'),
(272, 12, 'Primavera'),
(273, 12, 'Punta Arenas'),
(274, 12, 'Río Verde'),
(275, 12, 'San Gregorio'),
(276, 12, 'Timaukel'),
(277, 12, 'Torres del Paine'),
(278, 13, 'Alhué'),
(279, 13, 'Buin'),
(280, 13, 'Calera de Tango'),
(281, 13, 'Cerrillos'),
(282, 13, 'Cerro Navia'),
(283, 13, 'Colina'),
(284, 13, 'Conchalí'),
(285, 13, 'Curacaví'),
(286, 13, 'El Bosque'),
(287, 13, 'El Monte'),
(288, 13, 'Estación Central'),
(289, 13, 'Huechuraba'),
(290, 13, 'Independencia'),
(291, 13, 'Isla de Maipo'),
(292, 13, 'La Cisterna'),
(293, 13, 'La Florida'),
(294, 13, 'La Granja'),
(295, 13, 'La Pintana'),
(296, 13, 'La Reina'),
(297, 13, 'Lampa'),
(298, 13, 'Las Condes'),
(299, 13, 'Lo Barnechea'),
(300, 13, 'Lo Espejo'),
(301, 13, 'Lo Prado'),
(302, 13, 'Macul'),
(303, 13, 'Maipú'),
(304, 13, 'María Pinto'),
(305, 13, 'Melipilla'),
(306, 13, 'Ñuñoa'),
(307, 13, 'Padre Hurtado'),
(308, 13, 'Paine'),
(309, 13, 'Pedro Aguirre Cerda'),
(310, 13, 'Peñaflor'),
(311, 13, 'Peñalolén'),
(312, 13, 'Pirque'),
(313, 13, 'Providencia'),
(314, 13, 'Pudahuel'),
(315, 13, 'Puente Alto'),
(316, 13, 'Quilicura'),
(317, 13, 'Quinta Normal'),
(318, 13, 'Recoleta'),
(319, 13, 'Renca'),
(320, 13, 'San Bernardo'),
(321, 13, 'San Joaquín'),
(322, 13, 'San José de Maipo'),
(323, 13, 'San Miguel'),
(324, 13, 'San Pedro'),
(325, 13, 'San Ramón'),
(326, 13, 'Santiago'),
(329, 13, 'Talagante'),
(330, 13, 'Tiltil'),
(331, 13, 'Vitacura'),
(332, 14, 'Corral'),
(333, 14, 'Futrono'),
(334, 14, 'La Unión'),
(335, 14, 'Lago Ranco'),
(336, 14, 'Lanco'),
(337, 14, 'Los Lagos'),
(338, 14, 'Máfil'),
(339, 14, 'Mariquina'),
(340, 14, 'Paillaco'),
(341, 14, 'Panguipulli'),
(342, 14, 'Río Bueno'),
(343, 14, 'Valdivia'),
(344, 15, 'Arica'),
(345, 15, 'Camarones'),
(346, 15, 'General Lagos'),
(347, 15, 'Putre'),
(348, 12, 'Antártica');
INSERT INTO `marca` VALUES (1,1,1,'Toyota','2014-06-23 02:58:31');
INSERT INTO `modelo` VALUES (1,1,'Yaris 1.5 GLX','2014-06-23 02:58:32');
  -- marca como borrados los registros de lablas relacionadas con 'vehiculo'
  CREATE TRIGGER borra_vehiculo 
  AFTER UPDATE OF borrado 
  ON vehiculo 
  FOR EACH ROW 
  WHEN NEW.borrado = 'true'
  BEGIN
    UPDATE reparacion SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE recordatorio SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE mantencion_usuario SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE carga_combustible SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;
  END;
  
  -- actualiza fecha_modificacion al actualizar cualquier columna de 'vehiculo'
  CREATE TRIGGER actualiza_vehiculo  
  AFTER UPDATE OF 
    id_modelo,
    id_tipo_transmision,
    id_combustible,
    id_traccion,
    alias,
    patente,
    anio,
    km,
    aire_acondicionado,
    alza_vidrios,
    borrado
  ON vehiculo FOR EACH ROW 
  BEGIN
    UPDATE vehiculo SET fecha_modificacion = datetime('now', 'localtime') WHERE id_vehiculo = NEW.id_vehiculo AND id_usuario = NEW.id_usuario;
  END;

  -- marca como borrados los registros de lablas relacionadas con 'mantencion_usuario'
  CREATE TRIGGER borra_mantencion_usuario
  AFTER UPDATE OF borrado 
  ON mantencion_usuario 
  FOR EACH ROW 
  WHEN NEW.borrado = 'true'
  BEGIN
    UPDATE mantencion_usuario_hecha SET borrado = 'true' 
    WHERE id_mantencion_usuario = NEW.id_mantencion_usuario 
    AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'mantencion_usuario'
  CREATE TRIGGER actualiza_mantencion_usuario
  AFTER UPDATE OF 
    id_mantencion_usuario,
    nombre,
    descripcion,
    beneficios,
    URL,
    DependeKm,
    KmEntreMantenciones,
    DiasEntreMantenciones,
    costo,
    borrado
  ON mantencion_usuario FOR EACH ROW 
  BEGIN
    UPDATE mantencion_usuario SET fecha_modificacion = datetime('now', 'localtime') WHERE id_mantencion_usuario = NEW.id_mantencion_usuario AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'reparacion'
  CREATE TRIGGER actualiza_reparacion
  AFTER UPDATE OF 
    id_vehiculo,
    titulo,
    descripcion,
    costo,
    fecha,
    borrado
  ON reparacion FOR EACH ROW 
  BEGIN
    UPDATE reparacion SET fecha_modificacion = datetime('now', 'localtime') WHERE id_reparacion = NEW.id_reparacion AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'recordatorio'
  CREATE TRIGGER actualiza_recordatorio
  AFTER UPDATE OF 
    id_vehiculo,
    recordar_fecha,
    recordar_km,
    fecha,
    km,
    titulo,
    descripcion,
    borrado
  ON recordatorio FOR EACH ROW 
  BEGIN
    UPDATE recordatorio SET fecha_modificacion = datetime('now', 'localtime') WHERE id_recordatorio = NEW.id_recordatorio AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'carga_combustible'
  CREATE TRIGGER actualiza_carga_combustible
  AFTER UPDATE OF 
    id_vehiculo,
    km,
    litros,
    fecha,
    estanque_lleno,
    costo,
    latitud,
    longitud,
    borrado
  ON carga_combustible FOR EACH ROW 
  BEGIN
    UPDATE carga_combustible SET fecha_modificacion = datetime('now', 'localtime') WHERE id_carga_combustible = NEW.id_carga_combustible AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'mantencion_usuario_hecha'
  CREATE TRIGGER actualiza_mantencion_usuario_hecha
  AFTER UPDATE OF 
    id_mantencion_usuario,
    km,
    fecha,
    costo,
    borrado
  ON mantencion_usuario_hecha FOR EACH ROW 
  BEGIN
    UPDATE mantencion_usuario_hecha SET fecha_modificacion = datetime('now', 'localtime') WHERE id_mantencion_usuario_hecha = NEW.id_mantencion_usuario_hecha AND id_usuario = NEW.id_usuario;
  END;

  -- actualiza fecha_modificacion al actualizar cualquier columna de 'usuario'
  CREATE TRIGGER actualiza_usuario
  AFTER UPDATE OF 
    id_comuna,
    nombre,
    correo,
    fecha_nacimiento,
    hombre,
    telefono,
    fecha_vencimiento_licencia,
    borrado
  ON usuario FOR EACH ROW 
  BEGIN
    UPDATE usuario SET fecha_modificacion = datetime('now', 'localtime') WHERE id_usuario = NEW.id_usuario;
  END;

