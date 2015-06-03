PRAGMA journal_mode = OFF;












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
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_usuario),
  CONSTRAINT fk_Usuario_Comuna1
    FOREIGN KEY (id_comuna)
    REFERENCES comuna (id_comuna)
    
    )

;

CREATE INDEX fk_Usuario_Comuna1_idx ON usuario (id_comuna ASC);







CREATE TABLE IF NOT EXISTS usuario_web (
  id_usuario_web INT(11) NOT NULL,
  nombre_usuario VARCHAR(16) NOT NULL,
  contrasena VARCHAR(32) NOT NULL,
  nombre VARCHAR(16) NOT NULL,
  apellidos VARCHAR(32) NOT NULL,
  email VARCHAR(32) NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT 'false',
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_usuario_web))


;

CREATE UNIQUE INDEX idx_usuario_web_nombre_usuario ON usuario_web (nombre_usuario ASC);

CREATE UNIQUE INDEX idx_usuario_web_email ON usuario_web (email ASC);







CREATE TABLE IF NOT EXISTS combustible (
  id_combustible TINYINT NOT NULL,
  descripcion VARCHAR(16) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_combustible))

;







CREATE TABLE IF NOT EXISTS tipo_transmision (
  id_tipo_transmision TINYINT NOT NULL,
  descripcion VARCHAR(16) NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_tipo_transmision))

;







CREATE TABLE IF NOT EXISTS traccion (
  id_traccion TINYINT NOT NULL,
  descripcion VARCHAR(40) NOT NULL,
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
  km_anuales INT(11) NULL DEFAULT NULL,
  fecha_ultimo_km DATE NULL DEFAULT NULL,
  km_calibrados INT(11) NULL DEFAULT NULL,
  fecha_ultima_calibracion DATE NULL DEFAULT NULL,
  patente VARCHAR(10) NULL,
  anio INT NULL,
  km INT NULL,
  aire_acondicionado BOOLEAN NULL,
  alza_vidrios BOOLEAN NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_vehiculo, id_usuario),
  CONSTRAINT fk_vehiculo_combustible1
    FOREIGN KEY (id_combustible)
    REFERENCES combustible (id_combustible)
    
    ,
  CONSTRAINT fk_Vehiculo_Modelo1
    FOREIGN KEY (id_modelo)
    REFERENCES modelo (id_modelo)
    
    ,
  CONSTRAINT fk_vehiculo_tipo_transmision1
    FOREIGN KEY (id_tipo_transmision)
    REFERENCES tipo_transmision (id_tipo_transmision)
    
    ,
  CONSTRAINT fk_vehiculo_traccion1
    FOREIGN KEY (id_traccion)
    REFERENCES traccion (id_traccion)
    
    ,
  CONSTRAINT fk_vehiculo_usuario1
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario)
    
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
  CONSTRAINT fk_autenticacion_red_social1
    FOREIGN KEY (id_red_social)
    REFERENCES red_social (id_red_social)
    
    )

;

CREATE INDEX fk_Autenticacion_Usuario1_idx ON autenticacion (id_usuario ASC);

CREATE INDEX fk_autenticacion_red_social1_idx ON autenticacion (id_red_social ASC);







CREATE TABLE IF NOT EXISTS mantencion_base (
  id_mantencion_base BIGINT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  traccion VARCHAR(3) NOT NULL,
  combustible VARCHAR(16) NOT NULL,
  accion VARCHAR(64) NULL ,
  beneficios TEXT NULL ,
  descripcion_item TEXT NULL ,
  url VARCHAR(256) NULL ,
  depende_km BOOLEAN NULL ,
  km_entre_mantenciones INT NULL ,
  meses_entre_mantenciones INT NULL ,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_mantencion_base))

;







CREATE TABLE IF NOT EXISTS mantencion_pospuesta (
  id_mantencion_pospuesta INT(11) NOT NULL,
  id_usuario BIGINT(20) NOT NULL,
  id_vehiculo BIGINT(20) NOT NULL,
  id_mantencion_base BIGINT(20) NOT NULL,
  km INT(11) NULL DEFAULT NULL,
  fecha DATE NULL DEFAULT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_mantencion_pospuesta, id_usuario),
  CONSTRAINT fk_mantencion_pospuesta_mantencion_base1
    FOREIGN KEY (id_mantencion_base)
    REFERENCES mantencion_base (id_mantencion_base)
    
    ,
  CONSTRAINT fk_mantencion_pospuesta_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )

;

CREATE INDEX fk_mantencion_pospuesta_mantencion_base1_idx ON mantencion_pospuesta (id_mantencion_base ASC);

CREATE INDEX fk_mantencion_pospuesta_vehiculo1_idx ON mantencion_pospuesta (id_vehiculo ASC, id_usuario ASC);







CREATE TABLE IF NOT EXISTS mantencion_usuario (
  id_mantencion_usuario BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  nombre VARCHAR(30) NULL,
  descripcion VARCHAR(1024) NULL,
  beneficios TEXT NULL,
  url VARCHAR(256) NULL,
  depende_km BOOLEAN NULL,
  km_entre_mantenciones INT NULL,
  meses_entre_mantenciones INT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_mantencion_usuario, id_usuario),
  CONSTRAINT fk_mantencion_usuario_usuario1
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario)
    
    )

;

CREATE INDEX fk_mantencion_usuario_usuario1_idx ON mantencion_usuario (id_usuario ASC);







CREATE TABLE IF NOT EXISTS mantencion_usuario_hecha (
  id_mantencion_usuario_hecha BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  id_mantencion_usuario BIGINT NOT NULL,
  km INT NULL,
  fecha DATE NULL,
  costo INT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_mantencion_usuario_hecha, id_usuario),
  CONSTRAINT fk_mantencion_usuario_hecha_mantencion_usuario1
    FOREIGN KEY (id_mantencion_usuario , id_usuario)
    REFERENCES mantencion_usuario (id_mantencion_usuario , id_usuario)
    
    ,
  CONSTRAINT fk_mantencion_usuario_hecha_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )

;

CREATE INDEX fk_mantencion_usuario_hecha_mantencion_usuario1_idx ON mantencion_usuario_hecha (id_mantencion_usuario ASC, id_usuario ASC);

CREATE INDEX fk_mantencion_usuario_hecha_vehiculo1_idx ON mantencion_usuario_hecha (id_vehiculo ASC, id_usuario ASC);







CREATE TABLE IF NOT EXISTS parametro (
  id_parametro BIGINT(20) NOT NULL,
  llave VARCHAR(64) NOT NULL,
  valor TEXT NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_parametro))

;

CREATE UNIQUE INDEX index2 ON parametro (llave ASC);







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
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_recordatorio, id_usuario),
  CONSTRAINT fk_recordatorio_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )

;

CREATE INDEX fk_recordatorio_vehiculo1_idx ON recordatorio (id_vehiculo ASC, id_usuario ASC);







CREATE TABLE IF NOT EXISTS log (
  id_log BIGINT NOT NULL,
  id_usuario BIGINT(20) NOT NULL,
  latitud DOUBLE NOT NULL,
  longitud DOUBLE NOT NULL,
  data TEXT NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_usuario, id_log))

;

CREATE INDEX fk_log_usuario1_idx ON log (id_usuario ASC);







CREATE TABLE IF NOT EXISTS reparacion (
  id_reparacion BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  titulo VARCHAR(30) NOT NULL,
  descripcion TEXT NOT NULL,
  costo INT NULL,
  fecha DATE NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
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
  latitud DOUBLE NULL,
  longitud DOUBLE NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_carga_combustible, id_usuario),
  CONSTRAINT fk_rendimiento_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )

;

CREATE INDEX fk_rendimiento_vehiculo1_idx ON carga_combustible (id_vehiculo ASC, id_usuario ASC);







CREATE TABLE IF NOT EXISTS info_sincro (
  id_info_sincro INT NOT NULL,
  usuario_id_usuario BIGINT NOT NULL,
  sentido TINYINT NOT NULL,
  fecha DATETIME NOT NULL,
  PRIMARY KEY (id_info_sincro))

;

CREATE INDEX fk_info_sincro_usuario1_idx ON info_sincro (usuario_id_usuario ASC);







CREATE TABLE IF NOT EXISTS mantencion_base_hecha (
  id_mantencion_base_hecha INT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  id_mantencion_base BIGINT NOT NULL,
  km INT NULL,
  fecha DATE NULL,
  costo INT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_mantencion_base_hecha, id_usuario),
  CONSTRAINT fk_mantencion_base_hecha_mantencion_base1
    FOREIGN KEY (id_mantencion_base)
    REFERENCES mantencion_base (id_mantencion_base)
    
    ,
  CONSTRAINT fk_mantencion_base_hecha_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )

;

CREATE INDEX fk_mantencion_base_hecha_mantencion_base1_idx ON mantencion_base_hecha (id_mantencion_base ASC);

CREATE INDEX fk_mantencion_base_hecha_vehiculo1_idx ON mantencion_base_hecha (id_vehiculo ASC, id_usuario ASC);







CREATE TABLE IF NOT EXISTS cambio_revision (
  id_cambio_revision INT NOT NULL,
  id_cambio BIGINT NULL,
  id_revision BIGINT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_cambio_revision),
  CONSTRAINT fk_cambio_revision_mantencion_base1
    FOREIGN KEY (id_cambio)
    REFERENCES mantencion_base (id_mantencion_base)
    
    ,
  CONSTRAINT fk_cambio_revision_mantencion_base2
    FOREIGN KEY (id_revision)
    REFERENCES mantencion_base (id_mantencion_base)
    
    )

;

CREATE INDEX fk_cambio_revision_mantencion_base1_idx ON cambio_revision (id_cambio ASC);

CREATE INDEX fk_cambio_revision_mantencion_base2_idx ON cambio_revision (id_revision ASC);







CREATE TABLE IF NOT EXISTS alerta (
  id_alerta INT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  id_mantencion_base BIGINT NOT NULL,
  km INT NULL,
  fecha DATE NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_alerta),
  CONSTRAINT fk_mantencion_base_hecha_mantencion_base10
    FOREIGN KEY (id_mantencion_base)
    REFERENCES mantencion_base (id_mantencion_base)
    
    ,
  CONSTRAINT fk_mantencion_base_hecha_vehiculo10
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )

;

CREATE INDEX fk_alerta_mantencion_base_idx ON alerta (id_mantencion_base ASC);

CREATE INDEX fk_alerta_vehiculo_idx ON alerta (id_vehiculo ASC, id_usuario ASC);







CREATE TABLE IF NOT EXISTS cia_seguros (
  id_cia_seguros INT NOT NULL,
  nombre VARCHAR(256) NOT NULL,
  datos_anexos TEXT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_cia_seguros))

;







CREATE TABLE IF NOT EXISTS tipo_seguro (
  id_tipo_seguro INT NOT NULL,
  descripcion VARCHAR(16) NOT NULL,
  PRIMARY KEY (id_tipo_seguro))

;







CREATE TABLE IF NOT EXISTS seguro_vehiculo (
  id_seguro_vehiculo BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_cia_seguros INT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  id_tipo_seguro INT(11) NOT NULL,
  poliza TEXT NULL,
  observaciones TEXT NULL,
  fecha_vencimiento DATE NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  borrado BOOLEAN NOT NULL DEFAULT 'false',
  PRIMARY KEY (id_seguro_vehiculo, id_usuario),
  CONSTRAINT fk_seguro_vehiculo_cia_seguros1
    FOREIGN KEY (id_cia_seguros)
    REFERENCES cia_seguros (id_cia_seguros)
    
    ,
  CONSTRAINT fk_seguro_vehiculo_tipo_seguro1
    FOREIGN KEY (id_tipo_seguro)
    REFERENCES tipo_seguro (id_tipo_seguro)
    
    ,
  CONSTRAINT fk_seguro_vehiculo_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    )

;

CREATE INDEX fk_seguro_vehiculo_cia_seguros1_idx ON seguro_vehiculo (id_cia_seguros ASC);

CREATE INDEX fk_seguro_vehiculo_vehiculo1_idx ON seguro_vehiculo (id_vehiculo ASC, id_usuario ASC);

CREATE INDEX fk_seguro_vehiculo_tipo_seguro1_idx ON seguro_vehiculo (id_tipo_seguro ASC);







CREATE TABLE IF NOT EXISTS proveedor (
  id_proveedor INT NOT NULL,
  nombre VARCHAR(256) NULL,
  direccion VARCHAR(512) NULL,
  correo VARCHAR(128) NULL,
  telefono VARCHAR(128) NULL,
  latitud DOUBLE NULL,
  longitud DOUBLE NULL,
  existen_valores BOOLEAN NULL,
  valor_minimo FLOAT NULL,
  valor_maximo FLOAT NULL,
  detalle_html TEXT NULL,
  calificacion TINYINT NULL,
  url VARCHAR(256) NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_proveedor))

;







CREATE TABLE IF NOT EXISTS proveedor_mantencion_base (
  id_proveedor_mantencion_base INT NOT NULL,
  id_proveedor INT NOT NULL,
  id_mantencion_base BIGINT NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_proveedor_mantencion_base),
  CONSTRAINT fk_proveedor_mantencion_base_proveedor1
    FOREIGN KEY (id_proveedor)
    REFERENCES proveedor (id_proveedor)
    
    ,
  CONSTRAINT fk_proveedor_mantencion_base_mantencion_base1
    FOREIGN KEY (id_mantencion_base)
    REFERENCES mantencion_base (id_mantencion_base)
    
    )

;

CREATE INDEX fk_proveedor_mantencion_base_proveedor1_idx ON proveedor_mantencion_base (id_proveedor ASC);

CREATE INDEX fk_proveedor_mantencion_base_mantencion_base1_idx ON proveedor_mantencion_base (id_mantencion_base ASC);







CREATE TABLE IF NOT EXISTS consulta_proveedor (
  id_consulta_proveedor INT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_mantencion_base BIGINT NOT NULL,
  latitud DOUBLE NULL,
  longitud DOUBLE NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_consulta_proveedor),
  CONSTRAINT fk_consulta_proveedor_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    ,
  CONSTRAINT fk_consulta_proveedor_mantencion_base1
    FOREIGN KEY (id_mantencion_base)
    REFERENCES mantencion_base (id_mantencion_base)
    
    )

;

CREATE INDEX fk_consulta_proveedor_vehiculo1_idx ON consulta_proveedor (id_vehiculo ASC, id_usuario ASC);

CREATE INDEX fk_consulta_proveedor_mantencion_base1_idx ON consulta_proveedor (id_mantencion_base ASC);







CREATE TABLE IF NOT EXISTS respuesta_proveedor (
  id_respuesta_proveedor INT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_proveedor INT NOT NULL,
  id_consulta_proveedor INT NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_respuesta_proveedor),
  CONSTRAINT fk_respuesta_proveedor_vehiculo1
    FOREIGN KEY (id_vehiculo , id_usuario)
    REFERENCES vehiculo (id_vehiculo , id_usuario)
    
    ,
  CONSTRAINT fk_respuesta_proveedor_proveedor1
    FOREIGN KEY (id_proveedor)
    REFERENCES proveedor (id_proveedor)
    
    ,
  CONSTRAINT fk_respuesta_proveedor_consulta_proveedor1
    FOREIGN KEY (id_consulta_proveedor)
    REFERENCES consulta_proveedor (id_consulta_proveedor)
    
    )

;

CREATE INDEX fk_respuesta_proveedor_vehiculo1_idx ON respuesta_proveedor (id_vehiculo ASC, id_usuario ASC);

CREATE INDEX fk_respuesta_proveedor_proveedor1_idx ON respuesta_proveedor (id_proveedor ASC);

CREATE INDEX fk_respuesta_proveedor_consulta_proveedor1_idx ON respuesta_proveedor (id_consulta_proveedor ASC);







CREATE TABLE IF NOT EXISTS campania (
  id_campania INT NOT NULL,
  descripcion VARCHAR(64) NOT NULL,
  activa BOOLEAN NOT NULL DEFAULT 'false',
  condicion TEXT NULL,
  detalle TEXT NOT NULL,
  fecha_inicio DATE NULL,
  fecha_fin DATE NULL,
  periodicidad SMALLINT NULL,
  numero_impresiones SMALLINT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_campania))

;







CREATE TABLE IF NOT EXISTS campania_usuario (
  id_campania_usuario BIGINT NOT NULL,
  id_campania INT NOT NULL,
  id_usuario BIGINT NOT NULL,
  fecha_modificacion TIMESTAMP NOT NULL DEFAULT (datetime('now', 'localtime')),
  PRIMARY KEY (id_campania_usuario),
  CONSTRAINT fk_campania_usuario_campania1
    FOREIGN KEY (id_campania)
    REFERENCES campania (id_campania)
    
    ,
  CONSTRAINT fk_campania_usuario_usuario1
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario)
    
    )

;

CREATE INDEX fk_campania_usuario_campania1_idx ON campania_usuario (id_campania ASC);

CREATE INDEX fk_campania_usuario_usuario1_idx ON campania_usuario (id_usuario ASC);









CREATE  OR REPLACE VIEW vw_campania_usuario AS
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











INSERT INTO red_social (id_red_social, red_social, fecha_modificacion) VALUES (1, 'facebook', '2014-01-01 12:00:00');
INSERT INTO red_social (id_red_social, red_social, fecha_modificacion) VALUES (0, 'default', '2015-03-01 12:00:00');









INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (1, 'GASOLINA', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (2, 'DIESEL', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (3, 'GAS GLP', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (4, 'GAS GNC', '2014-01-01 12:00:00');
INSERT INTO combustible (id_combustible, descripcion, fecha_modificacion) VALUES (5, 'ELECTRICO', '2014-01-01 12:00:00');









INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (1, 'MANUAL', '2014-01-01 12:00:00');
INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (2, 'AUTOMATICA', '2014-01-01 12:00:00');
INSERT INTO tipo_transmision (id_tipo_transmision, descripcion, fecha_modificacion) VALUES (3, 'SEMI AUTOMATICA', '2014-01-01 12:00:00');









INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (1, 'DOBLE TRACCION PERMAMENTE (AWD)', '2014-01-01 12:00:00');
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (2, 'TRACCION DELANTERA', '2014-01-01 12:00:00');
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (3, 'DOBLE TRACCION NO PERMAMENTE (4WD)', '2014-01-01 12:00:00');
INSERT INTO traccion (id_traccion, descripcion, fecha_modificacion) VALUES (4, 'TRACCION TRASERA', '2014-01-01 12:00:00');









INSERT INTO tipo_seguro (id_tipo_seguro, descripcion) VALUES (1, 'SOAP');
INSERT INTO tipo_seguro (id_tipo_seguro, descripcion) VALUES (2, 'GENERAL');



  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'pais'
  CREATE TRIGGER actualiza_pais
  BEFORE UPDATE OF
    pais
  ON pais FOR EACH ROW
  BEGIN
    UPDATE pais
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_pais = NEW.id_pais;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'region'
  CREATE TRIGGER actualiza_region
  BEFORE UPDATE OF
    region,
    id_pais
  ON region FOR EACH ROW
  BEGIN
    UPDATE region
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_region = NEW.id_region;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'comuna'
  CREATE TRIGGER actualiza_comuna
  BEFORE UPDATE OF
    id_region,
    comuna
  ON comuna FOR EACH ROW
  BEGIN
    UPDATE comuna
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_comuna = NEW.id_comuna;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'tipo_vehiculo'
  CREATE TRIGGER actualiza_tipo_vehiculo
  BEFORE UPDATE OF
    descripcion
  ON tipo_vehiculo FOR EACH ROW
  BEGIN
    UPDATE tipo_vehiculo
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_tipo_vehiculo = NEW.id_tipo_vehiculo;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'marca'
  CREATE TRIGGER actualiza_marca
  BEFORE UPDATE OF
    id_tipo_vehiculo,
    id_pais,
    descripcion
  ON marca FOR EACH ROW
  BEGIN
    UPDATE marca
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_marca = NEW.id_marca;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'modelo'
  CREATE TRIGGER actualiza_modelo
  BEFORE UPDATE OF
    descripcion,
    id_marca
  ON modelo FOR EACH ROW
  BEGIN
    UPDATE modelo
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_modelo = NEW.id_modelo;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'red_social'
  CREATE TRIGGER actualiza_red_social
  BEFORE UPDATE OF
    red_social
  ON red_social FOR EACH ROW
  BEGIN
    UPDATE red_social
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_red_social = NEW.id_red_social;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'usuario'
  CREATE TRIGGER actualiza_usuario
  AFTER UPDATE OF
    nombre,
    fecha_vencimiento_licencia,
    hombre,
    id_comuna,
    borrado,
    telefono,
    correo,
    fecha_nacimiento
  ON usuario FOR EACH ROW
  BEGIN
    UPDATE usuario
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'combustible'
  CREATE TRIGGER actualiza_combustible
  BEFORE UPDATE OF
    descripcion
  ON combustible FOR EACH ROW
  BEGIN
    UPDATE combustible
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_combustible = NEW.id_combustible;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'tipo_transmision'
  CREATE TRIGGER actualiza_tipo_transmision
  BEFORE UPDATE OF
    descripcion
  ON tipo_transmision FOR EACH ROW
  BEGIN
    UPDATE tipo_transmision
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_tipo_transmision = NEW.id_tipo_transmision;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'traccion'
  CREATE TRIGGER actualiza_traccion
  BEFORE UPDATE OF
    descripcion
  ON traccion FOR EACH ROW
  BEGIN
    UPDATE traccion
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_traccion = NEW.id_traccion;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'vehiculo'
  CREATE TRIGGER actualiza_vehiculo
  BEFORE UPDATE OF
    anio,
    km_calibrados,
    km_anuales,
    aire_acondicionado,
    alias,
    borrado,
    fecha_ultimo_km,
    id_traccion,
    km,
    alza_vidrios,
    fecha_ultima_calibracion,
    patente,
    id_modelo,
    id_tipo_transmision,
    id_combustible
  ON vehiculo FOR EACH ROW
  BEGIN
    UPDATE vehiculo
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_vehiculo = NEW.id_vehiculo;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'autenticacion'
  CREATE TRIGGER actualiza_autenticacion
  BEFORE UPDATE OF
    fecha,
    id_red_social,
    token,
    id_usuario
  ON autenticacion FOR EACH ROW
  BEGIN
    UPDATE autenticacion
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_autenticacion = NEW.id_autenticacion;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_base'
  CREATE TRIGGER actualiza_mantencion_base
  BEFORE UPDATE OF
    combustible,
    km_entre_mantenciones,
    meses_entre_mantenciones,
    depende_km,
    accion,
    url,
    nombre,
    descripcion_item,
    traccion,
    beneficios
  ON mantencion_base FOR EACH ROW
  BEGIN
    UPDATE mantencion_base
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_mantencion_base = NEW.id_mantencion_base;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_pospuesta'
  CREATE TRIGGER actualiza_mantencion_pospuesta
  BEFORE UPDATE OF
    fecha,
    borrado,
    km,
    id_mantencion_base,
    id_vehiculo
  ON mantencion_pospuesta FOR EACH ROW
  BEGIN
    UPDATE mantencion_pospuesta
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_mantencion_pospuesta = NEW.id_mantencion_pospuesta;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_usuario'
  CREATE TRIGGER actualiza_mantencion_usuario
  BEFORE UPDATE OF
    borrado,
    descripcion,
    km_entre_mantenciones,
    meses_entre_mantenciones,
    depende_km,
    url,
    nombre,
    beneficios
  ON mantencion_usuario FOR EACH ROW
  BEGIN
    UPDATE mantencion_usuario
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_mantencion_usuario = NEW.id_mantencion_usuario;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_usuario_hecha'
  CREATE TRIGGER actualiza_mantencion_usuario_hecha
  BEFORE UPDATE OF
    fecha,
    borrado,
    id_mantencion_usuario,
    costo,
    km,
    id_vehiculo
  ON mantencion_usuario_hecha FOR EACH ROW
  BEGIN
    UPDATE mantencion_usuario_hecha
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_mantencion_usuario_hecha = NEW.id_mantencion_usuario_hecha;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'parametro'
  CREATE TRIGGER actualiza_parametro
  BEFORE UPDATE OF
    valor,
    llave
  ON parametro FOR EACH ROW
  BEGIN
    UPDATE parametro
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_parametro = NEW.id_parametro;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'recordatorio'
  CREATE TRIGGER actualiza_recordatorio
  BEFORE UPDATE OF
    fecha,
    borrado,
    descripcion,
    recordar_km,
    km,
    recordar_fecha,
    titulo,
    id_vehiculo
  ON recordatorio FOR EACH ROW
  BEGIN
    UPDATE recordatorio
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_recordatorio = NEW.id_recordatorio AND
    id_usuario = NEW.id_usuario;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'log'
  CREATE TRIGGER actualiza_log
  BEFORE UPDATE OF
    borrado,
    data,
    latitud,
    longitud
  ON log FOR EACH ROW
  BEGIN
    UPDATE log
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_log = NEW.id_log;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'reparacion'
  CREATE TRIGGER actualiza_reparacion
  BEFORE UPDATE OF
    fecha,
    borrado,
    descripcion,
    costo,
    titulo,
    id_vehiculo
  ON reparacion FOR EACH ROW
  BEGIN
    UPDATE reparacion
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_reparacion = NEW.id_reparacion;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'carga_combustible'
  CREATE TRIGGER actualiza_carga_combustible
  BEFORE UPDATE OF
    estanque_lleno,
    fecha,
    borrado,
    costo,
    km,
    litros,
    id_vehiculo,
    latitud,
    longitud
  ON carga_combustible FOR EACH ROW
  BEGIN
    UPDATE carga_combustible
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_carga_combustible = NEW.id_carga_combustible;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'mantencion_base_hecha'
  CREATE TRIGGER actualiza_mantencion_base_hecha
  BEFORE UPDATE OF
    fecha,
    borrado,
    costo,
    km,
    id_mantencion_base,
    id_vehiculo
  ON mantencion_base_hecha FOR EACH ROW
  BEGIN
    UPDATE mantencion_base_hecha
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_mantencion_base_hecha = NEW.id_mantencion_base_hecha;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'cambio_revision'
  CREATE TRIGGER actualiza_cambio_revision
  BEFORE UPDATE OF
    id_cambio,
    id_revision
  ON cambio_revision FOR EACH ROW
  BEGIN
    UPDATE cambio_revision
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_cambio_revision = NEW.id_cambio_revision;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'cia_seguros'
  CREATE TRIGGER actualiza_cia_seguros
  BEFORE UPDATE OF
    datos_anexos,
    nombre
  ON cia_seguros FOR EACH ROW
  BEGIN
    UPDATE cia_seguros
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_cia_seguros = NEW.id_cia_seguros;
  END;

  -- actualiza 'fecha_modificacion' al actualizar cualquier columna de 'seguro_vehiculo'
  CREATE TRIGGER actualiza_seguro_vehiculo
  BEFORE UPDATE OF
    id_cia_seguros,
    poliza,
    borrado,
    observaciones,
    fecha_vencimiento,
    id_vehiculo,
    id_tipo_seguro
  ON seguro_vehiculo FOR EACH ROW
  BEGIN
    UPDATE seguro_vehiculo
    SET fecha_modificacion = datetime('now', 'localtime')
    WHERE
    id_usuario = NEW.id_usuario AND
    id_seguro_vehiculo = NEW.id_seguro_vehiculo;
  END;

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

    UPDATE mantencion_base_hecha SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE mantencion_usuario_hecha SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;

    UPDATE carga_combustible SET borrado = 'true' 
    WHERE id_vehiculo = NEW.id_vehiculo 
    AND id_usuario = NEW.id_usuario;
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





CREATE TABLE vw_campania_usuario
(
  id BIGINT, 
  id_usuario BIGINT, 
  fecha_inicio DATE, 
  fecha_fin DATE, 
  periodicidad SMALLINT, 
  numero_impresiones SMALLINT, 
  detalle TEXT, 
  fecha_modificacion DATETIME,
  PRIMARY KEY(id)
);
INSERT INTO pais (id_pais, pais) VALUES 
(56, 'Chile');


INSERT INTO region (id_region, id_pais, region) VALUES 
(1, 56, 'De Tarapacá'),
(2, 56, 'Antofagasta'),
(3, 56, 'Atacama'),
(4, 56, 'Coquimbo'),
(5, 56, 'De Valparaíso'),
(6, 56, 'Del Lib. Bernardo O''Higgins'),
(7, 56, 'Del Maule'),
(8, 56, 'Del Bío  Bío'),
(9, 56, 'De La Araucanía'),
(10, 56, 'De Los Lagos'),
(11, 56, 'Aysén'),
(12, 56, 'De Magallanes y La Antártica Chilena'),
(13, 56, 'Metropolitana'),
(14, 56, 'De Los Ríos'),
(15, 56, 'Arica y Parinacota');


INSERT INTO comuna (id_comuna, id_region, comuna) VALUES 
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
INSERT INTO tipo_vehiculo VALUES (1,'AUTOMOVIL-CAMIONETA-','2015-05-18 01:26:41');
INSERT INTO tipo_vehiculo VALUES (2,'MOTO','2015-05-18 01:26:41');
INSERT INTO marca VALUES (1,1,56,'ACADIAN','2015-05-18 01:26:41');
INSERT INTO marca VALUES (2,1,56,'ACURA','2015-05-18 01:26:41');
INSERT INTO marca VALUES (3,1,56,'ALFA ROMEO','2015-05-18 01:26:41');
INSERT INTO marca VALUES (4,1,56,'AMERICAN MOTORS','2015-05-18 01:26:41');
INSERT INTO marca VALUES (6,1,56,'ARO','2015-05-18 01:26:41');
INSERT INTO marca VALUES (7,1,56,'ASIA MOTORS','2015-05-18 01:26:41');
INSERT INTO marca VALUES (8,1,56,'ASTON MARTIN','2015-05-18 01:26:41');
INSERT INTO marca VALUES (9,1,56,'AUDI','2015-05-18 01:26:41');
INSERT INTO marca VALUES (10,1,56,'AUSTIN','2015-05-18 01:26:41');
INSERT INTO marca VALUES (11,1,56,'AUTORRAD','2015-05-18 01:26:41');
INSERT INTO marca VALUES (14,1,56,'BEIGING','2015-05-18 01:26:41');
INSERT INTO marca VALUES (20,1,56,'BMW','2015-05-18 01:26:41');
INSERT INTO marca VALUES (22,1,56,'BRILLIANCE','2015-05-18 01:26:41');
INSERT INTO marca VALUES (24,1,56,'BUICK','2015-05-18 01:26:42');
INSERT INTO marca VALUES (26,1,56,'BYD','2015-05-18 01:26:42');
INSERT INTO marca VALUES (27,1,56,'CADILLAC','2015-05-18 01:26:42');
INSERT INTO marca VALUES (30,1,56,'CHANGAN','2015-05-18 01:26:42');
INSERT INTO marca VALUES (31,1,56,'CHANGHE','2015-05-18 01:26:42');
INSERT INTO marca VALUES (32,1,56,'CHERY','2015-05-18 01:26:42');
INSERT INTO marca VALUES (33,1,56,'CHEVROLET','2015-05-18 01:26:42');
INSERT INTO marca VALUES (34,1,56,'CHRYSLER','2015-05-18 01:26:42');
INSERT INTO marca VALUES (35,1,56,'CITROEN','2015-05-18 01:26:42');
INSERT INTO marca VALUES (36,1,56,'COMMER','2015-05-18 01:26:42');
INSERT INTO marca VALUES (37,1,56,'DACIA','2015-05-18 01:26:42');
INSERT INTO marca VALUES (39,1,56,'DAEWOO','2015-05-18 01:26:42');
INSERT INTO marca VALUES (40,1,56,'DAIHATSU','2015-05-18 01:26:42');
INSERT INTO marca VALUES (41,1,56,'DATSUN','2015-05-18 01:26:42');
INSERT INTO marca VALUES (43,1,56,'DODGE','2015-05-18 01:26:42');
INSERT INTO marca VALUES (44,1,56,'DONGFENG','2015-05-18 01:26:42');
INSERT INTO marca VALUES (49,1,56,'F.S.O.','2015-05-18 01:26:42');
INSERT INTO marca VALUES (50,1,56,'FERRARI','2015-05-18 01:26:42');
INSERT INTO marca VALUES (51,1,56,'FIAT','2015-05-18 01:26:42');
INSERT INTO marca VALUES (53,1,56,'FORD','2015-05-18 01:26:42');
INSERT INTO marca VALUES (54,1,56,'FOTON','2015-05-18 01:26:42');
INSERT INTO marca VALUES (57,1,56,'G.M.C.','2015-05-18 01:26:42');
INSERT INTO marca VALUES (58,1,56,'GAC GONOW','2015-05-18 01:26:42');
INSERT INTO marca VALUES (60,1,56,'GEELY','2015-05-18 01:26:42');
INSERT INTO marca VALUES (62,1,56,'GREAT WALL','2015-05-18 01:26:42');
INSERT INTO marca VALUES (64,1,56,'HAFEI','2015-05-18 01:26:42');
INSERT INTO marca VALUES (65,1,56,'HAIMA','2015-05-18 01:26:42');
INSERT INTO marca VALUES (71,1,56,'HILLMAN','2015-05-18 01:26:42');
INSERT INTO marca VALUES (72,1,56,'HONDA','2015-05-18 01:26:42');
INSERT INTO marca VALUES (76,1,56,'HYUNDAI','2015-05-18 01:26:42');
INSERT INTO marca VALUES (78,1,56,'INFINITI','2015-05-18 01:26:43');
INSERT INTO marca VALUES (79,1,56,'INTERNATIONAL','2015-05-18 01:26:43');
INSERT INTO marca VALUES (80,1,56,'ISUZU','2015-05-18 01:26:43');
INSERT INTO marca VALUES (81,1,56,'JAC','2015-05-18 01:26:43');
INSERT INTO marca VALUES (82,1,56,'JAGUAR','2015-05-18 01:26:43');
INSERT INTO marca VALUES (84,1,56,'JEEP','2015-05-18 01:26:43');
INSERT INTO marca VALUES (86,1,56,'JINBEI','2015-05-18 01:26:43');
INSERT INTO marca VALUES (87,1,56,'JMC','2015-05-18 01:26:43');
INSERT INTO marca VALUES (91,1,56,'KIA MOTORS','2015-05-18 01:26:43');
INSERT INTO marca VALUES (95,1,56,'LADA','2015-05-18 01:26:43');
INSERT INTO marca VALUES (97,1,56,'LANCIA','2015-05-18 01:26:43');
INSERT INTO marca VALUES (98,1,56,'LAND ROVER','2015-05-18 01:26:43');
INSERT INTO marca VALUES (99,1,56,'LANDWIND','2015-05-18 01:26:43');
INSERT INTO marca VALUES (100,1,56,'LEXUS','2015-05-18 01:26:43');
INSERT INTO marca VALUES (101,1,56,'LIFAN','2015-05-18 01:26:43');
INSERT INTO marca VALUES (102,1,56,'LINCOLN','2015-05-18 01:26:43');
INSERT INTO marca VALUES (105,1,56,'LOTUS','2015-05-18 01:26:43');
INSERT INTO marca VALUES (107,1,56,'MAHINDRA','2015-05-18 01:26:43');
INSERT INTO marca VALUES (109,1,56,'MASERATI','2015-05-18 01:26:43');
INSERT INTO marca VALUES (110,1,56,'MAZDA','2015-05-18 01:26:43');
INSERT INTO marca VALUES (111,1,56,'MCLAREN','2015-05-18 01:26:43');
INSERT INTO marca VALUES (112,1,56,'MERCEDES BENZ','2015-05-18 01:26:43');
INSERT INTO marca VALUES (113,1,56,'MERCURY','2015-05-18 01:26:43');
INSERT INTO marca VALUES (114,1,56,'MG','2015-05-18 01:26:43');
INSERT INTO marca VALUES (115,1,56,'MINI','2015-05-18 01:26:43');
INSERT INTO marca VALUES (116,1,56,'MITSUBISHI','2015-05-18 01:26:43');
INSERT INTO marca VALUES (119,1,56,'MORGAN','2015-05-18 01:26:43');
INSERT INTO marca VALUES (120,1,56,'MORRIS','2015-05-18 01:26:43');
INSERT INTO marca VALUES (125,1,56,'NISSAN','2015-05-18 01:26:43');
INSERT INTO marca VALUES (126,1,56,'NSU','2015-05-18 01:26:43');
INSERT INTO marca VALUES (128,1,56,'OLDSMOBILE','2015-05-18 01:26:44');
INSERT INTO marca VALUES (129,1,56,'OPEL','2015-05-18 01:26:44');
INSERT INTO marca VALUES (131,1,56,'PEUGEOT','2015-05-18 01:26:44');
INSERT INTO marca VALUES (135,1,56,'PLYMOUTH','2015-05-18 01:26:44');
INSERT INTO marca VALUES (137,1,56,'POLSKI FIAT','2015-05-18 01:26:44');
INSERT INTO marca VALUES (138,1,56,'PONTIAC','2015-05-18 01:26:44');
INSERT INTO marca VALUES (139,1,56,'PORSCHE','2015-05-18 01:26:44');
INSERT INTO marca VALUES (140,1,56,'PROTON','2015-05-18 01:26:44');
INSERT INTO marca VALUES (141,1,56,'PUMA','2015-05-18 01:26:44');
INSERT INTO marca VALUES (143,1,56,'RENAULT','2015-05-18 01:26:44');
INSERT INTO marca VALUES (145,1,56,'ROLLS ROYCE','2015-05-18 01:26:44');
INSERT INTO marca VALUES (146,1,56,'ROVER','2015-05-18 01:26:44');
INSERT INTO marca VALUES (147,1,56,'SAAB','2015-05-18 01:26:44');
INSERT INTO marca VALUES (149,1,56,'SAEHAN','2015-05-18 01:26:44');
INSERT INTO marca VALUES (150,1,56,'SAMSUNG','2015-05-18 01:26:44');
INSERT INTO marca VALUES (151,1,56,'SANFU','2015-05-18 01:26:44');
INSERT INTO marca VALUES (155,1,56,'SEAT','2015-05-18 01:26:44');
INSERT INTO marca VALUES (156,1,56,'SG','2015-05-18 01:26:44');
INSERT INTO marca VALUES (158,1,56,'SIMCA','2015-05-18 01:26:44');
INSERT INTO marca VALUES (159,1,56,'SKODA','2015-05-18 01:26:44');
INSERT INTO marca VALUES (161,1,56,'SMA','2015-05-18 01:26:44');
INSERT INTO marca VALUES (163,1,56,'SSANGYONG','2015-05-18 01:26:44');
INSERT INTO marca VALUES (164,1,56,'SUBARU','2015-05-18 01:26:44');
INSERT INTO marca VALUES (165,1,56,'SUZUKI','2015-05-18 01:26:44');
INSERT INTO marca VALUES (167,1,56,'TATA','2015-05-18 01:26:44');
INSERT INTO marca VALUES (170,1,56,'TOYOTA','2015-05-18 01:26:44');
INSERT INTO marca VALUES (177,1,56,'VOLKSWAGEN','2015-05-18 01:26:44');
INSERT INTO marca VALUES (178,1,56,'VOLVO','2015-05-18 01:26:44');
INSERT INTO marca VALUES (180,1,56,'WILLYS','2015-05-18 01:26:44');
INSERT INTO marca VALUES (187,1,56,'YUGO','2015-05-18 01:26:45');
INSERT INTO marca VALUES (189,1,56,'ZASTAVA','2015-05-18 01:26:45');
INSERT INTO marca VALUES (192,1,56,'ZOTYE','2015-05-18 01:26:45');
INSERT INTO marca VALUES (194,1,56,'ZX','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10005,2,56,'APRILIA','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10012,2,56,'BAJAJ','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10013,2,56,'BASHAN','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10015,2,56,'BENELLI','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10016,2,56,'BENYI','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10017,2,56,'BENZHOU','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10018,2,56,'BIGFOOT','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10019,2,56,'BIMOTA','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10020,2,56,'BMW','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10021,2,56,'BOATIAN','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10023,2,56,'BUELL','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10025,2,56,'BULTACO','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10028,2,56,'CAGIVA','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10029,2,56,'CFMOTO','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10038,2,56,'DAELIM','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10042,2,56,'DAYUN','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10045,2,56,'DUCATI','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10046,2,56,'DUNNA','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10047,2,56,'DYNA','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10048,2,56,'EUROMOT','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10052,2,56,'FLSTF','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10055,2,56,'FOX','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10056,2,56,'FXA','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10059,2,56,'GARELLI','2015-05-18 01:26:45');
INSERT INTO marca VALUES (10061,2,56,'GILERA','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10063,2,56,'GUZZI','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10066,2,56,'HARLEY','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10067,2,56,'HARLEY-DAVIDSON','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10068,2,56,'HARTFORD','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10069,2,56,'HENSIM','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10070,2,56,'HERO-PUCH','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10072,2,56,'HONDA','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10073,2,56,'HUSABERG','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10074,2,56,'HUSQVARNA','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10075,2,56,'HYOSUNG','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10077,2,56,'INDIAN','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10083,2,56,'JAWA','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10085,2,56,'JIANSHE','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10088,2,56,'KAWASAKI','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10089,2,56,'KAYAK','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10090,2,56,'KEEWAY','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10092,2,56,'KINLON','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10093,2,56,'KTM','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10094,2,56,'KYMCO','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10096,2,56,'LAMBRETTA','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10098,2,56,'LAND ROVER','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10101,2,56,'LIFAN','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10103,2,56,'LML','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10104,2,56,'LONCIN','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10106,2,56,'LUOJIA','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10108,2,56,'MAICO','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10117,2,56,'MONTELLI','2015-05-18 01:26:46');
INSERT INTO marca VALUES (10118,2,56,'MONTESA','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10121,2,56,'MOTO BECANE','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10122,2,56,'MOTORRAD','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10123,2,56,'MSK','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10124,2,56,'MV AGUSTA','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10127,2,56,'ODES','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10130,2,56,'OSSA','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10132,2,56,'PGO','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10133,2,56,'PIAGGIO','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10134,2,56,'PIONNER','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10136,2,56,'POLARIS','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10142,2,56,'REGAL RAPTOR','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10144,2,56,'RIZATO','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10148,2,56,'SACHS','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10152,2,56,'SANLG','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10153,2,56,'SANYA','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10154,2,56,'SANYANG SYM','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10157,2,56,'SHINERAY','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10160,2,56,'SKYGO','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10162,2,56,'SPITZ','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10165,2,56,'SUZUKI','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10166,2,56,'TAKASAKI','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10168,2,56,'TM','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10169,2,56,'TORITO','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10171,2,56,'TRIUMPH','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10172,2,56,'TVS','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10173,2,56,'UNITED MOTORS','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10174,2,56,'URAL','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10175,2,56,'VERONA','2015-05-18 01:26:47');
INSERT INTO marca VALUES (10176,2,56,'VESPA','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10179,2,56,'WANGYE','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10181,2,56,'WOLKEN','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10182,2,56,'XGJAO','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10183,2,56,'XINGYUE','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10184,2,56,'XMOTORS','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10185,2,56,'YAMAHA','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10186,2,56,'YAMAMOTO','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10188,2,56,'ZANELLAS','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10190,2,56,'ZNEN GROUP','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10191,2,56,'ZONGSHEN','2015-05-18 01:26:48');
INSERT INTO marca VALUES (10193,2,56,'ZUNDAPP','2015-05-18 01:26:48');
INSERT INTO modelo VALUES (1,1,'BEAUMONT','2015-05-18 01:26:48');
INSERT INTO modelo VALUES (2,1,'SEDAN','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (10003,2,'INTEGRA','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (10004,2,'LEGEND','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20005,3,'145','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20006,3,'146','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20007,3,'147','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20008,3,'155','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20009,3,'156','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20010,3,'159','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20011,3,'164','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20012,3,'166','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20013,3,'ALFA_SPORTWAGON 2.0','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (20014,3,'ALFA33','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20015,3,'ALFA75','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20016,3,'ALFASUD','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20017,3,'ALFETTA','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20018,3,'BRERA','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20019,3,'GIULIETTA','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20020,3,'GT','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20021,3,'GTV','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20022,3,'MITO','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20023,3,'SEDAN','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20024,3,'SPIDER','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (20025,3,'SPRINT 1.5','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (30026,4,'CHEROKEE','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (30027,4,'CJ-8 4WD','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (30028,4,'COMANCHE','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (30029,4,'HORNET','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (30030,4,'LAREDO CJ-7 4WD','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (30031,4,'PACER SEDAN','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (30032,4,'RENEGADE 4WD','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (50048,6,'DACIA','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (50049,6,'STANDARD','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (60050,7,'COMBI','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (60051,7,'ROCSTA','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (60052,7,'TOPIC','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (60053,7,'TOWNER','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (70054,8,'DB9 COUPE','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (70055,8,'DBS','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (70056,8,'RAPIDE','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (70057,8,'VANTAGE','2015-05-18 01:26:49');
INSERT INTO modelo VALUES (70058,8,'VIRAGE','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80059,9,'100','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80060,9,'80','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80061,9,'90 QUATTRO','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80062,9,'A1','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (80063,9,'A3','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80064,9,'A4','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80065,9,'A5','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80066,9,'A6','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80067,9,'A7','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (80068,9,'A8','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80069,9,'ALLROAD','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80070,9,'CABRIOLET','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80071,9,'NUEVO A8 4.2 FSI Q','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80072,9,'Q3','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (80073,9,'Q5','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (80074,9,'Q7','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (80075,9,'R8','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80076,9,'RS3 SB 2.5 TFSI QUATTR','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (80077,9,'RS4','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80078,9,'RS5 4.2','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80079,9,'RS6','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80080,9,'RSQ3 2.5 TFSI QUATTRO STRO','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (80081,9,'S2','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80082,9,'S3','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80083,9,'S4','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80084,9,'S5','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80085,9,'S6','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80086,9,'S7 SB 4.0 TFSI QUATTRO','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (80087,9,'S8','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80088,9,'TT','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80089,9,'TTR','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80090,9,'TTRS','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80091,9,'TTS','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (80092,9,'W12','2015-05-18 01:26:50');
INSERT INTO modelo VALUES (90093,10,'500-KGS.','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (90094,10,'A-40','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (90095,10,'A-7','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (90096,10,'ALLEGRO','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (90097,10,'GT','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (90098,10,'METRO 1000 BASICO','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (90099,10,'MG','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (90100,10,'MINI','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (90101,10,'MODELO-1.100','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (100102,11,'CENTURY','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (100103,11,'OUTSIDER','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (100104,11,'RUDA D/C','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (130109,14,'BJ 212A 4WD','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (190127,20,'1.602 COUPE CLASICO','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190128,20,'114 I','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190129,20,'114I','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190130,20,'116','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190131,20,'118 I','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190132,20,'120','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190133,20,'125','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190134,20,'130','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190135,20,'135','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190136,20,'1602','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190137,20,'2002 COUPE','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190138,20,'220 I COUPE EXECUTIVE','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190139,20,'315','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190140,20,'316','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190141,20,'318','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190142,20,'320','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190143,20,'323','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190144,20,'325','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190145,20,'328','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190146,20,'330','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190147,20,'335','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190148,20,'420 I COUPE','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190149,20,'428 I','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190150,20,'435 I','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190151,20,'500','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190152,20,'518','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190153,20,'520','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190154,20,'523','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190155,20,'525','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190156,20,'528','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190157,20,'530','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190158,20,'535','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190159,20,'540 IA','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190160,20,'545 IA','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190161,20,'550','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190163,20,'628','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190164,20,'630','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190165,20,'633','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190166,20,'635','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190167,20,'640','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190168,20,'645','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190169,20,'650','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190170,20,'728','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190171,20,'730','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190172,20,'732','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190173,20,'733','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190174,20,'735','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190175,20,'740','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190176,20,'745','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190177,20,'750','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190178,20,'760','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190179,20,'ACTIVE HYBRID','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190185,20,'M COUPE','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190186,20,'M135 I','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190187,20,'M235 I COUPE','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190188,20,'M3','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (190189,20,'M4 COUPE','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (190190,20,'M5','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190191,20,'M6','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190196,20,'X1','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190197,20,'X3','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (190198,20,'X4 XDRIVE','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190199,20,'X5','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190200,20,'X6','2015-05-18 01:26:53');
INSERT INTO modelo VALUES (190201,20,'Z3','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (190202,20,'Z4','2015-05-18 01:26:52');
INSERT INTO modelo VALUES (210204,22,'EUPHORIA 1.6','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (210205,22,'FRV','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (210206,22,'FSV','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (210207,22,'H220 1.5MT HB','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (210208,22,'H230 1.5MT SD','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (210209,22,'SPLENDOR','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (210210,22,'V5','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (230221,24,'APOLLO','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230222,24,'CENTURY','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230223,24,'COMPACTO','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230224,24,'GRAN-SPORT','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230225,24,'LE-SABRE','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230226,24,'REGAL','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230227,24,'RIVIERA','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230228,24,'SKYHAW WAGON','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (230229,24,'SKYHAWK CUSTOM','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230230,24,'SKYLARK','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (230231,24,'SPORT-WAGON','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (250237,26,'F0','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (250238,26,'F3','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (250239,26,'F3-R','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (250240,26,'G3','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (250241,26,'NEW F3','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (250242,26,'NEW F3-R','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (250243,26,'S6','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (260244,27,'CALAIS','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (260245,27,'DE-VILLE','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (260246,27,'EL-DORADO','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (260247,27,'FLEETWOOD','2015-05-18 01:26:54');
INSERT INTO modelo VALUES (260248,27,'SEVILLE','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (290265,30,'BENNI','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (290266,30,'CM10','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (290267,30,'CM5','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (290268,30,'CS1','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (290269,30,'CS35','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (290270,30,'CV1','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (290271,30,'CV2','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (290272,30,'EADO','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (290273,30,'M201','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (290274,30,'MD201','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (290275,30,'S100','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (290276,30,'S200','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (290277,30,'S300','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (300278,31,'SPLA','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (310279,32,'A516','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (310280,32,'BEAT','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (310281,32,'DESTINY','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (310282,32,'FACE','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (310283,32,'FULWIN','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (310284,32,'IQ','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (310285,32,'NEW TIGGO 1.6 DVVT','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (310286,32,'S21','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (310287,32,'SKIN','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (310288,32,'TIGGO','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (320289,33,'1.300_KG','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (320290,33,'APACHE-10 500 KG','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (320291,33,'APACHE-20 750 KG','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (320292,33,'ASKA','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320293,33,'ASTRA','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320294,33,'ASTRO VAN','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (320295,33,'AVALANCHE','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320296,33,'AVEO','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320297,33,'B-10 500 KG','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320298,33,'B-20','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320299,33,'BEAUVILLE','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320300,33,'BEL-AIR','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320301,33,'BERETTA GTU','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320302,33,'BLAZER','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320303,33,'BYSCAINE','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320304,33,'C10','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320305,33,'C100 WORK TRUCK 2WD MT','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320306,33,'C-1500 WORK TRUCK','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320307,33,'C-20','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320308,33,'C-30 D/C','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320309,33,'CAMARO','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320310,33,'CAPRICE','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320311,33,'CAPTIVA','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (320312,33,'CARAVAN','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320313,33,'CAVALIER','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320314,33,'CELEBRITY','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320315,33,'CHEVELLE','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320316,33,'CHEVETTE','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320317,33,'CHEVY','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320318,33,'CHEYENNE','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320319,33,'CITATION','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320320,33,'COACHMAN','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (320321,33,'COLORADO','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (320322,33,'COMBO','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (320323,33,'COMODORE OPALA','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320324,33,'CORSA','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320325,33,'CORSICA','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320326,33,'CORVAIR','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320327,33,'CORVETTE','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320328,33,'CRUZE','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320329,33,'DIPLOMATA','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320330,33,'D-MAX','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320331,33,'EL_CAMINO CLASSIC 500 KG','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320332,33,'EPICA','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320333,33,'EQUINOX LS SU 5P 3.4','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (320334,33,'EXPRESS','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (320335,33,'GEMINI','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320336,33,'GRAND LUV','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320337,33,'HATCH 1400','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320338,33,'IMPALA','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320339,33,'LAGUNA','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320340,33,'LUMINA','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320341,33,'LUV','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (320342,33,'MALIBU','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320343,33,'MARAJO','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (320344,33,'MONTANA','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (320345,33,'MONTECARLO','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320346,33,'MONTEGO','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320347,33,'MONZA','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320348,33,'N300 MAX VAN 1.2 MT','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (320349,33,'NEW SPARK HB 1.2 MT','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320350,33,'OPALA','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320351,33,'OPTRA','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320352,33,'ORLANDO','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320353,33,'RECORD SPRINT','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (320354,33,'S/MODELO','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (320355,33,'S10','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (320356,33,'SAIL','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320357,33,'SCOTTDALE','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (320358,33,'SILVERADO','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (320359,33,'SONIC','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320360,33,'SPARK','2015-05-18 01:26:55');
INSERT INTO modelo VALUES (320361,33,'SPECTRUM','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320362,33,'SPORTVAN','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (320363,33,'SUBURBAN','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (320364,33,'SUBURBANO','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (320365,33,'TAHOE','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320366,33,'TRACKER 1.8','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320367,33,'TRAILBLAZER','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (320368,33,'TRAVERSE','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320369,33,'TROOPER','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (320370,33,'UPLANDER LS VAN','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320371,33,'VECTRA','2015-05-18 01:26:56');
INSERT INTO modelo VALUES (320372,33,'VEGA','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (320373,33,'VENTURE','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320374,33,'VERANEIRO','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (320375,33,'VIVANT LS MC 1.6 16V','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (320376,33,'WFR 2.0','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (320377,33,'ZAFIRA','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (330378,34,'150 GLS','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330379,34,'300','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330380,34,'CARAVAN','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (330381,34,'CHEROKEE','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (330382,34,'CORDOVA','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330383,34,'CROSS-FIRE (AUTOSTICK)','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330384,34,'GRAND','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (330385,34,'IMPERIAL','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330386,34,'LE-BARON','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330387,34,'NEON','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330388,34,'NEW CARAVAN','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (330389,34,'NEW SEBRING','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330390,34,'PACIFICA','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (330391,34,'PT','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330392,34,'SEBRING','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330393,34,'STRATUS','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330394,34,'TOWN-COUNTRY','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (330395,34,'VISION TSI 24 VALV.','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (330396,34,'WRANGLER','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (340397,35,'18-HP','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340398,35,'2CV6','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340399,35,'A.Z.U. 18 HP','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (340400,35,'ACADYANE','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (340401,35,'AK-6 33 HP','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (340402,35,'AMI-8','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340403,35,'AX','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340404,35,'BERLINGO','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (340405,35,'BX','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340406,35,'C-1','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340407,35,'C15','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (340408,35,'C-2','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340409,35,'C-3','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340410,35,'C-4','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340411,35,'C-5','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340412,35,'C-6','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340413,35,'C-AZAM','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340414,35,'C-ELYSEE','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340415,35,'CX','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340416,35,'DS 20','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340417,35,'DS3','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340418,35,'DS4','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340419,35,'DS5 THP 160','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340420,35,'DYANA','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (340421,35,'GRAND C-4 PICASSO','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340422,35,'GS','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340423,35,'GSA','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340424,35,'JUMPER','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (340425,35,'JUMPY HDI','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (340426,35,'L.N.A.','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340427,35,'MULTISPACE','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (340428,35,'NEMO','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (340429,35,'NUEVO C-3 SX PK 1.6','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340430,35,'NUEVO C-4 1.6','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340431,35,'REFLEX','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (340432,35,'SAXO','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340433,35,'SPACEVAN 1.4','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (340434,35,'VISA','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340435,35,'XANTIA','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340436,35,'XM','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340437,35,'XSARA','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (340438,35,'YAGAN','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (340439,35,'ZX','2015-05-18 01:26:57');
INSERT INTO modelo VALUES (350440,36,'350-KG','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (360441,37,'1.304 MIL KGS','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (360442,37,'1.410 TLX','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (360443,37,'10.4 4WD SERIE2','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (380449,39,'DAMAS','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (380450,39,'ESPERO','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380451,39,'HEAVEN','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380452,39,'KORANDO','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (380453,39,'LABO','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (380454,39,'LANOS','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (380455,39,'LEGANZA','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (380456,39,'MATIZ','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380457,39,'MUSSO','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (380458,39,'NEW POINTER','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380459,39,'NEXIA','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380460,39,'NUBIRA','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (380461,39,'POINTER 1.5','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380462,39,'PRINCE 2.0 LUJO','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380463,39,'RACER 1.5','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380464,39,'REZZO','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (380465,39,'SUPER-SALON 2.0','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (380466,39,'TICO HB','2015-05-18 01:26:58');
INSERT INTO modelo VALUES (390467,40,'55-WIDE VAN HIGH','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (390468,40,'APPLAUSE LTD','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390469,40,'CAB-VAN','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (390470,40,'CHARADE','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390471,40,'CHARMANT','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390472,40,'COPEN','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390473,40,'CUORE','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390474,40,'EXTOL BLIND VAN','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (390475,40,'FEROZA','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (390476,40,'GIRO','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390477,40,'GRAN-MOVE','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (390478,40,'HIJET','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (390479,40,'MAX-CUORE SEDAN','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390480,40,'MIRA','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390481,40,'NEW TERIOS','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (390482,40,'ROCKY','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (390483,40,'SIRION','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (390484,40,'SUPER-CUORE','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390485,40,'TAFT','2015-05-18 01:26:59');
INSERT INTO modelo VALUES (390486,40,'TERIOS','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (390487,40,'YRV','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400488,41,'100-A CHERRY','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400489,41,'120-A','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400490,41,'120-Y SUNNY','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400491,41,'130-A PULSAR','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400492,41,'140-J','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400493,41,'140-Y','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400494,41,'150-Y','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400495,41,'160-B SEDAN','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400496,41,'160-J','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400497,41,'180-B','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400498,41,'180-K SEDAN','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400499,41,'180-SX SILVIA','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400500,41,'200-SX SILVIA','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400501,41,'260-C','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400502,41,'260-Z SPORT','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400503,41,'280-ZX','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400504,41,'500-KG','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (400505,41,'B-210','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400506,41,'BLUEBIRD','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400507,41,'C/S-STD','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (400508,41,'C-20','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (400509,41,'CABINA_Y_MEDIA','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (400510,41,'CEDRIC','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400511,41,'CHASSIS-CORTO 1000 KG','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (400512,41,'CHASSIS-LARGO 1000 KG','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (400513,41,'CON-ESTACAS 1000 KG','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (400514,41,'D/C','2015-05-18 01:27:28');
INSERT INTO modelo VALUES (400515,41,'KING-CAB','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (400516,41,'LAUREL','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400517,41,'SEDAN','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (400518,41,'SUNNY','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (400519,41,'URVAN MINIBUS 15 ASIENTOS','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (400520,41,'VANETTE 1000 KG','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (420529,43,'500 A 750 KGS.','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (420530,43,'ARIES','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420531,43,'ASPEN','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420532,43,'CALIBER','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (420533,43,'CAMPING','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (420534,43,'CARAVAN','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (420535,43,'CHALLENGER','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (420536,43,'CHARGER','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (420537,43,'COLT','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420538,43,'CORONET','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420539,43,'CROWN','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420540,43,'DAKOTA','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (420541,43,'DART','2015-05-18 01:27:00');
INSERT INTO modelo VALUES (420542,43,'DURANGO','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (420543,43,'GALANT','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420544,43,'GRAND CARAVAN','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (420545,43,'JOURNEY','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (420546,43,'LANCER','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420547,43,'NEW RAM','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (420548,43,'NITRO','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (420549,43,'RAM','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (420550,43,'ROYAL','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (420551,43,'SEDAN','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420552,43,'SPORTMAN 12 ASIENTOS','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (420553,43,'SWINGER','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420554,43,'VALIANT SPORT','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (420555,43,'VAN LARGA','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (420556,43,'WAGONIER CARRY ALL','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (430557,44,'CARGO','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (430558,44,'DF','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (430559,44,'H30','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (430560,44,'JOYEAR','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (430561,44,'MINISTAR','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (430562,44,'MINITRUCK','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (430563,44,'MINIVAN','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (430564,44,'MULTIPROPOSITO','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (430565,44,'OTING 4X2','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (430566,44,'REFRITRUCK','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (430567,44,'RICH','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (430568,44,'S30','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (430569,44,'SUCCE','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (430570,44,'TRUCK','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (430571,44,'VAN','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (480599,49,'1.500-CC','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (480600,49,'125-P 750 KGS','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (480601,49,'POLONEZ','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (490602,50,'458','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (490603,50,'CALIFORNIA','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (490604,50,'F149 CALIFORNIA DCT','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (490605,50,'F360','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (490606,50,'F430','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (490607,50,'F599 F1','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (490608,50,'FERRARI CALIFORNIA (2 O 2+)','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (490609,50,'FF','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500610,51,'124 SPIEDER','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500611,51,'125','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500612,51,'126 PERSONAL','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500613,51,'128','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500614,51,'131','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500615,51,'132','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500616,51,'147','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500617,51,'500 L TREKKING','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500618,51,'600','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500619,51,'ARGENTA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500620,51,'BARCHETTA CONFORT 1.8','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500621,51,'BRAVA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500622,51,'BRAVO','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500623,51,'CINQUECENTO','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500624,51,'CITY','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (500625,51,'DIGIT 1.6','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500626,51,'DOBLO','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (500627,51,'DUCATO MAXI','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (500628,51,'DUNA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500629,51,'FIORINO','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (500630,51,'GRANDE PUNTO','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500631,51,'IDEA','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500632,51,'LINEA','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500633,51,'MAREA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500634,51,'NUEVA FIORINO FIRE','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (500635,51,'NVA STRADA','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (500636,51,'NVO PALIO','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500637,51,'OGGI','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500638,51,'PALIO','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500639,51,'PANDA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500640,51,'PANORAMA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500641,51,'PICK-UP','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (500642,51,'PREMIO SL','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500643,51,'PUNTO','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500644,51,'QUBO DYNAMIC 1.4','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500645,51,'REGATA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500646,51,'RITMO','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500647,51,'SIENA','2015-05-18 01:27:01');
INSERT INTO modelo VALUES (500648,51,'SILVER','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500649,51,'SPAZZIO TR E','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500650,51,'STILO','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500651,51,'STRADA','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (500652,51,'TEMPRA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500653,51,'TIPO','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500654,51,'UNO','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (500655,51,'WEEKEND TREKKING','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (500656,51,'X-1/9 BERTONE DEPORTIVO','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (520658,53,'12-M TRANSFORMADO','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (520659,53,'17-M TRANSFORMADO','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (520660,53,'750_KGS.','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (520661,53,'AEROSTAR','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (520662,53,'BELINA','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (520663,53,'BRONCO','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (520664,53,'CAPRI','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520665,53,'CONSUL','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520666,53,'CONTOUR','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520667,53,'CORCEL','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520668,53,'CORTINA','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520669,53,'COUNTRY','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (520670,53,'COURIER','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (520671,53,'CROWN_VICTOR.LX','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520672,53,'CUSTOM','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520673,53,'DEL_REY','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520674,53,'E-100 CARGO-VAN','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (520675,53,'E-150','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (520676,53,'E-250','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (520677,53,'E-350','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (520678,53,'ECONOLINE','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (520679,53,'ECOSPORT','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (520680,53,'EDGE','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (520681,53,'ESCAPE','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (520682,53,'ESCORT','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520683,53,'EUROESCORT','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520684,53,'EXPEDITION','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (520685,53,'EXPLORER','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (520686,53,'F-100','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (520687,53,'F-1000','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (520688,53,'F-150','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (520689,53,'F-250','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (520690,53,'F-350 XL','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (520691,53,'FAIRLAINE','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520692,53,'FAIRMONT','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520693,53,'FALCON','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520694,53,'FESTIVA XL 1.3','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520695,53,'FIESTA','2015-05-18 01:27:02');
INSERT INTO modelo VALUES (520696,53,'FOCUS','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520697,53,'FUSION SE','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520698,53,'FUTURA','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520699,53,'GALAXIE','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520700,53,'GRANADA','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520701,53,'HERITAGE','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520702,53,'KA','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520703,53,'LASER','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520704,53,'LTD','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520705,53,'MAVERICK','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520706,53,'MERCURY GRAND MARQUIS LS','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520707,53,'MONDEO','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520708,53,'MUSTANG','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520709,53,'NEW ESCAPE','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (520710,53,'NEW EXPLORER','2015-05-18 01:27:43');
INSERT INTO modelo VALUES (520711,53,'NEW FOCUS CLX','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520712,53,'PAMPA 500KG. 4WD','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (520713,53,'PINTO','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520714,53,'PREFECT','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520715,53,'PROBE','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520716,53,'RANCHERA','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (520717,53,'RANGER','2015-05-18 01:27:29');
INSERT INTO modelo VALUES (520718,53,'S/MODELOS','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (520719,53,'SIERRA','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520720,53,'SUPER_CLUB_WAGON','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (520721,53,'TAUNUS','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520722,53,'TAURUS','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520723,53,'TELSTAR','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520724,53,'TEMPO','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520725,53,'THUNDERBIRD','2015-05-18 01:27:03');
INSERT INTO modelo VALUES (520726,53,'TORINO','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (520727,53,'TRANSIT','2015-05-18 01:27:34');
INSERT INTO modelo VALUES (520728,53,'U-50','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (520729,53,'WINDSTAR','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (520730,53,'ZEPHIR','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (530731,54,'CARGO 2.2','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (530732,54,'ESCOLAR 2.2','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (530733,54,'MIDI','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (530734,54,'SUP','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (530735,54,'TERRACOTA','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (530736,54,'VIEW','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (560740,57,'BLAZER','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (560741,57,'CARRY-ALL','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (560742,57,'JIMMY 4WD','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (560743,57,'SAFARI','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (560744,57,'SIERRA','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (560745,57,'SPRINT','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (560746,57,'VANDURA 2.5','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (570747,58,'CARGO BOX','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (570748,58,'FURGON CARGO','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (570749,58,'GA5 2.0 AT ELITE','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (570750,58,'GS5 2.0','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (570751,58,'MINI VAN 7 PASAJEROS','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (570752,58,'WAY','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (590755,60,'08MK GL NUEVO','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (590756,60,'CK','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (590757,60,'EC 1.8','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (590758,60,'EX7 2.0 4X2','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (590759,60,'LC','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (590760,60,'MK','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (590761,60,'NEW CK','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (590762,60,'NEW MK 1.5 GL','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (590763,60,'SL 1.8 VVT','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (610767,62,'DEER','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (610768,62,'FLORID','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (610769,62,'HAVAL','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (610770,62,'HOVER','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (610771,62,'PERI','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (610772,62,'SAFE','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (610773,62,'SOCOOL','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (610774,62,'VOLEEX','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (610775,62,'WINGLE','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (630783,64,'FURGON CARGO','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (630784,64,'LOBO HATCHBACK 1.0 MEC','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (630785,64,'MINITRUCK','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (630786,64,'RUIYI','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (630787,64,'ZHONGYI','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (640788,65,'FSTAR CARGO VAN MT 1L','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (640789,65,'HAIMA','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (640790,65,'NEW HAIMA 3 SD','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (700887,71,'TRANSFORMADO','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (710891,72,'ACCORD','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (710892,72,'ACTY','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (710895,72,'BUGGI','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (710919,72,'CITY','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (710920,72,'CIVIC','2015-05-18 01:27:04');
INSERT INTO modelo VALUES (710938,72,'CR-V','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (710944,72,'FIT','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (710950,72,'HR-V','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (710952,72,'INTEGRA','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (710954,72,'LEGEND','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (710968,72,'ODYSSEY','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (710971,72,'PILOT','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (710972,72,'PRELUDE','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (710974,72,'QUINTET','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (710975,72,'RIDGELINE','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (710984,72,'STREAM','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (751085,76,'ACCENT','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751086,76,'ATOS','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751087,76,'AZERA','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751088,76,'COUNTY','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (751089,76,'COUPE','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751090,76,'ELANTRA','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751091,76,'ELW','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (751092,76,'EON 0.8','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (751093,76,'EQUUS','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751094,76,'EXCEL','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751095,76,'GALLOPER','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (751096,76,'GENESIS','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751097,76,'GETZ','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751098,76,'GRACE','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (751099,76,'GRAND SANTA FE NC','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (751100,76,'H-1','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (751101,76,'I-10','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751102,76,'I-30','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751103,76,'I-40 SW 2.0','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (751104,76,'MATRIX','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751105,76,'NEW CENTENNIAL 4.6 AT','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751106,76,'NEW COUPE','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751107,76,'NEW H-1','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (751108,76,'NEW TUCSON','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (751109,76,'PONY','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751110,76,'PORTER','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (751111,76,'SANTA FE','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (751112,76,'SANTAMO','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (751113,76,'SONATA','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751114,76,'STELLAR','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (751115,76,'TERRACAN','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (751116,76,'TRAJET','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (751117,76,'TUCSON','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (751118,76,'VELOSTER 1.6 GLS','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (751119,76,'VERACRUZ','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (751120,76,'XG','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (771122,78,'EX37','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (771123,78,'FX37','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (771124,78,'G','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (771125,78,'G25','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (771126,78,'G37','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (771127,78,'M37','2015-05-18 01:27:05');
INSERT INTO modelo VALUES (781128,79,'***S/MODELOS***','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (781129,79,'1.000-KGS.','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (781130,79,'750-KGS.','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (781131,79,'CARRY-ALL','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (781132,79,'CORTO','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (791133,80,'COUPE','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (791134,80,'RANCHERA','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (791135,80,'SEDAN','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (791136,80,'WFR','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (791137,80,'XS STYLUS 1.6 M','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (801138,81,'A0 1.0','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (801139,81,'A-137 1.3','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (801140,81,'BCLASS','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (801141,81,'REFINE','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (801142,81,'REIN','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (801143,81,'S5 2.0 4X2 6MT SE','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (801144,81,'SUNRAY','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (801145,81,'TRIP 1.8','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (811146,82,'9000 GRIFFIN','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811147,82,'DAIMLER','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811148,82,'F-TYPE','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811149,82,'SOVEREIGN 4.0','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811150,82,'S-TYPE','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811151,82,'XF','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811152,82,'XFR S 5.0 V8 S/C','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811153,82,'XJ','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811154,82,'XJ6','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811155,82,'XJ8','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811156,82,'XJR','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811157,82,'XJS','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811158,82,'XK','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811159,82,'XK8','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811160,82,'XKR','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (811161,82,'X-TYPE','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (831165,84,'CHEROKEE','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (831166,84,'COMMANDER','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (831167,84,'COMPASS','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (831168,84,'GRAND CHEROKEE','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (831169,84,'NEW CHEROKEE','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (831170,84,'NEW GRAND CHEROKEE','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (831171,84,'PATRIOT','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (831172,84,'WRANGLER','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (851179,86,'FURGON HAISE DSL 2P EIV','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (851180,86,'HAISE','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (851181,86,'HIGH ESCOLAR 19P EIV','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (851182,86,'MB HAISE DSL ABS 12P','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (861183,87,'BOARDING 2.8L','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (861184,87,'CARRYING','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (901280,91,'AVELLA','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (901281,91,'BESTA','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (901282,91,'BRISA','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (901283,91,'CADENZA 3.5 L','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901284,91,'CARENS','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901285,91,'CARNIVAL','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (901286,91,'CERATO','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901287,91,'CERES','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (901288,91,'CLARUS','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901289,91,'COMBI TURBO INT.','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (901290,91,'FAMILY-WAGON GL','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (901291,91,'FRONTIER','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (901292,91,'GRAND CARNIVAL','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (901293,91,'JOICE 2.0L','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901294,91,'K-2400','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (901295,91,'KOUP','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901296,91,'MAGENTIS','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901297,91,'MOHAVE EX','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (901298,91,'MORNING','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901299,91,'NEW CARENS','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (901300,91,'NEW CARNIVAL LX','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (901301,91,'NEW CERATO','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901302,91,'NEW SORENTO','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (901303,91,'OPIRUS','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901304,91,'OPTIMA','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901305,91,'PRIDE','2015-05-18 01:27:06');
INSERT INTO modelo VALUES (901306,91,'QUORIS SX 3.8 8AT','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901307,91,'RETONA','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (901308,91,'RIO','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901309,91,'SEPHIA','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901310,91,'SORENTO EX','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (901311,91,'SOUL','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901312,91,'SPECTRA 1.6 LS','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (901313,91,'SPORTAGE','2015-05-18 01:27:44');
INSERT INTO modelo VALUES (901314,91,'TOPIC 3V','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (901315,91,'TOWNER','2015-05-18 01:27:30');
INSERT INTO modelo VALUES (941410,95,'2104','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (941411,95,'21043','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (941412,95,'21044 I','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (941413,95,'2105 SEDAN','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941414,95,'21053','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941415,95,'2106 SEDAN','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941416,95,'21060 1.6 SEDAN','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941417,95,'2107','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941418,95,'21070 4 VEL','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941419,95,'21073 I','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (941420,95,'21074','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (941421,95,'21083','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941422,95,'2109 SAMARA HATCHBACK','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941423,95,'21093','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941424,95,'21099','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941425,95,'27150 FURGON','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (941426,95,'27151 CARGO','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (941427,95,'CHARLOTTE','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941428,95,'NIEVA 2121 CHARLOTTE','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (941429,95,'NIVA','2015-05-18 01:27:38');
INSERT INTO modelo VALUES (941430,95,'SAMARA','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (941431,95,'TAVRIA 1102 HATCHBACK','2015-05-18 01:27:07');
INSERT INTO modelo VALUES (961433,97,'APPIA','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961434,97,'DEDRA 2.0','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961435,97,'DELTA GT IE','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961436,97,'EXECUTIVE','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961437,97,'GAMA COUPE','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961438,97,'GEMMA BERLINA','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961439,97,'H-P EXECUTIVE 2000 IE','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961440,97,'KAPPA 3.0','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961441,97,'PRISMA','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961442,97,'THEMA','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (961443,97,'Y-10','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (971444,98,'CORTO','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (971445,98,'DEFENDER','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (971446,98,'DISCOVERY','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (971447,98,'EVOQUE','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (971448,98,'FREELANDER','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (971449,98,'LARGO','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (971450,98,'NEW DISCOVERY','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (971452,98,'RANGE ROVER','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (971453,98,'SANTANA DIESEL','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (981454,99,'SUV LUX 2.0 4X2','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (991455,100,'CT200F SPORTS','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991456,100,'CT200H HIBRIDO','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991457,100,'ES350','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (991458,100,'GS250','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991459,100,'GS300','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991460,100,'GS350','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991461,100,'GS350F SPORTS','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991462,100,'GS450 HIBRIDO','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991463,100,'GS460','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991464,100,'IS250','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991465,100,'IS350','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991466,100,'LS460','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991467,100,'LS600 HL HIBRIDO','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991468,100,'LX570','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (991469,100,'NEW IS250','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991470,100,'NEW IS300 HIBRIDO','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991471,100,'NEW IS350','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (991472,100,'RX350','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (991473,100,'RX450 H','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (991474,100,'SC430 CONVERTIBLE','2015-05-18 01:27:08');
INSERT INTO modelo VALUES (1001475,101,'320','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1001476,101,'520','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1001477,101,'530','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1001478,101,'620','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1001479,101,'CARGO','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (1001482,101,'TRUCK','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1001483,101,'VAN','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1001485,101,'X60 EX 1.8','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1011486,102,'CONTINENTAL','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1041504,105,'ELISE','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1041505,105,'EXIGE','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1061507,107,'GENIO PU','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1061508,107,'PIK-UP','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1061509,107,'SCORPIO SUV','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1061510,107,'XUV500','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1081513,109,'COUPE CAMBIOCORSA','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1081514,109,'GHIBLI','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1081515,109,'GRANCABRIO','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1081516,109,'GRANSPORT','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1081517,109,'GRANTURISMO','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1081518,109,'QUATTROPORTE','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1081519,109,'SPYDER CAMBIOCORSA','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091520,110,'1000_COACH','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1091521,110,'121 LX','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091522,110,'1600_COACH','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1091523,110,'2200_COACH','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1091524,110,'323','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091525,110,'616','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1091526,110,'626','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1091527,110,'808','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1091528,110,'929','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1091529,110,'ARTIS','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091530,110,'B2000','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091531,110,'B2200','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091532,110,'B2500','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091533,110,'B2600','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091534,110,'B2900','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091535,110,'BT-50','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091536,110,'CREW CAB 2.6','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091537,110,'CX-5','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1091538,110,'CX-7','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1091539,110,'CX-9','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1091540,110,'E1600','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091541,110,'E2000','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (1091542,110,'E2200','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091543,110,'F1000','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (1091544,110,'MAZDA2','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1091545,110,'MAZDA3','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091546,110,'MAZDA5','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091547,110,'MAZDA6','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091548,110,'MIATA','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091549,110,'MPV','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1091550,110,'MX-3 SPORT GLX','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091551,110,'MX-5','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091552,110,'MX-6 GLX','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091553,110,'NEW MAZDA3','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1091554,110,'NEW MAZDA6','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1091555,110,'RX-2','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091556,110,'RX-7 SPORT','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091557,110,'RX-8','2015-05-18 01:27:09');
INSERT INTO modelo VALUES (1091558,110,'S/MODELOS','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1091559,110,'TRIBUTE','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1101560,111,'MP4-12C COUPE V8 BITURBO','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1111561,112,'180','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111562,112,'190','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111563,112,'200','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111564,112,'206 1.245 KGS.','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1111565,112,'220','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111566,112,'230','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111567,112,'230/6','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111568,112,'240','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111569,112,'250','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111570,112,'260','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111571,112,'280','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111572,112,'300','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111573,112,'307 1700 KG','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1111574,112,'310 1700 KG','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1111575,112,'312 D SPRINTER','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1111576,112,'320','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111577,112,'350','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111578,112,'380','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111579,112,'409 2500 KG','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (1111580,112,'420','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111581,112,'450','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111582,112,'500','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1111583,112,'560','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1111584,112,'A160','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111585,112,'A170','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1111586,112,'A180 CDI','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1111587,112,'A200','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1111588,112,'A250 CGI AUTOMATICO','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111589,112,'A45 AMG','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111590,112,'B170','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111591,112,'B180','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1111592,112,'B200','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1111593,112,'C180','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111594,112,'C200','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1111595,112,'C220 CDI','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111596,112,'C230','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111597,112,'C240','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111598,112,'C250','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111599,112,'C280','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111600,112,'C300','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111601,112,'C320','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111602,112,'C350','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111603,112,'C55 AMG','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111604,112,'C63 AMG','2015-05-18 01:27:10');
INSERT INTO modelo VALUES (1111605,112,'CITAN 109 CDI 3.1 M3','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (1111606,112,'CL500','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111607,112,'CL600','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111608,112,'CL63 AMG','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111609,112,'CL65 AMG','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111610,112,'CLA180','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111611,112,'CLA200','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111612,112,'CLA220 CDI','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111613,112,'CLA250','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111614,112,'CLA45 AMG','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111615,112,'CLC180 K','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111616,112,'CLC200','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111617,112,'CLC350','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111618,112,'CLK280','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111619,112,'CLK320','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111620,112,'CLK350','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111621,112,'CLK430','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111622,112,'CLK500','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111623,112,'CLK63 AMG','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111624,112,'CLS350','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111625,112,'CLS500','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111626,112,'CLS55 AMG','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111627,112,'CLS63 AMG','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111628,112,'E200','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111629,112,'E220 CDI','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111630,112,'E240','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111631,112,'E250','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111632,112,'E280','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111633,112,'E300','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111634,112,'E320','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111635,112,'E350','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111636,112,'E400','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111637,112,'E430','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111638,112,'E500','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111639,112,'E55 AMG','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111640,112,'E63 AMG','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111641,112,'G270 CDI STATION','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1111642,112,'G320 CDI T','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1111643,112,'G350','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111644,112,'G500','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111645,112,'G55 AMG','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111646,112,'G63 AMG','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111647,112,'GL320 CDI','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111648,112,'GL350','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1111649,112,'GL450','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111650,112,'GL500','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111651,112,'GL63 AMG','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111652,112,'GLA 200','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111653,112,'GLA220 CDI 4MATIC','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111654,112,'GLA250 4MATIC','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111655,112,'GLK220 CDI','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111656,112,'GLK280','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111657,112,'GLK300','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1111658,112,'GLK350','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1111659,112,'MB100','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (1111660,112,'MB140','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (1111661,112,'MB180 2000 KG','2015-05-18 01:27:31');
INSERT INTO modelo VALUES (1111662,112,'ML250 BLUE TEC','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1111663,112,'ML270 CDI','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1111664,112,'ML300 CDI','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111665,112,'ML320','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1111666,112,'ML350','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1111667,112,'ML430','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1111668,112,'ML500','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1111669,112,'ML55 AMG','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1111670,112,'ML63 AMG','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111671,112,'R350','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111672,112,'R500','2015-05-18 01:27:45');
INSERT INTO modelo VALUES (1111673,112,'S320','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1111674,112,'S350','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111675,112,'S430','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111676,112,'S500','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111677,112,'S600','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111678,112,'S63 AMG','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111679,112,'S65 AMG LARGO','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111680,112,'SL350','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111681,112,'SL500','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111682,112,'SL55 AMG','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111683,112,'SL63 AMG','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111684,112,'SLK200','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111685,112,'SLK230 K','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111686,112,'SLK280','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111687,112,'SLK300','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111688,112,'SLK320','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1111689,112,'SLK350','2015-05-18 01:27:12');
INSERT INTO modelo VALUES (1111690,112,'SLK55 AMG','2015-05-18 01:27:13');
INSERT INTO modelo VALUES (1111691,112,'SLS','2015-05-18 01:27:11');
INSERT INTO modelo VALUES (1111692,112,'SPRINTER','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1111693,112,'VIANO','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1121694,113,'BOBCAT','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121695,113,'CAPRI','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121696,113,'COMET','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121697,113,'COUGAR','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121698,113,'GRAND-MARQUIS','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1121699,113,'HAT. LS','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121700,113,'LIFTGATE GS','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121701,113,'LYNX 1.6 WAGON','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1121702,113,'MARQUIS SEDAN','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121703,113,'MONARCH','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121704,113,'MONTEGO 390','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1121705,113,'SABLE 3.0','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1121706,113,'ZEPHIR','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131707,114,'550 1.8 DVVT','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131708,114,'DELUXE','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131709,114,'MG3 MT 1.5','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131710,114,'MG350','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131711,114,'MG5','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131712,114,'MG550','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131713,114,'MG6','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131714,114,'MG750 AT V6','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131715,114,'TF','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1131716,114,'ZT','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1141717,115,'CLUBMAN','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1141718,115,'COOPER','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1141719,115,'COUNTRYMAN COOPER','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1141720,115,'COUPE COOPER S','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1141721,115,'JCW','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1141722,115,'JOHN COOPER WORKS HB SV91','2015-05-18 01:27:14');
INSERT INTO modelo VALUES (1141723,115,'PACEMAN COOPER','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1141724,115,'ROADSTER COOPER S','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151725,116,'ASX','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1151726,116,'COLT','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151727,116,'ECLIPSE','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151728,116,'GALANT','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151729,116,'I-MIEV','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151730,116,'L100','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1151731,116,'L200','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1151732,116,'L300','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1151733,116,'LANCER','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151734,116,'MIRAGE','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151735,116,'MONTERO','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1151736,116,'NEW L200 D/C','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1151737,116,'NEW LANCER 2001','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151738,116,'NEW MONTERO SPORT G2','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1151739,116,'NEW OUTLANDER K2','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1151740,116,'OUTLANDER','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1151741,116,'SAPPORO','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1151742,116,'STARION COUPE TURBO','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1181755,119,'4 4 SPORT CONVERTIBLE','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1181756,119,'PLUS 4 4 SEATER','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1191757,120,'MARINA 575','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241828,125,'180-SGL COUPE','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241829,125,'180-SX SILVIA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241830,125,'200','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241831,125,'240 SX 2.4','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241832,125,'280 ZX','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241833,125,'300 ZX COUPE','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241834,125,'350Z COUPE','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241835,125,'370Z COUPE','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241836,125,'500-KG','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241837,125,'AD-WAGON','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1241838,125,'ALMERA','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241839,125,'ALTIMA','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241840,125,'BLUEBIRD','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241841,125,'C/S','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241842,125,'C-20','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1241843,125,'CABINA Y MEDIA','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241844,125,'CEDRIC 2.8','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241845,125,'CHASSIS-CORTO','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241846,125,'CHASSIS-LARGO','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241847,125,'CORTA STD','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241848,125,'D/C','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241849,125,'D21','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241850,125,'D22','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241851,125,'GXE LUXURY','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241852,125,'JUKE','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1241853,125,'KING-CAB','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241854,125,'LAUREL','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241855,125,'MARCH','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241856,125,'MAXIMA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241857,125,'MURANO SL','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1241858,125,'NAVARA','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241859,125,'NEW MURANO LE','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1241860,125,'NEW PATHFINDER','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1241861,125,'NINJA 1.6 TURBO','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241862,125,'NOTE','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241863,125,'NV350','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1241864,125,'PATHFINDER','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1241865,125,'PATROL','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1241866,125,'PLATINA','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241867,125,'PRAIRIE','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1241868,125,'PRIMERA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241869,125,'PULSAR','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241870,125,'QASHQAI','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1241871,125,'SENTRA','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241872,125,'SILVIA SX 2000 COUPE','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241873,125,'STANZA','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241874,125,'SUNNY','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241875,125,'TEANA','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241876,125,'TERRANO','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1241877,125,'TIIDA','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241878,125,'URVAN','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1241879,125,'V16','2015-05-18 01:27:15');
INSERT INTO modelo VALUES (1241880,125,'VANETTE','2015-05-18 01:27:35');
INSERT INTO modelo VALUES (1241881,125,'VERSA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1241882,125,'X-TRAIL','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1251883,126,'PRINZ','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1271887,128,'42','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1271888,128,'CUSTOM-CRUISER','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1271889,128,'CUTLASS','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1271890,128,'DELTA 88','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1271891,128,'NINETY-EIGHT','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1271892,128,'OMEGA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1271893,128,'STAR-FIRE','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1271894,128,'TORONADO','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1271895,128,'VISTA-CRUISSIER','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1281896,129,'ANTARA COSMO 2.2 DSL AWD','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1281897,129,'ASCONA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1281898,129,'ASTRA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1281899,129,'CALIBRA 20-I 16 VALV','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1281900,129,'CARAVAN 500 KGS.','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1281901,129,'CARAVAN-OLIMPIA TRANSFORM','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1281902,129,'CASCADA COSMO 1.6T AT6','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1281903,129,'COMBO','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1281904,129,'COMMODORE COUPE','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1281905,129,'CORSA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1281906,129,'INSIGNIA','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1281907,129,'KADDET','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1281908,129,'KADET-CARAVAN 2.0','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1281909,129,'KADETT','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1281910,129,'KAPITAN','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1281911,129,'MANTA','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1281912,129,'MERIVA','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1281913,129,'OLIMPIA 500 KGS','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1281914,129,'OMEGA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1281915,129,'REKORD','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1281916,129,'VECTRA','2015-05-18 01:27:16');
INSERT INTO modelo VALUES (1301918,131,'104 1.1','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301919,131,'106','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301920,131,'107','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301921,131,'2008','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1301922,131,'204','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301923,131,'205','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301924,131,'206','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301925,131,'207','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301926,131,'208','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301927,131,'3008','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301928,131,'301','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301929,131,'304','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301930,131,'305','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301931,131,'306','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301932,131,'307','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301933,131,'308','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301934,131,'309','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301935,131,'4008','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1301936,131,'404','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301937,131,'405','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301938,131,'406','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301939,131,'407','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301940,131,'5008','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1301941,131,'504','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301942,131,'505','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301943,131,'508','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301944,131,'604 SEDAN','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301945,131,'605','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301946,131,'607','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301947,131,'806','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301948,131,'BIPPER','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1301949,131,'BOXER','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1301950,131,'EXPERT','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1301951,131,'EXPERT MINIBUS ACTIVE HDI 9P','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1301952,131,'GRAN TEPEE 2.0 HDI 163HP','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1301953,131,'J-5 CARGA 1.300 KGS','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1301954,131,'NUEVO 607 HDI FAP','2015-05-18 01:27:17');
INSERT INTO modelo VALUES (1301955,131,'PARTNER','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1301956,131,'RCZ','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1301957,131,'TEPEE OUTDOOR','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1341973,135,'***S/MODELOS***','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1341974,135,'ACCLAIM LC','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1341975,135,'BELVEDERE','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1341976,135,'COLT-VISTA','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1341977,135,'DUSTER','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1341978,135,'FURY','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1341979,135,'GRAND VOYAGER','2015-05-18 01:27:46');
INSERT INTO modelo VALUES (1341980,135,'HORIZON','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1341981,135,'SATELITE CUSTOM','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1341982,135,'VALIANT','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1341983,135,'VOLARE','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1341984,135,'VOYAGER','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1362003,137,'125-P','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1362004,137,'POLONES','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372005,138,'ASTRE','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372006,138,'BONEVILLE','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372007,138,'CATALINA','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372008,138,'COUPE','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372009,138,'FIREBIRD','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372010,138,'G.T.O.','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372011,138,'GRAN-PRIX','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372012,138,'LE-MANS','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372013,138,'MINIVAN TRANSPORTED 9PJ','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1372014,138,'PHOENIX','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372015,138,'SUNBIRD','2015-05-18 01:27:18');
INSERT INTO modelo VALUES (1372016,138,'TEMPEST','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1372017,138,'TRANS-AM','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1372018,138,'VENTURA','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382019,139,'910','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382020,139,'911','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382021,139,'924','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382022,139,'BOXSTER','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382023,139,'CARRERA','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382024,139,'CAYENNE','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382025,139,'CAYMAN','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382026,139,'MACAN','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1382027,139,'PANAMERA','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1392028,140,'NATURA','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1392029,140,'PERSONA','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1392030,140,'SATRIA 1.6 XLI','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1402031,141,'GTE','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1402032,141,'GTS','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422040,143,'CLIO','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422041,143,'DUSTER','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422042,143,'ESPACE RXE','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1422043,143,'EXPRESS','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1422044,143,'FLORIDE','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422045,143,'FLUENCE','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422046,143,'FUEGO','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422047,143,'IKA TORINO','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422048,143,'KANGOO','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422049,143,'KOLEOS','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422050,143,'LAGUNA','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422051,143,'LATITUDE','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422052,143,'LOGAN SEDAN','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422053,143,'MEGANE','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422054,143,'R-1 TON.','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1422055,143,'R-11','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422056,143,'R-12','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422057,143,'R-18','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422058,143,'R-19','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422059,143,'R-21','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422060,143,'R-25 GTS','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422061,143,'R-30 TS','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422062,143,'R-4','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422063,143,'R-5','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422064,143,'R-6','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422065,143,'R-9','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422066,143,'SAFRANE','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422067,143,'SANDERO','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422068,143,'SCENIC','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1422069,143,'SYMBOL','2015-05-18 01:27:19');
INSERT INTO modelo VALUES (1422070,143,'TRAFIC','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1422071,143,'TWINGO','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1442074,145,'GHOST','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1442075,145,'PHANTOM','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1442076,145,'WRAITH','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452077,146,'200','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1452078,146,'214','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1452079,146,'216','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1452080,146,'220 COUPE TURBO','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1452081,146,'25','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1452082,146,'400 SEDAN 103 HP','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452083,146,'414','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452084,146,'416','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452085,146,'420 GSI 2.0 16V','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452086,146,'45','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1452087,146,'620 SI LUX','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452088,146,'623','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452089,146,'75','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1452090,146,'800 COUPE','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452091,146,'825','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452092,146,'827','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452093,146,'MG 1.8','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1452094,146,'MINI','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1452095,146,'SE','2015-05-18 01:27:20');
INSERT INTO modelo VALUES (1462096,147,'900','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1462097,147,'9000','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1462098,147,'9-3','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1462099,147,'9-5','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1462100,147,'9-7 X','2015-05-18 01:27:21');
INSERT INTO modelo VALUES (1462101,147,'SAAB 9.3','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1482105,149,'BIRD','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1482106,149,'MAX-PICK-UP','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1482107,149,'ROYALE','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1482108,149,'S-BIRD DE LUXE','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1492109,150,'SM3','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (1492110,150,'SM5','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (1492111,150,'SM7','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (1492112,150,'SQ5','2015-05-18 01:26:51');
INSERT INTO modelo VALUES (1492113,150,'TRUCK SV 110','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1502114,151,'6-ASIENTOS','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1542135,155,'127','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542136,155,'131','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542137,155,'133','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542138,155,'ALHAMBRA','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1542139,155,'ALTA XL 1.6 STYLANCE','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542140,155,'ALTEA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542141,155,'CORDOBA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542142,155,'FURA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542143,155,'IBIZA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542144,155,'INCA','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1542145,155,'LEON','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542146,155,'MALAGA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542147,155,'MARBELLA CE','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542148,155,'PANDA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542149,155,'RITMO 75','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542150,155,'RONDA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1542151,155,'TERRA CE','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1542152,155,'TOLEDO','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1552153,156,'PLUTUS','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1552154,156,'STEED','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1572181,158,'GLS-SEDAN','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582182,159,'120','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582183,159,'FABIA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582184,159,'FAVORIT','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582185,159,'FELICIA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582186,159,'FORMAN','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1582187,159,'OCTAVIA','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582188,159,'PICK-UP','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1582189,159,'RAPID','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582190,159,'ROOMSTER','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582191,159,'SPACEBACK','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582192,159,'SUPER_COMFORT','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1582193,159,'YETI','2015-05-18 01:27:22');
INSERT INTO modelo VALUES (1602195,161,'C52 1.5','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1602196,161,'C61 1.6 MEC FULL ABS','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1602197,161,'C81 1.8 MEC FULL ABS','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1602198,161,'R51','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1602199,161,'R80 H/B 1.8 MEC FULL','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1602200,161,'R81 1.8 MEC FULL ABS','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1622244,163,'A.SPORTS','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1622245,163,'ACTYON','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1622246,163,'KORANDO','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1622247,163,'KYRON XDI','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1622248,163,'MUSSO','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1622249,163,'NEW A.SPORTS','2015-05-18 01:27:32');
INSERT INTO modelo VALUES (1622250,163,'NEW KORANDO','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1622251,163,'NEW KYRON','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1622252,163,'REXTON','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1622253,163,'STAVIC','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1632254,164,'1.6 DL','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632255,164,'1.8 GL 4WD','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632256,164,'4WD','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632257,164,'600','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632258,164,'700','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632259,164,'ALL NEW','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632260,164,'B9 TRIBECA','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632261,164,'BAJA PICK UP 2.5','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1632262,164,'BRZ 2.0 RWD','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632263,164,'CARRY-ALL','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1632264,164,'COUPE','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632265,164,'DL 4WD','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632266,164,'E-10 DELIVERY-VAN DX','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1632267,164,'FORESTER','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1632268,164,'GL','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632269,164,'GLF 4WD D/R','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632270,164,'HARDTOP','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632271,164,'HATCHBACK','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632272,164,'IMPREZA','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632273,164,'J-10','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632274,164,'J-12','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632275,164,'JUSTY','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632276,164,'LEGACY','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632277,164,'LOYALE','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632278,164,'MV 1.8 4WD','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1632279,164,'NEW FORESTER','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632280,164,'NEW IMPREZA','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632281,164,'NEW LEGACY','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632282,164,'NEW OUTBACK','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632283,164,'NEW TRIBECA','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632284,164,'NEW WRX','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632285,164,'NEW XV','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1632286,164,'OUTBACK','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632287,164,'SEDAN','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632288,164,'STI 2.5 4D AWD 6MT','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632289,164,'TRIBECA 3.6R','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1632290,164,'UTILITARIO','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1632291,164,'WRX 2.5','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632292,164,'WRX+L','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1632293,164,'XV','2015-05-18 01:27:23');
INSERT INTO modelo VALUES (1642298,165,'600 KGS','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1642304,165,'AERIO','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642306,165,'ALTO','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642314,165,'APV MINVAN','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1642316,165,'BALENO','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642317,165,'CARRY','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1642318,165,'CELERIO 1.0','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642319,165,'CERVO SC','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642336,165,'FORZA','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642337,165,'FRONTE','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642338,165,'FURGON','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1642345,165,'GRAND','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1642370,165,'IGNIS','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642371,165,'JAZZ 1.3','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642372,165,'JIMNY','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1642374,165,'KIZASHI SEDAN','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642375,165,'LIANA','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1642376,165,'LJ-60','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1642377,165,'LJ-80 CAPOTA','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1642398,165,'MARUTI','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642399,165,'MASTERVAN','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1642401,165,'NOMADE','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1642402,165,'PICK-UP','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1642418,165,'SAMURAI','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1642419,165,'SB 308','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642422,165,'SIDEKICK','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1642423,165,'SJ408','2015-05-18 01:27:39');
INSERT INTO modelo VALUES (1642424,165,'SJ410','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1642425,165,'SJ413','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1642426,165,'SS','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642428,165,'SWIFT','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642429,165,'SX4','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1642435,165,'UTILITARIO','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1642436,165,'VITARA','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1642446,165,'WAGON R','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1642448,165,'XL7','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1662534,167,'XENON','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1692542,170,'4RUNNER','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1692543,170,'ADVANTAGE','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1692544,170,'ADVATAGE RAV4 S.LUJO SE/CA 4X4','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1692545,170,'AURIS','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692546,170,'AVENSIS','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692547,170,'CAMRY','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692548,170,'CARINA','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692549,170,'CELICA','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692550,170,'COMMUTER','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1692551,170,'COROLLA','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692552,170,'CORONA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1692553,170,'CRESSIDA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1692554,170,'CROWN','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1692555,170,'FJ CRUISER','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1692556,170,'FORTUNER','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1692557,170,'HIACE','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1692558,170,'HILUX','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1692559,170,'LAND CRUISER','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1692560,170,'LEXUS','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692561,170,'LITE ACE','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1692562,170,'NEW COROLLA','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692563,170,'NEW HILUX','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1692564,170,'NEW TERCEL','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692565,170,'NEW YARIS SEDAN GLI','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1692566,170,'PASEO','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692567,170,'PRERUNNER','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1692568,170,'PREVIA','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1692569,170,'PRIUS','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1692570,170,'RAV4','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1692571,170,'SEQUOIA 4X4 LIMITED','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1692572,170,'STARLET','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1692573,170,'STOUT CAJA 4 VELOC','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1692574,170,'TERCEL','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692575,170,'TUNDRA','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1692576,170,'URBAN CRUISER','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692577,170,'YARIS','2015-05-18 01:27:24');
INSERT INTO modelo VALUES (1692578,170,'ZELAS HB','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762626,177,'105','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1762627,177,'211_KOMBI','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (1762628,177,'261','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1762629,177,'262','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1762630,177,'265 DOBLE CABINA','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1762631,177,'AMAROK','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1762632,177,'AMAZON','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762633,177,'ATLANTIC GL','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762634,177,'BEETLE','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762635,177,'BORA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762636,177,'BRASILIA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762637,177,'BUGGY','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762638,177,'CADDY','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1762639,177,'CALIFORNIA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762640,177,'CAMPER','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (1762641,177,'CAMPER-KOMBI','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (1762642,177,'CAMPING','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (1762643,177,'CRAFTER','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1762644,177,'CROSSFOX','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762645,177,'CROSSOVER','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1762646,177,'DANFO','2015-05-18 01:27:41');
INSERT INTO modelo VALUES (1762647,177,'ESCARABAJO','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762648,177,'FOX HB','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762649,177,'FURGON_PANEL 1.8','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (1762650,177,'GOL','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762651,177,'GOLF','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762652,177,'JETTA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762653,177,'JORKER','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (1762654,177,'KARGMAN MOBILE SAFARI','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (1762655,177,'KARGMAN-GHIA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762656,177,'KLEINBUS','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (1762657,177,'KLEINBUS-KOMBI 9 ASIENTO','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (1762658,177,'KOMBI','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (1762659,177,'LT-40','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1762660,177,'MULTIVAN','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1762661,177,'NEW BEETLE 2.5 CABRIOLET','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762662,177,'NEW BORA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762663,177,'NUEVA SAVEIRO GP CEXT 1.6','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1762664,177,'NUEVO BEETLE 2.0','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762665,177,'NUEVO GOLF','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1762666,177,'NUEVO TOUAREG','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1762667,177,'NVA SAVEIRO GP CS 1.6','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1762668,177,'NVA_GOL 1.6/95 COMFORT','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1762669,177,'PANAMERICANA','2015-05-18 01:27:37');
INSERT INTO modelo VALUES (1762670,177,'PARATI','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1762671,177,'PASSAT','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762672,177,'POLO','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762673,177,'QUANTUM','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1762674,177,'SANTANA','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762675,177,'SAVEIRO','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1762676,177,'SCIROCCO','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1762677,177,'SCIROCO GT','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1762678,177,'SEDAN','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1762679,177,'SURAN','2015-05-18 01:27:47');
INSERT INTO modelo VALUES (1762680,177,'T.L.','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1762681,177,'TIGUAN','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1762682,177,'TOUAREG','2015-05-18 01:27:40');
INSERT INTO modelo VALUES (1762683,177,'TRANSPORTER','2015-05-18 01:27:36');
INSERT INTO modelo VALUES (1762684,177,'VARIANT','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1762685,177,'VENTO','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1762686,177,'VOYAGE','2015-05-18 01:27:25');
INSERT INTO modelo VALUES (1772687,178,'142','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772688,178,'144','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772689,178,'145','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1772690,178,'164','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772691,178,'240','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772692,178,'242','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772693,178,'244','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772694,178,'245','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772695,178,'262 GL. COUPE','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772696,178,'264','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772697,178,'343','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772698,178,'345 GLS','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772699,178,'360','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772700,178,'440 HATCHBACK','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772701,178,'460','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772702,178,'740','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772703,178,'745 GLT 882','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1772704,178,'760 GLE','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772705,178,'850 GLT','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772706,178,'940','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1772707,178,'960','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1772708,178,'C30','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772709,178,'C70','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772710,178,'S40','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772711,178,'S60','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772712,178,'S70','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1772713,178,'S80','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772714,178,'V40','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772715,178,'V50','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1772716,178,'V60','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1772717,178,'V70','2015-05-18 01:27:26');
INSERT INTO modelo VALUES (1772718,178,'V90 XC','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1772719,178,'XC60','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1772720,178,'XC70','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1772721,178,'XC90','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1792723,180,'WAGONIER','2015-05-18 01:27:48');
INSERT INTO modelo VALUES (1862889,187,'55 GLS','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1862890,187,'65','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1862891,187,'FLORIDA','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1862892,187,'KORAL','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1862893,187,'POLY 65','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1862894,187,'SKALA','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1882896,189,'***S/MODELOS***','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1882897,189,'1500 TK','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1882898,189,'750','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1882899,189,'DOBLE-CABINA','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1882900,189,'KOMBI STANDARD','2015-05-18 01:27:42');
INSERT INTO modelo VALUES (1912903,192,'HUNTER','2015-05-18 01:27:27');
INSERT INTO modelo VALUES (1932905,194,'ADMIRAL','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1932906,194,'GRAND TIGER','2015-05-18 01:27:33');
INSERT INTO modelo VALUES (1932907,194,'LANDMARK','2015-05-18 01:27:48');
INSERT INTO mantencion_base VALUES (1,'Revisión de Aceite','ALL','ALL','REVISION','Revisar el nivel de aceite del motor\nDetectar posibles pérdidas\nRellenar hasta niveles declarados por el fabricante','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n  <body><h1>Revisión de Aceite de Motor</h1><h2>¿En qué Consiste?</h2>Consiste en verificar que el nivel de aceite del motor se encuentre dentro de los niveles sugeridos por el fabricante. Es una tarea sencilla que se realiza en el motor midiendo el nivel de aceite con una varilla de medición.<h2>¿Para qué se hace?</h2>Para evitar el sobrecalentamiento del motor producto del roce de sus partes y piezas.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Debe ser hecha cada 5.000 Km o previo a un viaje largo<h2>¿En qué debo fijarme al hacer esta revisión?</h2>El motor debe estar apagado y a temperatura de funcionamiento (caliente)<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>Se enciende la luz roja del tablero que indica bajo nivel de aceite y rápido incremento de la temperatura de funcionamiento.<h2>¿Cuáles son las tareas asociadas?</h2>Abrir el capot, sacar la varilla indicadora para limpiarla con un paño limpio <b>(nunca huaipe porque bota pelusas)</b>, introducir la varilla y sacarla para certificar que el aceite está entre las dos marcas que tiene. <br> Esto debe realizarse al menos dos veces para evitar lecturas erróneas. <br>Luego dejar la varilla en posición original y rellenar si es del caso con un lubricante de iguales características al que posee.\n</body>\n</html>',NULL,1,5000,NULL,'2014-12-12 06:12:58');
INSERT INTO mantencion_base VALUES (2,'Cambio de Aceite Motor','ALL','ALL','CAMBIO','\nCambio de aceite del motor.\nCambio de filtro de aceite.\n','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n  <body><h1>Cambio de Aceite Motor</h1><h2>¿En qué Consiste?</h2>Consiste en cambiar la totalidad del aceite de motor en uso por uno nuevo según las recomendaciones del fabricante. \"Usualmente\" del tipo SAE 15W40. Tarea que dura 40 minutos aproximadamente.<h2>¿Para qué se hace?</h2>Para renovar el lubricante y disponer de los beneficios de limpieza, refrigeración y lubricación necesarias para evitar el desgaste prematuro del motor.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Cada 12 meses o 10.000 kms aprox; lo que depende de las recomendaciones y calidad del aceite. El \"sintético\" es el mejor pero es más costoso.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que el motor esté frío. Que la tarea se realice en un lugar limpio, con el aceite recomendado y proveniente de un recipiente que sólo contenga el mismo tipo de lubricante. Además debe revisarse el nivel a través de la varilla, debiendo quedar el tapón del cárter (que almacena al lubricante) completamente cerrado. Se sugiere realizar también el CAMBIO del FILTRO de ACEITE. La calidad del lubricante JAMÁS se mide con la yema de los dedos, sino que con instrumetos de laboratorio.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>Se enciende luz roja que indica bajo nivel de aceite y rápido incremento de la temperatura de funcionamiento.  En situaciones extremas pueden escucharse golpeteos en el motor o simplemente éste pierde fuerza y deja de funcionar<h2>¿Cuáles son las tareas asociadas?</h2>Abrir el capot para medir el nivel de aceite, luego sacar el tapón del cárter (dispositivo que almacena el lubricante, al que se accede debajo del motor) para dejar caer el lubricante viejo. Se pone el tapón y por la parte superior del motor se realiza el relleno. <b>El mecánico debe abrir el envase frente a usted y luego comprobar el correcto funcionamiento del motor</b>.\n</body>\n</html>',NULL,1,10000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (3,'Afinamiento','ALL','ALL','REVISION','Cambio de bujías.\nCambio de Filtro de Aire.\nCambio de Filtro de Combustible.\nLimpieza de Válvulas Eléctricas ó Calibración de Inyectores según corresponda.\n','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Afinamiento</h1><h2>¿En qué Consiste?</h2>Consiste en el cambio de bujías, filtros de aire y aceite.  y eventual cambio de correas de transmisión del motor. Revisión del sensor de gases de escape y de combustible. Duración aproximada, tres horas.<h2>¿Para qué se hace?</h2>Para mejorar la eficacia del motor, mejorar su rendimiento y disminuir la emisión de gases contaminantes.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Cada 36 meses o 45.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que efectivamente cambie las bujías, filtros y/o correas.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El vehículo consume más combustible y en casos extremos se pueden sufrir fallas catastróficas, como por ejemplo \"\"motor fundido\"\" con el corte de correas.<h2>¿Cuáles son las tareas asociadas?</h2>Cambiar bujías y confirmar que no estén húmedas (lo que indica fallas mayores), cambiar filtros y eventualmente correas de distribución (según indicaciones del fabricante). El proveedor debe devolver los elementos retirados para confirmar la ejecución de la tarea.\n</body>\n</html>',NULL,1,45000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (4,'Revisión del Motor (120 mil km)','ALL','ALL','REVISION','Medición de compresión. \nRevisión de gases de escape. \nRectificación de block y culata. \nCambio de empaquetaduras, guías de válvulas, anillos, metales y retenes. Eventualmente rectificación de las superficies de los ejes de levas y cigüeñal. Todo ello previas mediciones de tolerancias realizadas con micrómetros y comparadores de superficies. \nAsentamiento de válvulas y juego de cojinetes. ','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Revisión del Motor (120 mil km)</h1><h2>¿En qué Consiste?</h2>Consiste en una revisión invasiva y completa del funcionamiento de los sistemas del motor. Puede durar incluso 60 horas si es que se necesita una intervención mayor, como sería el caso de realizar un \"semi-ajuste\" o un \"ajuste\" del motor, para lo cual es necesario desarmar el motor.<h2>¿Para qué se hace?</h2>Para chequear el correcto funcionamiento del motor y decidir si es necesario realizar un semi-ajuste o un ajuste completo al motor.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Cada 96 meses o 120.000 kms aprox. El resultado de las pruebas de compresión y funcionamiento del motor son esenciales para definir el momento exacto de realizar un ajuste o semi ajuste de motor. Es necesario tener presente que un mal funcionamiento del sistema de refrigeración o lubricación (entre otros) pueden tener como consecuencia la ejecución de un costoso y largo ajuste del motor en cualquier momento.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Revisar la compresión del motor para determinar si existen desgastes de las superficies mecánicas del motor. También se debe considerar el color de humo de escape, lo que determina una eventual quema de lubricamte. Y también es importante considerar si es que el vehículo pierde fuerza cuando es exigido. El mecánico debe trabajar con instrumento de calibración para decidir las tareas a realizar. No basta con la inspección visual.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El vehículo pierde fuerza. El motor está manchado exteriormente con aceite o bien \"quema aceite\" (excesivo consumo), lo que se evidencia por humo negro. Pueden existir ruidos en el motor del tipo \"golpeteo\" o \"cascabeleo\".<h2>¿Cuáles son las tareas asociadas?</h2>Los trabajos de ajuste o semi ajuste consideran: rectificación de las superifices del block, culata, descansos del cigüeñal y/o del eje de levas,. Se cambian y asientan válvulas, guías de válvulas, descansos y puños de biela , cambio de: anillos, metales y retenes. Puede llegar a ser necesario también, rectificar los ejes cigüeñal y/o de levas dependiendo del resultado de las mediciones realizadas con micrómetros. Para realizar estas tareas, es absolutamente necesario desarmar el motor. Es importante volver al mecánico una semana después del ajuste para \"reapriete de culata\" según medidas establecidas por el fabricante.\n</body>\n</html>',NULL,1,120000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (5,'Revisión de Niveles de Líquidos y Lubricantes','ALL','ALL','REVISION','Revisión Nivel aceite motor, liquido de frenos, lubricante de bomba de dirección, depósito de liquido de frenos, nivel de refrigerante, nivel liquido hidraulico caja cambios y caja de transferencia (cuando coresponda).','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Revisión de Niveles de Líquidos y Lubricantes</h1><h2>¿En qué Consiste?</h2>Chequeo del nivel de aceite, liquido de frenos,  refrigerantes, aceite de transmisión (caja de cambios), liquido limpia parabrisas. Esta tarea dura 15 minutos aprox.<h2>¿Para qué se hace?</h2>Para asegurarse  de que los niveles de liquidos y lubricantes se encuentran en la cantidad recomendad por el fabricante; evitando la aparición de fallas.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Lo recomedable es cada 12 meses o cada 15.000 kms<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que se usen paños limpios para evitar contaminación, debiendo estar el auto detenido y de preferncia recién apagado (motor caliente).<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>Existirán sobrecalentamientos y alertas de luces rojas en el panel de control del vehículo.<h2>¿Cuáles son las tareas asociadas?</h2>Revisar el nivel de aceite motor con varilla. Revisar nivel aceite de caja de cambios (o líquido hidraulico para el caso de transmision automática) . Revisar nivel y condición del liquido de frenos y dirección hidrahulica. Revisión de Regfrigerante (No se usa agua de la llave) y nivel líquido limpia parabrisas.\n</body>\n</html>',NULL,1,15000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (6,'Cambio de Aceite de Transmisión','ALL','ALL','CAMBIO','Cambio de aceite de Transmisión','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Cambio de Aceite de Transmisión</h1><h2>¿En qué Consiste?</h2>Tarea sencilla que se realiza en la parte inferior del vehículo; específicamente en la caja de cambios. Esta tarea dura aprox 30 minutos.<h2>¿Para qué se hace?</h2>Para controlar que el nivel de aceite (o líquido hidráulico para el caso de transmisión automática) esté según lo recomienda el fabricante.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Cada 60 meses aprox o 80.000 kms<h2>¿En qué debo fijarme al hacer la mantención?</h2>El motor debe estar apagado y a temperatura de funcionamiento (caliente). Que consulte el manual para conocer las recomendaciones del fabricante.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>Se enciende luz roja que indica bajo nivel de aceite y rápido incremento de la temperatura de funcionamiento. Además, puede comenzar a funcionar incorrectamente la transmisión.<h2>¿Cuáles son las tareas asociadas?</h2>Revisar el nivel de lubricante desde la parte inferior del vehículo (usualmente). Vaciar de la caja el lubricante antiguo y luego rellenar con el nuevo. Terminado se debe hacer funcionar el vehículo para probar el funcionamiento de la transmisión. No deben existir ruidos ni trabas durante la conducción. Si la transmisión es mecánica se usa aceite del tipo 80W90 u otro recomendado por el fabricante. Si la transmisión es hidráulica, se utiliza \"líquido hidráulico\", el que no es \"espeso\" como el aceite.\n</body>\n</html>',NULL,1,80000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (7,'Revisión de Suspensión','ALL','ALL','REVISION','Inspección ocular para advertir pérdidas de líquido de los amortiguadores, los que deben estar secos exteriormene. \nEstudiar el comportamiento de los amortiguadores; los que deben absorber esa fuerza evitando que el vehículo se desestabilice. ','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Revisión de Suspensión</h1><h2>¿En qué Consiste?</h2>Tarea que permite conocer el estado de la amortiguación y que puede durar unos 15 minutos aprox.<h2>¿Para qué se hace?</h2>Se realiza para chequear que los amotiguadores no tengan fugas de aceite.<h2>¿Cada cuánto tiempo debo realizarla?</h2>36 meses o 45.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que el vehículo no tenga ocupantes y que el mecánico ejerza fuerza (se cargue) sobre la carrocería a la altura de las ruedas. El sistema debe absorber la fuerza y el auto no debe rebotar como pelota saltarina.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El vehículo salta como pelota saltarina y la conducción se vuelve incómoda pudiendo dañar la estructura del chasis.<h2>¿Cuáles son las tareas asociadas?</h2>Debe chequear que el amortiguador (llamado telescópico) no presente manchas de aceite. Si alguno tuviera fuga, se deben cambiar \"\"en pares\"\", es decir, se cambian los amortiguadores delanteros y/o traseros, pero nunca uno sólo.\n</body>\n</html>',NULL,1,45000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (8,'Cambio de Suspensión','ALL','ALL','CAMBIO','Cambiar los amortiguadores SIEMPRE en pares. Es decir, los delanteros o bien los traseros juntos. ','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Cambio de Suspensión</h1><h2>¿En qué Consiste?</h2>Tarea que permite cambiar los amortiguadores (telescópicos) del vehículo cuando han cumplido su vida útil de aprox  80.000 a 90.000 kms, o bien cuando estas presentan fugas. Dicha tarea dura aproximadamente 100 a 120 minutos.<h2>¿Para qué se hace?</h2>Para devolver al vehículo su capacidad de brindar confort a los pasajeros a través de la amortiguación.<h2>¿Cada cuánto tiempo debo realizarla?</h2>60 meses o 90.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que ocupe amortiguadores apropiados según las recomendaciones del fabricante.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El vehículo salta como pelota saltarina y la conducción se vuelve incómoda pudiendo dañar la estructura del chasis.<h2>¿Cuáles son las tareas asociadas?</h2>Cambiar los amortiguadores SIEMPRE en pares. Es decir, los delanteros o bien los traseros juntos. No es recomedable cambiar sólo uno.\n</body>\n</html>',NULL,1,90000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (9,'Revisión de Neumáticos','ALL','ALL','REVISION','Medir la presión y los dibujos del neumático.','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Revisión de Neumáticos</h1><h2>¿En qué Consiste?</h2>Consiste en controlar el inflado y dibujos (desgaste) del neumático. Además se debe considerar que el vehículo no desvíe su marcha al soltar el volante durante la conducción (lo que debe hacerse con mucha precaución y a baja velocidad donde no exista riesgo de choque)<h2>¿Para qué se hace?</h2>Para cerciorarse que el vehículo reponderá al frenado, a la marcha en curvas y a la conducción sin desviarse de la ruta, brindando confort al transitar sobre superficies irregulares.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Cada 12 meses o 10.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que controle la presión de inflado y el estado de los dibujos del neumático; los que contribuyen a mejorar la adherencia a la superficie.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El vehículo derrapa durante el frenado (patina) o  desvía su marcha.<br> Incremento de consumo de combustible.<h2>¿Cuáles son las tareas asociadas?</h2>Medir la presión y los dibujos del neumático.\n</body>\n</html>',NULL,1,10000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (10,'Cambio de Neumáticos','ALL','ALL','CAMBIO','Cambio de Neumáticos\nAlineación y Balanceo','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Cambio de Neumáticos</h1><h2>¿En qué Consiste?</h2>Cambiar los neumáticos cuando están gastados, lo que depende mucho del tipo de terreno y cuidado que se tenga al conducir, especialmente en cuanto al inflado de ellos. Esta tarea dura aprox 45 minutos.<h2>¿Para qué se hace?</h2>Para brindar seguridad en la conducción del vehículo, ya que el estado de los neumáticos influye fuertemente en el frenado.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Cada 70.000 a 80.000 aprox, o a los 40 meses aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Junto con cambiar el neumático debe chequearse exteriormente el  mecanismo de frenado que queda a la vista. Los neumáticos deben quedar \"alineados\"y \"balanceados\"<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El vehículo puede patinar en las curvas y en los frenados. Además, el auto desvía su marcha hacia los costados. Además, puede que el volante comience a vibrar al alcanzar cierta velocidad, lo que podría indicar adicionalmente,  problemas en el sistema de dirección. También aumenta el consumo de combustible con neumáticos en mal estado.<h2>¿Cuáles son las tareas asociadas?</h2>Las medidas del neumático deben ser las que recomienda el fabricante dependiendo del tipo de uso del vehículo. Las ruedas deben quedar firmemente afianzadas. Se debe realizar la alineación y balanceo a la totalidad de los neumáticos.\n</body>\n</html>',NULL,1,70000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (11,'Alineación y Balanceo','ALL','ALL','CAMBIO','Medición inicial del estado de alineación de los neumáticos.\nCorregir desviaciones.\nEntrega de reporte final con el detalle de las mediciones.\n','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Alineación y Balanceo</h1><h2>¿En qué Consiste?</h2>Consiste en devolver la homogeneidad a la forma del neumático, ya que durante la conducción las  ruedas se golpean y se van deformando, lo que ocasiona que el vehículo desvíe su marcha hacia los costados de la ruta; dificultando el control de avance. Esta tarea dura aprox 60 minutos.<h2>¿Para qué se hace?</h2>Para asegurar una conducción segura, confortable y económica porque se incrementa el consumo de combustible. Será necesario realizar esta tarea si es que se conduce por terrenos irregulares o bien el vehículo se golpea contra la cuneta.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Cada 24 meses o 30.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que ambas tareas son independientes una de la otra y deben realizarse preferentemente en el orden \"Alineación\" y luego \"Balanceo\".<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El vehículo desvía su marcha y a veces el volante tirita (se sacude) a ciertas velocidades. Además, se incrementa el consumo de combustible.<h2>¿Cuáles son las tareas asociadas?</h2>Que se haga una medición inicial del estado de alineación del neumático y luego se proceda a realizar el trabajo; el que debe corregir las desviaciones apreciadas al inicio de esta tarea. Se debe entregar un reporte con los detalles.\n</body>\n</html>',NULL,1,45000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (12,'Revisión Sistema Eléctrico','ALL','ALL','REVISION','Se debe revisar la entrega de energía por parte de la batería, la carga que entrega el alternador, el correcto funiconamiento del alumbrado, cierre centralizado y alza vidrios.','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Revisión Sistema Eléctrico</h1><h2>¿En qué Consiste?</h2>Revisión del sistema de carga del alternador con un tester (energización de los sistemas del vehículo), circuito de alumbrado, tablero de fusibles, sensores y calefacción. Esta tarea tarda 60 minutos aprox.<h2>¿Para qué se hace?</h2>Para asegurarse que todos los dispositivos que son accionados eléctricamente reciban la energía necesaria para funcionar correctamente.<h2>¿Cada cuánto tiempo debo realizarla?</h2>Cada 24 meses o 30.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que utilice un tester elcétrico para certificar que cada sistema recibe la energía necesaria para funcionar correctamente.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>Los sistemas dejan de funcionar, por ejemplo el alumbrado, alza vidrios, calefacción, airbag, etc., y si lo hacen, funcionan incorrectamente, pudiendo generarse una sobrecarga.<h2>¿Cuáles son las tareas asociadas?</h2>Se debe revisar la entrega de energía por parte de la batería, la carga que entrega el alternador, el correcto funiconamiento del alumbrado, cierre centralizado, alza vidrios, etc..\n</body>\n</html>',NULL,1,30000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (13,'Cambio de Batería','ALL','ALL','CAMBIO','Cambiar Batería.','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Cambio de Batería</h1><h2>¿En qué Consiste?</h2>Consiste en eliminar la batería antigua y reemplazarla por una nueva según especificaciones del fabricante. Esta tarea tarda 30 minutos aprox. <h2>¿Para qué se hace?</h2>Para recuperar la capacidad de entregar energía a los sistemas del vehículo.<h2>¿Cada cuánto tiempo debo realizarla?</h2>36 meses o 45.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que desconecte los bornes de la batería y la cambie por otra nueva. Existen baterías que se rellenan con \"electrolito\", mientras que otras son \"secas\" o \"libres de mantenimiento\".<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El vehículo tiene dificultades para arrancar, pudiendo causar desperfectos en el sisema de carga e iluminación.<h2>¿Cuáles son las tareas asociadas?</h2>Desconectar la batería con el vehículo detenido y luego colocar una nueva, chequeando que ésta entregue la energía necesaria paa el funcionamiento del vehículo con el instrumento debido (tester).\n</body>\n</html>',NULL,0,45000,36,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (14,'Revisión de Frenos','ALL','ALL','REVISION','Revisión de líquido de frenos. \nChequeo del recorrido del pedal de frenos para obtener la detención deseada. \nAdvertencia de derrapes y ruidos durante el frenado.','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Revisión de Frenos</h1><h2>¿En qué Consiste?</h2>Consiste en el chequeo del correcto funcionamiento del sistema de frenos, el que no debe generar ruidos ni producir derrapes del vehículo. Incluye freno de mano. Esta tarea tarda 40 minutos aprox.<h2>¿Para qué se hace?</h2>Es una medida de seguridad para lograr la necesaria detención del vehículo y sirve para advertir tempranamente fallas.<h2>¿Cada cuánto tiempo debo realizarla?</h2>24 meses o 30.000 kms<h2>¿En qué debo fijarme al hacer la mantención?</h2>Nivel del líquido de frenos, que el vehículo no derrape ni produzca ruidos al frenar. Incluye revisión de freno de mano.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>Los frenos \"\"se ponen largos\"\" porque a pesar de pisar el pedal, el vehículo demora en detenerse lo que puede ocasionar una daño severo con riesgos de vida ante situaciones de urgencia. Sin duda alguna, este es un mantenenimiento de gran cuidado que no debe postergarse.<h2>¿Cuáles son las tareas asociadas?</h2>Revisión de líquido de frenos. Chequeo del recorrido del pedal de frenos para obtener la detención deseada. Advertencia de derrapes y ruidos durante el frenado.\n</body>\n</html>',NULL,1,30000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (15,'Mantención de Frenos','ALL','ALL','CAMBIO','Desmontar ruedas, inspeccionar, reparar y reemplazar componentes deteriorados del sitema de frenos. \nChequear el nivel de líquido de frenos, el recorrido del pedal para deterner el vehículos.\n Realizar una \"prueba práctica\" de frenado en ruta. \nRevisión del freno de mano.','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n  <body><h1>Mantención de Frenos</h1><h2>¿En qué Consiste?</h2>Consiste en cambiar o reparar si es necesario los componentes del sistema de frenos, por ejemplo las \"pastillas o balatas según sea el caso\" , el tambor, el disco y otros componentes menores. Esta tarea tarda 120 minutos aprox.<h2>¿Para qué se hace?</h2>Para recuperar la capacidad de detención del vehículo.<h2>¿Cada cuánto tiempo debo realizarla?</h2>36 meses o 45.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que desmonte las cuatro ruedas y desarme los componentes del sistema de frenos para chequear su estado y cambiarlos si es que presentan defectos o según recomendación del fabricante. Incluye revisión freno de mano.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>El sistema produce ruidos y derrape al accionarse. Pueden generarse además, graves consecuencias si es que los frenos no responden ante situaciones de emergencia, por lo que <b>esta tarea no debe postergarse por ningún motivo</b>.<h2>¿Cuáles son las tareas asociadas?</h2>Desmontar ruedas, inspeccionar, reparar y reemplazar componentes deteriorados del sitema de frenos. Además debe chequear en nivel de líquido de frenos, el recorrido del pedal para deterner el vehículos y debe realizar una \"prueba práctica\" de frenado en ruta. Incluye revisión del freno de mano.\n</body>\n</html>',NULL,1,45000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (16,'Revisión de Caja de Cambio','ALL','ALL','REVISION','Chequear el nivel de lubricante.','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n<body><h1>Revisión de Caja de Cambio</h1><h2>¿En qué Consiste?</h2>Chequeo del funcionamiento del sistema de transmisión sbre la base de advertir ruidos o dificultades para pasar de un cambio a otro. Además debe revisarse el accionamiento del pedal de embrague (recorrdido) para el caso de transmisión mecánica.Tarea que tarda 30 minutos aprox.<h2>¿Para qué se hace?</h2>Para asegurarse de que la fuerza generada por el motor es transmitida a las ruedas, evitando la ocurrencia imprevista de fallas por escasez de lubricante o mal funcionamiento del sistema; lo que se advierte por pérdida de fuerza, sobrecalentaiento o ruidos extraños.<h2>¿Cada cuánto tiempo debo realizarla?</h2>40 meses o 40.000 kms aprox.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Control del nivel de lubricante del sistema de transimisón; al que se accede por debajo del vehículo.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>Si la cantidad de lubricante es inferior a la necesaria, se puede producir aumento de temperatuara con el consecuente deterioro de las partes metálicas. Por otro lado, pueden ocasionarse dificultades para pasar de un cambio a otro, o incluso la pérdida de fuerza para acelerar. En el caso de transmisión hidraulica (automática) la caja se puede \"\"trabar\"\".<h2>¿Cuáles son las tareas asociadas?</h2>Debe chequear el nivel de lubricante, como también advertir ruidos extraños o pérdida de fuerza del vehículo, especialmente cuando es necesaro acelerar. Esto debe hacerse en forma práctica \"\"en ruta\"\".\n</body>\n</html>',NULL,1,40000,NULL,'2014-12-12 06:12:59');
INSERT INTO mantencion_base VALUES (17,'Cambio Correa Distribución','ALL','ALL','CAMBIO','Cambio de la correa de Distribución','<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n</head>\n  <body><h1>Cambio Correa de Distribución</h1><h2>¿En qué Consiste?</h2>Consiste en cambiar la correa de distribución según el modelo indicado por el fabricante, a pesar de que exteriormente pareciera que está en buenas condiciones. Esta tarea dura aprox. 45 minutos.<h2>¿Para qué se hace?</h2>Para asegurarse que la fuerza que produce el motor sea entregada (distribuida) a todos los componentes del motor, por ejemplo al sistema eléctrico, calefacción, luces, etc. <b>Nunca pase por alto esta tarea, ya que su ejecución es vital para la vida del motor</b>.<h2>¿Cada cuánto tiempo debo realizarla?</h2>60 meses aprox. Es muy importante realizar esta tarea, ya que se pueden producir fallas muy costosa en caso de descuidarla.<h2>¿En qué debo fijarme al hacer la mantención?</h2>Que la correa sea cambiada por una nueva según las especificaciones del fabricante del vehículo, debiendose comprobar el correcto funcionamiento del motor una vez finalizada esta tarea.<h2>¿Cómo puedo detectar que requiero esta mantención?</h2>Se expulsan más gases de escape que lo de costumbre. Es difícil hacer partir el vehículo. El motor vibra y produce \"\"cascabeleo\"\", o  simplemente puede \"\"detenerse\"\".<h2>¿Cuáles son las tareas asociadas?</h2>Se trabaja en el sector del motor del vehículo. Se desconecta la correa (o cadena en muchos casos) y se instala una nueva. Luego se prueba el correcto funcionamiento del motor.\n</body>\n</html>',NULL,1,90000,NULL,'2015-05-08 19:35:52');
INSERT INTO mantencion_base VALUES (101,'Servicio de Grúa','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:22:15');
INSERT INTO mantencion_base VALUES (102,'Servicio de Vulcanización','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:27:12');
INSERT INTO mantencion_base VALUES (103,'Servicio de Cerrajería','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:28:03');
INSERT INTO mantencion_base VALUES (104,'Servicio Lubricentro','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:28:43');
INSERT INTO mantencion_base VALUES (105,'Servicio Aire Acondicionado','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:29:21');
INSERT INTO mantencion_base VALUES (106,'Servicio Revisión Técnica','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:30:01');
INSERT INTO mantencion_base VALUES (107,'Servicio Lavado Autos','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:30:35');
INSERT INTO mantencion_base VALUES (108,'Servicio Parabrisas','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:31:09');
INSERT INTO mantencion_base VALUES (109,'Servicio Taller Eléctrico','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:32:10');
INSERT INTO mantencion_base VALUES (110,'Servicio Taller Mecánico','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:33:00');
INSERT INTO mantencion_base VALUES (111,'Servicio Pintura y Desabolladura','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:33:40');
INSERT INTO mantencion_base VALUES (112,'Servicio Frenos','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:34:14');
INSERT INTO mantencion_base VALUES (113,'Servicio de Radiadores','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:34:44');
INSERT INTO mantencion_base VALUES (114,'Análisis de Gases','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:35:41');
INSERT INTO mantencion_base VALUES (115,'Servicio ALineación y Balanceo','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:36:16');
INSERT INTO mantencion_base VALUES (116,'Servicio Tubo de Escape','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:37:06');
INSERT INTO mantencion_base VALUES (117,'Servicio Ajuste de Motor','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:37:36');
INSERT INTO mantencion_base VALUES (118,'Servicio Batería','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:38:07');
INSERT INTO mantencion_base VALUES (119,'Servicio Repuestos','ALL','ALL',NULL,NULL,NULL,NULL,1,1000000000,NULL,'2015-04-23 03:38:37');
INSERT INTO cambio_revision VALUES (1,2,1,'2015-04-30 04:28:22');
INSERT INTO cambio_revision VALUES (2,4,3,'2015-04-30 04:28:22');
INSERT INTO cambio_revision VALUES (3,8,7,'2015-04-30 04:28:22');
INSERT INTO cambio_revision VALUES (4,10,9,'2015-04-30 04:28:22');
INSERT INTO cambio_revision VALUES (5,15,14,'2015-04-30 04:28:23');
INSERT INTO cambio_revision VALUES (6,13,NULL,'2015-04-30 04:28:23');
INSERT INTO cambio_revision VALUES (7,NULL,5,'2015-04-30 04:28:23');
INSERT INTO cambio_revision VALUES (8,6,NULL,'2015-04-30 04:28:23');
INSERT INTO cambio_revision VALUES (9,11,NULL,'2015-04-30 04:28:23');
INSERT INTO cambio_revision VALUES (10,NULL,12,'2015-04-30 04:28:23');
INSERT INTO cambio_revision VALUES (11,NULL,16,'2015-04-30 04:28:23');
INSERT INTO cambio_revision VALUES (12,17,NULL,'2015-05-08 19:41:48');
INSERT INTO cia_seguros VALUES (1,'ACE Seguros S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (2,'Aseguradora Magallanes S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (3,'BCI Seguros Generales S.A',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (4,'CESCE Chile Aseguradora S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (5,'Chilena Consolidada Seguros Generales S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (6,'CHUBB de Chile Compañía de Seguros Generales S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (7,'Compañía de Seguros Generales Consorcio Nacional de Seguros S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (8,'Compañía de Seguros de Crédito Continental S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (9,'Compañía de Seguros de Créditos COFACE S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (10,'Compañías de Seguros Generales CARDIF S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (11,'Compañía de Seguros Generales Penta-Security S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (12,'Santander Seguros Generales S.A 	FAF International Seguros Generales S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (13,'HDI Seguros S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (14,'Chartis Chile Compañía de Seguros Generales S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (15,'LIBERTY SEGUROS Compañía de Seguros Generales S.A. 	Liberty Compañía de Seguros Generales S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (16,'MAPFRE Compañía de Seguros Generales.S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (17,'MAPFRE Garantías y Crédito S.A. Cia. de Seguros.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (18,'Mutualidad de Carabineros.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (19,'ORION Seguros Generales S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (20,'Renta Nacional Cia. de Seguros Generales S.A.',NULL,'2015-05-18 01:30:33');
INSERT INTO cia_seguros VALUES (21,'RSA Seguros ChileS.A.',NULL,'2015-05-18 01:30:34');
INSERT INTO cia_seguros VALUES (22,'Santander Seguros Generales S.A 	Santander Seguros Generales S.A.',NULL,'2015-05-18 01:30:34');
INSERT INTO parametro VALUES (1,'busqueda_servicios_miauto','{\n  \"instruccion\": \"Presiona el servicio que buscas para revisar los proveedores asociados\",\n  \"servicios\": [\n    {\n      \"tipo\": \"GRUA\",\n      \"texto\": \"Grúas\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"grua vehículo\"\n    },\n    {\n      \"tipo\": \"VULCANIZACION\",\n      \"texto\": \"Vulcanizaciones\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"vulcanización\"\n    },\n    {\n      \"tipo\": \"CERRAJERO\",\n      \"texto\": \"Cerrajeros\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"cerrajero automovil\"\n    },\n    {\n      \"tipo\": \"LUBRICANTES\",\n      \"texto\": \"Lubricentros\",\n      \"busca_en_miauto\": true,\n      \"servidor_miauto\": \"http://www.manadachile.cl:8080/cl.dsoft.carws2/getProveedores\",\n      \"id_mantencion\": 2,\n      \"palabra_clave_googlemap\": \"lubricentro\"\n    },\n    {\n      \"tipo\": \"AIRE_ACONDICIONADO\",\n      \"texto\": \"Aire Acondicionado\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"aire acondicionado automovil\"\n    },\n    {\n      \"tipo\": \"REVISION_TECNICA\",\n      \"texto\": \"Plantas de Revisión Técnica\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 5,\n      \"palabra_clave_googlemap\": \"revisión técnica\"\n    },\n    {\n      \"tipo\": \"LAVADO_AUTOS\",\n      \"texto\": \"Lavado de Autos\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"Lavado Autos\"\n    },\n    {\n      \"tipo\": \"PARABRISAS\",\n      \"texto\": \"Parabrisas\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"parabrisas vehiculo\"\n    },\n    {\n      \"tipo\": \"TALLER_ELECTRICO\",\n      \"texto\": \"Taller Eléctrico\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"taller eléctrico automovil\"\n    },\n    {\n      \"tipo\": \"TALLER_MECANICO\",\n      \"texto\": \"Taller Mecánico\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"taller mecánico automovil\"\n    },\n    {\n      \"tipo\": \"PINTURA_DESABOLLADURA\",\n      \"texto\": \"Desabolladura y Pintura\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"desabolladura pintura automovil\"\n    },\n    {\n      \"tipo\": \"FRENOS\",\n      \"texto\": \"Frenos\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"frenos automovil\"\n    },\n    {\n      \"tipo\": \"RADIADORES\",\n      \"texto\": \"Radiadores\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"radiador automovil\"\n    },\n    {\n      \"tipo\": \"ANALISIS_GASES\",\n      \"texto\": \"Análisis de Gases\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"análisis gases automovil\"\n    },\n    {\n      \"tipo\": \"ALINEACION_BALANCEO\",\n      \"texto\": \"Alineación y Balanceo\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"alineación balanceo automovil\"\n    },\n    {\n      \"tipo\": \"TUBO_ESCAPE\",\n      \"texto\": \"Tubos de Escape\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"tubos escapeautomovil\"\n    },\n    {\n      \"tipo\": \"AJUSTE_MOTOR\",\n      \"texto\": \"Ajuste Motor\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"ajuste motor automovil\"\n    },\n    {\n      \"tipo\": \"BATERIA\",\n      \"texto\": \"Baterías\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"Baterías vehículo\"\n    },\n    {\n      \"tipo\": \"REPUESTO\",\n      \"texto\": \"Repuestos\",\n      \"busca_en_miauto\": false,\n      \"servidor_miauto\": \"\",\n      \"id_mantencion\": 0,\n      \"palabra_clave_googlemap\": \"repuestos vehículo\"\n    }\n  ]\n}','2015-05-18 01:30:34');
INSERT INTO parametro VALUES (2,'servidor_consulta_proveedor','http://www.manadachile.cl:8080/cl.dsoft.carws2/getProveedores','2015-05-18 01:30:34');
INSERT INTO parametro VALUES (3,'servidor_miauto','http://www.manadachile.cl:8080/cl.dsoft.carws2','2015-05-18 01:30:34');
-- correcciones

UPDATE mantencion_base
SET depende_km = 'true'
WHERE depende_km = 1;
UPDATE mantencion_base
SET depende_km = 'false'
WHERE depende_km = 0;

-- se borran las tablas no necesarias en la app movil

DROP TABLE alerta;
-- DROP TABLE aux_correo;
DROP TABLE campania;
DROP TABLE campania_usuario;
DROP TABLE usuario_web;
DROP TABLE proveedor;
DROP TABLE proveedor_mantencion_base;
DROP TABLE consulta_proveedor;
DROP TABLE respuesta_proveedor;

PRAGMA foreign_keys = ON;
