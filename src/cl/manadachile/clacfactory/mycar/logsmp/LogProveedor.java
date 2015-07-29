package cl.manadachile.clacfactory.mycar.logsmp;

import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

//import android.util.Log;
import cl.manadachile.clacfactory.mycar.logsmp.Boton.*;

public class LogProveedor extends LogMiAuto {

	/* Datos de la Mantencion y el proveedor */
	private long UsuarioId = -1;
	private long ProveedorId = -1;
	private long MantencionId = -1;
	private long VehiculoId = -1;

	/* Datos del Activity */
	private String html = null;
	private BotonWeb btnWeb = null;
	private BotonLlamadaTelefonica btnCall = null;
	private BotonMapa btnMapa = null;
	private BotonCorreo btnCorreo = null;

	Date FechaVisualizacion = new Date();

	public JSONObject getJSON(boolean resumido) throws JSONException {

		JSONObject json = super.getJSON();
		json.put("proveedor", getDatosMantencion(resumido));
		json.put("activity", getDatosActivity(resumido));
		//Log.i("MiAuto", "LogProveedor: getJSON: json="+json.toString());
		return json;
	}

	public LogProveedor() throws JSONException, NullPointerException {
		super(TipoLog.LOG_PROVEEDOR);
	}

	public LogProveedor(JSONObject json, boolean resumido)
			throws JSONException, NullPointerException {
		super(json);

		JSONObject jsonActivity = null;
		JSONObject jsonDatosProveedor = null;
		if (json == null) {
			return;
		}

		jsonActivity = json.getJSONObject("activity");
		jsonDatosProveedor = json.getJSONObject("proveedor");

		setDatosProveedor(jsonDatosProveedor, resumido);
		setDatosActivity(jsonActivity, resumido);
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(JSONObject json) throws JSONException,
			NullPointerException {
		html = json.getString("html");
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public BotonWeb getBotonWeb() {
		return btnWeb;
	}

	public BotonLlamadaTelefonica getBotonLlamadaTelefonica() {
		return btnCall;
	}

	public BotonMapa getBotonMapa() {
		return btnMapa;
	}

	public BotonCorreo getBotonCorreo() {
		return btnCorreo;
	}

	public Date getFechaVisualizacion() {
		return FechaVisualizacion;
	}

	public void setFechaVisualizacion(Date fecha) {
		FechaVisualizacion = fecha;
	}

	public void setFechaVisualizacion(JSONObject json) throws JSONException,
			NullPointerException {
		long msegs = json.getLong("fecha_visualizacion");
		Date newDate = new Date();
		newDate.setTime(msegs);
		setFechaVisualizacion(newDate);
	}

	private void setDatosProveedor(JSONObject json, boolean resumido)
			throws JSONException, NullPointerException {
		setFechaVisualizacion(json);
		setProveedorId(json);
		setMantencionId(json);
		setVehiculoId(json);
		setUsuarioId(json);
	}

	private JSONObject getDatosMantencion(boolean resumido)
			throws JSONException {

		JSONObject json = new JSONObject();
		json.put("fecha_visualizacion", getFechaVisualizacion().getTime());
		json.put("id_proveedor", getProveedorId());
		json.put("id_mantencion", getMantencionId());
		json.put("id_vehiculo", getVehiculoId());
		json.put("id_usuario", getUsuarioId());

		return json;
	}

	private void setDatosActivity(JSONObject json, boolean resumido)
			throws JSONException {

		JSONArray jsArray;

		setHtml(json);
		jsArray = json.getJSONArray("botones");
		setBotones(jsArray, resumido);
	}

	private void setBotones(JSONArray jsArray, boolean resumido)
			throws JSONException {

		Boton boton;
		JSONObject json = null;
		if (jsArray == null) {
			return;
		}

		for (int i = 0; i < jsArray.length(); i++) {
			boton = null;
			json = (JSONObject) jsArray.get(i);

			if (json != null) {
				boton = new Boton(json, resumido);

				if (boton != null) {
					if (boton.getTipo().equals("WEB")) {
						btnWeb = new Boton.BotonWeb(json, resumido);
					}

					if (boton.getTipo().equals("CALL")) {
						btnCall = new Boton.BotonLlamadaTelefonica(json,
								resumido);
					}

					if (boton.getTipo().equals("MAPA")) {
						btnMapa = new Boton.BotonMapa(json, resumido);
					}

					if (boton.getTipo().equals("CORREO")) {
						btnCorreo = new Boton.BotonCorreo(json, resumido);
					}
				}
			}
		}
	}

	private JSONObject getDatosActivity(boolean resumido) throws JSONException,
			NullPointerException {

		JSONArray jsArray = new JSONArray();
		JSONObject json = new JSONObject();
		if (!resumido) {
			json.put("html", getHtml());
		}

		// jsArray = json.getJSONArray("botones");
		if (btnWeb != null && (btnWeb.getClicks() > 0 || !resumido)) {
			jsArray.put(btnWeb.getJSON(resumido));
		}
		if (btnCall != null && (btnCall.getClicks() > 0 || !resumido)) {
			jsArray.put(btnCall.getJSON(resumido));
		}
		if (btnMapa != null && (btnMapa.getClicks() > 0 || !resumido)) {
			jsArray.put(btnMapa.getJSON(resumido));
		}
		if (btnCorreo != null && (btnCorreo.getClicks() > 0 || !resumido)) {
			jsArray.put(btnCorreo.getJSON(resumido));
		}
		json.put("botones", jsArray);

		return json;
	}

	public long getUsuarioId() {
		return UsuarioId;
	}

	public void setUsuarioId(long usuarioId) {
		UsuarioId = usuarioId;
	}

	public void setUsuarioId(JSONObject json) throws JSONException,
			NullPointerException {
		UsuarioId = json.getLong("id_usuario");
	}

	public long getProveedorId() {
		return ProveedorId;
	}

	public void setProveedorId(long proveedorId) {
		ProveedorId = proveedorId;
	}

	public void setProveedorId(JSONObject json) throws JSONException,
			NullPointerException {

		ProveedorId = json.getLong("id_proveedor");
	}

	public long getMantencionId() {
		return MantencionId;
	}

	public void setMantencionId(long mantencionId) {
		MantencionId = mantencionId;
	}

	public void setMantencionId(JSONObject json) throws JSONException,
			NullPointerException {
		MantencionId = json.getLong("id_mantencion");
	}

	public long getVehiculoId() {
		return VehiculoId;
	}

	public void setVehiculoId(long vehiculoId) {
		VehiculoId = vehiculoId;
	}

	public void setVehiculoId(JSONObject json) throws JSONException,
			NullPointerException {
		VehiculoId = json.getLong("id_vehiculo");
	}

	public BotonWeb getBtnWeb() {
		return btnWeb;
	}

	public void setBtnWeb(BotonWeb btnWeb) {
		this.btnWeb = btnWeb;
	}

	public BotonLlamadaTelefonica getBtnCall() {
		return btnCall;
	}

	public void setBtnCall(BotonLlamadaTelefonica btnCall) {
		this.btnCall = btnCall;
	}

	public BotonMapa getBtnMapa() {
		return btnMapa;
	}

	public void setBtnMapa(BotonMapa btnMapa) {
		this.btnMapa = btnMapa;
	}

	public BotonCorreo getBtnCorreo() {
		return btnCorreo;
	}

	public void setBtnCorreo(BotonCorreo btnCorreo) {
		this.btnCorreo = btnCorreo;
	}

}
