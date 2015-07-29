package cl.manadachile.clacfactory.mycar.logsmp;

import org.json.JSONException;
import org.json.JSONObject;

public class LogMiAuto {

	public static enum TipoLog {
		LOG_ERROR, LOG_POSICION, LOG_PROVEEDOR, LOG_NOTIFICACION, LOG_PUBLICIDAD
	}

	private TipoLog tipo;

	public LogMiAuto(TipoLog tipo) {
		this.tipo = tipo;
	}

	public LogMiAuto(JSONObject json) throws JSONException, NullPointerException {
		String strAux = null;
		strAux = json.getString("tipo_log");
		if (strAux == null) {
			tipo = TipoLog.LOG_ERROR;
			return;
		}
		if (strAux.equals("POS")) {
			tipo = TipoLog.LOG_POSICION;
			return;
		}
		if (strAux.equals("PROV")) {
			tipo = TipoLog.LOG_PROVEEDOR;
			return;
		}
		if (strAux.equals("NOT")) {
			tipo = TipoLog.LOG_NOTIFICACION;
			return;
		}
		if (strAux.equals("PUB")) {
			tipo = TipoLog.LOG_PUBLICIDAD;
			return;
		}
		tipo = TipoLog.LOG_ERROR;
	}

	/**
	 * @return the tipo
	 */
	public TipoLog getTipo() {
		return tipo;
	}

	/**
	 * @param tipo the tipo to set
	 */
	public void setTipo(TipoLog tipo) {
		this.tipo = tipo;
	}

	public JSONObject getJSON() throws JSONException {
		JSONObject json = new JSONObject();
		String strAux = "";
		switch (tipo) {
		case LOG_ERROR:
			strAux = "ERROR";
			break;
		case LOG_POSICION:
			strAux = "POS";
			break;
		case LOG_PROVEEDOR:
			strAux = "PROV";
			break;
		case LOG_NOTIFICACION:
			strAux = "NOT";
			break;
		case LOG_PUBLICIDAD:
			strAux = "PUB";
			break;
		default:
			strAux = "ERROR";
			break;
		}
		json.put("tipo_log", strAux);
		return json;
	}
}
