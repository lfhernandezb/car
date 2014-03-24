-- DROP TABLE perfil
DROP TABLE IF EXISTS "perfil" CASCADE;

-- CREATE TABLE perfil
CREATE TABLE "perfil" (
	"id_perfil" int4 NOT NULL DEFAULT nextval('perfil_id_perfil_seq'::regclass),
	"id_empresa" int4 NOT NULL,
	"estado" int2 NOT NULL,
	"descripcion" varchar(32) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "perfil_pkey" PRIMARY KEY("id_perfil")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "perfil_idx_descripcion" ON "perfil" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_perfil" BEFORE INSERT OR UPDATE 
	ON "perfil" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "perfil" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "perfil" TO "taisa";

GRANT SELECT ON TABLE "perfil" TO "usrarwsdb";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "perfil" TO "usrarbowdb";



-- DROP TABLE info_sincro_pda
DROP TABLE IF EXISTS "info_sincro_pda" CASCADE;

-- CREATE TABLE info_sincro_pda
CREATE TABLE "info_sincro_pda" (
	"id_usuario" int4 NOT NULL,
	"nombre_proceso" varchar(16) NOT NULL,
	"fecha_ultima_sincro" timestamp NOT NULL,
	PRIMARY KEY("id_usuario","nombre_proceso")
);


ALTER TABLE "info_sincro_pda" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "info_sincro_pda" TO "taisa";

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "info_sincro_pda" TO "usrarwsdb";



-- DROP TABLE jefe_venta
DROP TABLE IF EXISTS "jefe_venta" CASCADE;

-- CREATE TABLE jefe_venta
CREATE TABLE "jefe_venta" (
	"id_jefe_venta" int4 NOT NULL,
	"id_sucursal_empresa" int4 NOT NULL,
	"username" varchar(16) NOT NULL,
	"password" varchar(32) NOT NULL,
	"rut" varchar(10) NOT NULL,
	"nombre_completo" varchar(64) NOT NULL,
	"cargo" varchar(24) NOT NULL,
	"email" varchar(200) NOT NULL DEFAULT 'vacio'::character varying,
	"estado" int2 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
	"borrado" bool NOT NULL DEFAULT false,
	PRIMARY KEY("id_jefe_venta")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "jefe_venta_idx_username" ON "jefe_venta" (
	"username"
);


CREATE TRIGGER "tgr_f_mod_usuario" BEFORE INSERT OR UPDATE 
	ON "jefe_venta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_usuario" AFTER INSERT OR UPDATE 
	ON "jefe_venta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_usuario"();


ALTER TABLE "jefe_venta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "jefe_venta" TO "taisa";

GRANT SELECT ON TABLE "jefe_venta" TO "usrarwsdb";

GRANT SELECT, UPDATE ON TABLE "jefe_venta" TO "usrarbowdb";



-- DROP TABLE encuesta
DROP TABLE IF EXISTS "encuesta" CASCADE;

-- CREATE TABLE encuesta
CREATE TABLE "encuesta" (
	"id_encuesta" int4 NOT NULL,
	"descripcion" varchar(250) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "encuesta_pkey" PRIMARY KEY("id_encuesta")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "encuesta_idx_descripcion" ON "encuesta" (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_enc" BEFORE INSERT OR UPDATE 
	ON "encuesta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "encuesta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "encuesta" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "encuesta" TO "usrarwsdb";



-- DROP TABLE moneda
DROP TABLE IF EXISTS "moneda" CASCADE;

-- CREATE TABLE moneda
CREATE TABLE "moneda" (
	"id_moneda" int4 NOT NULL,
	"descripcion" varchar(50) NOT NULL,
	"valor" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "moneda_pkey" PRIMARY KEY("id_moneda")
);


CREATE UNIQUE INDEX "moneda_idx_descripcion" ON "moneda" (
	"descripcion"
);
GRANT ALL PRIVILEGES ON TABLE "moneda" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "moneda" TO "usrarwsdb";



-- DROP TABLE region
DROP TABLE IF EXISTS "region" CASCADE;

-- CREATE TABLE region
CREATE TABLE "region" (
	"id_region" int4 NOT NULL,
	"descripcion" varchar(100) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "region_pkey" PRIMARY KEY("id_region")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "region_idx_descripcion" ON "region" (
	"descripcion"
);


CREATE TRIGGER "tbi_f_mod_reg" BEFORE INSERT OR UPDATE 
	ON "region" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "region" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "region" TO "taisa";

GRANT SELECT ON TABLE "region" TO "usrarwsdb";



-- DROP TABLE unidad_medida
DROP TABLE IF EXISTS "unidad_medida" CASCADE;

-- CREATE TABLE unidad_medida
CREATE TABLE "unidad_medida" (
	"id_unidad_medida" int4 NOT NULL,
	"descripcion" varchar(100) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "unidad_medida_pkey" PRIMARY KEY("id_unidad_medida")
);


CREATE INDEX "unidad_medida_idx_descripcion" ON "unidad_medida" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_um" BEFORE INSERT OR UPDATE 
	ON "unidad_medida" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();
GRANT ALL PRIVILEGES ON TABLE "unidad_medida" TO "taisa";

GRANT SELECT ON TABLE "unidad_medida" TO "usrarwsdb";



-- DROP TABLE historico_no_efectividad
DROP TABLE IF EXISTS "historico_no_efectividad" CASCADE;

-- CREATE TABLE historico_no_efectividad
CREATE TABLE "historico_no_efectividad" (
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_motivo_no_efectividad" int4 NOT NULL,
	"fecha" timestamp NOT NULL,
	PRIMARY KEY("fecha")
);


ALTER TABLE "historico_no_efectividad" OWNER TO "taisa";

-- DROP TABLE historico_nota_venta
DROP TABLE IF EXISTS "historico_nota_venta" CASCADE;

-- CREATE TABLE historico_nota_venta
CREATE TABLE "historico_nota_venta" (
	"id_nota_venta" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"id_motivo_no_efectividad" int4,
	"fecha_creacion" date NOT NULL,
	PRIMARY KEY("id_nota_venta","id_usuario_emisor","id_usuario_receptor")
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_nv" AFTER INSERT OR UPDATE 
	ON "historico_nota_venta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_nv"();


ALTER TABLE "historico_nota_venta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "historico_nota_venta" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "historico_nota_venta" TO "usrarwsdb";



-- DROP TABLE parametro
DROP TABLE IF EXISTS "parametro" CASCADE;

-- CREATE TABLE parametro
CREATE TABLE "parametro" (
	"id_parametro" int4 NOT NULL DEFAULT nextval('parametro_id_parametro_seq'::regclass),
	"agrupacion" varchar(250) NOT NULL,
	"ambito" varchar(100) NOT NULL,
	"descripcion" varchar(50) NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"valor" varchar(100) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "parametros_pkey" PRIMARY KEY("id_parametro")
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_parametros" BEFORE INSERT OR UPDATE 
	ON "parametro" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "parametro" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "parametro" TO "taisa";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "parametro" TO "usrarwsdb";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "parametro" TO "usrarbowdb";



-- DROP TABLE modulo
DROP TABLE IF EXISTS "modulo" CASCADE;

-- CREATE TABLE modulo
CREATE TABLE "modulo" (
	"id_modulo" int4 NOT NULL DEFAULT nextval('modulo_id_modulo_seq'::regclass),
	"aplicacion" varchar(3) NOT NULL,
	"fecha_creacion" date NOT NULL,
	"modulo" varchar(20) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "chequeo_aplicacion" CHECK(aplicacion::text = 'SDS'::text OR aplicacion::text = 'BOW'::text),
	CONSTRAINT "modulos_pkey" PRIMARY KEY("id_modulo")
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_mod" BEFORE INSERT OR UPDATE 
	ON "modulo" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "modulo" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "modulo" TO "taisa";

GRANT SELECT ON TABLE "modulo" TO "usrarwsdb";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "modulo" TO "usrarbowdb";



-- DROP TABLE impuesto
DROP TABLE IF EXISTS "impuesto" CASCADE;

-- CREATE TABLE impuesto
CREATE TABLE "impuesto" (
	"id_impuesto" int4 NOT NULL,
	"descripcion" varchar(30) NOT NULL,
	"porcentaje" numeric(5,2) NOT NULL,
	"codigo_sii" char(2) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "impuesto_pkey" PRIMARY KEY("id_impuesto")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "impuesto_idx_descripcion" ON "impuesto" (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_imp" BEFORE INSERT OR UPDATE 
	ON "impuesto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "impuesto" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "impuesto" TO "taisa";

GRANT SELECT ON TABLE "impuesto" TO "usrarwsdb";



-- DROP TABLE lista_negra
DROP TABLE IF EXISTS "lista_negra" CASCADE;

-- CREATE TABLE lista_negra
CREATE TABLE "lista_negra" (
	"rut" varchar(15) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("rut")
);


ALTER TABLE "lista_negra" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "lista_negra" TO "taisa";

GRANT SELECT ON TABLE "lista_negra" TO "usrarwsdb";



-- DROP TABLE sincronizacion
DROP TABLE IF EXISTS "sincronizacion" CASCADE;

-- CREATE TABLE sincronizacion
CREATE TABLE "sincronizacion" (
	"ts_creacion" timestamp with time zone NOT NULL DEFAULT now(),
	"ts_inicio" timestamp with time zone,
	"ts_termino" timestamp with time zone,
	"estado" int4 NOT NULL DEFAULT 0,
	"origen" char(1) NOT NULL DEFAULT 'A'::bpchar,
	"limpiar" bool NOT NULL DEFAULT False,
	"intentos" int4 NOT NULL DEFAULT 0,
	"grupo" varchar(50)
);


ALTER TABLE "sincronizacion" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "sincronizacion" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "sincronizacion" TO "usrarwsdb";



-- DROP TABLE rango_id
DROP TABLE IF EXISTS "rango_id" CASCADE;

-- CREATE TABLE rango_id
CREATE TABLE "rango_id" (
	"nombre_tabla" varchar(255) NOT NULL,
	"id_usuario" int4 NOT NULL,
	"desde" int4 NOT NULL,
	"hasta" int4 NOT NULL,
	PRIMARY KEY("nombre_tabla","id_usuario")
);


ALTER TABLE "rango_id" OWNER TO "taisa";

-- DROP TABLE estado_nota_venta
DROP TABLE IF EXISTS "estado_nota_venta" CASCADE;

-- CREATE TABLE estado_nota_venta
CREATE TABLE "estado_nota_venta" (
	"id_estado_nota_venta" int4 NOT NULL,
	"descripcion" varchar(20) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_estado_nota_venta")
);


ALTER TABLE "estado_nota_venta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "estado_nota_venta" TO "taisa";

GRANT SELECT ON TABLE "estado_nota_venta" TO "usrarwsdb";



-- DROP TABLE forma_pago
DROP TABLE IF EXISTS "forma_pago" CASCADE;

-- CREATE TABLE forma_pago
CREATE TABLE "forma_pago" (
	"id_forma_pago" int4 NOT NULL,
	"descripcion" varchar(100),
	"es_contado" bool NOT NULL DEFAULT False,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "forma_pago_pkey" PRIMARY KEY("id_forma_pago")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "forma_pago_idx_forma_pago" ON "forma_pago" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_fp" BEFORE INSERT OR UPDATE 
	ON "forma_pago" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "forma_pago" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "forma_pago" TO "taisa";

GRANT SELECT ON TABLE "forma_pago" TO "usrarwsdb";



-- DROP TABLE motivo_no_efectividad
DROP TABLE IF EXISTS "motivo_no_efectividad" CASCADE;

-- CREATE TABLE motivo_no_efectividad
CREATE TABLE "motivo_no_efectividad" (
	"id_motivo_no_efectividad" int4 NOT NULL,
	"contexto" varchar(100) NOT NULL,
	"descripcion" varchar(200) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "motivo_no_efectividad_pkey" PRIMARY KEY("id_motivo_no_efectividad")
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_mne" BEFORE INSERT OR UPDATE 
	ON "motivo_no_efectividad" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "motivo_no_efectividad" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "motivo_no_efectividad" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "motivo_no_efectividad" TO "usrarwsdb";



-- DROP TABLE proceso
DROP TABLE IF EXISTS "proceso" CASCADE;

-- CREATE TABLE proceso
CREATE TABLE "proceso" (
	"pid" int4 NOT NULL,
	"ts_inicio" timestamp with time zone NOT NULL DEFAULT now(),
	"ts_heartbeat" timestamp with time zone,
	"ts_termino" timestamp with time zone,
	"estado" int4 NOT NULL DEFAULT 0,
	"tipo" int4,
	PRIMARY KEY("pid")
);


ALTER TABLE "proceso" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "proceso" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "proceso" TO "usrarwsdb";



-- DROP TABLE version_sds
DROP TABLE IF EXISTS "version_sds" CASCADE;

-- CREATE TABLE version_sds
CREATE TABLE "version_sds" (
	"id_usuario" int4 NOT NULL,
	"version" varchar(20) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_usuario")
);


ALTER TABLE "version_sds" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "version_sds" TO "taisa";

GRANT SELECT ON TABLE "version_sds" TO "usrarwsdb";



-- DROP TABLE usuario
DROP TABLE IF EXISTS "usuario" CASCADE;

-- CREATE TABLE usuario
CREATE TABLE "usuario" (
	"id_usuario" int4 NOT NULL,
	"cargo" varchar(24) NOT NULL,
	"email" varchar(200) NOT NULL DEFAULT 'vacio'::character varying,
	"estado" int2 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"nombre_completo" varchar(64) NOT NULL,
	"password" varchar(32) NOT NULL,
	"rut" varchar(10) NOT NULL,
	"umbral_folios" int2,
	"username" varchar(16) NOT NULL,
	"nro_intentos" int4,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "usuario_pkey" PRIMARY KEY("id_usuario")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "usuario_idx_username" ON "usuario" (
	"username"
);


CREATE TRIGGER "tgr_f_mod_usuario" BEFORE INSERT OR UPDATE 
	ON "usuario" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_usuario" AFTER INSERT OR UPDATE 
	ON "usuario" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_usuario"();


ALTER TABLE "usuario" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "usuario" TO "taisa";

GRANT SELECT ON TABLE "usuario" TO "usrarwsdb";

GRANT SELECT, UPDATE ON TABLE "usuario" TO "usrarbowdb";



-- DROP TABLE banco
DROP TABLE IF EXISTS "banco" CASCADE;

-- CREATE TABLE banco
CREATE TABLE "banco" (
	"id_banco" int4 NOT NULL,
	"descripcion" varchar(50) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "banco_pkey" PRIMARY KEY("id_banco")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "banco_idx_descripcion" ON "banco" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_ban" BEFORE INSERT OR UPDATE 
	ON "banco" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "banco" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "banco" TO "taisa";

GRANT SELECT ON TABLE "banco" TO "usrarwsdb";



-- DROP TABLE criticidad
DROP TABLE IF EXISTS "criticidad" CASCADE;

-- CREATE TABLE criticidad
CREATE TABLE "criticidad" (
	"id_criticidad" int4 NOT NULL,
	"descripcion" varchar(16) NOT NULL,
	"color" varchar(16) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_criticidad")
);


ALTER TABLE "criticidad" OWNER TO "taisa";

-- DROP TABLE tipo_bloqueo_cliente
DROP TABLE IF EXISTS "tipo_bloqueo_cliente" CASCADE;

-- CREATE TABLE tipo_bloqueo_cliente
CREATE TABLE "tipo_bloqueo_cliente" (
	"id_tipo_bloqueo_cliente" int4 NOT NULL,
	"descripcion" varchar(100) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "tipo_bloqueo_cliente_pkey" PRIMARY KEY("id_tipo_bloqueo_cliente")
)
WITH (
	OIDS = False
);


CREATE INDEX "tipo_bloqueo_cliente_idx_descripcion" ON "tipo_bloqueo_cliente" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_tbc" BEFORE INSERT OR UPDATE 
	ON "tipo_bloqueo_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "tipo_bloqueo_cliente" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "tipo_bloqueo_cliente" TO "taisa";

GRANT SELECT ON TABLE "tipo_bloqueo_cliente" TO "usrarwsdb";



-- DROP TABLE tipo_documento_tributario
DROP TABLE IF EXISTS "tipo_documento_tributario" CASCADE;

-- CREATE TABLE tipo_documento_tributario
CREATE TABLE "tipo_documento_tributario" (
	"id_tipo_documento_tributario" int4 NOT NULL,
	"descripcion" varchar(64) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "tipo_documento_tributario_pkey" PRIMARY KEY("id_tipo_documento_tributario")
)
WITH (
	OIDS = False
);


CREATE INDEX "tipo_documento_tributario_idx_descripcion" ON "tipo_documento_tributario" (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_tdt" BEFORE INSERT OR UPDATE 
	ON "tipo_documento_tributario" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "tipo_documento_tributario" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "tipo_documento_tributario" TO "taisa";

GRANT SELECT ON TABLE "tipo_documento_tributario" TO "usrarwsdb";



-- DROP TABLE canal
DROP TABLE IF EXISTS "canal" CASCADE;

-- CREATE TABLE canal
CREATE TABLE "canal" (
	"id_canal" int4 NOT NULL,
	"descripcion" varchar(30) NOT NULL,
	"fecha_mensaje_desde" date,
	"fecha_mensaje_hasta" date,
	"fecha_sincronizacion_a_pda" timestamp,
	"mensaje" varchar(250),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "canal_pkey" PRIMARY KEY("id_canal")
)
WITH (
	OIDS = False
);


ALTER TABLE "canal" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "canal" TO "taisa";

GRANT SELECT ON TABLE "canal" TO "usrarwsdb";



-- DROP TABLE historico_vendedores
DROP TABLE IF EXISTS "historico_vendedores" CASCADE;

-- CREATE TABLE historico_vendedores
CREATE TABLE "historico_vendedores" (
	"id_vendedor" int4 NOT NULL,
	"fecha" date NOT NULL,
	"total_clientes" int4 NOT NULL DEFAULT 0,
	"clientes_en_frecuencia" int4 NOT NULL DEFAULT 0,
	"clientes_visitados" int4 NOT NULL DEFAULT 0,
	"visitas_en_frecuencia" int4 NOT NULL DEFAULT 0,
	"visitas_fuera_frecuencia" int4 NOT NULL DEFAULT 0,
	"clientes_nuevos" int4 NOT NULL DEFAULT 0,
	"clientes_con_pedidos" int4 NOT NULL DEFAULT 0,
	"clientes_no_efectividad" int4 NOT NULL DEFAULT 0,
	"monto_pedidos" int4 NOT NULL DEFAULT 0,
	"kilos_pedidos" numeric(10,3) NOT NULL DEFAULT 0.0,
	"sku" text NOT NULL DEFAULT '',
	"lineas" text NOT NULL DEFAULT '',
	PRIMARY KEY("id_vendedor","fecha")
);


ALTER TABLE "historico_vendedores" OWNER TO "taisa";

-- DROP TABLE info_sincro
DROP TABLE IF EXISTS "info_sincro" CASCADE;

-- CREATE TABLE info_sincro
CREATE TABLE "info_sincro" (
	"id_info_sincro" int4 NOT NULL DEFAULT nextval('info_sincro_seq'::regclass),
	"id_usuario" int4 NOT NULL,
	"sentido" int2 NOT NULL,
	"archivo_nombre" varchar(255) NOT NULL,
	"archivo_tamano" int4 NOT NULL,
	"archivo_md5" char(32) NOT NULL,
	"fecha" timestamp NOT NULL,
	"fecha_lectura" timestamp,
	"fecha_fin_procesamiento" timestamp,
	"es_full" bool NOT NULL DEFAULT False,
	"id_info_sincro_in" int4,
	CONSTRAINT "info_sincro_pkey" PRIMARY KEY("id_info_sincro")
);


ALTER TABLE "info_sincro" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "info_sincro" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "info_sincro" TO "usrarwsdb";



-- DROP TABLE acceso
DROP TABLE IF EXISTS "acceso" CASCADE;

-- CREATE TABLE acceso
CREATE TABLE "acceso" (
	"id_acceso" int4 NOT NULL DEFAULT nextval('acceso_id_acceso_seq'::regclass),
	"id_modulo" int4 NOT NULL,
	"id_perfil" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "acceso_pkey" PRIMARY KEY("id_acceso","id_modulo")
)
WITH (
	OIDS = False
);


CREATE INDEX "fki_acceso_id_modulo_fkey" ON "acceso" USING BTREE (
	"id_modulo"
);


CREATE TRIGGER "tgr_f_mod_acceso" BEFORE INSERT OR UPDATE 
	ON "acceso" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "acceso" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "acceso" TO "taisa";

GRANT SELECT ON TABLE "acceso" TO "usrarwsdb";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "acceso" TO "usrarbowdb";



-- DROP TABLE historico_pedidos
DROP TABLE IF EXISTS "historico_pedidos" CASCADE;

-- CREATE TABLE historico_pedidos
CREATE TABLE "historico_pedidos" (
	"id_nota_venta" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"linea" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_linea" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_motivo_no_efectividad" int4,
	"id_usuario_creador" int4,
	"cum_valorizacion_final" numeric(10,3) NOT NULL DEFAULT 0,
	"precio_final" int4 NOT NULL DEFAULT 0,
	"fecha_creacion" timestamp NOT NULL,
	PRIMARY KEY("id_nota_venta","id_usuario_emisor","linea","id_producto")
)
WITH (
	OIDS = False
);


CREATE INDEX "fki_motivo_no_efectividad_fkey0" ON "historico_pedidos" USING BTREE (
	"id_motivo_no_efectividad"
);


ALTER TABLE "historico_pedidos" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "historico_pedidos" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "historico_pedidos" TO "usrarwsdb";



-- DROP TABLE contenedor
DROP TABLE IF EXISTS "contenedor" CASCADE;

-- CREATE TABLE contenedor
CREATE TABLE "contenedor" (
	"id_contenedor" int4 NOT NULL,
	"descripcion" varchar(250),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "contenedor_pkey" PRIMARY KEY("id_contenedor")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "contenedor_idx_descripcion" ON "contenedor" (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_cont" BEFORE INSERT OR UPDATE 
	ON "contenedor" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "contenedor" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "contenedor" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "contenedor" TO "usrarwsdb";



-- DROP TABLE tipo_movimiento
DROP TABLE IF EXISTS "tipo_movimiento" CASCADE;

-- CREATE TABLE tipo_movimiento
CREATE TABLE "tipo_movimiento" (
	"id_tipo_movimiento" int4 NOT NULL,
	"descripcion" varchar(50) NOT NULL,
	"operador" char(1) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "tipo_movimiento_pkey" PRIMARY KEY("id_tipo_movimiento")
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_tm" BEFORE INSERT OR UPDATE 
	ON "tipo_movimiento" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "tipo_movimiento" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "tipo_movimiento" TO "taisa";

GRANT SELECT ON TABLE "tipo_movimiento" TO "usrarwsdb";



-- DROP TABLE acteco
DROP TABLE IF EXISTS "acteco" CASCADE;

-- CREATE TABLE acteco
CREATE TABLE "acteco" (
	"id_acteco" int4 NOT NULL,
	"codigo" varchar(6) NOT NULL,
	"descripcion" varchar(128),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "acteco_pkey" PRIMARY KEY("id_acteco")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "acteco_idx_codigo" ON "acteco" (
	"codigo"
);


CREATE TRIGGER "tgr_f_mod_ac" BEFORE INSERT OR UPDATE 
	ON "acteco" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "acteco" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "acteco" TO "taisa";

GRANT SELECT ON TABLE "acteco" TO "usrarwsdb";



-- DROP TABLE zona
DROP TABLE IF EXISTS "zona" CASCADE;

-- CREATE TABLE zona
CREATE TABLE "zona" (
	"id_zona" int4 NOT NULL,
	"codigo" varchar(10) NOT NULL,
	"descripcion" varchar(100) NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "zona_pkey" PRIMARY KEY("id_zona")
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "zona_idx_codigo" ON "zona" USING BTREE (
	"codigo"
);


CREATE UNIQUE INDEX "zona_idx_descripcion" ON "zona" (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_z" BEFORE INSERT OR UPDATE 
	ON "zona" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "zona" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "zona" TO "taisa";

GRANT SELECT ON TABLE "zona" TO "usrarwsdb";

GRANT SELECT ON TABLE "zona" TO "usrarbowdb";



-- DROP TABLE subcanal
DROP TABLE IF EXISTS "subcanal" CASCADE;

-- CREATE TABLE subcanal
CREATE TABLE "subcanal" (
	"id_subcanal" int4 NOT NULL,
	"fecha_mensaje_desde" date,
	"fecha_mensaje_hasta" date,
	"fecha_sincronizacion_a_pda" timestamp,
	"id_canal" int4 NOT NULL,
	"mensaje" varchar(250),
	"descripcion" varchar(50) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "subcanal_pkey" PRIMARY KEY("id_subcanal"),
  CONSTRAINT "canal_fkey" FOREIGN KEY ("id_canal")
    REFERENCES "canal"("id_canal")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "subcanal_fki_canal_fkey" ON "subcanal" USING BTREE (
	"id_canal"
);


CREATE INDEX "subcanal_idx_descripcion" ON "subcanal" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_sc" BEFORE INSERT OR UPDATE 
	ON "subcanal" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "subcanal" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "subcanal" TO "taisa";

GRANT SELECT ON TABLE "subcanal" TO "usrarwsdb";



-- DROP TABLE solicitud_carga_folio
DROP TABLE IF EXISTS "solicitud_carga_folio" CASCADE;

-- CREATE TABLE solicitud_carga_folio
CREATE TABLE "solicitud_carga_folio" (
	"id_solicitud_carga_folio" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"estado" int2 NOT NULL DEFAULT 0,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_creacion" timestamp NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "solicitud_carga_folio_pkey" PRIMARY KEY("id_solicitud_carga_folio","id_usuario"),
  CONSTRAINT "usuario_fkey14" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


ALTER TABLE "solicitud_carga_folio" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "solicitud_carga_folio" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "solicitud_carga_folio" TO "usrarwsdb";



-- DROP TABLE pregunta_encuesta
DROP TABLE IF EXISTS "pregunta_encuesta" CASCADE;

-- CREATE TABLE pregunta_encuesta
CREATE TABLE "pregunta_encuesta" (
	"id_pregunta_encuesta" int4 NOT NULL,
	"id_encuesta" int4 NOT NULL,
	"descripcion" varchar(250) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "pregunta_encuesta_pkey" PRIMARY KEY("id_pregunta_encuesta"),
  CONSTRAINT "encuesta_fkey" FOREIGN KEY ("id_encuesta")
    REFERENCES "encuesta"("id_encuesta")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_pe" BEFORE INSERT OR UPDATE 
	ON "pregunta_encuesta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "pregunta_encuesta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "pregunta_encuesta" TO "taisa";

GRANT SELECT ON TABLE "pregunta_encuesta" TO "usrarwsdb";



-- DROP TABLE codigo_autorizacion
DROP TABLE IF EXISTS "codigo_autorizacion" CASCADE;

-- CREATE TABLE codigo_autorizacion
CREATE TABLE "codigo_autorizacion" (
	"id_codigo_autorizacion" int4 NOT NULL DEFAULT nextval('codigo_autorizacion_seq'::regclass),
	"id_usuario_consumidor" int4 NOT NULL,
	"id_usuario_generador" int4 NOT NULL,
	"codigo" varchar(100) NOT NULL,
	"fecha_vigencia" date NOT NULL,
	"utilizado" bool NOT NULL DEFAULT True,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_codigo_autorizacion"),
  CONSTRAINT "usuario_fkey11" FOREIGN KEY ("id_usuario_consumidor")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tbi_codigo_autorizacion0" BEFORE INSERT OR UPDATE 
	ON "codigo_autorizacion" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();
GRANT ALL PRIVILEGES ON TABLE "codigo_autorizacion" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "codigo_autorizacion" TO "usrarwsdb";



-- DROP TABLE documento_tributario
DROP TABLE IF EXISTS "documento_tributario" CASCADE;

-- CREATE TABLE documento_tributario
CREATE TABLE "documento_tributario" (
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"esta_anulado" bool NOT NULL DEFAULT False,
	"fecha_emision" date NOT NULL,
	"rut_emisor" varchar(10) NOT NULL,
	"rut_receptor" varchar(10) NOT NULL,
	"xml_dte" text,
	"xml_dte_shipping" text,
	"xml_enviodte" text,
	"xml_enviodte_shipping" text,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "documento_tributario_pkey" PRIMARY KEY("folio","id_tipo_documento_tributario"),
  CONSTRAINT "tipo_documento_tributario_fkey" FOREIGN KEY ("id_tipo_documento_tributario")
    REFERENCES "tipo_documento_tributario"("id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tbi_documento_tributario0" BEFORE INSERT OR UPDATE 
	ON "documento_tributario" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "documento_tributario" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "documento_tributario" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "documento_tributario" TO "usrarwsdb";



-- DROP TABLE factura
DROP TABLE IF EXISTS "factura" CASCADE;

-- CREATE TABLE factura
CREATE TABLE "factura" (
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"estado" int2 NOT NULL DEFAULT 0,
	"fecha_vencimiento_condicion_pago" date NOT NULL,
	"monto_neto" int4 NOT NULL,
	"monto_total" int4 NOT NULL,
	"observacion" varchar(100),
	"shipping" int4 NOT NULL DEFAULT 0,
	"shipping_total" int4 NOT NULL DEFAULT 0,
	"total_kilos" numeric(12,6),
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "factura_pkey" PRIMARY KEY("folio","id_tipo_documento_tributario"),
  CONSTRAINT "documento_tributario_fkey" FOREIGN KEY ("folio", "id_tipo_documento_tributario")
    REFERENCES "documento_tributario"("folio", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_factura" BEFORE INSERT OR UPDATE 
	ON "factura" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "factura" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "factura" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "factura" TO "usrarwsdb";

GRANT SELECT, UPDATE ON TABLE "factura" TO "envioarfd";



-- DROP TABLE detalle_factura
DROP TABLE IF EXISTS "detalle_factura" CASCADE;

-- CREATE TABLE detalle_factura
CREATE TABLE "detalle_factura" (
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"linea" int2 NOT NULL,
	"id_producto" int4 NOT NULL,
	"cum_valorizacion" numeric(10,3) NOT NULL,
	"cum_transaccion" numeric(10,3) NOT NULL,
	"descuento_monto" numeric(10,2) NOT NULL DEFAULT 0,
	"descuento_porcentaje" numeric(5,2) NOT NULL DEFAULT 0,
	"neto_linea" int4 NOT NULL DEFAULT 0,
	"precio_unitario" int4 NOT NULL,
	"shipping_aplicado" int4 NOT NULL DEFAULT 0,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "detalle_factura_pkey" PRIMARY KEY("linea","folio","id_tipo_documento_tributario","id_producto"),
  CONSTRAINT "factura_fkey1" FOREIGN KEY ("folio", "id_tipo_documento_tributario")
    REFERENCES "factura"("folio", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_detalle_factura" BEFORE INSERT OR UPDATE 
	ON "detalle_factura" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "detalle_factura" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "detalle_factura" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "detalle_factura" TO "usrarwsdb";



-- DROP TABLE autorizacion_anulacion_factura
DROP TABLE IF EXISTS "autorizacion_anulacion_factura" CASCADE;

-- CREATE TABLE autorizacion_anulacion_factura
CREATE TABLE "autorizacion_anulacion_factura" (
	"id_codigo_autorizacion" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	PRIMARY KEY("id_codigo_autorizacion"),
  CONSTRAINT "codigo_autorizacion_fkey1" FOREIGN KEY ("id_codigo_autorizacion")
    REFERENCES "codigo_autorizacion"("id_codigo_autorizacion")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tbi_autorizacion_anulacion_factura0" BEFORE INSERT OR UPDATE 
	ON "autorizacion_anulacion_factura" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "autorizacion_anulacion_factura" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "autorizacion_anulacion_factura" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "autorizacion_anulacion_factura" TO "usrarwsdb";



-- DROP TABLE minimo_diario
DROP TABLE IF EXISTS "minimo_diario" CASCADE;

-- CREATE TABLE minimo_diario
CREATE TABLE "minimo_diario" (
	"id_usuario" int4 NOT NULL,
	"valor" int4,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_usuario"),
  CONSTRAINT "Ref_minimo_diario_to_usuario" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


ALTER TABLE "minimo_diario" OWNER TO "taisa";

-- DROP TABLE guia_despacho
DROP TABLE IF EXISTS "guia_despacho" CASCADE;

-- CREATE TABLE guia_despacho
CREATE TABLE "guia_despacho" (
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"codigo_anulacion" varchar(250),
	"codigo_autorizacion" varchar(256),
	"estado" int2 NOT NULL DEFAULT 0,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_vencimiento" date,
	"impreso_cedible" bool NOT NULL DEFAULT false,
	"iva" int4 NOT NULL,
	"monto_neto" int4 NOT NULL,
	"monto_total" int4 NOT NULL,
	"observacion" varchar(100),
	"otro_impuesto" int4,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "guia_despacho_pkey" PRIMARY KEY("id_tipo_documento_tributario","folio"),
  CONSTRAINT "documento_tributario_fkey2" FOREIGN KEY ("folio", "id_tipo_documento_tributario")
    REFERENCES "documento_tributario"("folio", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_gd" BEFORE INSERT OR UPDATE 
	ON "guia_despacho" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_gd" AFTER INSERT OR UPDATE 
	ON "guia_despacho" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_dnv"();


ALTER TABLE "guia_despacho" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "guia_despacho" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "guia_despacho" TO "usrarwsdb";



-- DROP TABLE ultimo_id
DROP TABLE IF EXISTS "ultimo_id" CASCADE;

-- CREATE TABLE ultimo_id
CREATE TABLE "ultimo_id" (
	"nombre_tabla" varchar(255) NOT NULL,
	"id_usuario" int4 NOT NULL,
	"id" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "rango_id_fkey" FOREIGN KEY ("nombre_tabla", "id_usuario")
    REFERENCES "rango_id"("nombre_tabla", "id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


-- DROP TABLE alternativa_encuesta
DROP TABLE IF EXISTS "alternativa_encuesta" CASCADE;

-- CREATE TABLE alternativa_encuesta
CREATE TABLE "alternativa_encuesta" (
	"id_alternativa_encuesta" int4 NOT NULL,
	"id_pregunta_encuesta" int4 NOT NULL,
	"descripcion" varchar(250) NOT NULL,
	"es_seleccion" bool NOT NULL DEFAULT False,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "alternativa_encuesta_pkey" PRIMARY KEY("id_alternativa_encuesta"),
  CONSTRAINT "pregunta_encuesta_fkey" FOREIGN KEY ("id_pregunta_encuesta")
    REFERENCES "pregunta_encuesta"("id_pregunta_encuesta")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_ae" BEFORE INSERT OR UPDATE 
	ON "alternativa_encuesta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "alternativa_encuesta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "alternativa_encuesta" TO "taisa";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "alternativa_encuesta" TO "usrarwsdb";



-- DROP TABLE ciudad
DROP TABLE IF EXISTS "ciudad" CASCADE;

-- CREATE TABLE ciudad
CREATE TABLE "ciudad" (
	"id_ciudad" int4 NOT NULL,
	"id_region" int4 NOT NULL,
	"descripcion" varchar(100) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "ciudad_pkey" PRIMARY KEY("id_ciudad"),
  CONSTRAINT "region_fkey" FOREIGN KEY ("id_region")
    REFERENCES "region"("id_region")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tbi_f_mod_ciu" BEFORE INSERT OR UPDATE 
	ON "ciudad" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "ciudad" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "ciudad" TO "taisa";

GRANT SELECT ON TABLE "ciudad" TO "usrarwsdb";



-- DROP TABLE log_envio_fd
DROP TABLE IF EXISTS "log_envio_fd" CASCADE;

-- CREATE TABLE log_envio_fd
CREATE TABLE "log_envio_fd" (
	"id_envio_fd" int4 NOT NULL DEFAULT nextval('log_envio_fd_id_envio_fd_seq'::regclass),
	"id_tipo_documento_tributario" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"codigo" varchar(10),
	"error_log" bool NOT NULL DEFAULT false,
	"fecha_envio" timestamp NOT NULL,
	"mensaje" text,
	CONSTRAINT "log_envio_fd_pkey" PRIMARY KEY("id_envio_fd"),
  CONSTRAINT "factura_fkey0" FOREIGN KEY ("folio", "id_tipo_documento_tributario")
    REFERENCES "factura"("folio", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


ALTER TABLE "log_envio_fd" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "log_envio_fd" TO "taisa";

GRANT INSERT ON TABLE "log_envio_fd" TO "envioarfd";



-- DROP TABLE jefe_venta_usuario
DROP TABLE IF EXISTS "jefe_venta_usuario" CASCADE;

-- CREATE TABLE jefe_venta_usuario
CREATE TABLE "jefe_venta_usuario" (
	"id_usuario" int4 NOT NULL,
	"id_jefe_venta" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
	"borrado" bool NOT NULL DEFAULT False,
  CONSTRAINT "usuario_fkey20" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "jefe_venta_fkey" FOREIGN KEY ("id_jefe_venta")
    REFERENCES "jefe_venta"("id_jefe_venta")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


ALTER TABLE "jefe_venta_usuario" OWNER TO "taisa";

-- DROP TABLE denominacion_efectivo
DROP TABLE IF EXISTS "denominacion_efectivo" CASCADE;

-- CREATE TABLE denominacion_efectivo
CREATE TABLE "denominacion_efectivo" (
	"id_moneda" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"fecha_creacion" timestamp NOT NULL,
	"monto" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "denominacion_efectivo_pkey" PRIMARY KEY("id_moneda","id_usuario","fecha_creacion"),
  CONSTRAINT "moneda_fkey" FOREIGN KEY ("id_moneda")
    REFERENCES "moneda"("id_moneda")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey19" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);
GRANT ALL PRIVILEGES ON TABLE "denominacion_efectivo" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "denominacion_efectivo" TO "usrarwsdb";



-- DROP TABLE factura_impuesto
DROP TABLE IF EXISTS "factura_impuesto" CASCADE;

-- CREATE TABLE factura_impuesto
CREATE TABLE "factura_impuesto" (
	"id_impuesto" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"porcentaje" numeric(5,2) NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"monto" int4 NOT NULL DEFAULT 0,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "factura_impuesto_pkey" PRIMARY KEY("id_impuesto","folio","id_tipo_documento_tributario"),
  CONSTRAINT "factura_fkey2" FOREIGN KEY ("folio", "id_tipo_documento_tributario")
    REFERENCES "factura"("folio", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "impuesto_fkey" FOREIGN KEY ("id_impuesto")
    REFERENCES "impuesto"("id_impuesto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_fi" BEFORE INSERT OR UPDATE 
	ON "factura_impuesto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "factura_impuesto" OWNER TO "taisa";GRANT INSERT, SELECT, UPDATE, DELETE, REFERENCES, TRIGGER ON TABLE "factura_impuesto" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "factura_impuesto" TO "usrarwsdb";



-- DROP TABLE mensaje
DROP TABLE IF EXISTS "mensaje" CASCADE;

-- CREATE TABLE mensaje
CREATE TABLE "mensaje" (
	"id_mensaje" int4 NOT NULL DEFAULT nextval('mensaje_id_mensaje_seq'::regclass),
	"asunto" varchar(128),
	"contenido" varchar(1024),
	"fecha_creacion" timestamp NOT NULL,
	"fecha_lectura" timestamp,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"id_usuario_emisor" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "mensaje_pkey" PRIMARY KEY("id_mensaje"),
  CONSTRAINT "usuario_fkey0" FOREIGN KEY ("id_usuario_emisor")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE CASCADE
	ON UPDATE CASCADE
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey1" FOREIGN KEY ("id_usuario_receptor")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE CASCADE
	ON UPDATE CASCADE
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_mensaje" BEFORE INSERT OR UPDATE 
	ON "mensaje" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "mensaje" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "mensaje" TO "taisa";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "mensaje" TO "usrarwsdb";

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "mensaje" TO "usrarbowdb";



-- DROP TABLE perfil_usuario
DROP TABLE IF EXISTS "perfil_usuario" CASCADE;

-- CREATE TABLE perfil_usuario
CREATE TABLE "perfil_usuario" (
	"id_perfil" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "perfil_usuario_pkey" PRIMARY KEY("id_perfil","id_usuario"),
  CONSTRAINT "perfil_fkey0" FOREIGN KEY ("id_perfil")
    REFERENCES "perfil"("id_perfil")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey2" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "idx_perfil_usuario_id_usuario" ON "perfil_usuario" (
	"id_usuario"
);


CREATE TRIGGER "tgr_f_mod_perfil_usuario" BEFORE INSERT OR UPDATE 
	ON "perfil_usuario" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "perfil_usuario" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "perfil_usuario" TO "taisa";

GRANT SELECT ON TABLE "perfil_usuario" TO "usrarwsdb";

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "perfil_usuario" TO "usrarbowdb";



-- DROP TABLE cliente
DROP TABLE IF EXISTS "cliente" CASCADE;

-- CREATE TABLE cliente
CREATE TABLE "cliente" (
	"id_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_canal" int4 NOT NULL,
	"id_subcanal" int4,
	"id_tipo_bloqueo_cliente" int4 NOT NULL,
	"id_usuario_administrador" int4,
	"entrega_factura" bool NOT NULL,
	"entrega_guia" bool NOT NULL,
	"es_prospecto" bool NOT NULL DEFAULT false,
	"fecha_mensaje_desde" date,
	"fecha_mensaje_hasta" date,
	"giro" text,
	"mensaje" varchar(250),
	"nombre_fantasia" varchar(100) NOT NULL,
	"observaciones" text,
	"razon_social" varchar(100),
	"rut" char(10),
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "cliente_pkey" PRIMARY KEY("id_cliente","id_usuario_creador"),
  CONSTRAINT "subcanal_fkey" FOREIGN KEY ("id_subcanal")
    REFERENCES "subcanal"("id_subcanal")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "canal_fkey1" FOREIGN KEY ("id_canal")
    REFERENCES "canal"("id_canal")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "tipo_bloqueo_cliente_fkey" FOREIGN KEY ("id_tipo_bloqueo_cliente")
    REFERENCES "tipo_bloqueo_cliente"("id_tipo_bloqueo_cliente")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "cliente_fki_subcanal_fkey" ON "cliente" USING BTREE (
	"id_subcanal"
);


CREATE UNIQUE INDEX "cliente_idx_rut" ON "cliente" (
	"rut"
);


CREATE TRIGGER "tgr_f_mod_cliente" BEFORE INSERT OR UPDATE 
	ON "cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "cliente" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "cliente" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "cliente" TO "usrarwsdb";



-- DROP TABLE nota_credito
DROP TABLE IF EXISTS "nota_credito" CASCADE;

-- CREATE TABLE nota_credito
CREATE TABLE "nota_credito" (
	"id_nota_credito" int4 NOT NULL,
	"id_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"estado" int4 NOT NULL,
	"fecha_emision" date NOT NULL,
	"fecha_ultima_utilizacion" timestamp,
	"monto" int4 NOT NULL,
	"monto_utilizado" int4,
	"numero_folio" int4 NOT NULL,
	"numero_voucher" varchar(100),
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "nota_credito_pkey" PRIMARY KEY("id_nota_credito"),
  CONSTRAINT "cliente_fkey1" FOREIGN KEY ("id_cliente", "id_usuario_creador")
    REFERENCES "cliente"("id_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_nc" BEFORE INSERT OR UPDATE 
	ON "nota_credito" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_nc" AFTER INSERT OR UPDATE 
	ON "nota_credito" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_scl"();


ALTER TABLE "nota_credito" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "nota_credito" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "nota_credito" TO "usrarwsdb";



-- DROP TABLE detalle_guia_despacho
DROP TABLE IF EXISTS "detalle_guia_despacho" CASCADE;

-- CREATE TABLE detalle_guia_despacho
CREATE TABLE "detalle_guia_despacho" (
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"linea" int2 NOT NULL,
	"codigo_producto" varchar(64) NOT NULL,
	"cum_transaccion" numeric(10,3) NOT NULL,
	"cum_valorizacion" numeric(10,3) NOT NULL,
	"descripcion_producto" varchar(200) NOT NULL,
	"descuento_monto" numeric(10,2) NOT NULL DEFAULT 0,
	"descuento_porcentaje" numeric(5,2) NOT NULL DEFAULT 0,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"neto_linea" int4 NOT NULL DEFAULT 0,
	"precio_unitario" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "detalle_guia_despacho_pkey" PRIMARY KEY("linea","folio","id_tipo_documento_tributario","codigo_producto"),
  CONSTRAINT "guia_despacho_fkey" FOREIGN KEY ("id_tipo_documento_tributario", "folio")
    REFERENCES "guia_despacho"("id_tipo_documento_tributario", "folio")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_dgd" BEFORE INSERT OR UPDATE 
	ON "detalle_guia_despacho" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_dgd" BEFORE INSERT OR UPDATE 
	ON "detalle_guia_despacho" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_gdnv"();


ALTER TABLE "detalle_guia_despacho" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "detalle_guia_despacho" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "detalle_guia_despacho" TO "usrarwsdb";



-- DROP TABLE comuna
DROP TABLE IF EXISTS "comuna" CASCADE;

-- CREATE TABLE comuna
CREATE TABLE "comuna" (
	"id_comuna" int4 NOT NULL,
	"id_ciudad" int4 NOT NULL,
	"descripcion" varchar(100) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "comuna_pkey" PRIMARY KEY("id_comuna"),
  CONSTRAINT "ciudad_fkey" FOREIGN KEY ("id_ciudad")
    REFERENCES "ciudad"("id_ciudad")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tbi_f_mod_com" BEFORE INSERT OR UPDATE 
	ON "comuna" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "comuna" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "comuna" TO "taisa";

GRANT SELECT ON TABLE "comuna" TO "usrarwsdb";



-- DROP TABLE cuenta_corriente
DROP TABLE IF EXISTS "cuenta_corriente" CASCADE;

-- CREATE TABLE cuenta_corriente
CREATE TABLE "cuenta_corriente" (
	"id_banco" int4 NOT NULL,
	"numero_cuenta" varchar(50) NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_cliente" int4 NOT NULL,
	"rut_titular" varchar(15) NOT NULL,
	"nombre_titular" varchar(50) NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "cuenta_corriente_pkey" PRIMARY KEY("numero_cuenta","id_banco","id_cliente","id_usuario_creador"),
  CONSTRAINT "banco_fkey1" FOREIGN KEY ("id_banco")
    REFERENCES "banco"("id_banco")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "cliente_fkey" FOREIGN KEY ("id_cliente", "id_usuario_creador")
    REFERENCES "cliente"("id_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tgr_f_mod_cc" BEFORE INSERT OR UPDATE 
	ON "cuenta_corriente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_cc" AFTER INSERT OR UPDATE 
	ON "cuenta_corriente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_scl"();


ALTER TABLE "cuenta_corriente" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "cuenta_corriente" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "cuenta_corriente" TO "usrarwsdb";



-- DROP TABLE forma_pago_cliente
DROP TABLE IF EXISTS "forma_pago_cliente" CASCADE;

-- CREATE TABLE forma_pago_cliente
CREATE TABLE "forma_pago_cliente" (
	"id_forma_pago" int4 NOT NULL,
	"id_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"aplica_cobranza" bool NOT NULL DEFAULT False,
	"aplica_vuelto" bool NOT NULL DEFAULT False,
	"monto_maximo" int8,
	"monto_utilizado" int8,
	"orden" int2 NOT NULL,
	"plazo_maximo" int4,
	"suspendido" bool NOT NULL DEFAULT False,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "forma_pago_cliente_pkey" PRIMARY KEY("id_forma_pago","id_cliente","id_usuario_creador"),
  CONSTRAINT "cliente_fkey2" FOREIGN KEY ("id_cliente", "id_usuario_creador")
    REFERENCES "cliente"("id_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "forma_pago_fkey2" FOREIGN KEY ("id_forma_pago")
    REFERENCES "forma_pago"("id_forma_pago")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tgr_f_mod_fpc" BEFORE INSERT OR UPDATE 
	ON "forma_pago_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_fpc" AFTER INSERT OR UPDATE 
	ON "forma_pago_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_scl"();
GRANT ALL PRIVILEGES ON TABLE "forma_pago_cliente" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "forma_pago_cliente" TO "usrarwsdb";



-- DROP TABLE cliente_ret_ex
DROP TABLE IF EXISTS "cliente_ret_ex" CASCADE;

-- CREATE TABLE cliente_ret_ex
CREATE TABLE "cliente_ret_ex" (
	"id_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_impuesto" int4 NOT NULL,
	"exencion" bool NOT NULL DEFAULT True,
	"retencion" bool NOT NULL DEFAULT True,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "cliente_impuesto_pkey" PRIMARY KEY("id_cliente","id_impuesto","id_usuario_creador"),
  CONSTRAINT "impuesto_fkey2" FOREIGN KEY ("id_impuesto")
    REFERENCES "impuesto"("id_impuesto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "cliente_fkey3" FOREIGN KEY ("id_cliente", "id_usuario_creador")
    REFERENCES "cliente"("id_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "cliente_ret_ex_idx" ON "cliente_ret_ex" (
	"id_cliente", 
	"id_impuesto", 
	"exencion", 
	"retencion"
);


CREATE TRIGGER "tgr_f_mod_cre" BEFORE INSERT OR UPDATE 
	ON "cliente_ret_ex" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "cliente_ret_ex" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "cliente_ret_ex" TO "taisa";

GRANT SELECT ON TABLE "cliente_ret_ex" TO "usrarwsdb";



-- DROP TABLE solicitud_forma_pago_cliente
DROP TABLE IF EXISTS "solicitud_forma_pago_cliente" CASCADE;

-- CREATE TABLE solicitud_forma_pago_cliente
CREATE TABLE "solicitud_forma_pago_cliente" (
	"id_solicitud" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"id_cliente" int4 NOT NULL,
	"id_forma_pago" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "solicitud_forma_pago_pkey" PRIMARY KEY("id_solicitud","id_usuario"),
  CONSTRAINT "usuario_fkey9" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "cliente_fkey0" FOREIGN KEY ("id_cliente", "id_usuario_creador")
    REFERENCES "cliente"("id_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "forma_pago_fkey" FOREIGN KEY ("id_forma_pago")
    REFERENCES "forma_pago"("id_forma_pago")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "solicitud_forma_pago_cliente_idx_id_cliente" ON "solicitud_forma_pago_cliente" USING BTREE (
	"id_cliente"
);


CREATE TRIGGER "tgr_f_mod_solicitud_forma_pago" BEFORE INSERT OR UPDATE 
	ON "solicitud_forma_pago_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "solicitud_forma_pago_cliente" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "solicitud_forma_pago_cliente" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "solicitud_forma_pago_cliente" TO "usrarwsdb";

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "solicitud_forma_pago_cliente" TO "usrarwsdb";



-- DROP TABLE recaudo
DROP TABLE IF EXISTS "recaudo" CASCADE;

-- CREATE TABLE recaudo
CREATE TABLE "recaudo" (
	"id_recaudo" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"id_banco" int4,
	"id_forma_pago" int4 NOT NULL,
	"id_nota_credito" int4,
	"autorizador_documento" varchar(32),
	"fecha_fin_autorizacion" date,
	"fecha_inicio_autorizacion" date,
	"fecha_recaudacion" date,
	"fecha_vencimiento_doc" date,
	"monto" int4 NOT NULL,
	"nro_cuenta" varchar(20),
	"nro_documento" varchar(20),
	"plaza_documento" varchar(30),
	"rut_titular" varchar(10),
	"serie_documento" varchar(20),
	"tipo_documento" varchar(20),
	"voucher_impreso" bool,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "recaudacion_pkey" PRIMARY KEY("id_recaudo","id_usuario"),
  CONSTRAINT "banco_fkey" FOREIGN KEY ("id_banco")
    REFERENCES "banco"("id_banco")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "nota_credito_fkey" FOREIGN KEY ("id_nota_credito")
    REFERENCES "nota_credito"("id_nota_credito")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "forma_pago_fkey1" FOREIGN KEY ("id_forma_pago")
    REFERENCES "forma_pago"("id_forma_pago")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey22" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "recaudo_fki_id_banco_fkey" ON "recaudo" USING BTREE (
	"id_banco"
);


ALTER TABLE "recaudo" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "recaudo" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "recaudo" TO "usrarwsdb";



-- DROP TABLE pago_factura
DROP TABLE IF EXISTS "pago_factura" CASCADE;

-- CREATE TABLE pago_factura
CREATE TABLE "pago_factura" (
	"id_pago_factura" int4 NOT NULL,
	"id_recaudo" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"monto_factura" int4 NOT NULL,
	"monto_pago" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "pago_factura_pkey" PRIMARY KEY("id_pago_factura","id_usuario","id_recaudo"),
  CONSTRAINT "recaudo_fkey" FOREIGN KEY ("id_recaudo", "id_usuario")
    REFERENCES "recaudo"("id_recaudo", "id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


ALTER TABLE "pago_factura" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "pago_factura" TO "taisa";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "pago_factura" TO "usrarwsdb";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "pago_factura" TO "usrarbowdb";



-- DROP TABLE empresa
DROP TABLE IF EXISTS "empresa" CASCADE;

-- CREATE TABLE empresa
CREATE TABLE "empresa" (
	"id_empresa" int4 NOT NULL,
	"id_comuna" int4 NOT NULL,
	"giro" varchar(100) NOT NULL,
	"nombre_fantasia" varchar(100),
	"razon_social" varchar(100) NOT NULL,
	"rut" char(10) NOT NULL,
	"direccion" varchar(500) NOT NULL,
	"telefono1" varchar(30),
	"telefono2" varchar(30),
	"fax1" varchar(30),
	"fax2" varchar(30),
	"sitio_web" varchar(100),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "empresa_pkey" PRIMARY KEY("id_empresa"),
  CONSTRAINT "comuna_fkey" FOREIGN KEY ("id_comuna")
    REFERENCES "comuna"("id_comuna")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "empresa_idx_rut" ON "empresa" USING BTREE (
	"rut"
);


CREATE UNIQUE INDEX "empresa_idx_razon_social" ON "empresa" (
	"razon_social"
);


CREATE TRIGGER "tgr_f_mod_empresa" BEFORE INSERT OR UPDATE 
	ON "empresa" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "empresa" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "empresa" TO "taisa";

GRANT SELECT ON TABLE "empresa" TO "usrarwsdb";

GRANT SELECT, UPDATE, INSERT ON TABLE "empresa" TO "usrarbowdb";



-- DROP TABLE linea
DROP TABLE IF EXISTS "linea" CASCADE;

-- CREATE TABLE linea
CREATE TABLE "linea" (
	"id_linea" int4 NOT NULL,
	"id_empresa" int4 NOT NULL,
	"descripcion" varchar(250) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "categoria_producto_pkey" PRIMARY KEY("id_linea"),
  CONSTRAINT "empresa_fkey8" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "linea_idx_descripcion" ON "linea" (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_lin" BEFORE INSERT OR UPDATE 
	ON "linea" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "linea" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "linea" TO "taisa";

GRANT SELECT ON TABLE "linea" TO "usrarwsdb";



-- DROP TABLE familia
DROP TABLE IF EXISTS "familia" CASCADE;

-- CREATE TABLE familia
CREATE TABLE "familia" (
	"id_familia" int4 NOT NULL,
	"id_linea" int4 NOT NULL,
	"descripcion" varchar(250) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "familia_pkey" PRIMARY KEY("id_familia"),
  CONSTRAINT "linea_fkey" FOREIGN KEY ("id_linea")
    REFERENCES "linea"("id_linea")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "familia_idx_descripcion" ON "familia" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_fam" BEFORE INSERT OR UPDATE 
	ON "familia" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_fam" BEFORE INSERT OR UPDATE 
	ON "familia" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_fam"();


ALTER TABLE "familia" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "familia" TO "taisa";

GRANT SELECT ON TABLE "familia" TO "usrarwsdb";



-- DROP TABLE grupo_producto
DROP TABLE IF EXISTS "grupo_producto" CASCADE;

-- CREATE TABLE grupo_producto
CREATE TABLE "grupo_producto" (
	"id_grupo_producto" int4 NOT NULL,
	"id_familia" int4 NOT NULL,
	"descripcion" varchar(250) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "grupo_producto_pkey" PRIMARY KEY("id_grupo_producto"),
  CONSTRAINT "familia_fkey" FOREIGN KEY ("id_familia")
    REFERENCES "familia"("id_familia")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_gp" BEFORE INSERT OR UPDATE 
	ON "grupo_producto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_gp" BEFORE INSERT OR UPDATE 
	ON "grupo_producto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_gp"();


ALTER TABLE "grupo_producto" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "grupo_producto" TO "taisa";

GRANT SELECT ON TABLE "grupo_producto" TO "usrarwsdb";



-- DROP TABLE grupo
DROP TABLE IF EXISTS "grupo" CASCADE;

-- CREATE TABLE grupo
CREATE TABLE "grupo" (
	"id_grupo" int8 NOT NULL DEFAULT nextval('grupo_id_grupo_seq'::regclass),
	"id_empresa" int4 NOT NULL,
	"activo" bool NOT NULL DEFAULT True,
	"descripcion" varchar(50) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "grupo_pkey" PRIMARY KEY("id_grupo"),
  CONSTRAINT "empresa_fkey1" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "fki_fki_empresa_grupo" ON "grupo" USING BTREE (
	"id_empresa"
);


CREATE UNIQUE INDEX "grupo_idx_descripcion" ON "grupo" (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_grupo" BEFORE INSERT OR UPDATE 
	ON "grupo" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "grupo" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "grupo" TO "taisa";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "grupo" TO "usrarbowdb";



-- DROP TABLE tipo_entrega
DROP TABLE IF EXISTS "tipo_entrega" CASCADE;

-- CREATE TABLE tipo_entrega
CREATE TABLE "tipo_entrega" (
	"id_tipo_entrega" int4 NOT NULL,
	"id_cliente" int4,
	"id_usuario_creador" int4 NOT NULL,
	"id_empresa" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"descripcion" varchar(100),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "tipo_pedido_pkey" PRIMARY KEY("id_tipo_entrega"),
  CONSTRAINT "empresa_fkey6" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "tipo_documento_tributario_fkey0" FOREIGN KEY ("id_tipo_documento_tributario")
    REFERENCES "tipo_documento_tributario"("id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "tipo_nota_venta_fki_empresa_fkey" ON "tipo_entrega" USING BTREE (
	"id_empresa"
);


CREATE INDEX "tipo_nota_venta_fki_tipo_documento_tributario_fkey" ON "tipo_entrega" USING BTREE (
	"id_tipo_documento_tributario"
);


CREATE TRIGGER "tgr_f_mod_te" BEFORE INSERT OR UPDATE 
	ON "tipo_entrega" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "tipo_entrega" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "tipo_entrega" TO "taisa";

GRANT SELECT ON TABLE "tipo_entrega" TO "usrarwsdb";



-- DROP TABLE empresa_acteco
DROP TABLE IF EXISTS "empresa_acteco" CASCADE;

-- CREATE TABLE empresa_acteco
CREATE TABLE "empresa_acteco" (
	"id_empresa" int4 NOT NULL,
	"id_acteco" int4 NOT NULL,
	"observacion" varchar(250),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "empresa_acteco_pkey" PRIMARY KEY("id_empresa","id_acteco"),
  CONSTRAINT "empresa_fkey3" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "acteco_fkey" FOREIGN KEY ("id_acteco")
    REFERENCES "acteco"("id_acteco")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tgr_f_mod_ea" BEFORE INSERT OR UPDATE 
	ON "empresa_acteco" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_ea" BEFORE INSERT OR UPDATE 
	ON "empresa_acteco" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_ec"();
GRANT ALL PRIVILEGES ON TABLE "empresa_acteco" TO "taisa";

GRANT SELECT ON TABLE "empresa_acteco" TO "usrarwsdb";



-- DROP TABLE empresa_canal
DROP TABLE IF EXISTS "empresa_canal" CASCADE;

-- CREATE TABLE empresa_canal
CREATE TABLE "empresa_canal" (
	"id_canal" int4 NOT NULL,
	"id_empresa" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "empresa_canal_pkey" PRIMARY KEY("id_canal","id_empresa"),
  CONSTRAINT "empresa_fkey7" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "canal_fkey0" FOREIGN KEY ("id_canal")
    REFERENCES "canal"("id_canal")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_ec" BEFORE INSERT OR UPDATE 
	ON "empresa_canal" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_ec" BEFORE INSERT OR UPDATE 
	ON "empresa_canal" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_ec"();


ALTER TABLE "empresa_canal" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "empresa_canal" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "empresa_canal" TO "usrarwsdb";

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "empresa_canal" TO "usrarbowdb";



-- DROP TABLE grupo_usuario
DROP TABLE IF EXISTS "grupo_usuario" CASCADE;

-- CREATE TABLE grupo_usuario
CREATE TABLE "grupo_usuario" (
	"id_grupo" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "grupo_usuario_pkey" PRIMARY KEY("id_grupo","id_usuario"),
  CONSTRAINT "grupo_fkey" FOREIGN KEY ("id_grupo")
    REFERENCES "grupo"("id_grupo")
	MATCH SIMPLE
	ON DELETE CASCADE
	ON UPDATE CASCADE
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey4" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE CASCADE
	ON UPDATE CASCADE
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_grupo_usuario" BEFORE INSERT OR UPDATE 
	ON "grupo_usuario" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "grupo_usuario" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "grupo_usuario" TO "taisa";

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "grupo_usuario" TO "usrarbowdb";



-- DROP TABLE caf
DROP TABLE IF EXISTS "caf" CASCADE;

-- CREATE TABLE caf
CREATE TABLE "caf" (
	"id_caf" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"id_empresa" int4 NOT NULL,
	"contenido" text NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "caf_pkey" PRIMARY KEY("id_caf","id_tipo_documento_tributario"),
  CONSTRAINT "empresa_fkey5" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "tipo_documento_tributario_fkey1" FOREIGN KEY ("id_tipo_documento_tributario")
    REFERENCES "tipo_documento_tributario"("id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_caf" BEFORE INSERT OR UPDATE 
	ON "caf" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "caf" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "caf" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "caf" TO "usrarwsdb";



-- DROP TABLE sucursal_empresa
DROP TABLE IF EXISTS "sucursal_empresa" CASCADE;

-- CREATE TABLE sucursal_empresa
CREATE TABLE "sucursal_empresa" (
	"id_sucursal_empresa" int4 NOT NULL,
	"id_empresa" int4,
	"id_zona" int4 NOT NULL,
	"id_comuna" int4 NOT NULL,
	"cdgsiisucur" varchar(9),
	"descripcion" varchar(50) NOT NULL,
	"direccion" varchar(500) NOT NULL,
	"telefono1" varchar(30),
	"telefono2" varchar(30),
	"fax1" varchar(30),
	"fax2" varchar(30),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "sucursal_empresa_pkey" PRIMARY KEY("id_sucursal_empresa"),
  CONSTRAINT "empresa_fkey" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "zona_fkey" FOREIGN KEY ("id_zona")
    REFERENCES "zona"("id_zona")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "comuna_fkey0" FOREIGN KEY ("id_comuna")
    REFERENCES "comuna"("id_comuna")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "sucursal_empresa_idx_descripcion" ON "sucursal_empresa" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_se" BEFORE INSERT OR UPDATE 
	ON "sucursal_empresa" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_se" BEFORE INSERT OR UPDATE 
	ON "sucursal_empresa" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_ec"();


ALTER TABLE "sucursal_empresa" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "sucursal_empresa" TO "taisa";

GRANT SELECT ON TABLE "sucursal_empresa" TO "usrarwsdb";

GRANT SELECT ON TABLE "sucursal_empresa" TO "usrarbowdb";



-- DROP TABLE subgrupo_producto
DROP TABLE IF EXISTS "subgrupo_producto" CASCADE;

-- CREATE TABLE subgrupo_producto
CREATE TABLE "subgrupo_producto" (
	"id_subgrupo_producto" int4 NOT NULL,
	"id_grupo_producto" int4 NOT NULL,
	"descripcion" varchar(250) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "subgrupo_producto_pkey" PRIMARY KEY("id_subgrupo_producto"),
  CONSTRAINT "grupo_producto_fkey" FOREIGN KEY ("id_grupo_producto")
    REFERENCES "grupo_producto"("id_grupo_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "subgrupo_producto_idx_descripcion" ON "subgrupo_producto" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_sgp" BEFORE INSERT OR UPDATE 
	ON "subgrupo_producto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_sgp" BEFORE INSERT OR UPDATE 
	ON "subgrupo_producto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_sgp"();


ALTER TABLE "subgrupo_producto" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "subgrupo_producto" TO "taisa";

GRANT SELECT ON TABLE "subgrupo_producto" TO "usrarwsdb";



-- DROP TABLE pda
DROP TABLE IF EXISTS "pda" CASCADE;

-- CREATE TABLE pda
CREATE TABLE "pda" (
	"id_pda" int4 NOT NULL DEFAULT nextval('pda_seq'::regclass),
	"id_empresa" int4 NOT NULL,
	"estado" int2 NOT NULL,
	"fecha_bloqueo" date,
	"fecha_creacion" date NOT NULL,
	"id_interno" varchar(256) NOT NULL,
	"observaciones" varchar(1024),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "check_estados" CHECK(estado = 0 OR estado = 1 OR estado = 2),
	CONSTRAINT "pda_pkey" PRIMARY KEY("id_pda"),
  CONSTRAINT "empresa_fkey0" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "pda_fki_fki_pda_empresa" ON "pda" USING BTREE (
	"id_empresa"
);


CREATE UNIQUE INDEX "pda_idx_pda_id_interno" ON "pda" USING BTREE (
	"id_interno"
);


CREATE TRIGGER "tgr_f_mod_pda" BEFORE INSERT OR UPDATE 
	ON "pda" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_pda_id_interno" BEFORE INSERT OR UPDATE 
	ON "pda" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_pda_id_interno"();


ALTER TABLE "pda" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "pda" TO "taisa";

GRANT SELECT ON TABLE "pda" TO "usrarwsdb";

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE "pda" TO "usrarbowdb";



-- DROP TABLE territorio
DROP TABLE IF EXISTS "territorio" CASCADE;

-- CREATE TABLE territorio
CREATE TABLE "territorio" (
	"id_territorio" int4 NOT NULL,
	"id_sucursal_empresa" int4 NOT NULL,
	"descripcion" varchar(50) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "territorio_pkey" PRIMARY KEY("id_territorio"),
  CONSTRAINT "sucursal_empresa_fkey" FOREIGN KEY ("id_sucursal_empresa")
    REFERENCES "sucursal_empresa"("id_sucursal_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "territorio_idx_descripcion" ON "territorio" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_ter" BEFORE INSERT OR UPDATE 
	ON "territorio" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "territorio" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "territorio" TO "taisa";

GRANT SELECT ON TABLE "territorio" TO "usrarwsdb";

GRANT SELECT ON TABLE "territorio" TO "usrarbowdb";



-- DROP TABLE linea_territorio_diferencial
DROP TABLE IF EXISTS "linea_territorio_diferencial" CASCADE;

-- CREATE TABLE linea_territorio_diferencial
CREATE TABLE "linea_territorio_diferencial" (
	"id_linea" int4 NOT NULL,
	"id_territorio" int4 NOT NULL,
	"diferencial" int4 NOT NULL DEFAULT 0,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "linea_territorio_diferencial_pkey" PRIMARY KEY("id_linea","id_territorio"),
  CONSTRAINT "territorio_fkey" FOREIGN KEY ("id_territorio")
    REFERENCES "territorio"("id_territorio")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "linea_fkey0" FOREIGN KEY ("id_linea")
    REFERENCES "linea"("id_linea")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tgr_f_mod_ltd" BEFORE INSERT OR UPDATE 
	ON "linea_territorio_diferencial" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();
GRANT ALL PRIVILEGES ON TABLE "linea_territorio_diferencial" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "linea_territorio_diferencial" TO "usrarwsdb";



-- DROP TABLE movil
DROP TABLE IF EXISTS "movil" CASCADE;

-- CREATE TABLE movil
CREATE TABLE "movil" (
	"id_movil" int4 NOT NULL,
	"id_sucursal_empresa" int4 NOT NULL,
	"id_usuario" int4,
	"descripcion" varchar(100) NOT NULL,
	"patente" varchar(10) NOT NULL,
	"tonelaje" int4,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "movil_pkey" PRIMARY KEY("id_movil"),
  CONSTRAINT "usuario_fkey6" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "sucursal_empresa_fkey1" FOREIGN KEY ("id_sucursal_empresa")
    REFERENCES "sucursal_empresa"("id_sucursal_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "movil_idx_usuario" ON "movil" USING BTREE (
	"id_usuario"
);


CREATE TRIGGER "tgr_borrado" BEFORE UPDATE 
	ON "movil" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_borrado"();


CREATE TRIGGER "tgr_f_mod_mov" BEFORE INSERT OR UPDATE 
	ON "movil" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "movil" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "movil" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "movil" TO "usrarwsdb";



-- DROP TABLE login_pda_usuario
DROP TABLE IF EXISTS "login_pda_usuario" CASCADE;

-- CREATE TABLE login_pda_usuario
CREATE TABLE "login_pda_usuario" (
	"id_login_pda_usuario" int4 NOT NULL DEFAULT nextval('login_pda_usuario_id_login_pda_usuario_seq'::regclass),
	"id_usuario" int4 NOT NULL,
	"borrado" bool NOT NULL DEFAULT false,
	"fecha_login" timestamp NOT NULL,
	"fecha_sincronizacion_desde_pda" timestamp,
	"id_pda" int4 NOT NULL,
	CONSTRAINT "login_pda_usuario_pkey" PRIMARY KEY("id_login_pda_usuario","id_usuario"),
  CONSTRAINT "pda_fkey0" FOREIGN KEY ("id_pda")
    REFERENCES "pda"("id_pda")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey7" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


ALTER TABLE "login_pda_usuario" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "login_pda_usuario" TO "taisa";

GRANT INSERT ON TABLE "login_pda_usuario" TO "usrarwsdb";



-- DROP TABLE pda_usuario
DROP TABLE IF EXISTS "pda_usuario" CASCADE;

-- CREATE TABLE pda_usuario
CREATE TABLE "pda_usuario" (
	"id_pda" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"fecha_asignacion" date NOT NULL,
	"fecha_devolucion" date,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "pda_usuario_pkey" PRIMARY KEY("id_pda","id_usuario"),
  CONSTRAINT "pda_fkey" FOREIGN KEY ("id_pda")
    REFERENCES "pda"("id_pda")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey5" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_pda_usuario" BEFORE INSERT OR UPDATE 
	ON "pda_usuario" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "pda_usuario" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "pda_usuario" TO "taisa";

GRANT SELECT ON TABLE "pda_usuario" TO "usrarwsdb";

GRANT SELECT, UPDATE, INSERT ON TABLE "pda_usuario" TO "usrarbowdb";



-- DROP TABLE log_pda_usuario
DROP TABLE IF EXISTS "log_pda_usuario" CASCADE;

-- CREATE TABLE log_pda_usuario
CREATE TABLE "log_pda_usuario" (
	"id_log_pda_usuario" int4 NOT NULL DEFAULT nextval('log_pda_usuario_id_log_pda_usuario_seq'::regclass),
	"id_usuario" int4 NOT NULL,
	"borrado" bool NOT NULL DEFAULT false,
	"descripcion_evento" varchar(256),
	"fecha_evento" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"id_pda" int4 NOT NULL,
	CONSTRAINT "log_pda_usuario_pkey" PRIMARY KEY("id_log_pda_usuario","id_usuario"),
  CONSTRAINT "pda_fkey1" FOREIGN KEY ("id_pda")
    REFERENCES "pda"("id_pda")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey8" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "log_pda_usuario_fki_id_pda" ON "log_pda_usuario" USING BTREE (
	"id_pda"
);


CREATE INDEX "log_pda_usuario_fki_id_usuario" ON "log_pda_usuario" USING BTREE (
	"id_usuario"
);


ALTER TABLE "log_pda_usuario" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "log_pda_usuario" TO "taisa";

GRANT INSERT ON TABLE "log_pda_usuario" TO "usrarwsdb";



-- DROP TABLE rango_folio
DROP TABLE IF EXISTS "rango_folio" CASCADE;

-- CREATE TABLE rango_folio
CREATE TABLE "rango_folio" (
	"id_rango_folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"id_caf" int4,
	"id_usuario" int4,
	"desde" int4 NOT NULL,
	"hasta" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "rango_folio_pkey" PRIMARY KEY("id_rango_folio","id_tipo_documento_tributario"),
  CONSTRAINT "usuario_fkey" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "caf_fkey" FOREIGN KEY ("id_caf", "id_tipo_documento_tributario")
    REFERENCES "caf"("id_caf", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_rf" BEFORE INSERT OR UPDATE 
	ON "rango_folio" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_fr" AFTER INSERT OR UPDATE 
	ON "rango_folio" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_rf"();


ALTER TABLE "rango_folio" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "rango_folio" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "rango_folio" TO "usrarwsdb";



-- DROP TABLE bodega_sucursal
DROP TABLE IF EXISTS "bodega_sucursal" CASCADE;

-- CREATE TABLE bodega_sucursal
CREATE TABLE "bodega_sucursal" (
	"id_bodega" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_sucursal_empresa" int4 NOT NULL,
	"id_comuna" int4 NOT NULL,
	"descripcion" varchar(20),
	"direccion" varchar(500) NOT NULL,
	"telefono1" varchar(30),
	"telefono2" varchar(30),
	"fax1" varchar(30),
	"fax2" varchar(30),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "bodega_sucursal_pkey" PRIMARY KEY("id_bodega","id_sucursal_empresa","id_usuario_creador"),
  CONSTRAINT "sucursal_empresa_fkey2" FOREIGN KEY ("id_sucursal_empresa")
    REFERENCES "sucursal_empresa"("id_sucursal_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "comuna_fkey1" FOREIGN KEY ("id_comuna")
    REFERENCES "comuna"("id_comuna")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE UNIQUE INDEX "bodega_sucursal_idx_descripcion" ON "bodega_sucursal" USING BTREE (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_bs" BEFORE INSERT OR UPDATE 
	ON "bodega_sucursal" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_bs" BEFORE INSERT OR UPDATE 
	ON "bodega_sucursal" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_bs"();


ALTER TABLE "bodega_sucursal" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "bodega_sucursal" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "bodega_sucursal" TO "usrarwsdb";



-- DROP TABLE sucursal_cliente
DROP TABLE IF EXISTS "sucursal_cliente" CASCADE;

-- CREATE TABLE sucursal_cliente
CREATE TABLE "sucursal_cliente" (
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_cliente" int4 NOT NULL,
	"id_territorio" int4 NOT NULL,
	"id_comuna" int4 NOT NULL,
	"id_comuna_f" int4,
	"fecha_creacion" date,
	"horario_llamada_desde" char(5),
	"horario_llamada_hasta" char(5),
	"horario_visita_desde" char(5),
	"horario_visita_hasta" char(5),
	"horario_ccenter_desde" char(5),
	"horario_ccenter_hasta" char(5),
	"id_usuario_administrador" int4,
	"descripcion" varchar(40) NOT NULL,
	"observaciones" varchar(500),
	"valor_periodicidad_llamado" char(7),
	"valor_periodicidad_visita" char(7) NOT NULL,
	"valor_periodicidad_ccenter" char(7),
	"local" int4 NOT NULL DEFAULT 0,
	"direccion" varchar(500) NOT NULL,
	"telefono1" varchar(30),
	"telefono2" varchar(30),
	"celular" varchar(30),
	"fax1" varchar(30),
	"fax2" varchar(30),
	"direccion_f" varchar(500) NOT NULL,
	"telefono1_f" varchar(30),
	"telefono2_f" varchar(30),
	"fax1_f" varchar(30),
	"fax2_f" varchar(30),
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "sucursal_cliente_pkey" PRIMARY KEY("id_sucursal_cliente","id_usuario_creador"),
  CONSTRAINT "territorio_fkey0" FOREIGN KEY ("id_territorio")
    REFERENCES "territorio"("id_territorio")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "cliente_fkey5" FOREIGN KEY ("id_cliente", "id_usuario_creador")
    REFERENCES "cliente"("id_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "comuna_fkey2" FOREIGN KEY ("id_comuna")
    REFERENCES "comuna"("id_comuna")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "comuna_fkey3" FOREIGN KEY ("id_comuna_f")
    REFERENCES "comuna"("id_comuna")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_scl" BEFORE INSERT OR UPDATE 
	ON "sucursal_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_scl" AFTER INSERT OR UPDATE 
	ON "sucursal_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_scl"();


ALTER TABLE "sucursal_cliente" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "sucursal_cliente" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "sucursal_cliente" TO "usrarwsdb";



-- DROP TABLE producto
DROP TABLE IF EXISTS "producto" CASCADE;

-- CREATE TABLE producto
CREATE TABLE "producto" (
	"id_producto" int4 NOT NULL,
	"id_empresa" int4 NOT NULL,
	"id_producto_contenido" int4,
	"id_subgrupo_producto" int4 NOT NULL,
	"id_unidad_medida_transaccion" int4 NOT NULL,
	"id_unidad_medida_valorizacion" int4 NOT NULL,
	"codigo" varchar(64) NOT NULL,
	"codigo_barra_dun14" char(14),
	"codigo_barra_ean13" char(13),
	"cumt_pc" numeric(10,3),
	"cumv_maxima" numeric(10,3),
	"cumv_minima" numeric(10,3),
	"cumv_promedio" numeric(10,3),
	"cumv_visible" bool NOT NULL DEFAULT True,
	"descripcion" varchar(200) NOT NULL,
	"es_comercializable" bool NOT NULL,
	"fecha_desde_vigencia_dos" date,
	"fecha_desde_vigencia_tres" date,
	"fecha_desde_vigencia_uno" date NOT NULL,
	"fecha_hasta_vigencia_dos" date,
	"fecha_hasta_vigencia_tres" date,
	"fecha_hasta_vigencia_uno" date NOT NULL,
	"ficha_tecnica" varchar(300),
	"formato" varchar(100),
	"precio_base_vigencia_dos" int4,
	"precio_base_vigencia_tres" int4,
	"precio_base_vigencia_uno" int4 NOT NULL,
	"vida_util" int4,
	"precio_minimo_vigencia_uno" int4 NOT NULL,
	"precio_minimo_vigencia_dos" int4,
	"precio_minimo_vigencia_tres" int4,
	"unidades_por_bandeja" int2,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "producto_pkey" PRIMARY KEY("id_producto"),
  CONSTRAINT "empresa_fkey4" FOREIGN KEY ("id_empresa")
    REFERENCES "empresa"("id_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "subgrupo_producto_fkey" FOREIGN KEY ("id_subgrupo_producto")
    REFERENCES "subgrupo_producto"("id_subgrupo_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey2" FOREIGN KEY ("id_unidad_medida_valorizacion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey3" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey17" FOREIGN KEY ("id_producto_contenido")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "producto_fki_fki_empresa" ON "producto" USING BTREE (
	"id_empresa"
);


CREATE UNIQUE INDEX "producto_idx_producto" ON "producto" USING BTREE (
	"codigo"
);


CREATE UNIQUE INDEX "producto_idx_descripcion" ON "producto" (
	"descripcion"
);


CREATE TRIGGER "tgr_f_mod_prod" BEFORE INSERT OR UPDATE 
	ON "producto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "producto" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "producto" TO "taisa";

GRANT SELECT ON TABLE "producto" TO "usrarwsdb";



-- DROP TABLE movimiento
DROP TABLE IF EXISTS "movimiento" CASCADE;

-- CREATE TABLE movimiento
CREATE TABLE "movimiento" (
	"id_movil" int4 NOT NULL,
	"id_movimiento" int4 NOT NULL DEFAULT nextval('movimiento_seq'::regclass),
	"id_tipo_movimiento" int4 NOT NULL,
	"folio" int4,
	"id_producto" int4 NOT NULL,
	"id_tipo_documento_tributario" int4,
	"id_unidad_medida_transaccion" int4 NOT NULL,
	"cum_transaccion" numeric(10,3) NOT NULL DEFAULT 0,
	"cum_valorizacion" numeric(10,3) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	"fecha_sincronizacion_paso" timestamp DEFAULT now(),
	CONSTRAINT "movimiento_pkey" PRIMARY KEY("id_movimiento","id_tipo_movimiento","id_movil"),
  CONSTRAINT "movil_fkey1" FOREIGN KEY ("id_movil")
    REFERENCES "movil"("id_movil")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey13" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "tipo_movimiento_fkey" FOREIGN KEY ("id_tipo_movimiento")
    REFERENCES "tipo_movimiento"("id_tipo_movimiento")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey7" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "fki_tipo_movimiento_fkey" ON "movimiento" USING BTREE (
	"id_tipo_movimiento"
);


CREATE TRIGGER "tbi_movimiento0" AFTER INSERT 
	ON "movimiento" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_mov"();


ALTER TABLE "movimiento" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "movimiento" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "movimiento" TO "usrarwsdb";



-- DROP TABLE nota_venta
DROP TABLE IF EXISTS "nota_venta" CASCADE;

-- CREATE TABLE nota_venta
CREATE TABLE "nota_venta" (
	"id_nota_venta" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"id_motivo_no_efectividad" int4,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_tipo_entrega" int4 NOT NULL,
	"id_estado_nota_venta" int4 NOT NULL,
	"tipo_nota_venta" int4 NOT NULL,
	"id_ariztia" int4,
	"fecha_creacion" date NOT NULL,
	"fecha_entrega" date NOT NULL,
	"orden_compra" varchar(20),
	"origen_nota_venta" varchar(250),
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "nota_venta_pkey" PRIMARY KEY("id_nota_venta","id_usuario_emisor","id_usuario_receptor"),
  CONSTRAINT "motivo_no_efectividad_fkey0" FOREIGN KEY ("id_motivo_no_efectividad")
    REFERENCES "motivo_no_efectividad"("id_motivo_no_efectividad")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "sucursal_cliente_fkey3" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey21" FOREIGN KEY ("id_usuario_receptor")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "tipo_entrega_fkey" FOREIGN KEY ("id_tipo_entrega")
    REFERENCES "tipo_entrega"("id_tipo_entrega")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "estado_nota_venta_fkey" FOREIGN KEY ("id_estado_nota_venta")
    REFERENCES "estado_nota_venta"("id_estado_nota_venta")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "idx_nv_id_usuario_receptor" ON "nota_venta" (
	"id_usuario_receptor"
);


CREATE TRIGGER "tgr_f_nv" AFTER INSERT OR UPDATE 
	ON "nota_venta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_nv"();


ALTER TABLE "nota_venta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "nota_venta" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "nota_venta" TO "usrarwsdb";



-- DROP TABLE mensaje_sucursal_cliente
DROP TABLE IF EXISTS "mensaje_sucursal_cliente" CASCADE;

-- CREATE TABLE mensaje_sucursal_cliente
CREATE TABLE "mensaje_sucursal_cliente" (
	"id_mensaje_sucursal_cliente" int4 NOT NULL DEFAULT nextval('mensaje_sucursal_cliente_seq'::regclass),
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"estado" int2 NOT NULL,
	"desde" varchar(64),
	"a" varchar(64),
	"asunto" varchar(64),
	"contenido" varchar(512) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_mensaje_sucursal_cliente"),
  CONSTRAINT "sucursal_cliente_fkey14" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


ALTER TABLE "mensaje_sucursal_cliente" OWNER TO "taisa";

-- DROP TABLE descuento_negociacion_suc_cliente
DROP TABLE IF EXISTS "descuento_negociacion_suc_cliente" CASCADE;

-- CREATE TABLE descuento_negociacion_suc_cliente
CREATE TABLE "descuento_negociacion_suc_cliente" (
	"id_producto" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"maximo" numeric(3,1) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "descuento_negociacion_suc_cliente_pkey" PRIMARY KEY("id_producto","id_sucursal_cliente","id_usuario_creador"),
  CONSTRAINT "sucursal_cliente_fkey12" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "fki_dn_producto_suc_cliente" ON "descuento_negociacion_suc_cliente" USING BTREE (
	"id_sucursal_cliente", 
	"id_producto"
);


CREATE INDEX "descuento_negociacion_suc_cliente_idx_id_sucursal_cliente" ON "descuento_negociacion_suc_cliente" (
	"id_sucursal_cliente"
);


CREATE TRIGGER "tgr_f_mod_descuento_negociacion_suc_cliente" BEFORE INSERT OR UPDATE 
	ON "descuento_negociacion_suc_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "descuento_negociacion_suc_cliente" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "descuento_negociacion_suc_cliente" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "descuento_negociacion_suc_cliente" TO "usrarwsdb";



-- DROP TABLE contacto
DROP TABLE IF EXISTS "contacto" CASCADE;

-- CREATE TABLE contacto
CREATE TABLE "contacto" (
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"nombre_completo" varchar(100) NOT NULL,
	"cargo" varchar(32),
	"cumpleanos" varchar(5),
	"depto" varchar(250),
	"email" varchar(32),
	"id_usuario_administrador" int4,
	"telefono1" varchar(16),
	"telefono2" varchar(16),
	"fax" varchar(16),
	"celular" varchar(16),
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "contacto_pkey" PRIMARY KEY("id_sucursal_cliente","id_usuario_creador","nombre_completo"),
  CONSTRAINT "sucursal_cliente_fkey0" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_contacto" BEFORE INSERT OR UPDATE 
	ON "contacto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "contacto" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "contacto" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "contacto" TO "usrarwsdb";



-- DROP TABLE historico_detalle_nv
DROP TABLE IF EXISTS "historico_detalle_nv" CASCADE;

-- CREATE TABLE historico_detalle_nv
CREATE TABLE "historico_detalle_nv" (
	"id_nota_venta" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"linea" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"cum_valorizacion_final" numeric(10,3) NOT NULL DEFAULT 0,
	"precio_final" int4 NOT NULL DEFAULT 0,
	CONSTRAINT "historico_detalle_nv_pkey" PRIMARY KEY("id_usuario_receptor"),
  CONSTRAINT "nota_venta_fkey4" FOREIGN KEY ("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
    REFERENCES "nota_venta"("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


ALTER TABLE "historico_detalle_nv" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "historico_detalle_nv" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "historico_detalle_nv" TO "usrarwsdb";



-- DROP TABLE descuento_volumen_suc_cliente
DROP TABLE IF EXISTS "descuento_volumen_suc_cliente" CASCADE;

-- CREATE TABLE descuento_volumen_suc_cliente
CREATE TABLE "descuento_volumen_suc_cliente" (
	"id_producto" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"nivel" int2 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"cum_transaccion_desde" numeric(10,3),
	"cum_transaccion_hasta" numeric(10,3),
	"cum_valorizacion_desde" numeric(10,3),
	"cum_valorizacion_hasta" numeric(10,3),
	"descuento" numeric(3,1) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "descuento_volumen_suc_cliente_pkey" PRIMARY KEY("id_producto","id_sucursal_cliente","nivel"),
  CONSTRAINT "sucursal_cliente_fkey11" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "fki_dv_producto_suc_cliente" ON "descuento_volumen_suc_cliente" USING BTREE (
	"id_sucursal_cliente", 
	"id_producto"
);


CREATE INDEX "descuento_volumen_suc_cliente_idx_id_sucursal_cliente" ON "descuento_volumen_suc_cliente" (
	"id_sucursal_cliente"
);


CREATE TRIGGER "tgr_f_mod_descuento_volumen_suc_cliente" BEFORE INSERT OR UPDATE 
	ON "descuento_volumen_suc_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "descuento_volumen_suc_cliente" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "descuento_volumen_suc_cliente" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "descuento_volumen_suc_cliente" TO "usrarwsdb";



-- DROP TABLE folio
DROP TABLE IF EXISTS "folio" CASCADE;

-- CREATE TABLE folio
CREATE TABLE "folio" (
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"id_rango_folio" int4 NOT NULL,
	"estado" int2 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	PRIMARY KEY("folio","id_tipo_documento_tributario"),
  CONSTRAINT "rango_folio_fkey" FOREIGN KEY ("id_rango_folio", "id_tipo_documento_tributario")
    REFERENCES "rango_folio"("id_rango_folio", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_folio" BEFORE INSERT OR UPDATE 
	ON "folio" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_folio" AFTER INSERT OR UPDATE 
	ON "folio" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_folio"();


ALTER TABLE "folio" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "folio" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "folio" TO "usrarwsdb";



-- DROP TABLE producto_suc_cliente_precio_especial
DROP TABLE IF EXISTS "producto_suc_cliente_precio_especial" CASCADE;

-- CREATE TABLE producto_suc_cliente_precio_especial
CREATE TABLE "producto_suc_cliente_precio_especial" (
	"id_producto" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"fecha_vigencia_desde" timestamp NOT NULL,
	"fecha_vigencia_hasta" timestamp NOT NULL,
	"precio" int4 NOT NULL,
	"precio_maximo" int4,
	"precio_minimo" int4,
	"aplica_shipping" bool NOT NULL DEFAULT False,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "producto_suc_cliente_precio_especial_pkey" PRIMARY KEY("id_producto","id_sucursal_cliente"),
  CONSTRAINT "producto_fkey6" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "sucursal_cliente_fkey6" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE INDEX "producto_suc_cliente_precio_especial_idx_id_sucursal_cliente" ON "producto_suc_cliente_precio_especial" (
	"id_sucursal_cliente"
);


CREATE TRIGGER "tgr_f_mod_pscpe" BEFORE INSERT OR UPDATE 
	ON "producto_suc_cliente_precio_especial" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();
GRANT ALL PRIVILEGES ON TABLE "producto_suc_cliente_precio_especial" TO "taisa";

GRANT SELECT, UPDATE, DELETE ON TABLE "producto_suc_cliente_precio_especial" TO "usrarwsdb";



-- DROP TABLE visita
DROP TABLE IF EXISTS "visita" CASCADE;

-- CREATE TABLE visita
CREATE TABLE "visita" (
	"id_visita" int4 NOT NULL DEFAULT nextval('visita_seq'::regclass),
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"estado" int2 NOT NULL,
	"fecha_visita" timestamp NOT NULL,
	"fecha_aviso" timestamp,
	PRIMARY KEY("id_visita"),
  CONSTRAINT "sucursal_cliente_fkey15" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey23" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


ALTER TABLE "visita" OWNER TO "taisa";

-- DROP TABLE criticidad_sucursal_cliente
DROP TABLE IF EXISTS "criticidad_sucursal_cliente" CASCADE;

-- CREATE TABLE criticidad_sucursal_cliente
CREATE TABLE "criticidad_sucursal_cliente" (
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_criticidad" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_sucursal_cliente","id_usuario_creador"),
  CONSTRAINT "sucursal_cliente_fkey16" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "criticidad_fkey" FOREIGN KEY ("id_criticidad")
    REFERENCES "criticidad"("id_criticidad")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


ALTER TABLE "criticidad_sucursal_cliente" OWNER TO "taisa";

-- DROP TABLE cobranza_saldo
DROP TABLE IF EXISTS "cobranza_saldo" CASCADE;

-- CREATE TABLE cobranza_saldo
CREATE TABLE "cobranza_saldo" (
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_usuario_receptor" int4,
	"monto_autorizado" int4 NOT NULL DEFAULT 0,
	"saldo_vencido" int4 NOT NULL DEFAULT 0,
	"saldo_sin_vencer" int4 NOT NULL DEFAULT 0,
	"saldo_vencido_15" int4 NOT NULL DEFAULT 0,
	"saldo_vencido_30" int4 NOT NULL DEFAULT 0,
	"saldo_vencido_45" int4 NOT NULL DEFAULT 0,
	"saldo_vencido_60" int4 NOT NULL DEFAULT 0,
	"saldo_vencido_90" int4 NOT NULL DEFAULT 0,
	"saldo_vencido_120" int4 NOT NULL DEFAULT 0,
	"saldo_vencido_mas_120" int4 NOT NULL DEFAULT 0,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
  CONSTRAINT "sucursal_cliente_fkey1" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey16" FOREIGN KEY ("id_usuario_receptor")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


ALTER TABLE "cobranza_saldo" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "cobranza_saldo" TO "taisa";

GRANT SELECT ON TABLE "cobranza_saldo" TO "usrarwsdb";



-- DROP TABLE sucursal_cliente_no_efectividad
DROP TABLE IF EXISTS "sucursal_cliente_no_efectividad" CASCADE;

-- CREATE TABLE sucursal_cliente_no_efectividad
CREATE TABLE "sucursal_cliente_no_efectividad" (
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_motivo_no_efectividad" int4 NOT NULL,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT now(),
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_sucursal_cliente","id_usuario_creador","id_motivo_no_efectividad"),
  CONSTRAINT "sucursal_cliente_fkey13" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "motivo_no_efectividad_fkey1" FOREIGN KEY ("id_motivo_no_efectividad")
    REFERENCES "motivo_no_efectividad"("id_motivo_no_efectividad")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


ALTER TABLE "sucursal_cliente_no_efectividad" OWNER TO "taisa";

-- DROP TABLE sucursal_cliente_usuario
DROP TABLE IF EXISTS "sucursal_cliente_usuario" CASCADE;

-- CREATE TABLE sucursal_cliente_usuario
CREATE TABLE "sucursal_cliente_usuario" (
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"fecha_sincronizacion_paso" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_sucursal_cliente","id_usuario","id_usuario_creador"),
  CONSTRAINT "sucursal_cliente_fkey9" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey18" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE UNIQUE INDEX "sucursal_cliente_usuario_idx_id_sucursal_cliente_usuario_id_usuario" ON "sucursal_cliente_usuario" (
	"id_sucursal_cliente", 
	"id_usuario"
);


CREATE INDEX "sucursal_cliente_usuario_idx_id_sucursal_cliente" ON "sucursal_cliente_usuario" (
	"id_sucursal_cliente"
);


CREATE TRIGGER "tgr_f_mod_scu" BEFORE INSERT OR UPDATE 
	ON "sucursal_cliente_usuario" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();
GRANT ALL PRIVILEGES ON TABLE "sucursal_cliente_usuario" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "sucursal_cliente_usuario" TO "usrarwsdb";



-- DROP TABLE producto_unidad_medida_transaccion
DROP TABLE IF EXISTS "producto_unidad_medida_transaccion" CASCADE;

-- CREATE TABLE producto_unidad_medida_transaccion
CREATE TABLE "producto_unidad_medida_transaccion" (
	"id_producto" int4 NOT NULL,
	"id_unidad_medida" int4 NOT NULL,
	"factor_unidad_medida_maximo" numeric(10,3) NOT NULL,
	"factor_unidad_medida_minimo" numeric(10,3) NOT NULL,
	"factor_unidad_medida_promedio" numeric(10,3) NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "producto_unidad_medida_transaccion_pkey" PRIMARY KEY("id_producto","id_unidad_medida"),
  CONSTRAINT "unidad_medida_fkey1" FOREIGN KEY ("id_unidad_medida")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey8" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);
GRANT ALL PRIVILEGES ON TABLE "producto_unidad_medida_transaccion" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "producto_unidad_medida_transaccion" TO "usrarwsdb";



-- DROP TABLE producto_suc_cliente_bloqueado
DROP TABLE IF EXISTS "producto_suc_cliente_bloqueado" CASCADE;

-- CREATE TABLE producto_suc_cliente_bloqueado
CREATE TABLE "producto_suc_cliente_bloqueado" (
	"id_producto" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "producto_suc_cliente_bloqueado_pkey" PRIMARY KEY("id_producto","id_sucursal_cliente"),
  CONSTRAINT "sucursal_cliente_fkey8" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey9" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE INDEX "producto_suc_cliente_bloqueado_idx_id_sucursal_cliente" ON "producto_suc_cliente_bloqueado" (
	"id_sucursal_cliente"
);


CREATE TRIGGER "tgr_f_mod_pscb" BEFORE INSERT OR UPDATE 
	ON "producto_suc_cliente_bloqueado" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();
GRANT ALL PRIVILEGES ON TABLE "producto_suc_cliente_bloqueado" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "producto_suc_cliente_bloqueado" TO "usrarwsdb";



-- DROP TABLE serial
DROP TABLE IF EXISTS "serial" CASCADE;

-- CREATE TABLE serial
CREATE TABLE "serial" (
	"serial" varchar(50) NOT NULL,
	"id_movil" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"cumt_original" numeric(10,3) NOT NULL DEFAULT 0,
	"cumv_original" numeric(10,3) NOT NULL DEFAULT 0,
	"cumt_final" numeric(10,3) NOT NULL DEFAULT 0,
	"cumv_final" numeric(10,3) NOT NULL DEFAULT 0,
	"nuevo_serial" bool,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "serial_pkey" PRIMARY KEY("serial"),
  CONSTRAINT "movil_fkey2" FOREIGN KEY ("id_movil")
    REFERENCES "movil"("id_movil")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey7" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tgr_f_mod_serial" BEFORE INSERT OR UPDATE 
	ON "serial" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_serial" AFTER INSERT OR UPDATE 
	ON "serial" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_serial"();
GRANT ALL PRIVILEGES ON TABLE "serial" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "serial" TO "usrarwsdb";



-- DROP TABLE producto_cliente_shipping
DROP TABLE IF EXISTS "producto_cliente_shipping" CASCADE;

-- CREATE TABLE producto_cliente_shipping
CREATE TABLE "producto_cliente_shipping" (
	"id_cliente" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "producto_cliente_shipping_pkey" PRIMARY KEY("id_producto","id_cliente"),
  CONSTRAINT "producto_fkey16" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "cliente_fkey4" FOREIGN KEY ("id_cliente", "id_usuario_creador")
    REFERENCES "cliente"("id_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tgr_f_mod_pcs" BEFORE INSERT OR UPDATE 
	ON "producto_cliente_shipping" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();
GRANT ALL PRIVILEGES ON TABLE "producto_cliente_shipping" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "producto_cliente_shipping" TO "usrarwsdb";



-- DROP TABLE producto_contenedor
DROP TABLE IF EXISTS "producto_contenedor" CASCADE;

-- CREATE TABLE producto_contenedor
CREATE TABLE "producto_contenedor" (
	"id_contenedor" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"cantidad_unidades_contenedor" int4,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "producto_contenedor_pkey" PRIMARY KEY("id_contenedor","id_producto"),
  CONSTRAINT "producto_fkey14" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "contenedor_fkey" FOREIGN KEY ("id_contenedor")
    REFERENCES "contenedor"("id_contenedor")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


ALTER TABLE "producto_contenedor" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "producto_contenedor" TO "taisa";

GRANT SELECT ON TABLE "producto_contenedor" TO "usrarwsdb";



-- DROP TABLE encuesta_sucursal_cliente
DROP TABLE IF EXISTS "encuesta_sucursal_cliente" CASCADE;

-- CREATE TABLE encuesta_sucursal_cliente
CREATE TABLE "encuesta_sucursal_cliente" (
	"id_encuesta" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"contestada" bool NOT NULL DEFAULT false,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "encuesta_sucursal_cliente_pkey" PRIMARY KEY("id_encuesta","id_sucursal_cliente","id_usuario_creador"),
  CONSTRAINT "sucursal_cliente_fkey4" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "encuesta_fkey0" FOREIGN KEY ("id_encuesta")
    REFERENCES "encuesta"("id_encuesta")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "encuesta_sucursal_cliente_fki_encuesta_fkey" ON "encuesta_sucursal_cliente" USING BTREE (
	"id_encuesta"
);


CREATE UNIQUE INDEX "encuesta_sucursal_cliente_idx_id_sucursal_cliente" ON "encuesta_sucursal_cliente" (
	"id_sucursal_cliente"
);


CREATE TRIGGER "tgr_f_mod_esc" BEFORE INSERT OR UPDATE 
	ON "encuesta_sucursal_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_esc" AFTER INSERT OR UPDATE 
	ON "encuesta_sucursal_cliente" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_nv"();


ALTER TABLE "encuesta_sucursal_cliente" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "encuesta_sucursal_cliente" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "encuesta_sucursal_cliente" TO "usrarwsdb";



-- DROP TABLE factura_nota_venta
DROP TABLE IF EXISTS "factura_nota_venta" CASCADE;

-- CREATE TABLE factura_nota_venta
CREATE TABLE "factura_nota_venta" (
	"folio" int4 NOT NULL,
	"id_nota_venta" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "factura_nota_venta_pkey" PRIMARY KEY("id_nota_venta","id_usuario_emisor","id_tipo_documento_tributario","folio"),
  CONSTRAINT "nota_venta_fkey" FOREIGN KEY ("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
    REFERENCES "nota_venta"("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "factura_fkey" FOREIGN KEY ("folio", "id_tipo_documento_tributario")
    REFERENCES "factura"("folio", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "factura_nota_venta_fki_factura_nota_venta" ON "factura_nota_venta" USING BTREE (
	"id_nota_venta"
);


CREATE TRIGGER "tgr_f_mod_factura_nota_venta" BEFORE INSERT OR UPDATE 
	ON "factura_nota_venta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "factura_nota_venta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "factura_nota_venta" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "factura_nota_venta" TO "usrarwsdb";



-- DROP TABLE guia_despacho_nota_venta
DROP TABLE IF EXISTS "guia_despacho_nota_venta" CASCADE;

-- CREATE TABLE guia_despacho_nota_venta
CREATE TABLE "guia_despacho_nota_venta" (
	"id_nota_venta" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"id_tipo_documento_tributario" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "guia_despacho_nota_venta_pkey" PRIMARY KEY("id_nota_venta","folio","id_usuario_emisor","id_tipo_documento_tributario"),
  CONSTRAINT "nota_venta_fkey2" FOREIGN KEY ("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
    REFERENCES "nota_venta"("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "guia_despacho_fkey0" FOREIGN KEY ("id_tipo_documento_tributario", "folio")
    REFERENCES "guia_despacho"("id_tipo_documento_tributario", "folio")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "fki_fki_gd_nv" ON "guia_despacho_nota_venta" USING BTREE (
	"id_nota_venta"
);


CREATE TRIGGER "tgr_f_mod_gdnv" BEFORE INSERT OR UPDATE 
	ON "guia_despacho_nota_venta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_gdnv" BEFORE INSERT OR UPDATE 
	ON "guia_despacho_nota_venta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_gdnv"();


ALTER TABLE "guia_despacho_nota_venta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "guia_despacho_nota_venta" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "guia_despacho_nota_venta" TO "usrarwsdb";



-- DROP TABLE serial_contenedor_movimiento
DROP TABLE IF EXISTS "serial_contenedor_movimiento" CASCADE;

-- CREATE TABLE serial_contenedor_movimiento
CREATE TABLE "serial_contenedor_movimiento" (
	"id_movil" int4 NOT NULL,
	"id_serial_contenedor_movimiento" int4 NOT NULL,
	"id_movimiento" int4 NOT NULL,
	"id_unidad_medida_transaccion" int4 NOT NULL,
	"cum_transaccion" numeric(10,3),
	"cum_valorizacion" numeric(10,3),
	"serial" varchar(50) NOT NULL,
	"serial_contenedor" varchar(50) NOT NULL,
	"serial_pallet" int4,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	"id_tipo_movimiento" int4 NOT NULL,
	CONSTRAINT "serial_producto_movimiento_pkey" PRIMARY KEY("id_serial_contenedor_movimiento","id_movil"),
  CONSTRAINT "unidad_medida_fkey9" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "movimiento_fkey" FOREIGN KEY ("id_movimiento", "id_movil", "id_tipo_movimiento")
    REFERENCES "movimiento"("id_movimiento", "id_movil", "id_tipo_movimiento")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_serial_producto_mov" BEFORE INSERT OR UPDATE 
	ON "serial_contenedor_movimiento" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "serial_contenedor_movimiento" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "serial_contenedor_movimiento" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "serial_contenedor_movimiento" TO "usrarwsdb";



-- DROP TABLE producto_impuesto
DROP TABLE IF EXISTS "producto_impuesto" CASCADE;

-- CREATE TABLE producto_impuesto
CREATE TABLE "producto_impuesto" (
	"id_impuesto" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "producto_impuesto_pkey" PRIMARY KEY("id_impuesto","id_producto"),
  CONSTRAINT "impuesto_fkey1" FOREIGN KEY ("id_impuesto")
    REFERENCES "impuesto"("id_impuesto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey0" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_producto_impuesto" BEFORE INSERT OR UPDATE 
	ON "producto_impuesto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "producto_impuesto" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "producto_impuesto" TO "taisa";

GRANT SELECT ON TABLE "producto_impuesto" TO "usrarwsdb";



-- DROP TABLE producto_sugerido
DROP TABLE IF EXISTS "producto_sugerido" CASCADE;

-- CREATE TABLE producto_sugerido
CREATE TABLE "producto_sugerido" (
	"id_producto" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "producto_sugerido_pkey" PRIMARY KEY("id_producto","id_sucursal_cliente"),
  CONSTRAINT "sucursal_cliente_fkey10" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey3" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "producto_sugerido_idx_id_sucursal_cliente" ON "producto_sugerido" (
	"id_sucursal_cliente"
);


CREATE TRIGGER "tgr_f_mod_ps" BEFORE INSERT OR UPDATE 
	ON "producto_sugerido" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "producto_sugerido" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "producto_sugerido" TO "taisa";

GRANT SELECT ON TABLE "producto_sugerido" TO "usrarwsdb";



-- DROP TABLE producto_suc_empresa
DROP TABLE IF EXISTS "producto_suc_empresa" CASCADE;

-- CREATE TABLE producto_suc_empresa
CREATE TABLE "producto_suc_empresa" (
	"id_producto" int4 NOT NULL,
	"id_sucursal_empresa" int4 NOT NULL,
	"diferencial_precio" numeric(10,2),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "producto_suc_empresa_pkey" PRIMARY KEY("id_producto","id_sucursal_empresa"),
  CONSTRAINT "producto_fkey" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "sucursal_empresa_fkey0" FOREIGN KEY ("id_sucursal_empresa")
    REFERENCES "sucursal_empresa"("id_sucursal_empresa")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "producto_suc_empresa_fki_id_producto_fkey" ON "producto_suc_empresa" USING BTREE (
	"id_producto"
);


CREATE TRIGGER "tgr_f_mod_producto_suc_empresa" BEFORE INSERT OR UPDATE 
	ON "producto_suc_empresa" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "producto_suc_empresa" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "producto_suc_empresa" TO "taisa";

GRANT SELECT ON TABLE "producto_suc_empresa" TO "usrarwsdb";



-- DROP TABLE stock_inicial_movil
DROP TABLE IF EXISTS "stock_inicial_movil" CASCADE;

-- CREATE TABLE stock_inicial_movil
CREATE TABLE "stock_inicial_movil" (
	"id_movil" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_unidad_medida_transaccion" int4 NOT NULL,
	"cum_valorizacion_disponible" numeric(10,3),
	"cum_valorizacion_no_disponible" numeric(10,3),
	"cum_transaccion_disponible" numeric(10,3) NOT NULL DEFAULT 0,
	"cum_transaccion_no_disponible" numeric(10,3) NOT NULL DEFAULT 0,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	CONSTRAINT "stock_inicial_movil_pkey" PRIMARY KEY("id_movil","id_producto"),
  CONSTRAINT "movil_fkey0" FOREIGN KEY ("id_movil")
    REFERENCES "movil"("id_movil")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey15" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey6" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_sim" BEFORE INSERT OR UPDATE 
	ON "stock_inicial_movil" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


CREATE TRIGGER "tgr_f_sim" AFTER INSERT OR UPDATE 
	ON "stock_inicial_movil" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_serial"();


ALTER TABLE "stock_inicial_movil" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "stock_inicial_movil" TO "taisa";

GRANT SELECT ON TABLE "stock_inicial_movil" TO "usrarwsdb";



-- DROP TABLE stock_bodega
DROP TABLE IF EXISTS "stock_bodega" CASCADE;

-- CREATE TABLE stock_bodega
CREATE TABLE "stock_bodega" (
	"id_bodega" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_sucursal_empresa" int4 NOT NULL,
	"id_unidad_medida_transaccion" int4 NOT NULL,
	"cum_valorizacion_disponible" numeric(10,3),
	"cum_transaccion_disponible" numeric(10,3) NOT NULL DEFAULT 0,
	"cum_transaccion_no_disponible" numeric(10,3) NOT NULL DEFAULT 0,
	"cum_valorizacion_no_disponible" numeric(10,3),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	"id_usuario_creador" int4 NOT NULL,
	CONSTRAINT "stock_bodega_pkey" PRIMARY KEY("id_bodega","id_producto","id_sucursal_empresa"),
  CONSTRAINT "bodega_sucursal_fkey" FOREIGN KEY ("id_bodega", "id_sucursal_empresa", "id_usuario_creador")
    REFERENCES "bodega_sucursal"("id_bodega", "id_sucursal_empresa", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey8" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey12" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "stock_bodega_fki_fki_stock_producto_suc_empresa" ON "stock_bodega" USING BTREE (
	"id_producto", 
	"id_sucursal_empresa"
);


CREATE TRIGGER "tgr_f_mod_stock_bodega" BEFORE INSERT OR UPDATE 
	ON "stock_bodega" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "stock_bodega" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "stock_bodega" TO "taisa";

GRANT SELECT ON TABLE "stock_bodega" TO "usrarwsdb";



-- DROP TABLE devolucion
DROP TABLE IF EXISTS "devolucion" CASCADE;

-- CREATE TABLE devolucion
CREATE TABLE "devolucion" (
	"id_tipo_documento_tributario" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador_sucursal_cliente" int4 NOT NULL,
	"tipo_devolucion" varchar(20) NOT NULL,
	"guia_despacho_cliente" int4,
	"numero_voucher" varchar(32),
	"observacion" varchar(264),
	"fecha_guia_cliente" date,
	"motivo_devolucion" varchar(50),
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	PRIMARY KEY("id_tipo_documento_tributario","folio"),
  CONSTRAINT "usuario_fkey10" FOREIGN KEY ("id_usuario_receptor")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "documento_tributario_fkey0" FOREIGN KEY ("folio", "id_tipo_documento_tributario")
    REFERENCES "documento_tributario"("folio", "id_tipo_documento_tributario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "sucursal_cliente_fkey5" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador_sucursal_cliente")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_dev" BEFORE INSERT OR UPDATE 
	ON "devolucion" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_dev" AFTER INSERT OR UPDATE 
	ON "devolucion" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_dev"();


ALTER TABLE "devolucion" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "devolucion" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "devolucion" TO "usrarwsdb";



-- DROP TABLE detalle_devolucion
DROP TABLE IF EXISTS "detalle_devolucion" CASCADE;

-- CREATE TABLE detalle_devolucion
CREATE TABLE "detalle_devolucion" (
	"id_tipo_documento_tributario" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"linea_devolucion" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_unidad_medida_transaccion" int4 NOT NULL,
	"cum_transaccion" numeric(10,3) NOT NULL,
	"cum_valorizacion" numeric(10,3) NOT NULL,
	"guia_despacho_cliente" int4,
	"observacion" varchar(128),
	"precio_unitario" int4 NOT NULL,
	"precio_final" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "detalle_devolucion_pkey" PRIMARY KEY("linea_devolucion","folio","id_tipo_documento_tributario"),
  CONSTRAINT "producto_fkey11" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey10" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "devolucion_fkey" FOREIGN KEY ("id_tipo_documento_tributario", "folio")
    REFERENCES "devolucion"("id_tipo_documento_tributario", "folio")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "detalle_devolucion_fki_producto_fkey" ON "detalle_devolucion" USING BTREE (
	"id_producto"
);


CREATE TRIGGER "tgr_f_mod_dd" BEFORE INSERT OR UPDATE 
	ON "detalle_devolucion" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_dd" AFTER INSERT OR UPDATE 
	ON "detalle_devolucion" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_dd"();


ALTER TABLE "detalle_devolucion" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "detalle_devolucion" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "detalle_devolucion" TO "usrarwsdb";



-- DROP TABLE stock_movil
DROP TABLE IF EXISTS "stock_movil" CASCADE;

-- CREATE TABLE stock_movil
CREATE TABLE "stock_movil" (
	"id_movil" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_unidad_medida_transaccion" int4 NOT NULL,
	"cum_valorizacion_disponible" numeric(10,3),
	"cum_valorizacion_no_disponible" numeric(10,3),
	"cum_transaccion_disponible" numeric(10,3) NOT NULL DEFAULT 0,
	"cum_transaccion_no_disponible" numeric(10,3) NOT NULL DEFAULT 0,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "stock_movil_pkey" PRIMARY KEY("id_movil","id_producto"),
  CONSTRAINT "movil_fkey" FOREIGN KEY ("id_movil")
    REFERENCES "movil"("id_movil")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey5" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey10" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "stock_movil_idx_id_producto" ON "stock_movil" USING BTREE (
	"id_producto"
);


CREATE TRIGGER "tgr_f_mod_stock_movil" BEFORE INSERT OR UPDATE 
	ON "stock_movil" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "stock_movil" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "stock_movil" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "stock_movil" TO "usrarwsdb";



-- DROP TABLE cobranza
DROP TABLE IF EXISTS "cobranza" CASCADE;

-- CREATE TABLE cobranza
CREATE TABLE "cobranza" (
	"id_tipo_documento_tributario" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador_sucursal_cliente" int4,
	"id_usuario_receptor" int4,
	"id_usuario_creador_cobranza" int4 NOT NULL,
	"fecha_emision" date NOT NULL,
	"fecha_ultimo_abono" date,
	"fecha_vencimiento" date NOT NULL,
	"monto_abonado" int4 NOT NULL DEFAULT 0,
	"monto_original" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	PRIMARY KEY("id_tipo_documento_tributario","folio"),
  CONSTRAINT "usuario_fkey3" FOREIGN KEY ("id_usuario_receptor")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "sucursal_cliente_fkey" FOREIGN KEY ("id_sucursal_cliente", "id_usuario_creador_sucursal_cliente")
    REFERENCES "sucursal_cliente"("id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey13" FOREIGN KEY ("id_usuario_creador_cobranza")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_cob" BEFORE INSERT OR UPDATE 
	ON "cobranza" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_cob" AFTER INSERT OR UPDATE 
	ON "cobranza" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_cob"();


ALTER TABLE "cobranza" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "cobranza" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "cobranza" TO "usrarwsdb";



-- DROP TABLE nv_impuesto
DROP TABLE IF EXISTS "nv_impuesto" CASCADE;

-- CREATE TABLE nv_impuesto
CREATE TABLE "nv_impuesto" (
	"id_impuesto" int4 NOT NULL,
	"id_nota_venta" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"porcentaje" numeric(5,2) NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "nv_impuesto_pkey" PRIMARY KEY("id_impuesto","id_nota_venta","id_producto","id_usuario_emisor"),
  CONSTRAINT "nota_venta_fkey1" FOREIGN KEY ("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
    REFERENCES "nota_venta"("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey4" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "impuesto_fkey0" FOREIGN KEY ("id_impuesto")
    REFERENCES "impuesto"("id_impuesto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_nvi" BEFORE INSERT OR UPDATE 
	ON "nv_impuesto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_nvi" AFTER INSERT OR UPDATE 
	ON "nv_impuesto" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_dnv"();


ALTER TABLE "nv_impuesto" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "nv_impuesto" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "nv_impuesto" TO "usrarwsdb";



-- DROP TABLE respuesta_encuesta
DROP TABLE IF EXISTS "respuesta_encuesta" CASCADE;

-- CREATE TABLE respuesta_encuesta
CREATE TABLE "respuesta_encuesta" (
	"id_respuesta_encuesta" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"id_alternativa_encuesta" int4 NOT NULL,
	"id_encuesta" int4 NOT NULL,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador" int4 NOT NULL,
	"otra" varchar(200),
	"respuesta" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "respuesta_encuesta_pkey" PRIMARY KEY("id_respuesta_encuesta","id_usuario"),
  CONSTRAINT "alternativa_encuesta_fkey" FOREIGN KEY ("id_alternativa_encuesta")
    REFERENCES "alternativa_encuesta"("id_alternativa_encuesta")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "usuario_fkey17" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "encuesta_sucursal_cliente_fkey" FOREIGN KEY ("id_encuesta", "id_sucursal_cliente", "id_usuario_creador")
    REFERENCES "encuesta_sucursal_cliente"("id_encuesta", "id_sucursal_cliente", "id_usuario_creador")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgp_f_mod_re" BEFORE INSERT OR UPDATE 
	ON "respuesta_encuesta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tbi_respuesta_encuesta0" BEFORE INSERT OR UPDATE 
	ON "respuesta_encuesta" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_re"();


ALTER TABLE "respuesta_encuesta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "respuesta_encuesta" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "respuesta_encuesta" TO "usrarwsdb";



-- DROP TABLE meta
DROP TABLE IF EXISTS "meta" CASCADE;

-- CREATE TABLE meta
CREATE TABLE "meta" (
	"id_usuario" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_unidad_medida" int4 NOT NULL,
	"cum_valorizacion_meta" numeric(10,3) NOT NULL,
	"cum_valorizacion_actual" numeric(10,3),
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "meta_pkey" PRIMARY KEY("id_usuario","id_producto","id_unidad_medida"),
  CONSTRAINT "usuario_fkey15" FOREIGN KEY ("id_usuario")
    REFERENCES "usuario"("id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey2" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey" FOREIGN KEY ("id_unidad_medida")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


ALTER TABLE "meta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "meta" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "meta" TO "usrarwsdb";



-- DROP TABLE cobranza_voucher
DROP TABLE IF EXISTS "cobranza_voucher" CASCADE;

-- CREATE TABLE cobranza_voucher
CREATE TABLE "cobranza_voucher" (
	"id_tipo_documento_tributario" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"id_forma_pago" int4 NOT NULL,
	"id_recaudo" int4 NOT NULL,
	"id_usuario" int4 NOT NULL,
	"numero_voucher" varchar(50) NOT NULL,
	"monto_cancelado" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_tipo_documento_tributario","folio","id_forma_pago","id_recaudo","id_usuario"),
  CONSTRAINT "forma_pago_fkey0" FOREIGN KEY ("id_forma_pago")
    REFERENCES "forma_pago"("id_forma_pago")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "cobranza_fkey" FOREIGN KEY ("id_tipo_documento_tributario", "folio")
    REFERENCES "cobranza"("id_tipo_documento_tributario", "folio")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "recaudo_fkey0" FOREIGN KEY ("id_recaudo", "id_usuario")
    REFERENCES "recaudo"("id_recaudo", "id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tbi_cobranza_voucher0" BEFORE INSERT OR UPDATE 
	ON "cobranza_voucher" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tbi_cobranza_voucher1" BEFORE INSERT OR UPDATE 
	ON "cobranza_voucher" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_cv"();


ALTER TABLE "cobranza_voucher" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "cobranza_voucher" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "cobranza_voucher" TO "usrarwsdb";



-- DROP TABLE autorizacion_forma_pago
DROP TABLE IF EXISTS "autorizacion_forma_pago" CASCADE;

-- CREATE TABLE autorizacion_forma_pago
CREATE TABLE "autorizacion_forma_pago" (
	"id_codigo_autorizacion" int4 NOT NULL,
	"id_banco" int4,
	"id_forma_pago" int4,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_usuario_creador_sucursal_cliente" int4,
	"id_recaudo" int4,
	"id_usuario" int4,
	"monto" int4 NOT NULL,
	"fecha_vencimiento_documento" date,
	"nro_cuenta_corriente" varchar(50),
	"nro_documento" varchar(20),
	"rut_titular" varchar(10),
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	PRIMARY KEY("id_codigo_autorizacion"),
  CONSTRAINT "forma_pago_fkey3" FOREIGN KEY ("id_forma_pago")
    REFERENCES "forma_pago"("id_forma_pago")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "codigo_autorizacion_fkey0" FOREIGN KEY ("id_codigo_autorizacion")
    REFERENCES "codigo_autorizacion"("id_codigo_autorizacion")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "sucursal_cliente_fkey2" FOREIGN KEY ("id_usuario_creador_sucursal_cliente", "id_sucursal_cliente")
    REFERENCES "sucursal_cliente"("id_usuario_creador", "id_sucursal_cliente")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "recaudo_fkey1" FOREIGN KEY ("id_recaudo", "id_usuario")
    REFERENCES "recaudo"("id_recaudo", "id_usuario")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tbi_autorizacion_forma_pago0" BEFORE INSERT OR UPDATE 
	ON "autorizacion_forma_pago" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "autorizacion_forma_pago" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "autorizacion_forma_pago" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "autorizacion_forma_pago" TO "usrarwsdb";



-- DROP TABLE detalle_nota_venta
DROP TABLE IF EXISTS "detalle_nota_venta" CASCADE;

-- CREATE TABLE detalle_nota_venta
CREATE TABLE "detalle_nota_venta" (
	"id_nota_venta" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"linea" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_usuario_receptor" int4 NOT NULL,
	"id_motivo_no_efectividad" int4,
	"id_unidad_medida_transaccion" int4 NOT NULL,
	"cum_transaccion_final" numeric(10,3) NOT NULL DEFAULT 0,
	"cum_transaccion_inicial" numeric(10,3) NOT NULL DEFAULT 0,
	"cum_valorizacion_final" numeric(10,3) NOT NULL DEFAULT 0,
	"cum_valorizacion_inicial" numeric(10,3) NOT NULL DEFAULT 0,
	"descuento_negociacion" numeric(3,1) NOT NULL DEFAULT 0,
	"descuento_volumen" numeric(3,1) NOT NULL DEFAULT 0,
	"linea_territorio_diferencial" numeric(10,2),
	"dif_sucursal_empresa" numeric(10,2),
	"precio_base" int4 NOT NULL DEFAULT 0,
	"precio_especial" int4,
	"precio_minimo" int4,
	"precio_unitario" int4 NOT NULL,
	"precio_final" int4 NOT NULL DEFAULT 0,
	"cum_valorizacion_bodega" numeric(10,3),
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "detalle_nota_venta_pkey" PRIMARY KEY("linea","id_nota_venta","id_usuario_emisor","id_producto"),
  CONSTRAINT "producto_fkey1" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "motivo_no_efectividad_fkey" FOREIGN KEY ("id_motivo_no_efectividad")
    REFERENCES "motivo_no_efectividad"("id_motivo_no_efectividad")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "unidad_medida_fkey4" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "nota_venta_fkey0" FOREIGN KEY ("id_usuario_emisor", "id_nota_venta", "id_usuario_receptor")
    REFERENCES "nota_venta"("id_usuario_emisor", "id_nota_venta", "id_usuario_receptor")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE INDEX "fki_motivo_no_efectividad_fkey" ON "detalle_nota_venta" USING BTREE (
	"id_motivo_no_efectividad"
);


CREATE INDEX "idx_dnv_id_usuario_receptor" ON "detalle_nota_venta" (
	"id_usuario_receptor"
);


ALTER TABLE "detalle_nota_venta" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "detalle_nota_venta" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "detalle_nota_venta" TO "usrarwsdb";



-- DROP TABLE autorizacion_modificacion_precio
DROP TABLE IF EXISTS "autorizacion_modificacion_precio" CASCADE;

-- CREATE TABLE autorizacion_modificacion_precio
CREATE TABLE "autorizacion_modificacion_precio" (
	"id_codigo_autorizacion" int4 NOT NULL,
	"id_usuario_creador_sucursal_cliente" int4,
	"id_sucursal_cliente" int4 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_nota_venta" int4,
	"id_usuario_emisor" int4,
	"id_usuario_receptor" int4,
	"precio_producto" int4 NOT NULL,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT False,
	PRIMARY KEY("id_codigo_autorizacion"),
  CONSTRAINT "codigo_autorizacion_fkey" FOREIGN KEY ("id_codigo_autorizacion")
    REFERENCES "codigo_autorizacion"("id_codigo_autorizacion")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "sucursal_cliente_fkey7" FOREIGN KEY ("id_usuario_creador_sucursal_cliente", "id_sucursal_cliente")
    REFERENCES "sucursal_cliente"("id_usuario_creador", "id_sucursal_cliente")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "producto_fkey5" FOREIGN KEY ("id_producto")
    REFERENCES "producto"("id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "nota_venta_fkey3" FOREIGN KEY ("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
    REFERENCES "nota_venta"("id_nota_venta", "id_usuario_emisor", "id_usuario_receptor")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
);


CREATE TRIGGER "tbi_autorizacion_modificacion_precio0" BEFORE INSERT OR UPDATE 
	ON "autorizacion_modificacion_precio" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod"();


ALTER TABLE "autorizacion_modificacion_precio" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "autorizacion_modificacion_precio" TO "taisa";

GRANT SELECT, UPDATE ON TABLE "autorizacion_modificacion_precio" TO "usrarwsdb";



-- DROP TABLE df_dnv
DROP TABLE IF EXISTS "df_dnv" CASCADE;

-- CREATE TABLE df_dnv
CREATE TABLE "df_dnv" (
	"id_tipo_documento_tributario" int4 NOT NULL,
	"folio" int4 NOT NULL,
	"linea_factura" int2 NOT NULL,
	"id_producto" int4 NOT NULL,
	"id_nota_venta" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"linea_nota_venta" int4 NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "df_dnv_pkey" PRIMARY KEY("id_nota_venta","id_usuario_emisor","linea_nota_venta","id_tipo_documento_tributario","folio","linea_factura","id_producto"),
  CONSTRAINT "detalle_nota_venta_fkey" FOREIGN KEY ("linea_nota_venta", "id_nota_venta", "id_usuario_emisor", "id_producto")
    REFERENCES "detalle_nota_venta"("linea", "id_nota_venta", "id_usuario_emisor", "id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "detalle_factura_fkey" FOREIGN KEY ("folio", "id_tipo_documento_tributario", "id_producto", "linea_factura")
    REFERENCES "detalle_factura"("folio", "id_tipo_documento_tributario", "id_producto", "linea")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_df_dnv" BEFORE INSERT OR UPDATE 
	ON "df_dnv" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


ALTER TABLE "df_dnv" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "df_dnv" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "df_dnv" TO "usrarwsdb";



-- DROP TABLE serial_contenedor_dnv
DROP TABLE IF EXISTS "serial_contenedor_dnv" CASCADE;

-- CREATE TABLE serial_contenedor_dnv
CREATE TABLE "serial_contenedor_dnv" (
	"id_serial_contenedor_dnv" varchar(50) NOT NULL,
	"id_nota_venta" int4 NOT NULL,
	"id_usuario_emisor" int4 NOT NULL,
	"linea" int4 NOT NULL,
	"id_unidad_medida_transaccion" int4,
	"id_producto" int4 NOT NULL,
	"cum_transaccion" numeric(10,3),
	"cum_valorizacion" numeric(10,3),
	"serial_contenedor" varchar(50) NOT NULL,
	"fecha_sincronizacion_a_pda" timestamp,
	"fecha_sincronizacion_desde_pda" timestamp,
	"fecha_sincronizacion_paso" timestamp,
	"fecha_modificacion" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"borrado" bool NOT NULL DEFAULT false,
	CONSTRAINT "serial_producto_dnv_pkey" PRIMARY KEY("id_serial_contenedor_dnv","id_usuario_emisor","id_nota_venta","linea"),
  CONSTRAINT "unidad_medida_fkey0" FOREIGN KEY ("id_unidad_medida_transaccion")
    REFERENCES "unidad_medida"("id_unidad_medida")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE,
  CONSTRAINT "detalle_nota_venta_fkey0" FOREIGN KEY ("linea", "id_nota_venta", "id_usuario_emisor", "id_producto")
    REFERENCES "detalle_nota_venta"("linea", "id_nota_venta", "id_usuario_emisor", "id_producto")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE
)
WITH (
	OIDS = False
);


CREATE TRIGGER "tgr_f_mod_scdnv" BEFORE INSERT OR UPDATE 
	ON "serial_contenedor_dnv" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_f_mod_2"();


CREATE TRIGGER "tgr_f_scdnv" BEFORE INSERT OR UPDATE 
	ON "serial_contenedor_dnv" FOR EACH ROW
	EXECUTE PROCEDURE "sp_tgr_scdnv"();


ALTER TABLE "serial_contenedor_dnv" OWNER TO "taisa";GRANT ALL PRIVILEGES ON TABLE "serial_contenedor_dnv" TO "taisa";

GRANT SELECT, UPDATE, INSERT ON TABLE "serial_contenedor_dnv" TO "usrarwsdb";
