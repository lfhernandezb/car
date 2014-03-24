PRAGMA foreign_keys = ON;




CREATE TABLE perfil (
	id_perfil int4 NOT NULL,
	id_empresa int4 NOT NULL,
	estado int2 NOT NULL,
	descripcion varchar(32) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_perfil)



);


CREATE UNIQUE INDEX perfil_idx_descripcion ON perfil (
	descripcion
);



	
	














CREATE TABLE info_sincro_pda (
	id_usuario int4 NOT NULL,
	nombre_proceso varchar(16) NOT NULL,
	fecha_ultima_sincro timestamp NOT NULL,
	PRIMARY KEY(id_usuario,nombre_proceso)
);












CREATE TABLE jefe_venta (
	id_jefe_venta int4 NOT NULL,
	id_sucursal_empresa int4 NOT NULL,
	username varchar(16) NOT NULL,
	password varchar(32) NOT NULL,
	rut varchar(10) NOT NULL,
	nombre_completo varchar(64) NOT NULL,
	cargo varchar(24) NOT NULL,
	email varchar(200) NOT NULL DEFAULT 'vacio',
	estado int2 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_jefe_venta)



);


CREATE UNIQUE INDEX jefe_venta_idx_username ON jefe_venta (
	username
);



	
	



	
	














CREATE TABLE encuesta (
	id_encuesta int4 NOT NULL,
	descripcion varchar(250) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_encuesta)



);


CREATE UNIQUE INDEX encuesta_idx_descripcion ON encuesta (
	descripcion
);



	
	












CREATE TABLE moneda (
	id_moneda int4 NOT NULL,
	descripcion varchar(50) NOT NULL,
	valor int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_moneda)
);


CREATE UNIQUE INDEX moneda_idx_descripcion ON moneda (
	descripcion
);










CREATE TABLE region (
	id_region int4 NOT NULL,
	descripcion varchar(100) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_region)



);


CREATE UNIQUE INDEX region_idx_descripcion ON region (
	descripcion
);



	
	












CREATE TABLE unidad_medida (
	id_unidad_medida int4 NOT NULL,
	descripcion varchar(100) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_unidad_medida)
);


CREATE INDEX unidad_medida_idx_descripcion ON unidad_medida (
	descripcion
);



	
	










CREATE TABLE historico_no_efectividad (
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_motivo_no_efectividad int4 NOT NULL,
	fecha timestamp NOT NULL,
	PRIMARY KEY(fecha)
);








CREATE TABLE historico_nota_venta (
	id_nota_venta int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	id_motivo_no_efectividad int4,
	fecha_creacion date NOT NULL,
	PRIMARY KEY(id_nota_venta,id_usuario_emisor,id_usuario_receptor)



);



	
	












CREATE TABLE parametro (
	id_parametro int4 NOT NULL,
	agrupacion varchar(250) NOT NULL,
	ambito varchar(100) NOT NULL,
	descripcion varchar(50) NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	valor varchar(100) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_parametro)



);



	
	














CREATE TABLE modulo (
	id_modulo int4 NOT NULL,
	aplicacion varchar(3) NOT NULL,
	fecha_creacion date NOT NULL,
	modulo varchar(20) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	
	PRIMARY KEY(id_modulo)



);



	
	














CREATE TABLE impuesto (
	id_impuesto int4 NOT NULL,
	descripcion varchar(30) NOT NULL,
	porcentaje numeric(5,2) NOT NULL,
	codigo_sii char(2) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_impuesto)



);


CREATE UNIQUE INDEX impuesto_idx_descripcion ON impuesto (
	descripcion
);



	
	












CREATE TABLE lista_negra (
	rut varchar(15) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(rut)
);












CREATE TABLE sincronizacion (
	ts_creacion timestamp with time zone NOT NULL DEFAULT (datetime('now', 'localtime')),
	ts_inicio timestamp with time zone,
	ts_termino timestamp with time zone,
	estado int4 NOT NULL DEFAULT 0,
	origen char(1) NOT NULL DEFAULT 'A',
	limpiar bool NOT NULL DEFAULT 0,
	intentos int4 NOT NULL DEFAULT 0,
	grupo varchar(50)
);












CREATE TABLE rango_id (
	nombre_tabla varchar(255) NOT NULL,
	id_usuario int4 NOT NULL,
	desde int4 NOT NULL,
	hasta int4 NOT NULL,
	PRIMARY KEY(nombre_tabla,id_usuario)
);








CREATE TABLE estado_nota_venta (
	id_estado_nota_venta int4 NOT NULL,
	descripcion varchar(20) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_estado_nota_venta)
);












CREATE TABLE forma_pago (
	id_forma_pago int4 NOT NULL,
	descripcion varchar(100),
	es_contado bool NOT NULL DEFAULT 0,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_forma_pago)



);


CREATE UNIQUE INDEX forma_pago_idx_forma_pago ON forma_pago (
	descripcion
);



	
	












CREATE TABLE motivo_no_efectividad (
	id_motivo_no_efectividad int4 NOT NULL,
	contexto varchar(100) NOT NULL,
	descripcion varchar(200) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_motivo_no_efectividad)



);



	
	












CREATE TABLE proceso (
	pid int4 NOT NULL,
	ts_inicio timestamp with time zone NOT NULL DEFAULT (datetime('now', 'localtime')),
	ts_heartbeat timestamp with time zone,
	ts_termino timestamp with time zone,
	estado int4 NOT NULL DEFAULT 0,
	tipo int4,
	PRIMARY KEY(pid)
);












CREATE TABLE version_sds (
	id_usuario int4 NOT NULL,
	version varchar(20) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_usuario)
);












CREATE TABLE usuario (
	id_usuario int4 NOT NULL,
	cargo varchar(24) NOT NULL,
	email varchar(200) NOT NULL DEFAULT 'vacio',
	estado int2 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	nombre_completo varchar(64) NOT NULL,
	password varchar(32) NOT NULL,
	rut varchar(10) NOT NULL,
	umbral_folios int2,
	username varchar(16) NOT NULL,
	nro_intentos int4,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_usuario)



);


CREATE UNIQUE INDEX usuario_idx_username ON usuario (
	username
);



	
	



	
	














CREATE TABLE banco (
	id_banco int4 NOT NULL,
	descripcion varchar(50) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_banco)



);


CREATE UNIQUE INDEX banco_idx_descripcion ON banco (
	descripcion
);



	
	












CREATE TABLE criticidad (
	id_criticidad int4 NOT NULL,
	descripcion varchar(16) NOT NULL,
	color varchar(16) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_criticidad)
);








CREATE TABLE tipo_bloqueo_cliente (
	id_tipo_bloqueo_cliente int4 NOT NULL,
	descripcion varchar(100) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_tipo_bloqueo_cliente)



);


CREATE INDEX tipo_bloqueo_cliente_idx_descripcion ON tipo_bloqueo_cliente (
	descripcion
);



	
	












CREATE TABLE tipo_documento_tributario (
	id_tipo_documento_tributario int4 NOT NULL,
	descripcion varchar(64) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_tipo_documento_tributario)



);


CREATE INDEX tipo_documento_tributario_idx_descripcion ON tipo_documento_tributario (
	descripcion
);



	
	












CREATE TABLE canal (
	id_canal int4 NOT NULL,
	descripcion varchar(30) NOT NULL,
	fecha_mensaje_desde date,
	fecha_mensaje_hasta date,
	fecha_sincronizacion_a_pda timestamp,
	mensaje varchar(250),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_canal)



);












CREATE TABLE historico_vendedores (
	id_vendedor int4 NOT NULL,
	fecha date NOT NULL,
	total_clientes int4 NOT NULL DEFAULT 0,
	clientes_en_frecuencia int4 NOT NULL DEFAULT 0,
	clientes_visitados int4 NOT NULL DEFAULT 0,
	visitas_en_frecuencia int4 NOT NULL DEFAULT 0,
	visitas_fuera_frecuencia int4 NOT NULL DEFAULT 0,
	clientes_nuevos int4 NOT NULL DEFAULT 0,
	clientes_con_pedidos int4 NOT NULL DEFAULT 0,
	clientes_no_efectividad int4 NOT NULL DEFAULT 0,
	monto_pedidos int4 NOT NULL DEFAULT 0,
	kilos_pedidos numeric(10,3) NOT NULL DEFAULT 0.0,
	sku text NOT NULL DEFAULT '',
	lineas text NOT NULL DEFAULT '',
	PRIMARY KEY(id_vendedor,fecha)
);








CREATE TABLE info_sincro (
	id_info_sincro int4 NOT NULL,
	id_usuario int4 NOT NULL,
	sentido int2 NOT NULL,
	archivo_nombre varchar(255) NOT NULL,
	archivo_tamano int4 NOT NULL,
	archivo_md5 char(32) NOT NULL,
	fecha timestamp NOT NULL,
	fecha_lectura timestamp,
	fecha_fin_procesamiento timestamp,
	es_full bool NOT NULL DEFAULT 0,
	id_info_sincro_in int4,
	PRIMARY KEY(id_info_sincro)
);












CREATE TABLE acceso (
	id_acceso int4 NOT NULL,
	id_modulo int4 NOT NULL,
	id_perfil int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_acceso,id_modulo)



);


CREATE INDEX fki_acceso_id_modulo_fkey ON acceso (
	id_modulo
);



	
	














CREATE TABLE historico_pedidos (
	id_nota_venta int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	linea int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_linea int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_motivo_no_efectividad int4,
	id_usuario_creador int4,
	cum_valorizacion_final numeric(10,3) NOT NULL DEFAULT 0,
	precio_final int4 NOT NULL DEFAULT 0,
	fecha_creacion timestamp NOT NULL,
	PRIMARY KEY(id_nota_venta,id_usuario_emisor,linea,id_producto)



);


CREATE INDEX fki_motivo_no_efectividad_fkey0 ON historico_pedidos (
	id_motivo_no_efectividad
);












CREATE TABLE contenedor (
	id_contenedor int4 NOT NULL,
	descripcion varchar(250),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_contenedor)



);


CREATE UNIQUE INDEX contenedor_idx_descripcion ON contenedor (
	descripcion
);



	
	












CREATE TABLE tipo_movimiento (
	id_tipo_movimiento int4 NOT NULL,
	descripcion varchar(50) NOT NULL,
	operador char(1) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_tipo_movimiento)



);



	
	












CREATE TABLE acteco (
	id_acteco int4 NOT NULL,
	codigo varchar(6) NOT NULL,
	descripcion varchar(128),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_acteco)



);


CREATE UNIQUE INDEX acteco_idx_codigo ON acteco (
	codigo
);



	
	












CREATE TABLE zona (
	id_zona int4 NOT NULL,
	codigo varchar(10) NOT NULL,
	descripcion varchar(100) NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_zona)



);


CREATE UNIQUE INDEX zona_idx_codigo ON zona (
	codigo
);


CREATE UNIQUE INDEX zona_idx_descripcion ON zona (
	descripcion
);



	
	














CREATE TABLE subcanal (
	id_subcanal int4 NOT NULL,
	fecha_mensaje_desde date,
	fecha_mensaje_hasta date,
	fecha_sincronizacion_a_pda timestamp,
	id_canal int4 NOT NULL,
	mensaje varchar(250),
	descripcion varchar(50) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_subcanal),
  FOREIGN KEY (id_canal)
    REFERENCES canal(id_canal)

	
	




);


CREATE INDEX subcanal_fki_canal_fkey ON subcanal (
	id_canal
);


CREATE INDEX subcanal_idx_descripcion ON subcanal (
	descripcion
);



	
	












CREATE TABLE solicitud_carga_folio (
	id_solicitud_carga_folio int4 NOT NULL,
	id_usuario int4 NOT NULL,
	estado int2 NOT NULL DEFAULT 0,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_creacion timestamp NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_solicitud_carga_folio,id_usuario),
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	




);












CREATE TABLE pregunta_encuesta (
	id_pregunta_encuesta int4 NOT NULL,
	id_encuesta int4 NOT NULL,
	descripcion varchar(250) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_pregunta_encuesta),
  FOREIGN KEY (id_encuesta)
    REFERENCES encuesta(id_encuesta)

	
	




);



	
	












CREATE TABLE codigo_autorizacion (
	id_codigo_autorizacion int4 NOT NULL,
	id_usuario_consumidor int4 NOT NULL,
	id_usuario_generador int4 NOT NULL,
	codigo varchar(100) NOT NULL,
	fecha_vigencia date NOT NULL,
	utilizado bool NOT NULL DEFAULT 1,
	fecha_sincronizacion_paso timestamp,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_codigo_autorizacion),
  FOREIGN KEY (id_usuario_consumidor)
    REFERENCES usuario(id_usuario)

	
	

);



	
	










CREATE TABLE documento_tributario (
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	esta_anulado bool NOT NULL DEFAULT 0,
	fecha_emision date NOT NULL,
	rut_emisor varchar(10) NOT NULL,
	rut_receptor varchar(10) NOT NULL,
	xml_dte text,
	xml_dte_shipping text,
	xml_enviodte text,
	xml_enviodte_shipping text,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(folio,id_tipo_documento_tributario),
  FOREIGN KEY (id_tipo_documento_tributario)
    REFERENCES tipo_documento_tributario(id_tipo_documento_tributario)

	
	




);



	
	












CREATE TABLE factura (
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	estado int2 NOT NULL DEFAULT 0,
	fecha_vencimiento_condicion_pago date NOT NULL,
	monto_neto int4 NOT NULL,
	monto_total int4 NOT NULL,
	observacion varchar(100),
	shipping int4 NOT NULL DEFAULT 0,
	shipping_total int4 NOT NULL DEFAULT 0,
	total_kilos numeric(12,6),
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(folio,id_tipo_documento_tributario),
  FOREIGN KEY (folio, id_tipo_documento_tributario)
    REFERENCES documento_tributario(folio, id_tipo_documento_tributario)

	
	




);



	
	














CREATE TABLE detalle_factura (
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	linea int2 NOT NULL,
	id_producto int4 NOT NULL,
	cum_valorizacion numeric(10,3) NOT NULL,
	cum_transaccion numeric(10,3) NOT NULL,
	descuento_monto numeric(10,2) NOT NULL DEFAULT 0,
	descuento_porcentaje numeric(5,2) NOT NULL DEFAULT 0,
	neto_linea int4 NOT NULL DEFAULT 0,
	precio_unitario int4 NOT NULL,
	shipping_aplicado int4 NOT NULL DEFAULT 0,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(linea,folio,id_tipo_documento_tributario,id_producto),
  FOREIGN KEY (folio, id_tipo_documento_tributario)
    REFERENCES factura(folio, id_tipo_documento_tributario)

	
	




);



	
	












CREATE TABLE autorizacion_anulacion_factura (
	id_codigo_autorizacion int4 NOT NULL,
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_codigo_autorizacion),
  FOREIGN KEY (id_codigo_autorizacion)
    REFERENCES codigo_autorizacion(id_codigo_autorizacion)

	
	




);



	
	












CREATE TABLE minimo_diario (
	id_usuario int4 NOT NULL,
	valor int4,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_usuario),
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	

);








CREATE TABLE guia_despacho (
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	codigo_anulacion varchar(250),
	codigo_autorizacion varchar(256),
	estado int2 NOT NULL DEFAULT 0,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_vencimiento date,
	impreso_cedible bool NOT NULL DEFAULT 0,
	iva int4 NOT NULL,
	monto_neto int4 NOT NULL,
	monto_total int4 NOT NULL,
	observacion varchar(100),
	otro_impuesto int4,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_tipo_documento_tributario,folio),
  FOREIGN KEY (folio, id_tipo_documento_tributario)
    REFERENCES documento_tributario(folio, id_tipo_documento_tributario)

	
	




);



	
	



	
	












CREATE TABLE ultimo_id (
	nombre_tabla varchar(255) NOT NULL,
	id_usuario int4 NOT NULL,
	id int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (nombre_tabla, id_usuario)
    REFERENCES rango_id(nombre_tabla, id_usuario)

	
	

);






CREATE TABLE alternativa_encuesta (
	id_alternativa_encuesta int4 NOT NULL,
	id_pregunta_encuesta int4 NOT NULL,
	descripcion varchar(250) NOT NULL,
	es_seleccion bool NOT NULL DEFAULT 0,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_alternativa_encuesta),
  FOREIGN KEY (id_pregunta_encuesta)
    REFERENCES pregunta_encuesta(id_pregunta_encuesta)

	
	




);



	
	












CREATE TABLE ciudad (
	id_ciudad int4 NOT NULL,
	id_region int4 NOT NULL,
	descripcion varchar(100) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_ciudad),
  FOREIGN KEY (id_region)
    REFERENCES region(id_region)

	
	




);



	
	












CREATE TABLE log_envio_fd (
	id_envio_fd int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	folio int4 NOT NULL,
	codigo varchar(10),
	error_log bool NOT NULL DEFAULT 0,
	fecha_envio timestamp NOT NULL,
	mensaje text,
	PRIMARY KEY(id_envio_fd),
  FOREIGN KEY (folio, id_tipo_documento_tributario)
    REFERENCES factura(folio, id_tipo_documento_tributario)

	
	




);












CREATE TABLE jefe_venta_usuario (
	id_usuario int4 NOT NULL,
	id_jefe_venta int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (id_jefe_venta)
    REFERENCES jefe_venta(id_jefe_venta)

	
	

);








CREATE TABLE denominacion_efectivo (
	id_moneda int4 NOT NULL,
	id_usuario int4 NOT NULL,
	fecha_creacion timestamp NOT NULL,
	monto int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_moneda,id_usuario,fecha_creacion),
  FOREIGN KEY (id_moneda)
    REFERENCES moneda(id_moneda)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	

);










CREATE TABLE factura_impuesto (
	id_impuesto int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	folio int4 NOT NULL,
	porcentaje numeric(5,2) NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	monto int4 NOT NULL DEFAULT 0,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_impuesto,folio,id_tipo_documento_tributario),
  FOREIGN KEY (folio, id_tipo_documento_tributario)
    REFERENCES factura(folio, id_tipo_documento_tributario)

	
	
,
  FOREIGN KEY (id_impuesto)
    REFERENCES impuesto(id_impuesto)

	
	




);



	
	












CREATE TABLE mensaje (
	id_mensaje int4 NOT NULL,
	asunto varchar(128),
	contenido varchar(1024),
	fecha_creacion timestamp NOT NULL,
	fecha_lectura timestamp,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	id_usuario_emisor int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_mensaje),
  FOREIGN KEY (id_usuario_emisor)
    REFERENCES usuario(id_usuario)

	ON DELETE CASCADE
	ON UPDATE CASCADE
,
  FOREIGN KEY (id_usuario_receptor)
    REFERENCES usuario(id_usuario)

	ON DELETE CASCADE
	ON UPDATE CASCADE




);



	
	














CREATE TABLE perfil_usuario (
	id_perfil int4 NOT NULL,
	id_usuario int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_perfil,id_usuario),
  FOREIGN KEY (id_perfil)
    REFERENCES perfil(id_perfil)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	




);


CREATE UNIQUE INDEX idx_perfil_usuario_id_usuario ON perfil_usuario (
	id_usuario
);



	
	














CREATE TABLE cliente (
	id_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_canal int4 NOT NULL,
	id_subcanal int4,
	id_tipo_bloqueo_cliente int4 NOT NULL,
	id_usuario_administrador int4,
	entrega_factura bool NOT NULL,
	entrega_guia bool NOT NULL,
	es_prospecto bool NOT NULL DEFAULT 0,
	fecha_mensaje_desde date,
	fecha_mensaje_hasta date,
	giro text,
	mensaje varchar(250),
	nombre_fantasia varchar(100) NOT NULL,
	observaciones text,
	razon_social varchar(100),
	rut char(10),
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_cliente,id_usuario_creador),
  FOREIGN KEY (id_subcanal)
    REFERENCES subcanal(id_subcanal)

	
	
,
  FOREIGN KEY (id_canal)
    REFERENCES canal(id_canal)

	
	
,
  FOREIGN KEY (id_tipo_bloqueo_cliente)
    REFERENCES tipo_bloqueo_cliente(id_tipo_bloqueo_cliente)

	
	




);


CREATE INDEX cliente_fki_subcanal_fkey ON cliente (
	id_subcanal
);


CREATE UNIQUE INDEX cliente_idx_rut ON cliente (
	rut
);



	
	












CREATE TABLE nota_credito (
	id_nota_credito int4 NOT NULL,
	id_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	estado int4 NOT NULL,
	fecha_emision date NOT NULL,
	fecha_ultima_utilizacion timestamp,
	monto int4 NOT NULL,
	monto_utilizado int4,
	numero_folio int4 NOT NULL,
	numero_voucher varchar(100),
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_nota_credito),
  FOREIGN KEY (id_cliente, id_usuario_creador)
    REFERENCES cliente(id_cliente, id_usuario_creador)

	
	




);



	
	



	
	












CREATE TABLE detalle_guia_despacho (
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	linea int2 NOT NULL,
	codigo_producto varchar(64) NOT NULL,
	cum_transaccion numeric(10,3) NOT NULL,
	cum_valorizacion numeric(10,3) NOT NULL,
	descripcion_producto varchar(200) NOT NULL,
	descuento_monto numeric(10,2) NOT NULL DEFAULT 0,
	descuento_porcentaje numeric(5,2) NOT NULL DEFAULT 0,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	neto_linea int4 NOT NULL DEFAULT 0,
	precio_unitario int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(linea,folio,id_tipo_documento_tributario,codigo_producto),
  FOREIGN KEY (id_tipo_documento_tributario, folio)
    REFERENCES guia_despacho(id_tipo_documento_tributario, folio)

	
	




);



	
	



	
	












CREATE TABLE comuna (
	id_comuna int4 NOT NULL,
	id_ciudad int4 NOT NULL,
	descripcion varchar(100) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_comuna),
  FOREIGN KEY (id_ciudad)
    REFERENCES ciudad(id_ciudad)

	
	




);



	
	












CREATE TABLE cuenta_corriente (
	id_banco int4 NOT NULL,
	numero_cuenta varchar(50) NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_cliente int4 NOT NULL,
	rut_titular varchar(15) NOT NULL,
	nombre_titular varchar(50) NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(numero_cuenta,id_banco,id_cliente,id_usuario_creador),
  FOREIGN KEY (id_banco)
    REFERENCES banco(id_banco)

	
	
,
  FOREIGN KEY (id_cliente, id_usuario_creador)
    REFERENCES cliente(id_cliente, id_usuario_creador)

	
	

);



	
	



	
	












CREATE TABLE forma_pago_cliente (
	id_forma_pago int4 NOT NULL,
	id_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	aplica_cobranza bool NOT NULL DEFAULT 0,
	aplica_vuelto bool NOT NULL DEFAULT 0,
	monto_maximo LONG,
	monto_utilizado LONG,
	orden int2 NOT NULL,
	plazo_maximo int4,
	suspendido bool NOT NULL DEFAULT 0,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_forma_pago,id_cliente,id_usuario_creador),
  FOREIGN KEY (id_cliente, id_usuario_creador)
    REFERENCES cliente(id_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_forma_pago)
    REFERENCES forma_pago(id_forma_pago)

	
	

);



	
	



	
	










CREATE TABLE cliente_ret_ex (
	id_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_impuesto int4 NOT NULL,
	exencion bool NOT NULL DEFAULT 1,
	retencion bool NOT NULL DEFAULT 1,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_cliente,id_impuesto,id_usuario_creador),
  FOREIGN KEY (id_impuesto)
    REFERENCES impuesto(id_impuesto)

	
	
,
  FOREIGN KEY (id_cliente, id_usuario_creador)
    REFERENCES cliente(id_cliente, id_usuario_creador)

	
	




);


CREATE UNIQUE INDEX cliente_ret_ex_idx ON cliente_ret_ex (
	id_cliente, 
	id_impuesto, 
	exencion, 
	retencion
);



	
	












CREATE TABLE solicitud_forma_pago_cliente (
	id_solicitud int4 NOT NULL,
	id_usuario int4 NOT NULL,
	id_cliente int4 NOT NULL,
	id_forma_pago int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_solicitud,id_usuario),
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (id_cliente, id_usuario_creador)
    REFERENCES cliente(id_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_forma_pago)
    REFERENCES forma_pago(id_forma_pago)

	
	




);


CREATE INDEX solicitud_forma_pago_cliente_idx_id_cliente ON solicitud_forma_pago_cliente (
	id_cliente
);



	
	














CREATE TABLE recaudo (
	id_recaudo int4 NOT NULL,
	id_usuario int4 NOT NULL,
	id_banco int4,
	id_forma_pago int4 NOT NULL,
	id_nota_credito int4,
	autorizador_documento varchar(32),
	fecha_fin_autorizacion date,
	fecha_inicio_autorizacion date,
	fecha_recaudacion date,
	fecha_vencimiento_doc date,
	monto int4 NOT NULL,
	nro_cuenta varchar(20),
	nro_documento varchar(20),
	plaza_documento varchar(30),
	rut_titular varchar(10),
	serie_documento varchar(20),
	tipo_documento varchar(20),
	voucher_impreso bool,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_recaudo,id_usuario),
  FOREIGN KEY (id_banco)
    REFERENCES banco(id_banco)

	
	
,
  FOREIGN KEY (id_nota_credito)
    REFERENCES nota_credito(id_nota_credito)

	
	
,
  FOREIGN KEY (id_forma_pago)
    REFERENCES forma_pago(id_forma_pago)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	




);


CREATE INDEX recaudo_fki_id_banco_fkey ON recaudo (
	id_banco
);












CREATE TABLE pago_factura (
	id_pago_factura int4 NOT NULL,
	id_recaudo int4 NOT NULL,
	id_usuario int4 NOT NULL,
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	monto_factura int4 NOT NULL,
	monto_pago int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_pago_factura,id_usuario,id_recaudo),
  FOREIGN KEY (id_recaudo, id_usuario)
    REFERENCES recaudo(id_recaudo, id_usuario)

	
	




);














CREATE TABLE empresa (
	id_empresa int4 NOT NULL,
	id_comuna int4 NOT NULL,
	giro varchar(100) NOT NULL,
	nombre_fantasia varchar(100),
	razon_social varchar(100) NOT NULL,
	rut char(10) NOT NULL,
	direccion varchar(500) NOT NULL,
	telefono1 varchar(30),
	telefono2 varchar(30),
	fax1 varchar(30),
	fax2 varchar(30),
	sitio_web varchar(100),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_empresa),
  FOREIGN KEY (id_comuna)
    REFERENCES comuna(id_comuna)

	
	




);


CREATE UNIQUE INDEX empresa_idx_rut ON empresa (
	rut
);


CREATE UNIQUE INDEX empresa_idx_razon_social ON empresa (
	razon_social
);



	
	














CREATE TABLE linea (
	id_linea int4 NOT NULL,
	id_empresa int4 NOT NULL,
	descripcion varchar(250) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_linea),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	




);


CREATE UNIQUE INDEX linea_idx_descripcion ON linea (
	descripcion
);



	
	












CREATE TABLE familia (
	id_familia int4 NOT NULL,
	id_linea int4 NOT NULL,
	descripcion varchar(250) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_familia),
  FOREIGN KEY (id_linea)
    REFERENCES linea(id_linea)

	
	




);


CREATE INDEX familia_idx_descripcion ON familia (
	descripcion
);



	
	



	
	












CREATE TABLE grupo_producto (
	id_grupo_producto int4 NOT NULL,
	id_familia int4 NOT NULL,
	descripcion varchar(250) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_grupo_producto),
  FOREIGN KEY (id_familia)
    REFERENCES familia(id_familia)

	
	




);



	
	



	
	












CREATE TABLE grupo (
	id_grupo LONG NOT NULL,
	id_empresa int4 NOT NULL,
	activo bool NOT NULL DEFAULT 1,
	descripcion varchar(50) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_grupo),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	




);


CREATE INDEX fki_fki_empresa_grupo ON grupo (
	id_empresa
);


CREATE UNIQUE INDEX grupo_idx_descripcion ON grupo (
	descripcion
);



	
	












CREATE TABLE tipo_entrega (
	id_tipo_entrega int4 NOT NULL,
	id_cliente int4,
	id_usuario_creador int4 NOT NULL,
	id_empresa int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	descripcion varchar(100),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_tipo_entrega),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	
,
  FOREIGN KEY (id_tipo_documento_tributario)
    REFERENCES tipo_documento_tributario(id_tipo_documento_tributario)

	
	




);


CREATE INDEX tipo_nota_venta_fki_empresa_fkey ON tipo_entrega (
	id_empresa
);


CREATE INDEX tipo_nota_venta_fki_tipo_documento_tributario_fkey ON tipo_entrega (
	id_tipo_documento_tributario
);



	
	












CREATE TABLE empresa_acteco (
	id_empresa int4 NOT NULL,
	id_acteco int4 NOT NULL,
	observacion varchar(250),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_empresa,id_acteco),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	
,
  FOREIGN KEY (id_acteco)
    REFERENCES acteco(id_acteco)

	
	

);



	
	



	
	










CREATE TABLE empresa_canal (
	id_canal int4 NOT NULL,
	id_empresa int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_canal,id_empresa),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	
,
  FOREIGN KEY (id_canal)
    REFERENCES canal(id_canal)

	
	




);



	
	



	
	














CREATE TABLE grupo_usuario (
	id_grupo int4 NOT NULL,
	id_usuario int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_grupo,id_usuario),
  FOREIGN KEY (id_grupo)
    REFERENCES grupo(id_grupo)

	ON DELETE CASCADE
	ON UPDATE CASCADE
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	ON DELETE CASCADE
	ON UPDATE CASCADE




);



	
	












CREATE TABLE caf (
	id_caf int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	id_empresa int4 NOT NULL,
	contenido text NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_caf,id_tipo_documento_tributario),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	
,
  FOREIGN KEY (id_tipo_documento_tributario)
    REFERENCES tipo_documento_tributario(id_tipo_documento_tributario)

	
	




);



	
	












CREATE TABLE sucursal_empresa (
	id_sucursal_empresa int4 NOT NULL,
	id_empresa int4,
	id_zona int4 NOT NULL,
	id_comuna int4 NOT NULL,
	cdgsiisucur varchar(9),
	descripcion varchar(50) NOT NULL,
	direccion varchar(500) NOT NULL,
	telefono1 varchar(30),
	telefono2 varchar(30),
	fax1 varchar(30),
	fax2 varchar(30),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_sucursal_empresa),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	
,
  FOREIGN KEY (id_zona)
    REFERENCES zona(id_zona)

	
	
,
  FOREIGN KEY (id_comuna)
    REFERENCES comuna(id_comuna)

	
	




);


CREATE UNIQUE INDEX sucursal_empresa_idx_descripcion ON sucursal_empresa (
	descripcion
);



	
	



	
	














CREATE TABLE subgrupo_producto (
	id_subgrupo_producto int4 NOT NULL,
	id_grupo_producto int4 NOT NULL,
	descripcion varchar(250) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_subgrupo_producto),
  FOREIGN KEY (id_grupo_producto)
    REFERENCES grupo_producto(id_grupo_producto)

	
	




);


CREATE INDEX subgrupo_producto_idx_descripcion ON subgrupo_producto (
	descripcion
);



	
	



	
	












CREATE TABLE pda (
	id_pda int4 NOT NULL,
	id_empresa int4 NOT NULL,
	estado int2 NOT NULL,
	fecha_bloqueo date,
	fecha_creacion date NOT NULL,
	id_interno varchar(256) NOT NULL,
	observaciones varchar(1024),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	
	PRIMARY KEY(id_pda),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	




);


CREATE INDEX pda_fki_fki_pda_empresa ON pda (
	id_empresa
);


CREATE UNIQUE INDEX pda_idx_pda_id_interno ON pda (
	id_interno
);



	
	



	
	














CREATE TABLE territorio (
	id_territorio int4 NOT NULL,
	id_sucursal_empresa int4 NOT NULL,
	descripcion varchar(50) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_territorio),
  FOREIGN KEY (id_sucursal_empresa)
    REFERENCES sucursal_empresa(id_sucursal_empresa)

	
	




);


CREATE INDEX territorio_idx_descripcion ON territorio (
	descripcion
);



	
	














CREATE TABLE linea_territorio_diferencial (
	id_linea int4 NOT NULL,
	id_territorio int4 NOT NULL,
	diferencial int4 NOT NULL DEFAULT 0,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_linea,id_territorio),
  FOREIGN KEY (id_territorio)
    REFERENCES territorio(id_territorio)

	
	
,
  FOREIGN KEY (id_linea)
    REFERENCES linea(id_linea)

	
	

);



	
	










CREATE TABLE movil (
	id_movil int4 NOT NULL,
	id_sucursal_empresa int4 NOT NULL,
	id_usuario int4,
	descripcion varchar(100) NOT NULL,
	patente varchar(10) NOT NULL,
	tonelaje int4,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_movil),
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (id_sucursal_empresa)
    REFERENCES sucursal_empresa(id_sucursal_empresa)

	
	




);


CREATE UNIQUE INDEX movil_idx_usuario ON movil (
	id_usuario
);



	
	



	
	












CREATE TABLE login_pda_usuario (
	id_login_pda_usuario int4 NOT NULL,
	id_usuario int4 NOT NULL,
	borrado bool NOT NULL DEFAULT 0,
	fecha_login timestamp NOT NULL,
	fecha_sincronizacion_desde_pda timestamp,
	id_pda int4 NOT NULL,
	PRIMARY KEY(id_login_pda_usuario,id_usuario),
  FOREIGN KEY (id_pda)
    REFERENCES pda(id_pda)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	




);












CREATE TABLE pda_usuario (
	id_pda int4 NOT NULL,
	id_usuario int4 NOT NULL,
	fecha_asignacion date NOT NULL,
	fecha_devolucion date,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_pda,id_usuario),
  FOREIGN KEY (id_pda)
    REFERENCES pda(id_pda)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	




);



	
	














CREATE TABLE log_pda_usuario (
	id_log_pda_usuario int4 NOT NULL,
	id_usuario int4 NOT NULL,
	borrado bool NOT NULL DEFAULT 0,
	descripcion_evento varchar(256),
	fecha_evento timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	id_pda int4 NOT NULL,
	PRIMARY KEY(id_log_pda_usuario,id_usuario),
  FOREIGN KEY (id_pda)
    REFERENCES pda(id_pda)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	




);


CREATE INDEX log_pda_usuario_fki_id_pda ON log_pda_usuario (
	id_pda
);


CREATE INDEX log_pda_usuario_fki_id_usuario ON log_pda_usuario (
	id_usuario
);












CREATE TABLE rango_folio (
	id_rango_folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	id_caf int4,
	id_usuario int4,
	desde int4 NOT NULL,
	hasta int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_rango_folio,id_tipo_documento_tributario),
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (id_caf, id_tipo_documento_tributario)
    REFERENCES caf(id_caf, id_tipo_documento_tributario)

	
	




);



	
	



	
	












CREATE TABLE bodega_sucursal (
	id_bodega int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_sucursal_empresa int4 NOT NULL,
	id_comuna int4 NOT NULL,
	descripcion varchar(20),
	direccion varchar(500) NOT NULL,
	telefono1 varchar(30),
	telefono2 varchar(30),
	fax1 varchar(30),
	fax2 varchar(30),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_bodega,id_sucursal_empresa,id_usuario_creador),
  FOREIGN KEY (id_sucursal_empresa)
    REFERENCES sucursal_empresa(id_sucursal_empresa)

	
	
,
  FOREIGN KEY (id_comuna)
    REFERENCES comuna(id_comuna)

	
	




);


CREATE UNIQUE INDEX bodega_sucursal_idx_descripcion ON bodega_sucursal (
	descripcion
);



	
	



	
	












CREATE TABLE sucursal_cliente (
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_cliente int4 NOT NULL,
	id_territorio int4 NOT NULL,
	id_comuna int4 NOT NULL,
	id_comuna_f int4,
	fecha_creacion date,
	horario_llamada_desde char(5),
	horario_llamada_hasta char(5),
	horario_visita_desde char(5),
	horario_visita_hasta char(5),
	horario_ccenter_desde char(5),
	horario_ccenter_hasta char(5),
	id_usuario_administrador int4,
	descripcion varchar(40) NOT NULL,
	observaciones varchar(500),
	valor_periodicidad_llamado char(7),
	valor_periodicidad_visita char(7) NOT NULL,
	valor_periodicidad_ccenter char(7),
	local int4 NOT NULL DEFAULT 0,
	direccion varchar(500) NOT NULL,
	telefono1 varchar(30),
	telefono2 varchar(30),
	celular varchar(30),
	fax1 varchar(30),
	fax2 varchar(30),
	direccion_f varchar(500) NOT NULL,
	telefono1_f varchar(30),
	telefono2_f varchar(30),
	fax1_f varchar(30),
	fax2_f varchar(30),
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_sucursal_cliente,id_usuario_creador),
  FOREIGN KEY (id_territorio)
    REFERENCES territorio(id_territorio)

	
	
,
  FOREIGN KEY (id_cliente, id_usuario_creador)
    REFERENCES cliente(id_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_comuna)
    REFERENCES comuna(id_comuna)

	
	
,
  FOREIGN KEY (id_comuna_f)
    REFERENCES comuna(id_comuna)

	
	




);



	
	



	
	












CREATE TABLE producto (
	id_producto int4 NOT NULL,
	id_empresa int4 NOT NULL,
	id_producto_contenido int4,
	id_subgrupo_producto int4 NOT NULL,
	id_unidad_medida_transaccion int4 NOT NULL,
	id_unidad_medida_valorizacion int4 NOT NULL,
	codigo varchar(64) NOT NULL,
	codigo_barra_dun14 char(14),
	codigo_barra_ean13 char(13),
	cumt_pc numeric(10,3),
	cumv_maxima numeric(10,3),
	cumv_minima numeric(10,3),
	cumv_promedio numeric(10,3),
	cumv_visible bool NOT NULL DEFAULT 1,
	descripcion varchar(200) NOT NULL,
	es_comercializable bool NOT NULL,
	fecha_desde_vigencia_dos date,
	fecha_desde_vigencia_tres date,
	fecha_desde_vigencia_uno date NOT NULL,
	fecha_hasta_vigencia_dos date,
	fecha_hasta_vigencia_tres date,
	fecha_hasta_vigencia_uno date NOT NULL,
	ficha_tecnica varchar(300),
	formato varchar(100),
	precio_base_vigencia_dos int4,
	precio_base_vigencia_tres int4,
	precio_base_vigencia_uno int4 NOT NULL,
	vida_util int4,
	precio_minimo_vigencia_uno int4 NOT NULL,
	precio_minimo_vigencia_dos int4,
	precio_minimo_vigencia_tres int4,
	unidades_por_bandeja int2,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto),
  FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa)

	
	
,
  FOREIGN KEY (id_subgrupo_producto)
    REFERENCES subgrupo_producto(id_subgrupo_producto)

	
	
,
  FOREIGN KEY (id_unidad_medida_valorizacion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (id_producto_contenido)
    REFERENCES producto(id_producto)

	
	




);


CREATE INDEX producto_fki_fki_empresa ON producto (
	id_empresa
);


CREATE UNIQUE INDEX producto_idx_producto ON producto (
	codigo
);


CREATE UNIQUE INDEX producto_idx_descripcion ON producto (
	descripcion
);



	
	












CREATE TABLE movimiento (
	id_movil int4 NOT NULL,
	id_movimiento int4 NOT NULL,
	id_tipo_movimiento int4 NOT NULL,
	folio int4,
	id_producto int4 NOT NULL,
	id_tipo_documento_tributario int4,
	id_unidad_medida_transaccion int4 NOT NULL,
	cum_transaccion numeric(10,3) NOT NULL DEFAULT 0,
	cum_valorizacion numeric(10,3) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	fecha_sincronizacion_paso timestamp DEFAULT (datetime('now', 'localtime')),
	PRIMARY KEY(id_movimiento,id_tipo_movimiento,id_movil),
  FOREIGN KEY (id_movil)
    REFERENCES movil(id_movil)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_tipo_movimiento)
    REFERENCES tipo_movimiento(id_tipo_movimiento)

	
	
,
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	




);


CREATE INDEX fki_tipo_movimiento_fkey ON movimiento (
	id_tipo_movimiento
);



	
	












CREATE TABLE nota_venta (
	id_nota_venta int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	id_motivo_no_efectividad int4,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_tipo_entrega int4 NOT NULL,
	id_estado_nota_venta int4 NOT NULL,
	tipo_nota_venta int4 NOT NULL,
	id_ariztia int4,
	fecha_creacion date NOT NULL,
	fecha_entrega date NOT NULL,
	orden_compra varchar(20),
	origen_nota_venta varchar(250),
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_nota_venta,id_usuario_emisor,id_usuario_receptor),
  FOREIGN KEY (id_motivo_no_efectividad)
    REFERENCES motivo_no_efectividad(id_motivo_no_efectividad)

	
	
,
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_usuario_receptor)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (id_tipo_entrega)
    REFERENCES tipo_entrega(id_tipo_entrega)

	
	
,
  FOREIGN KEY (id_estado_nota_venta)
    REFERENCES estado_nota_venta(id_estado_nota_venta)

	
	




);


CREATE INDEX idx_nv_id_usuario_receptor ON nota_venta (
	id_usuario_receptor
);



	
	












CREATE TABLE mensaje_sucursal_cliente (
	id_mensaje_sucursal_cliente int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	estado int2 NOT NULL,
	desde varchar(64),
	a varchar(64),
	asunto varchar(64),
	contenido varchar(512) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_mensaje_sucursal_cliente),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	

);








CREATE TABLE descuento_negociacion_suc_cliente (
	id_producto int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	maximo numeric(3,1) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto,id_sucursal_cliente,id_usuario_creador),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	




);


CREATE INDEX fki_dn_producto_suc_cliente ON descuento_negociacion_suc_cliente (
	id_sucursal_cliente, 
	id_producto
);


CREATE INDEX descuento_negociacion_suc_cliente_idx_id_sucursal_cliente ON descuento_negociacion_suc_cliente (
	id_sucursal_cliente
);



	
	












CREATE TABLE contacto (
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	nombre_completo varchar(100) NOT NULL,
	cargo varchar(32),
	cumpleanos varchar(5),
	depto varchar(250),
	email varchar(32),
	id_usuario_administrador int4,
	telefono1 varchar(16),
	telefono2 varchar(16),
	fax varchar(16),
	celular varchar(16),
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_sucursal_cliente,id_usuario_creador,nombre_completo),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	




);



	
	












CREATE TABLE historico_detalle_nv (
	id_nota_venta int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	linea int4 NOT NULL,
	id_producto int4 NOT NULL,
	cum_valorizacion_final numeric(10,3) NOT NULL DEFAULT 0,
	precio_final int4 NOT NULL DEFAULT 0,
	PRIMARY KEY(id_usuario_receptor),
  FOREIGN KEY (id_nota_venta, id_usuario_emisor, id_usuario_receptor)
    REFERENCES nota_venta(id_nota_venta, id_usuario_emisor, id_usuario_receptor)

	
	




);












CREATE TABLE descuento_volumen_suc_cliente (
	id_producto int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	nivel int2 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	cum_transaccion_desde numeric(10,3),
	cum_transaccion_hasta numeric(10,3),
	cum_valorizacion_desde numeric(10,3),
	cum_valorizacion_hasta numeric(10,3),
	descuento numeric(3,1) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto,id_sucursal_cliente,nivel),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	




);


CREATE INDEX fki_dv_producto_suc_cliente ON descuento_volumen_suc_cliente (
	id_sucursal_cliente, 
	id_producto
);


CREATE INDEX descuento_volumen_suc_cliente_idx_id_sucursal_cliente ON descuento_volumen_suc_cliente (
	id_sucursal_cliente
);



	
	












CREATE TABLE folio (
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	id_rango_folio int4 NOT NULL,
	estado int2 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(folio,id_tipo_documento_tributario),
  FOREIGN KEY (id_rango_folio, id_tipo_documento_tributario)
    REFERENCES rango_folio(id_rango_folio, id_tipo_documento_tributario)

	
	




);



	
	



	
	












CREATE TABLE producto_suc_cliente_precio_especial (
	id_producto int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	fecha_vigencia_desde timestamp NOT NULL,
	fecha_vigencia_hasta timestamp NOT NULL,
	precio int4 NOT NULL,
	precio_maximo int4,
	precio_minimo int4,
	aplica_shipping bool NOT NULL DEFAULT 0,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto,id_sucursal_cliente),
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	

);


CREATE INDEX producto_suc_cliente_precio_especial_idx_id_sucursal_cliente ON producto_suc_cliente_precio_especial (
	id_sucursal_cliente
);



	
	










CREATE TABLE visita (
	id_visita int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_usuario int4 NOT NULL,
	estado int2 NOT NULL,
	fecha_visita timestamp NOT NULL,
	fecha_aviso timestamp,
	PRIMARY KEY(id_visita),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	

);








CREATE TABLE criticidad_sucursal_cliente (
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_criticidad int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_sucursal_cliente,id_usuario_creador),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_criticidad)
    REFERENCES criticidad(id_criticidad)

	
	

);








CREATE TABLE cobranza_saldo (
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_usuario_receptor int4,
	monto_autorizado int4 NOT NULL DEFAULT 0,
	saldo_vencido int4 NOT NULL DEFAULT 0,
	saldo_sin_vencer int4 NOT NULL DEFAULT 0,
	saldo_vencido_15 int4 NOT NULL DEFAULT 0,
	saldo_vencido_30 int4 NOT NULL DEFAULT 0,
	saldo_vencido_45 int4 NOT NULL DEFAULT 0,
	saldo_vencido_60 int4 NOT NULL DEFAULT 0,
	saldo_vencido_90 int4 NOT NULL DEFAULT 0,
	saldo_vencido_120 int4 NOT NULL DEFAULT 0,
	saldo_vencido_mas_120 int4 NOT NULL DEFAULT 0,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_usuario_receptor)
    REFERENCES usuario(id_usuario)

	
	

);












CREATE TABLE sucursal_cliente_no_efectividad (
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_motivo_no_efectividad int4 NOT NULL,
	fecha_sincronizacion_paso timestamp,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_sucursal_cliente,id_usuario_creador,id_motivo_no_efectividad),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_motivo_no_efectividad)
    REFERENCES motivo_no_efectividad(id_motivo_no_efectividad)

	
	

);








CREATE TABLE sucursal_cliente_usuario (
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	id_usuario int4 NOT NULL,
	fecha_sincronizacion_paso timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_sucursal_cliente,id_usuario,id_usuario_creador),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	

);


CREATE UNIQUE INDEX sucursal_cliente_usuario_idx_id_sucursal_cliente_usuario_id_usuario ON sucursal_cliente_usuario (
	id_sucursal_cliente, 
	id_usuario
);


CREATE INDEX sucursal_cliente_usuario_idx_id_sucursal_cliente ON sucursal_cliente_usuario (
	id_sucursal_cliente
);



	
	










CREATE TABLE producto_unidad_medida_transaccion (
	id_producto int4 NOT NULL,
	id_unidad_medida int4 NOT NULL,
	factor_unidad_medida_maximo numeric(10,3) NOT NULL,
	factor_unidad_medida_minimo numeric(10,3) NOT NULL,
	factor_unidad_medida_promedio numeric(10,3) NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto,id_unidad_medida),
  FOREIGN KEY (id_unidad_medida)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	

);










CREATE TABLE producto_suc_cliente_bloqueado (
	id_producto int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto,id_sucursal_cliente),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	

);


CREATE INDEX producto_suc_cliente_bloqueado_idx_id_sucursal_cliente ON producto_suc_cliente_bloqueado (
	id_sucursal_cliente
);



	
	










CREATE TABLE serial (
	serial varchar(50) NOT NULL,
	id_movil int4 NOT NULL,
	id_producto int4 NOT NULL,
	cumt_original numeric(10,3) NOT NULL DEFAULT 0,
	cumv_original numeric(10,3) NOT NULL DEFAULT 0,
	cumt_final numeric(10,3) NOT NULL DEFAULT 0,
	cumv_final numeric(10,3) NOT NULL DEFAULT 0,
	nuevo_serial bool,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(serial),
  FOREIGN KEY (id_movil)
    REFERENCES movil(id_movil)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	

);



	
	



	
	










CREATE TABLE producto_cliente_shipping (
	id_cliente int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto,id_cliente),
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_cliente, id_usuario_creador)
    REFERENCES cliente(id_cliente, id_usuario_creador)

	
	

);



	
	










CREATE TABLE producto_contenedor (
	id_contenedor int4 NOT NULL,
	id_producto int4 NOT NULL,
	cantidad_unidades_contenedor int4,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_contenedor,id_producto),
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_contenedor)
    REFERENCES contenedor(id_contenedor)

	
	




);












CREATE TABLE encuesta_sucursal_cliente (
	id_encuesta int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	contestada bool NOT NULL DEFAULT 0,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_encuesta,id_sucursal_cliente,id_usuario_creador),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_encuesta)
    REFERENCES encuesta(id_encuesta)

	
	




);


CREATE INDEX encuesta_sucursal_cliente_fki_encuesta_fkey ON encuesta_sucursal_cliente (
	id_encuesta
);


CREATE UNIQUE INDEX encuesta_sucursal_cliente_idx_id_sucursal_cliente ON encuesta_sucursal_cliente (
	id_sucursal_cliente
);



	
	



	
	












CREATE TABLE factura_nota_venta (
	folio int4 NOT NULL,
	id_nota_venta int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_nota_venta,id_usuario_emisor,id_tipo_documento_tributario,folio),
  FOREIGN KEY (id_nota_venta, id_usuario_emisor, id_usuario_receptor)
    REFERENCES nota_venta(id_nota_venta, id_usuario_emisor, id_usuario_receptor)

	
	
,
  FOREIGN KEY (folio, id_tipo_documento_tributario)
    REFERENCES factura(folio, id_tipo_documento_tributario)

	
	




);


CREATE INDEX factura_nota_venta_fki_factura_nota_venta ON factura_nota_venta (
	id_nota_venta
);



	
	












CREATE TABLE guia_despacho_nota_venta (
	id_nota_venta int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	folio int4 NOT NULL,
	id_tipo_documento_tributario int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_nota_venta,folio,id_usuario_emisor,id_tipo_documento_tributario),
  FOREIGN KEY (id_nota_venta, id_usuario_emisor, id_usuario_receptor)
    REFERENCES nota_venta(id_nota_venta, id_usuario_emisor, id_usuario_receptor)

	
	
,
  FOREIGN KEY (id_tipo_documento_tributario, folio)
    REFERENCES guia_despacho(id_tipo_documento_tributario, folio)

	
	




);


CREATE INDEX fki_fki_gd_nv ON guia_despacho_nota_venta (
	id_nota_venta
);



	
	



	
	












CREATE TABLE serial_contenedor_movimiento (
	id_movil int4 NOT NULL,
	id_serial_contenedor_movimiento int4 NOT NULL,
	id_movimiento int4 NOT NULL,
	id_unidad_medida_transaccion int4 NOT NULL,
	cum_transaccion numeric(10,3),
	cum_valorizacion numeric(10,3),
	serial varchar(50) NOT NULL,
	serial_contenedor varchar(50) NOT NULL,
	serial_pallet int4,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	id_tipo_movimiento int4 NOT NULL,
	PRIMARY KEY(id_serial_contenedor_movimiento,id_movil),
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (id_movimiento, id_movil, id_tipo_movimiento)
    REFERENCES movimiento(id_movimiento, id_movil, id_tipo_movimiento)

	
	




);



	
	












CREATE TABLE producto_impuesto (
	id_impuesto int4 NOT NULL,
	id_producto int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_impuesto,id_producto),
  FOREIGN KEY (id_impuesto)
    REFERENCES impuesto(id_impuesto)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	




);



	
	












CREATE TABLE producto_sugerido (
	id_producto int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto,id_sucursal_cliente),
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	




);


CREATE INDEX producto_sugerido_idx_id_sucursal_cliente ON producto_sugerido (
	id_sucursal_cliente
);



	
	












CREATE TABLE producto_suc_empresa (
	id_producto int4 NOT NULL,
	id_sucursal_empresa int4 NOT NULL,
	diferencial_precio numeric(10,2),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_producto,id_sucursal_empresa),
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_sucursal_empresa)
    REFERENCES sucursal_empresa(id_sucursal_empresa)

	
	




);


CREATE INDEX producto_suc_empresa_fki_id_producto_fkey ON producto_suc_empresa (
	id_producto
);



	
	












CREATE TABLE stock_inicial_movil (
	id_movil int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_unidad_medida_transaccion int4 NOT NULL,
	cum_valorizacion_disponible numeric(10,3),
	cum_valorizacion_no_disponible numeric(10,3),
	cum_transaccion_disponible numeric(10,3) NOT NULL DEFAULT 0,
	cum_transaccion_no_disponible numeric(10,3) NOT NULL DEFAULT 0,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_movil,id_producto),
  FOREIGN KEY (id_movil)
    REFERENCES movil(id_movil)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	




);



	
	



	
	












CREATE TABLE stock_bodega (
	id_bodega int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_sucursal_empresa int4 NOT NULL,
	id_unidad_medida_transaccion int4 NOT NULL,
	cum_valorizacion_disponible numeric(10,3),
	cum_transaccion_disponible numeric(10,3) NOT NULL DEFAULT 0,
	cum_transaccion_no_disponible numeric(10,3) NOT NULL DEFAULT 0,
	cum_valorizacion_no_disponible numeric(10,3),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	id_usuario_creador int4 NOT NULL,
	PRIMARY KEY(id_bodega,id_producto,id_sucursal_empresa),
  FOREIGN KEY (id_bodega, id_sucursal_empresa, id_usuario_creador)
    REFERENCES bodega_sucursal(id_bodega, id_sucursal_empresa, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	




);


CREATE INDEX stock_bodega_fki_fki_stock_producto_suc_empresa ON stock_bodega (
	id_producto, 
	id_sucursal_empresa
);



	
	












CREATE TABLE devolucion (
	id_tipo_documento_tributario int4 NOT NULL,
	folio int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador_sucursal_cliente int4 NOT NULL,
	tipo_devolucion varchar(20) NOT NULL,
	guia_despacho_cliente int4,
	numero_voucher varchar(32),
	observacion varchar(264),
	fecha_guia_cliente date,
	motivo_devolucion varchar(50),
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_tipo_documento_tributario,folio),
  FOREIGN KEY (id_usuario_receptor)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (folio, id_tipo_documento_tributario)
    REFERENCES documento_tributario(folio, id_tipo_documento_tributario)

	
	
,
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador_sucursal_cliente)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	




);



	
	



	
	












CREATE TABLE detalle_devolucion (
	id_tipo_documento_tributario int4 NOT NULL,
	folio int4 NOT NULL,
	linea_devolucion int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_unidad_medida_transaccion int4 NOT NULL,
	cum_transaccion numeric(10,3) NOT NULL,
	cum_valorizacion numeric(10,3) NOT NULL,
	guia_despacho_cliente int4,
	observacion varchar(128),
	precio_unitario int4 NOT NULL,
	precio_final int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(linea_devolucion,folio,id_tipo_documento_tributario),
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (id_tipo_documento_tributario, folio)
    REFERENCES devolucion(id_tipo_documento_tributario, folio)

	
	




);


CREATE INDEX detalle_devolucion_fki_producto_fkey ON detalle_devolucion (
	id_producto
);



	
	



	
	












CREATE TABLE stock_movil (
	id_movil int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_unidad_medida_transaccion int4 NOT NULL,
	cum_valorizacion_disponible numeric(10,3),
	cum_valorizacion_no_disponible numeric(10,3),
	cum_transaccion_disponible numeric(10,3) NOT NULL DEFAULT 0,
	cum_transaccion_no_disponible numeric(10,3) NOT NULL DEFAULT 0,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_movil,id_producto),
  FOREIGN KEY (id_movil)
    REFERENCES movil(id_movil)

	
	
,
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	




);


CREATE INDEX stock_movil_idx_id_producto ON stock_movil (
	id_producto
);



	
	












CREATE TABLE cobranza (
	id_tipo_documento_tributario int4 NOT NULL,
	folio int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador_sucursal_cliente int4,
	id_usuario_receptor int4,
	id_usuario_creador_cobranza int4 NOT NULL,
	fecha_emision date NOT NULL,
	fecha_ultimo_abono date,
	fecha_vencimiento date NOT NULL,
	monto_abonado int4 NOT NULL DEFAULT 0,
	monto_original int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_tipo_documento_tributario,folio),
  FOREIGN KEY (id_usuario_receptor)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (id_sucursal_cliente, id_usuario_creador_sucursal_cliente)
    REFERENCES sucursal_cliente(id_sucursal_cliente, id_usuario_creador)

	
	
,
  FOREIGN KEY (id_usuario_creador_cobranza)
    REFERENCES usuario(id_usuario)

	
	




);



	
	



	
	












CREATE TABLE nv_impuesto (
	id_impuesto int4 NOT NULL,
	id_nota_venta int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	porcentaje numeric(5,2) NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_impuesto,id_nota_venta,id_producto,id_usuario_emisor),
  FOREIGN KEY (id_nota_venta, id_usuario_emisor, id_usuario_receptor)
    REFERENCES nota_venta(id_nota_venta, id_usuario_emisor, id_usuario_receptor)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_impuesto)
    REFERENCES impuesto(id_impuesto)

	
	




);



	
	



	
	












CREATE TABLE respuesta_encuesta (
	id_respuesta_encuesta int4 NOT NULL,
	id_usuario int4 NOT NULL,
	id_alternativa_encuesta int4 NOT NULL,
	id_encuesta int4 NOT NULL,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador int4 NOT NULL,
	otra varchar(200),
	respuesta int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_respuesta_encuesta,id_usuario),
  FOREIGN KEY (id_alternativa_encuesta)
    REFERENCES alternativa_encuesta(id_alternativa_encuesta)

	
	
,
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (id_encuesta, id_sucursal_cliente, id_usuario_creador)
    REFERENCES encuesta_sucursal_cliente(id_encuesta, id_sucursal_cliente, id_usuario_creador)

	
	




);



	
	



	
	












CREATE TABLE meta (
	id_usuario int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_unidad_medida int4 NOT NULL,
	cum_valorizacion_meta numeric(10,3) NOT NULL,
	cum_valorizacion_actual numeric(10,3),
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_usuario,id_producto,id_unidad_medida),
  FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_unidad_medida)
    REFERENCES unidad_medida(id_unidad_medida)

	
	




);












CREATE TABLE cobranza_voucher (
	id_tipo_documento_tributario int4 NOT NULL,
	folio int4 NOT NULL,
	id_forma_pago int4 NOT NULL,
	id_recaudo int4 NOT NULL,
	id_usuario int4 NOT NULL,
	numero_voucher varchar(50) NOT NULL,
	monto_cancelado int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_tipo_documento_tributario,folio,id_forma_pago,id_recaudo,id_usuario),
  FOREIGN KEY (id_forma_pago)
    REFERENCES forma_pago(id_forma_pago)

	
	
,
  FOREIGN KEY (id_tipo_documento_tributario, folio)
    REFERENCES cobranza(id_tipo_documento_tributario, folio)

	
	
,
  FOREIGN KEY (id_recaudo, id_usuario)
    REFERENCES recaudo(id_recaudo, id_usuario)

	
	

);



	
	



	
	












CREATE TABLE autorizacion_forma_pago (
	id_codigo_autorizacion int4 NOT NULL,
	id_banco int4,
	id_forma_pago int4,
	id_sucursal_cliente int4 NOT NULL,
	id_usuario_creador_sucursal_cliente int4,
	id_recaudo int4,
	id_usuario int4,
	monto int4 NOT NULL,
	fecha_vencimiento_documento date,
	nro_cuenta_corriente varchar(50),
	nro_documento varchar(20),
	rut_titular varchar(10),
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_codigo_autorizacion),
  FOREIGN KEY (id_forma_pago)
    REFERENCES forma_pago(id_forma_pago)

	
	
,
  FOREIGN KEY (id_codigo_autorizacion)
    REFERENCES codigo_autorizacion(id_codigo_autorizacion)

	
	
,
  FOREIGN KEY (id_usuario_creador_sucursal_cliente, id_sucursal_cliente)
    REFERENCES sucursal_cliente(id_usuario_creador, id_sucursal_cliente)

	
	
,
  FOREIGN KEY (id_recaudo, id_usuario)
    REFERENCES recaudo(id_recaudo, id_usuario)

	
	




);



	
	












CREATE TABLE detalle_nota_venta (
	id_nota_venta int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	linea int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_usuario_receptor int4 NOT NULL,
	id_motivo_no_efectividad int4,
	id_unidad_medida_transaccion int4 NOT NULL,
	cum_transaccion_final numeric(10,3) NOT NULL DEFAULT 0,
	cum_transaccion_inicial numeric(10,3) NOT NULL DEFAULT 0,
	cum_valorizacion_final numeric(10,3) NOT NULL DEFAULT 0,
	cum_valorizacion_inicial numeric(10,3) NOT NULL DEFAULT 0,
	descuento_negociacion numeric(3,1) NOT NULL DEFAULT 0,
	descuento_volumen numeric(3,1) NOT NULL DEFAULT 0,
	linea_territorio_diferencial numeric(10,2),
	dif_sucursal_empresa numeric(10,2),
	precio_base int4 NOT NULL DEFAULT 0,
	precio_especial int4,
	precio_minimo int4,
	precio_unitario int4 NOT NULL,
	precio_final int4 NOT NULL DEFAULT 0,
	cum_valorizacion_bodega numeric(10,3),
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(linea,id_nota_venta,id_usuario_emisor,id_producto),
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_motivo_no_efectividad)
    REFERENCES motivo_no_efectividad(id_motivo_no_efectividad)

	
	
,
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (id_usuario_emisor, id_nota_venta, id_usuario_receptor)
    REFERENCES nota_venta(id_usuario_emisor, id_nota_venta, id_usuario_receptor)

	
	




);


CREATE INDEX fki_motivo_no_efectividad_fkey ON detalle_nota_venta (
	id_motivo_no_efectividad
);


CREATE INDEX idx_dnv_id_usuario_receptor ON detalle_nota_venta (
	id_usuario_receptor
);












CREATE TABLE autorizacion_modificacion_precio (
	id_codigo_autorizacion int4 NOT NULL,
	id_usuario_creador_sucursal_cliente int4,
	id_sucursal_cliente int4 NOT NULL,
	id_producto int4 NOT NULL,
	id_nota_venta int4,
	id_usuario_emisor int4,
	id_usuario_receptor int4,
	precio_producto int4 NOT NULL,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_codigo_autorizacion),
  FOREIGN KEY (id_codigo_autorizacion)
    REFERENCES codigo_autorizacion(id_codigo_autorizacion)

	
	
,
  FOREIGN KEY (id_usuario_creador_sucursal_cliente, id_sucursal_cliente)
    REFERENCES sucursal_cliente(id_usuario_creador, id_sucursal_cliente)

	
	
,
  FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)

	
	
,
  FOREIGN KEY (id_nota_venta, id_usuario_emisor, id_usuario_receptor)
    REFERENCES nota_venta(id_nota_venta, id_usuario_emisor, id_usuario_receptor)

	
	

);



	
	












CREATE TABLE df_dnv (
	id_tipo_documento_tributario int4 NOT NULL,
	folio int4 NOT NULL,
	linea_factura int2 NOT NULL,
	id_producto int4 NOT NULL,
	id_nota_venta int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	linea_nota_venta int4 NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_nota_venta,id_usuario_emisor,linea_nota_venta,id_tipo_documento_tributario,folio,linea_factura,id_producto),
  FOREIGN KEY (linea_nota_venta, id_nota_venta, id_usuario_emisor, id_producto)
    REFERENCES detalle_nota_venta(linea, id_nota_venta, id_usuario_emisor, id_producto)

	
	
,
  FOREIGN KEY (folio, id_tipo_documento_tributario, id_producto, linea_factura)
    REFERENCES detalle_factura(folio, id_tipo_documento_tributario, id_producto, linea)

	
	




);



	
	












CREATE TABLE serial_contenedor_dnv (
	id_serial_contenedor_dnv varchar(50) NOT NULL,
	id_nota_venta int4 NOT NULL,
	id_usuario_emisor int4 NOT NULL,
	linea int4 NOT NULL,
	id_unidad_medida_transaccion int4,
	id_producto int4 NOT NULL,
	cum_transaccion numeric(10,3),
	cum_valorizacion numeric(10,3),
	serial_contenedor varchar(50) NOT NULL,
	fecha_sincronizacion_a_pda timestamp,
	fecha_sincronizacion_desde_pda timestamp,
	fecha_sincronizacion_paso timestamp,
	fecha_modificacion timestamp NOT NULL DEFAULT (datetime('now', 'localtime')),
	borrado bool NOT NULL DEFAULT 0,
	PRIMARY KEY(id_serial_contenedor_dnv,id_usuario_emisor,id_nota_venta,linea),
  FOREIGN KEY (id_unidad_medida_transaccion)
    REFERENCES unidad_medida(id_unidad_medida)

	
	
,
  FOREIGN KEY (linea, id_nota_venta, id_usuario_emisor, id_producto)
    REFERENCES detalle_nota_venta(linea, id_nota_venta, id_usuario_emisor, id_producto)

	
	




);



	
	



	
	





CREATE TABLE v_usuario_empresa
(
  id_empresa int4 not null,
  id_usuario int4 not null,
  fecha_modificacion timestamp not null
);

CREATE TABLE v_usuario_producto
(
  id_usuario int4 not null,
  id_producto int4 not null
);

CREATE TABLE v_usuario_cliente
(
  id_usuario int4 not null,
  id_cliente int4 not null,
  fecha_modificacion timestamp not null,
  PRIMARY KEY(id_usuario, id_cliente)
);

CREATE TABLE v_usuario_sucursal_cliente
(
  id_usuario int4 not null,
  id_sucursal_cliente int4 not null,
  id_cliente int4 not null,
  fecha_modificacion timestamp not null,
  PRIMARY KEY(id_usuario, id_sucursal_cliente, id_cliente)
);

CREATE TABLE v_usuario_sucursal_empresa
(
  id_usuario int4 not null,
  id_sucursal_empresa int4 not null,
  id_empresa int4 not null,
  fecha_modificacion timestamp not null
);

CREATE TABLE v_ultimo_id (
  nombre_tabla varchar(255) NOT NULL,
  id_usuario int4 NOT NULL,
  id int4 NOT NULL
);

CREATE TABLE v_ruta (
  id_cliente int4 not null,
  razon_social varchar(100) NOT NULL,
  id_sucursal_cliente int4 NOT NULL,
  id_usuario_creador int4 NOT NULL,
  descripcion varchar(40) NOT NULL,
  valor_periodicidad_visita char(7) NOT NULL,
  id_tipo_bloqueo_cliente int4 NOT NULL,
  descripcion_bloqueado varchar(100) NOT NULL,
  motivo_visita varchar(2) NOT NULL,
  valor_periodicidad_llamado char(7) NOT NULL,
  id_usuario int4 NOT NULL,
  horario_visita_desde char(5),
  horario_llamada_desde char(5),
  PRIMARY KEY(id_cliente, id_sucursal_cliente, motivo_visita)
);

CREATE TABLE v_territorio_comuna
(
  id_sucursal_empresa int4 not null,
  id_territorio int4 not null,
  id_comuna int4 not null,
  descripcion varchar(100) not null
);
CREATE TRIGGER actualiza_cliente_aft_update 
  AFTER UPDATE OF 
  id_cliente, id_usuario_creador, id_canal, id_subcanal, id_tipo_bloqueo_cliente, 
  id_usuario_administrador, entrega_factura, entrega_guia, es_prospecto, 
  fecha_mensaje_desde, fecha_mensaje_hasta, giro, mensaje, nombre_fantasia, 
  observaciones, razon_social, rut, borrado 
  ON cliente FOR EACH ROW 
  BEGIN
    UPDATE cliente SET fecha_modificacion = datetime('now', 'localtime') WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;

CREATE TRIGGER actualiza_sucursal_cliente_aft_insert 
  AFTER INSERT ON sucursal_cliente FOR EACH ROW 
  BEGIN
    UPDATE sucursal_cliente SET fecha_modificacion = datetime('now', 'localtime') WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador;
    UPDATE cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM sucursal_cliente WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador) WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;

CREATE TRIGGER actualiza_sucursal_cliente_aft_update 
  AFTER UPDATE OF 
  id_sucursal_cliente, id_usuario_creador, id_cliente, id_territorio, 
  id_comuna, id_comuna_f, fecha_creacion, horario_llamada_desde, 
  horario_llamada_hasta, horario_visita_desde, horario_visita_hasta, 
  id_usuario_administrador, descripcion, observaciones, valor_periodicidad_llamado, 
  valor_periodicidad_visita, "local", direccion, telefono1, telefono2, 
  fax1, fax2, direccion_f, telefono1_f, telefono2_f, fax1_f, fax2_f, 
  fecha_modificacion 
  ON sucursal_cliente FOR EACH ROW 
  BEGIN
    UPDATE sucursal_cliente SET fecha_modificacion = datetime('now', 'localtime') WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador;
    UPDATE cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM sucursal_cliente WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador) WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;

CREATE TRIGGER actualiza_contacto_aft_insert 
  AFTER INSERT ON contacto FOR EACH ROW 
  BEGIN
    UPDATE contacto SET fecha_modificacion = datetime('now', 'localtime') WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador AND nombre_completo = NEW.nombre_completo;
    UPDATE sucursal_cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM contacto WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador AND nombre_completo = NEW.nombre_completo) WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;

CREATE TRIGGER actualiza_contacto_aft_update 
  AFTER UPDATE OF 
  id_sucursal_cliente, id_usuario_creador, nombre_completo, cargo, 
  cumpleanos, depto, email, fax, id_usuario_administrador, telefono1, 
  telefono2, borrado
  ON contacto FOR EACH ROW 
  BEGIN
    UPDATE contacto SET fecha_modificacion = datetime('now', 'localtime') WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador AND nombre_completo = NEW.nombre_completo;
    UPDATE sucursal_cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM contacto WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador AND nombre_completo = NEW.nombre_completo) WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;






CREATE TRIGGER actualiza_forma_pago_cliente_aft_insert AFTER INSERT ON forma_pago_cliente FOR EACH ROW 
  BEGIN
    UPDATE forma_pago_cliente SET fecha_modificacion = datetime('now', 'localtime') WHERE id_forma_pago = NEW.id_forma_pago AND id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
    UPDATE cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM forma_pago_cliente WHERE id_forma_pago = NEW.id_forma_pago AND id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador) WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;

CREATE TRIGGER actualiza_forma_pago_cliente_aft_update AFTER UPDATE OF 
  id_forma_pago, id_cliente, id_usuario_creador, aplica_cobranza, aplica_vuelto, 
  monto_maximo, monto_utilizado, orden, plazo_maximo, suspendido, fecha_modificacion, borrado 
  ON forma_pago_cliente FOR EACH ROW 
  BEGIN
    UPDATE forma_pago_cliente SET fecha_modificacion = datetime('now', 'localtime') WHERE id_forma_pago = NEW.id_forma_pago AND id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
    UPDATE cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM forma_pago_cliente WHERE id_forma_pago = NEW.id_forma_pago AND id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador) WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;



CREATE TRIGGER actualiza_cuenta_corriente_aft_insert AFTER INSERT ON cuenta_corriente FOR EACH ROW 
  BEGIN
    UPDATE cuenta_corriente SET fecha_modificacion = datetime('now', 'localtime') WHERE numero_cuenta = NEW.numero_cuenta AND id_banco = NEW.id_banco AND id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
    UPDATE cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM cuenta_corriente WHERE numero_cuenta = NEW.numero_cuenta AND id_banco = NEW.id_banco AND id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador) WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;

CREATE TRIGGER actualiza_cuenta_corriente_aft_update AFTER UPDATE OF 
  id_banco, numero_cuenta, id_usuario_creador, id_cliente, rut_titular, 
  nombre_titular, fecha_modificacion, borrado 
  ON cuenta_corriente FOR EACH ROW 
  BEGIN
    UPDATE cuenta_corriente SET fecha_modificacion = datetime('now', 'localtime') WHERE numero_cuenta = NEW.numero_cuenta AND id_banco = NEW.id_banco AND id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
    UPDATE cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM cuenta_corriente WHERE numero_cuenta = NEW.numero_cuenta AND id_banco = NEW.id_banco AND id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador) WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;



CREATE TRIGGER actualiza_nota_credito_aft_insert 
  AFTER INSERT ON nota_credito FOR EACH ROW 
  BEGIN
    UPDATE nota_credito SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_credito = NEW.id_nota_credito;
    UPDATE cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM nota_credito WHERE id_nota_credito = NEW.id_nota_credito) WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;

CREATE TRIGGER actualiza_nota_credito_aft_update 
  AFTER UPDATE OF 
  id_nota_credito, estado, fecha_emision, 
  fecha_ultima_utilizacion, id_cliente, 
  id_usuario_creador, monto, monto_utilizado, numero_folio, numero_voucher, 
  fecha_modificacion, borrado 
  ON nota_credito FOR EACH ROW 
  BEGIN
    UPDATE nota_credito SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_credito = NEW.id_nota_credito;
    UPDATE cliente SET fecha_modificacion = (SELECT fecha_modificacion FROM nota_credito WHERE id_nota_credito = NEW.id_nota_credito) WHERE id_cliente = NEW.id_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;




CREATE TRIGGER actualiza_detalle_nota_venta_aft_insert AFTER INSERT ON detalle_nota_venta FOR EACH ROW 
  BEGIN
    UPDATE detalle_nota_venta SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_producto = NEW.id_producto AND linea = NEW.linea;
    UPDATE nota_venta SET fecha_modificacion = (SELECT fecha_modificacion FROM detalle_nota_venta WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_producto = NEW.id_producto AND linea = NEW.linea) WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor;
  END;

CREATE TRIGGER actualiza_detalle_nota_venta_aft_update AFTER UPDATE OF 
  id_nota_venta, id_usuario_emisor, linea, id_producto, id_motivo_no_efectividad, 
  id_unidad_medida_transaccion, cum_transaccion_final, cum_transaccion_inicial, 
  cum_valorizacion_final, cum_valorizacion_inicial, descuento_negociacion, 
  descuento_volumen, linea_territorio_diferencial, dif_sucursal_empresa, 
  precio_base, 
  precio_especial, precio_minimo, precio_unitario, precio_final, 
  fecha_modificacion, borrado 
  ON detalle_nota_venta FOR EACH ROW 
  BEGIN
    UPDATE detalle_nota_venta SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_producto = NEW.id_producto AND linea = NEW.linea;
    UPDATE nota_venta SET fecha_modificacion = (SELECT fecha_modificacion FROM detalle_nota_venta WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_producto = NEW.id_producto AND linea = NEW.linea) WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor;
  END;



CREATE TRIGGER actualiza_nv_impuesto_aft_insert AFTER INSERT ON nv_impuesto FOR EACH ROW 
  BEGIN
    UPDATE nv_impuesto SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_impuesto = NEW.id_impuesto AND id_producto = NEW.id_producto;
    UPDATE nota_venta SET fecha_modificacion = (SELECT fecha_modificacion FROM nv_impuesto WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_impuesto = NEW.id_impuesto AND id_producto = NEW.id_producto) WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor;
  END;

CREATE TRIGGER actualiza_nv_impuesto_aft_update AFTER UPDATE OF 
  id_impuesto, id_nota_venta, id_producto, id_usuario_emisor, porcentaje, 
  fecha_modificacion, borrado 
  ON nv_impuesto FOR EACH ROW 
  BEGIN
    UPDATE nv_impuesto SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_impuesto = NEW.id_impuesto AND id_producto = NEW.id_producto;
    UPDATE nota_venta SET fecha_modificacion = (SELECT fecha_modificacion FROM nv_impuesto WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_impuesto = NEW.id_impuesto AND id_producto = NEW.id_producto) WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor;
  END;




CREATE TRIGGER actualiza_factura_aft_insert AFTER INSERT ON factura FOR EACH ROW 
  BEGIN
    UPDATE factura SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
    UPDATE documento_tributario SET fecha_modificacion = (SELECT fecha_modificacion FROM factura WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;

CREATE TRIGGER actualiza_factura_aft_update AFTER UPDATE OF 
  folio, id_tipo_documento_tributario, estado, 
  fecha_vencimiento_condicion_pago, 
  monto_neto, monto_total, observacion, shipping, shipping_total, 
  total_kilos, fecha_modificacion, borrado
  ON factura FOR EACH ROW 
  BEGIN
    UPDATE factura SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
    UPDATE documento_tributario SET fecha_modificacion = (SELECT fecha_modificacion FROM factura WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;





CREATE TRIGGER actualiza_detalle_factura_aft_insert AFTER INSERT ON detalle_factura FOR EACH ROW 
  BEGIN
    UPDATE detalle_factura SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND id_producto = NEW.id_producto AND linea = NEW.linea;
    UPDATE factura SET fecha_modificacion = (SELECT fecha_modificacion FROM detalle_factura WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND id_producto = NEW.id_producto AND linea = NEW.linea) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;

CREATE TRIGGER actualiza_detalle_factura_aft_update AFTER UPDATE OF 
  folio, id_tipo_documento_tributario, linea, id_producto, cum_valorizacion, 
  cum_transaccion, descuento_monto, descuento_porcentaje, 
  neto_linea, precio_unitario, 
  fecha_modificacion, borrado 
  ON detalle_factura FOR EACH ROW 
  BEGIN
    UPDATE detalle_factura SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND id_producto = NEW.id_producto AND linea = NEW.linea;
    UPDATE factura SET fecha_modificacion = (SELECT fecha_modificacion FROM detalle_factura WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND id_producto = NEW.id_producto AND linea = NEW.linea) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;





CREATE TRIGGER actualiza_factura_impuesto_aft_insert AFTER INSERT ON factura_impuesto FOR EACH ROW 
  BEGIN
    UPDATE factura_impuesto SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND id_impuesto = NEW.id_impuesto;
    UPDATE factura SET fecha_modificacion = (SELECT fecha_modificacion FROM factura_impuesto WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND id_impuesto = NEW.id_impuesto) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;

CREATE TRIGGER actualiza_factura_impuesto_aft_update AFTER UPDATE OF 
  id_impuesto, id_tipo_documento_tributario, folio, 
  porcentaje, 
  fecha_modificacion, borrado 
  ON factura_impuesto FOR EACH ROW 
  BEGIN
    UPDATE factura_impuesto SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND id_impuesto = NEW.id_impuesto;
    UPDATE factura SET fecha_modificacion = (SELECT fecha_modificacion FROM factura_impuesto WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND id_impuesto = NEW.id_impuesto) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;





CREATE TRIGGER actualiza_devolucion_aft_insert AFTER INSERT ON devolucion FOR EACH ROW 
  BEGIN
    UPDATE devolucion SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
    UPDATE documento_tributario SET fecha_modificacion = (SELECT fecha_modificacion FROM devolucion WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;

CREATE TRIGGER actualiza_devolucion_aft_update AFTER UPDATE OF 
  id_tipo_documento_tributario, folio, id_usuario_receptor, id_sucursal_cliente, 
  id_usuario_creador_sucursal_cliente, tipo_devolucion, 
  guia_despacho_cliente, numero_voucher, 
  observacion, fecha_guia_cliente, motivo_devolucion, fecha_modificacion, borrado
  ON devolucion FOR EACH ROW 
  BEGIN
    UPDATE devolucion SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
    UPDATE documento_tributario SET fecha_modificacion = (SELECT fecha_modificacion FROM devolucion WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;



CREATE TRIGGER actualiza_detalle_devolucion_aft_insert AFTER INSERT ON detalle_devolucion FOR EACH ROW 
  BEGIN
    UPDATE detalle_devolucion SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND linea_devolucion = NEW.linea_devolucion;
    UPDATE devolucion SET fecha_modificacion = (SELECT fecha_modificacion FROM detalle_devolucion WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND linea_devolucion = NEW.linea_devolucion) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;

CREATE TRIGGER actualiza_detalle_devolucion_aft_update AFTER UPDATE OF 
  id_tipo_documento_tributario, folio, linea_devolucion, id_producto, 
  id_unidad_medida_transaccion, cum_transaccion, cum_valorizacion, 
  guia_despacho_cliente, 
  observacion, precio_unitario, precio_final, fecha_modificacion, borrado 
  ON detalle_devolucion FOR EACH ROW 
  BEGIN
    UPDATE detalle_devolucion SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND linea_devolucion = NEW.linea_devolucion;
    UPDATE devolucion SET fecha_modificacion = (SELECT fecha_modificacion FROM detalle_devolucion WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND linea_devolucion = NEW.linea_devolucion) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;



CREATE TRIGGER actualiza_cobranza_voucher_aft_insert AFTER INSERT ON cobranza_voucher FOR EACH ROW 
  BEGIN
    UPDATE cobranza_voucher SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND numero_voucher = NEW.numero_voucher;
    UPDATE cobranza SET fecha_modificacion = (SELECT fecha_modificacion FROM cobranza_voucher WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND numero_voucher = NEW.numero_voucher) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;

CREATE TRIGGER actualiza_cobranza_voucher_aft_update AFTER UPDATE OF 
  id_tipo_documento_tributario, folio, numero_voucher, id_forma_pago, 
  monto_cancelado, 
  fecha_modificacion, borrado 
  ON cobranza_voucher FOR EACH ROW 
  BEGIN
    UPDATE cobranza_voucher SET fecha_modificacion = datetime('now', 'localtime') WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND numero_voucher = NEW.numero_voucher;
    UPDATE cobranza SET fecha_modificacion = (SELECT fecha_modificacion FROM cobranza_voucher WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio AND numero_voucher = NEW.numero_voucher) WHERE id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;



CREATE  TRIGGER tg_actualiza_meta AFTER INSERT 
  ON detalle_factura FOR EACH ROW 
  BEGIN
    UPDATE meta SET cum_valorizacion_actual = (cum_valorizacion_actual + NEW.cum_valorizacion) WHERE meta.id_producto = NEW.id_producto and meta.id_unidad_medida=3;
    UPDATE meta SET cum_valorizacion_actual = (cum_valorizacion_actual + NEW.cum_transaccion) WHERE meta.id_producto = NEW.id_producto and meta.id_unidad_medida=1; 
  END;



CREATE TRIGGER actualiza_nota_venta_aft_insert AFTER INSERT ON nota_venta FOR EACH ROW 
  BEGIN
    UPDATE nota_venta SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_usuario_receptor = NEW.id_usuario_receptor;
  END;

CREATE TRIGGER actualiza_nota_venta_aft_update 
  AFTER UPDATE OF id_estado_nota_venta, fecha_modificacion, borrado 
  ON nota_venta FOR EACH ROW 
  BEGIN
    UPDATE nota_venta SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_usuario_receptor = NEW.id_usuario_receptor;
  END;

 -- marca como exitoso el registro de pedido en v_ruta
CREATE TRIGGER actualiza_ruta_nota_venta_emitida
AFTER INSERT ON nota_venta 
FOR EACH ROW 
WHEN NEW.id_estado_nota_venta = 1
  BEGIN
    UPDATE v_ruta SET motivo_visita = 'PE' 
	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente 
	AND id_usuario_creador = NEW.id_usuario_creador
	AND motivo_visita = 'P';
  END;

  CREATE TRIGGER actualiza_ruta_nota_venta_facturada 
  AFTER UPDATE OF id_estado_nota_venta 
  ON nota_venta 
  FOR EACH ROW 
  WHEN NEW.id_estado_nota_venta = 3
  BEGIN
    UPDATE v_ruta SET motivo_visita = 'EE' 
	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente 
	AND id_usuario_creador = NEW.id_usuario_creador
	AND motivo_visita = 'E';
  END;

  CREATE TRIGGER actualiza_ruta_nota_venta_no_entregada 
  AFTER UPDATE OF id_estado_nota_venta 
  ON nota_venta 
  FOR EACH ROW 
  WHEN NEW.id_estado_nota_venta = 5
  BEGIN
    UPDATE v_ruta SET motivo_visita = 'EN' 
	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente 
	AND id_usuario_creador = NEW.id_usuario_creador
	AND motivo_visita = 'E';
  END;

  CREATE TRIGGER actualiza_ruta_nota_venta_anulada 
  AFTER UPDATE OF id_estado_nota_venta 
  ON nota_venta 
  FOR EACH ROW 
  WHEN NEW.id_estado_nota_venta = 4
  BEGIN
    UPDATE v_ruta SET motivo_visita = 'PN' 
	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente 
	AND id_usuario_creador = NEW.id_usuario_creador
	AND motivo_visita = 'P';
  END;
  
-- marca como no exitoso pedidos rehusados
CREATE TRIGGER actualiza_ruta_nota_venta_rehusada
AFTER INSERT ON sucursal_cliente_no_efectividad 
FOR EACH ROW 
  BEGIN
    UPDATE v_ruta SET motivo_visita = 'PN' 
	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente 
	AND id_usuario_creador = NEW.id_usuario_creador
	AND motivo_visita = 'P';
  END;

-- marca en ruta devolucion exitosa
  CREATE TRIGGER actualiza_ruta_devolucion_realizada 
  AFTER UPDATE OF numero_voucher 
  ON devolucion 
  FOR EACH ROW 
  WHEN NEW.numero_voucher IS NOT NULL
  BEGIN
    UPDATE v_ruta SET motivo_visita = 'DE' 
	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente 
	AND id_usuario_creador = NEW.id_usuario_creador
	AND motivo_visita = 'D';
  END;

-- marca en ruta cobranza exitosa
  CREATE TRIGGER actualiza_ruta_nota_cobranza_recaudada 
  AFTER UPDATE OF monto_abonado 
  ON cobranza 
  FOR EACH ROW 
  WHEN NEW.monto_abonado > 0
  BEGIN
    UPDATE v_ruta SET motivo_visita = 'CE' 
	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente 
	AND id_usuario_creador = NEW.id_usuario_creador_sucursal_cliente
	AND motivo_visita = 'C';
  END;
  
  CREATE TRIGGER actualiza_factura_nota_venta_aft_insert AFTER INSERT ON factura_nota_venta FOR EACH ROW 
  BEGIN
    UPDATE factura_nota_venta SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;

CREATE TRIGGER actualiza_factura_nota_venta_aft_update AFTER UPDATE OF 
  fecha_modificacion, borrado 
  ON factura_nota_venta FOR EACH ROW 
  BEGIN
    UPDATE factura_nota_venta SET fecha_modificacion = datetime('now', 'localtime') WHERE id_nota_venta = NEW.id_nota_venta AND id_usuario_emisor = NEW.id_usuario_emisor AND id_tipo_documento_tributario = NEW.id_tipo_documento_tributario AND folio = NEW.folio;
  END;

-- elimina visita si tomo pedido

 CREATE TRIGGER borra_visita_aft_insert_nv
 AFTER INSERT ON nota_venta 
 FOR EACH ROW
 WHEN NEW.id_estado_nota_venta = 1
  BEGIN
  	DELETE FROM visita
  	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;

-- elimina visita si hay motivo no efectividad

 CREATE TRIGGER borra_visita_aft_insert_scne
 AFTER INSERT ON sucursal_cliente_no_efectividad 
 FOR EACH ROW
  BEGIN
  	DELETE FROM visita
  	WHERE id_sucursal_cliente = NEW.id_sucursal_cliente AND id_usuario_creador = NEW.id_usuario_creador;
  END;
  
-- inserta/suma stock cada vez que se inserta en movimiento
CREATE TRIGGER tbi_movimiento0
AFTER INSERT ON movimiento 
FOR EACH ROW
WHEN NEW.id_tipo_movimiento = 10
  BEGIN
	      UPDATE stock_movil
	      SET cum_valorizacion_disponible = cum_valorizacion_disponible + NEW.cum_valorizacion,
	      cum_transaccion_disponible = cum_transaccion_disponible + NEW.cum_transaccion
	      WHERE id_movil = NEW.id_movil
	      AND id_producto = NEW.id_producto
          AND EXISTS (
	      SELECT *
	      FROM stock_movil
	      WHERE id_movil = NEW.id_movil
	      AND id_producto = NEW.id_producto
          );         
      
	      INSERT
	      INTO stock_movil
	      (id_movil, id_producto, id_unidad_medida_transaccion, cum_valorizacion_disponible, cum_valorizacion_no_disponible, cum_transaccion_disponible, cum_transaccion_no_disponible)
	      SELECT id_movil, id_producto, id_unidad_medida_transaccion, cum_valorizacion, 0, cum_transaccion, 0
		  FROM movimiento
		  WHERE id_movimiento = NEW.id_movimiento
		  AND id_movil = NEW.id_movil
		  AND id_tipo_movimiento = 10
          AND NOT EXISTS (
	      SELECT *
	      FROM stock_movil
	      WHERE id_movil = NEW.id_movil
	      AND id_producto = NEW.id_producto
          );         
  END;

-- maneja inserciones en v_ruta evitando duplicados con igual motivo de entrega
CREATE TRIGGER actualiza_ruta_igual_motivo_entrega
BEFORE INSERT ON v_ruta 
FOR EACH ROW 
WHEN NEW.motivo_visita = 'E'
  BEGIN
    DELETE FROM v_ruta 
	WHERE id_cliente = NEW.id_cliente 
	AND id_sucursal_cliente = NEW.id_sucursal_cliente
	AND motivo_visita LIKE 'E%';
  END;

-- maneja inserciones en v_ruta evitando duplicados con igual motivo de cobranza
CREATE TRIGGER actualiza_ruta_igual_motivo_cobranza
BEFORE INSERT ON v_ruta 
FOR EACH ROW 
WHEN NEW.motivo_visita = 'C'
  BEGIN
    DELETE FROM v_ruta 
	WHERE id_cliente = NEW.id_cliente 
	AND id_sucursal_cliente = NEW.id_sucursal_cliente
	AND motivo_visita LIKE 'C%';
  END;
CREATE VIEW "v_linea_producto" AS
	SELECT linea.id_linea, familia.id_familia, grupo_producto.id_grupo_producto, subgrupo_producto.id_subgrupo_producto, producto.id_producto FROM ((((producto JOIN subgrupo_producto ON ((subgrupo_producto.id_subgrupo_producto = producto.id_subgrupo_producto))) JOIN grupo_producto ON ((grupo_producto.id_grupo_producto = subgrupo_producto.id_grupo_producto))) JOIN familia ON ((familia.id_familia = grupo_producto.id_familia))) JOIN linea ON ((linea.id_linea = familia.id_linea)));

	CREATE VIEW v_ruta_extendida AS
 SELECT v_ruta.id_cliente, v_ruta.razon_social, v_ruta.id_sucursal_cliente, v_ruta.id_usuario_creador, v_ruta.descripcion, v_ruta.valor_periodicidad_visita, v_ruta.id_tipo_bloqueo_cliente, v_ruta.descripcion_bloqueado, v_ruta.motivo_visita, v_ruta.valor_periodicidad_llamado, v_ruta.id_usuario, v_ruta.horario_visita_desde, v_ruta.horario_llamada_desde, count(mensaje_sucursal_cliente.id_mensaje_sucursal_cliente) AS tiene_mensaje, criticidad_sucursal_cliente.id_criticidad, count(visita.id_visita) AS tiene_visita
   FROM v_ruta
   LEFT JOIN mensaje_sucursal_cliente ON mensaje_sucursal_cliente.id_sucursal_cliente = v_ruta.id_sucursal_cliente AND mensaje_sucursal_cliente.id_usuario_creador = v_ruta.id_usuario_creador
   LEFT JOIN criticidad_sucursal_cliente ON criticidad_sucursal_cliente.id_sucursal_cliente = v_ruta.id_sucursal_cliente AND criticidad_sucursal_cliente.id_usuario_creador = v_ruta.id_usuario_creador
   LEFT JOIN visita ON visita.id_sucursal_cliente = v_ruta.id_sucursal_cliente AND visita.id_usuario_creador = v_ruta.id_usuario_creador
  GROUP BY v_ruta.id_cliente, v_ruta.razon_social, v_ruta.id_sucursal_cliente, v_ruta.id_usuario_creador, v_ruta.descripcion, v_ruta.valor_periodicidad_visita, v_ruta.id_tipo_bloqueo_cliente, v_ruta.descripcion_bloqueado, v_ruta.motivo_visita, v_ruta.valor_periodicidad_llamado, v_ruta.id_usuario, criticidad_sucursal_cliente.id_criticidad, v_ruta.horario_visita_desde, v_ruta.horario_llamada_desde;
	   
	CREATE VIEW v_cumplimiento_meta AS
SELECT producto.descripcion AS producto, unidad_medida.descripcion, meta.cum_valorizacion_meta AS meta, meta.cum_valorizacion_actual AS actual, SUM(detalle_nota_venta.cum_valorizacion_final) AS cum_valorizacion_hoy, CAST((100 * (meta.cum_valorizacion_actual + SUM(detalle_nota_venta.cum_valorizacion_final)) / meta.cum_valorizacion_meta) AS INTEGER) as cumplimiento
FROM meta
LEFT JOIN detalle_nota_venta ON detalle_nota_venta.id_producto = meta.id_producto
JOIN producto ON producto.id_producto = meta.id_producto
JOIN unidad_medida ON unidad_medida.id_unidad_medida = producto.id_unidad_medida_valorizacion
WHERE meta.cum_valorizacion_meta > 0
GROUP BY producto, unidad_medida.descripcion, meta, actual;

