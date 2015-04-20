INSERT INTO `car`.`notificacion`
(
`id_usuario`,
`fecha_inicio`,
`fecha_fin`,
`periodicidad`,
`numero_impresiones`,
`detalle`)
VALUES
(
755,
'2015-03-11',
'2015-04-11',
1,
1,
'{
  "datos_notif": {
    "nombre": "Bienvenid@",
    "cuerpo": "Mensaje de Bienvenida",
    "ticker": "Bienvenid@ a MiAuto",
    "id_notificacion": 6
  },
  "activity": {
    "html": "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n\n</head>\n<body>\n  <h1>\n    Bienvenid@ a MiAuto\n  </h1>\n  <p>\n    A través de este medio te informaremos cuándo tengas alguna mantención vencida así como cualquier información que sea importante para tí. Por ejemplo, te recordaremos cuando realizar la revisión técnica.\n    <br>\n    Con el Km Anual que ingresas para tu vehículo, estimamos el kilometraje aproximado de tu vehículo el cual usamos para recordarte tus mantenciones. De todas maneras necesitaremos que cada cierto tiempo nos confirmes el kilometraje de tu vehículo con el fin de que nuestra estimación sea más certera.\n    \n  </p>\n  <h2>\n    Hazte amigo de nuestra FanPage\n  </h2>\n  <p>\n    Podrás revisar consejos que te ayudarán a la mantención de tu vehículo y ver videos explicativos que te ayudarán a sacarle el máximo provecho a la aplicación.\n    <br>\n    Presiona el botón <b>\"ir a Fanpage\"</b> y subscríbete a nuestra página.\n  </p>\n  <h2>\n    Contáctate con nosotros\n  </h2>\n    <p>\n      Si necesitas ayuda de algún tipo o deseas hacernos alguna sugerencia, puedes contactarte con nosotros al correo soporte_miauto@clacfactory.cl.\n      Si deseas hacerlo ahora, presiona el botón <b>\"Contactar a MiAuto\"</b>.\n      </p>\n  <h2>\n    Queremos ser tu AMIGO\n     </h2>\n  Trabajamos para que sientas que somos tus amigos. Si no estuviesemos cumpliendo este objetivo, por favor, contáctane con nosotros para solucionar el problema.\n    <p>\n      \n      </p>\n</body>\n</html>",
    "botones": [
      {
        "tipo": "BTN_WEB",
        "texto": "Ir a FanPage",
        "url": "https://www.facebook.com/miautoapp/timeline"
      },
      {
        "tipo": "BTN_EMAIL",
        "texto": "Contactar a MiAuto",
        "para": "soporte_miauto@clacfactory.cl",
        "asunto": "CONTACTO BIENVENIDA",
        "mensaje": " "
      }
    ]
  }
}');

INSERT INTO `car`.`notificacion`
(
`id_usuario`,
`fecha_inicio`,
`fecha_fin`,
`periodicidad`,
`numero_impresiones`,
`detalle`)
VALUES
(
755,
'2015-03-11',
'2015-04-11',
1,
1,
'{
  "datos_notif": {
    "nombre": "Oferta del mes",
    "cuerpo": "Revisa la oferta del mes",
    "ticker": "Nueva oferta de MiAuto",
    "id_notificacion": 7
  },
  "activity": {
    "html": "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=utf-8 />\n\n</head>\n<body>\n  <h1>\n    Recarga de Aire Acondicionado por $18.900\n  </h1>\n  <p>\n    \n  </p>\n  <h2>\n    ¿Qué incluye?\n  </h2>\n  <p>\n    \n    Recarga del aire acondicionado + chequeo del sistema de aire y filtro de polen.\n    <br>\n   Respaldada con los productos Madico Windows Film, esta empresa revisa el sistema de aire del auto para detectar fugas previo a la recarga\n  </p>\n  <h2>\n    Validez de la oferta\n  </h2>\n    <p>\n      La oferta es válida hasta el día <b>31 de Mayo del 2015</b>.\n  <h2>\n    Letra  chica\n     </h2>\n  Válido para vehículos de la categoría city car, sedan y camionetas. <b>No válido para el 03 y 04 de Abril ni 01 y 21 de Mayo de 2015</b>. No incluye repuestos en caso de haber fallas en el vehículo. Solo para nuevos clientes. <b>La carga de aire acondicionado es solo para vehículos livianos, excepto Citroen, Renault Jeep,4x4 y furgones que requieren doble carga de aire acondicionado para su funcionamiento</b>. La diferencia del costo adicional deberá ser cancelada directo en el local. Reservas y cancelaciones con 48 horas de anticipación. No aplica paravehículoss comerciales\n  <h2>Datos del Proveedor\n     </h2>  \n  <b>Comercializadora SecurityMax. Ltda </b>\n  <p>\n    Dirección: Av. Francisco Bilbao #7446, Las Condes\n    <p>Teléfono: (02) 2 906 1978\n      </p>Horario: lun a vie de 09:00 a 18:00. Sáb de 09:00 a 14:00\n</body>\n</html>",
    "botones": [
      {
        "tipo": "BTN_WEB",
        "texto": "Ver Página WEB",
        "url": "http://www.filmsecuritymax.cl/?utm_source=Groupon&utm_medium=LinkSocio"
      },
      {
        "tipo": "BTN_LLAMADA_TELEFONICA",
        "texto": "Llamar",
        "telefono": 56229061978
      },
      {
        "tipo": "BTN_MAPA",
        "texto": "Ver Mapa",
        "uri_mapa": "geo:0,0?q=-33.4304223,-70.5551444 (SecurityMax)"
      }
    ]
  }
}');

