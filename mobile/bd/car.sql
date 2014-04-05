PRAGMA foreign_keys = ON;










CREATE TABLE IF NOT EXISTS pais (
  id_pais BIGINT NOT NULL,
  pais VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_pais))
;





CREATE TABLE IF NOT EXISTS region (
  id_region BIGINT NOT NULL,
  id_pais BIGINT NOT NULL,
  region VARCHAR(64) NOT NULL,
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
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_tipo_vehiculo))
;





CREATE TABLE IF NOT EXISTS marca (
  id_marca SMALLINT NOT NULL,
  descripcion VARCHAR(20) NOT NULL,
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_marca))
;





CREATE TABLE IF NOT EXISTS modelo (
  id_modelo BIGINT NOT NULL,
  id_marca SMALLINT NOT NULL,
  id_tipo_vehiculo TINYINT NOT NULL,
  descripcion VARCHAR(64) NOT NULL,
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_modelo),
  CONSTRAINT fk_Modelo_Marca1
    FOREIGN KEY (id_marca)
    REFERENCES marca (id_marca)
    
    ,
  CONSTRAINT fk_modelo_tipo_vehiculo1
    FOREIGN KEY (id_tipo_vehiculo)
    REFERENCES tipo_vehiculo (id_tipo_vehiculo)
    
    )
;

CREATE INDEX fk_Modelo_Marca1_idx ON modelo (id_marca ASC);

CREATE INDEX fk_modelo_tipo_vehiculo_idx ON modelo (id_tipo_vehiculo ASC);





CREATE TABLE IF NOT EXISTS red_social (
  id_red_social BIGINT NOT NULL,
  red_social VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_red_social))
;





CREATE TABLE IF NOT EXISTS usuario (
  id_usuario BIGINT NOT NULL,
  id_comuna BIGINT NOT NULL,
  nombre VARCHAR(45) NULL,
  correo VARCHAR(45) NULL,
  fecha_nacimiento DATE NULL,
  hombre BIT(1) NULL,
  telefono VARCHAR(20) NULL,
  fecha_vencimiento_licencia DATE NULL,
  fecha_modifiacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  borrado BIT(1) NULL DEFAULT 0,
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
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_tipo_transmision))
;





CREATE TABLE IF NOT EXISTS combustible (
  id_combustible TINYINT NOT NULL,
  descripcion VARCHAR(32) NOT NULL,
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_combustible))
;





CREATE TABLE IF NOT EXISTS traccion (
  id_traccion TINYINT NOT NULL,
  descripcion VARCHAR(16) NULL,
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
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
  aire_acondicionado BIT(1) NULL,
  alza_vidrios BIT(1) NULL,
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  borrado BIT(1) NULL DEFAULT 0,
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





CREATE TABLE IF NOT EXISTS modelo_anio (
  id_modelo_anio BIGINT NOT NULL,
  id_modelo BIGINT NOT NULL,
  anio INT(11) NOT NULL,
  PRIMARY KEY (id_modelo_anio),
  CONSTRAINT fk_modelo_ano_modelo1
    FOREIGN KEY (id_modelo)
    REFERENCES modelo (id_modelo)
    
    )
;

CREATE INDEX fk_modelo_ano_modelo1_idx ON modelo_anio (id_modelo ASC);





CREATE TABLE IF NOT EXISTS mantencion_base (
  id_mantencion_base BIGINT NOT NULL,
  id_modelo_anio BIGINT NOT NULL,
  beneficios TEXT NULL,
  url VARCHAR(256) NULL,
  depende_km BIT(1) NULL,
  km_entre_mantenciones INT NULL,
  dias_entre_mantenciones INT NULL,
  accion VARCHAR(64) NULL,
  item VARCHAR(64) NOT NULL,
  descripcion_item TEXT NULL,
  tipo_traccion VARCHAR(16) NOT NULL,
  tipo_transmision VARCHAR(16) NOT NULL,
  codigo_motor VARCHAR(16) NOT NULL,
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_mantencion_base),
  CONSTRAINT fk_mantencion_base_modelo_ano1
    FOREIGN KEY (id_modelo_anio)
    REFERENCES modelo_anio (id_modelo_anio)
    
    )
;

CREATE INDEX fk_mantencion_base_modelo_ano1_idx ON mantencion_base (id_modelo_anio ASC);





CREATE TABLE IF NOT EXISTS mantencion_usuario (
  id_mantencion_usuario BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  nombre VARCHAR(30) NULL,
  descripcion VARCHAR(1024) NULL,
  beneficios TEXT NULL,
  URL VARCHAR(256) NULL,
  DependeKm BIT(1) NULL,
  KmEntreMantenciones INT NULL,
  DiasEntreMantenciones INT NULL,
  MantencionUsuariocol VARCHAR(45) NULL,
  id_mantencion_base BIGINT NULL,
  mantecion_base TINYINT(1) NULL,
  mantencion_usuariocol VARCHAR(45) NULL,
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_mantencion_usuario, id_usuario),
  CONSTRAINT fk_mantencion_usuario_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )
;

CREATE INDEX fk_mantencion_usuario_vehiculo1_idx ON mantencion_usuario (id_vehiculo ASC, id_usuario ASC);





CREATE TABLE IF NOT EXISTS mantencion_usuario_hecha (
  id_mantencion_usuario_hecha BIGINT NOT NULL,
  id_mantencion_usuario BIGINT NOT NULL,
  km INT NULL,
  fecha DATE NULL,
  costo INT NULL,
  PRIMARY KEY (id_mantencion_usuario_hecha),
  CONSTRAINT fk_MantencionUsuarioHecha_MantencionUsuario1
    FOREIGN KEY (id_mantencion_usuario)
    REFERENCES mantencion_usuario (id_mantencion_usuario)
    
    )
;

CREATE INDEX fk_MantencionUsuarioHecha_MantencionUsuario1_idx ON mantencion_usuario_hecha (id_mantencion_usuario ASC);





CREATE TABLE IF NOT EXISTS recordatorio (
  id_recordatorio BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  recordar_fecha BIT(1) NULL,
  recordar_km BIT(1) NULL,
  fecha DATE NULL,
  km INT NULL,
  titulo VARCHAR(30) NULL,
  descripcion TEXT NULL,
  recordatoriocol VARCHAR(45) NOT NULL,
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  descartado BIT(1) NULL DEFAULT 0,
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
  fecha_modificacion TIMESTAMP NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_reparacion, id_usuario),
  CONSTRAINT fk_reparacion_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )
;

CREATE INDEX fk_reparacion_vehiculo1_idx ON reparacion (id_vehiculo ASC, id_usuario ASC);





CREATE TABLE IF NOT EXISTS rendimiento (
  id_rendimiento BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  km INT NULL,
  litros INT NULL,
  estanque_lleno BIT(1) NULL,
  costo INT NULL,
  latitud INT NULL,
  longitud INT NULL,
  fecha DATE NULL,
  PRIMARY KEY (id_rendimiento, id_usuario),
  CONSTRAINT fk_rendimiento_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )
;

CREATE INDEX fk_rendimiento_vehiculo1_idx ON rendimiento (id_vehiculo ASC, id_usuario ASC);





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





CREATE TABLE IF NOT EXISTS motor (
  id_motor BIGINT NOT NULL,
  codigo VARCHAR(416) NOT NULL,
  razon_compresion VARCHAR(8) NULL,
  cilindros TINYINT NULL,
  tamanio VARCHAR(8) NULL,
  desplazamiento INT NULL,
  configuracion VARCHAR(16) NULL,
  tipo_combustible VARCHAR(64) NULL,
  potencia INT NULL,
  torque INT NULL,
  valvulas TINYINT NULL,
  codigo_fabricante VARCHAR(16) NULL,
  tipo VARCHAR(32) NULL,
  tipo_compresor VARCHAR(32) NULL,
  id_modelo_anio BIGINT NOT NULL,
  PRIMARY KEY (id_motor),
  CONSTRAINT fk_motor_modelo_anio1
    FOREIGN KEY (id_modelo_anio)
    REFERENCES modelo_anio (id_modelo_anio)
    
    )
;

CREATE INDEX fk_motor_modelo_anio1_idx ON motor (id_modelo_anio ASC);





CREATE TABLE IF NOT EXISTS estilo (
  id_estilo BIGINT NOT NULL,
  traccion VARCHAR(32) NOT NULL,
  puertas TINYINT NOT NULL,
  nombre VARCHAR(128) NOT NULL,
  rendimiento_ciudad SMALLINT NULL,
  rendimiento_carretera SMALLINT NULL,
  id_modelo_anio BIGINT NOT NULL,
  PRIMARY KEY (id_estilo),
  CONSTRAINT fk_estilo_modelo_anio1
    FOREIGN KEY (id_modelo_anio)
    REFERENCES modelo_anio (id_modelo_anio)
    
    )
;

CREATE INDEX fk_estilo_modelo_anio1_idx ON estilo (id_modelo_anio ASC);











INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (1, 'ALL', NULL);
INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (2, 'AUTOMATIC', NULL);
INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (3, 'MANUAL', NULL);









INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (1, 'gas', NULL);
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (2, 'diesel', NULL);
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (3, 'hybrid', NULL);
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (4, 'flex-fuel (FFV)', NULL);
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (5, 'natural gas (CNG)', NULL);
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (6, 'electric', NULL);









INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (1, 'ALL', NULL);
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (2, 'AWD', NULL);
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (3, 'FWD', NULL);
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (4, '4WD', NULL);
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (5, 'RWD', NULL);



