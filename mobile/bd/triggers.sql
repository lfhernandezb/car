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
