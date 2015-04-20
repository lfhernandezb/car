
CREATE TABLE v_campania_usuario
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
