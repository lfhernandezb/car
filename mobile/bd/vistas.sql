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

