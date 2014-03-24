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
