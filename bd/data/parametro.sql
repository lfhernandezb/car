INSERT INTO parametro (llave, valor) VALUES ('busqueda_servicios_miauto', 
'{
  "instruccion": "Presiona el servicio que buscas para revisar los proveedores asociados",
  "servicios": [
    {
      "tipo": "GRUA",
      "texto": "Grúas",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "grua vehículo"
    },
    {
      "tipo": "VULCANIZACION",
      "texto": "Vulcanizaciones",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "vulcanización"
    },
    {
      "tipo": "CERRAJERO",
      "texto": "Cerrajeros",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "cerrajero automovil"
    },
    {
      "tipo": "LUBRICANTES",
      "texto": "Lubricentros",
      "busca_en_miauto": true,
      "servidor_miauto": "http://www.manadachile.cl:8080/cl.dsoft.carws2/getProveedores",
      "id_mantencion": 2,
      "palabra_clave_googlemap": "lubricentro"
    },
    {
      "tipo": "AIRE_ACONDICIONADO",
      "texto": "Aire Acondicionado",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "aire acondicionado automovil"
    },
    {
      "tipo": "REVISION_TECNICA",
      "texto": "Plantas de Revisión Técnica",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 5,
      "palabra_clave_googlemap": "revisión técnica"
    },
    {
      "tipo": "LAVADO_AUTOS",
      "texto": "Lavado de Autos",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "Lavado Autos"
    },
    {
      "tipo": "PARABRISAS",
      "texto": "Parabrisas",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "parabrisas vehiculo"
    },
    {
      "tipo": "TALLER_ELECTRICO",
      "texto": "Taller Eléctrico",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "taller eléctrico automovil"
    },
    {
      "tipo": "TALLER_MECANICO",
      "texto": "Taller Mecánico",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "taller mecánico automovil"
    },
    {
      "tipo": "PINTURA_DESABOLLADURA",
      "texto": "Desabolladura y Pintura",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "desabolladura pintura automovil"
    },
    {
      "tipo": "FRENOS",
      "texto": "Frenos",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "frenos automovil"
    },
    {
      "tipo": "RADIADORES",
      "texto": "Radiadores",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "radiador automovil"
    },
    {
      "tipo": "ANALISIS_GASES",
      "texto": "Análisis de Gases",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "análisis gases automovil"
    },
    {
      "tipo": "ALINEACION_BALANCEO",
      "texto": "Alineación y Balanceo",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "alineación balanceo automovil"
    },
    {
      "tipo": "TUBO_ESCAPE",
      "texto": "Tubos de Escape",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "tubos escapeautomovil"
    },
    {
      "tipo": "AJUSTE_MOTOR",
      "texto": "Ajuste Motor",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "ajuste motor automovil"
    },
    {
      "tipo": "BATERIA",
      "texto": "Baterías",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "Baterías vehículo"
    },
    {
      "tipo": "REPUESTO",
      "texto": "Repuestos",
      "busca_en_miauto": false,
      "servidor_miauto": "",
      "id_mantencion": 0,
      "palabra_clave_googlemap": "repuestos vehículo"
    }
  ]
}');
INSERT INTO parametro (llave, valor) VALUES ('servidor_consulta_proveedor', 'http://www.manadachile.cl:8080/cl.dsoft.carws2/getProveedores');
INSERT INTO parametro (llave, valor) VALUES ('servidor_miauto', 'http://www.manadachile.cl:8080/cl.dsoft.carws2');
