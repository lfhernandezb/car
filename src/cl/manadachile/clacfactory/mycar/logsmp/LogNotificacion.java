package cl.manadachile.clacfactory.mycar.logsmp;

import java.util.ArrayList;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class LogNotificacion extends LogMiAuto {
	public static String BTN_WEB = "BTN_WEB";
	public static String BTN_LLAMADA_TELEFONICA = "BTN_LLAMADA_TELEFONICA";
	public static String BTN_MAPA = "BTN_MAPA";
	public static String BTN_CORREO = "BTN_EMAIL";

	private ArrayList<Boton> botones = new ArrayList<Boton>();

	private int IdNotificacion = 5;
	private String NombreNotificacion = null;
	private String CuerpoNotificacion = null;
	private String TickerNotificacion = null;
	private long IdCampana = -1;
	private Date FechaVisualizacion = new Date();
	private String MensajeHTML = null;

	public LogNotificacion(TipoLog tipo, String strJSON)
			throws NullPointerException, JSONException {
		super(tipo);
		JSONObject json = new JSONObject(strJSON);
		JSONObject jsonActivity = json.getJSONObject("activity");
		JSONObject jsonDatosNotificacion = json.getJSONObject("datos_notif");
		setDatosActivity(jsonActivity);
		setDatosNotificacion(jsonDatosNotificacion);
	}

	public LogNotificacion(JSONObject json, boolean resumido)
			throws NullPointerException, JSONException {
		super(json);

		JSONObject jsonActivity = json.getJSONObject("activity");
		JSONObject jsonDatosNotificacion = json.getJSONObject("datos_notif");

		setDatosNotificacion(jsonDatosNotificacion, resumido);
		setDatosActivity(jsonActivity, resumido);
	}

	public JSONObject getJSON(boolean resumido) throws JSONException {
		JSONObject json = super.getJSON();
		json.put("datos_notif", getDatosNotificacion(resumido));
		json.put("activity", getDatosActivity(resumido));

		return json;
	}

	public ArrayList<Boton> getArregloBotones() {
		return botones;
	}


	private void setDatosNotificacion(JSONObject json)
			throws NullPointerException, JSONException {

		setDatosNotificacion(json, false);
	}
	
	private void setDatosNotificacion(JSONObject json, boolean resumido)
			throws NullPointerException, JSONException {

		if (!resumido) {
			setNombreNotificacion(json);
			setCuerpoNotificacion(json);
			setTickerNotificacion(json);
		}
		setIdNotificacion(json);
		setIdCampana(json);
	}

	private JSONObject getDatosNotificacion(boolean resumido)
			throws JSONException {
		JSONObject json = new JSONObject();
		json.put("id_notificacion", getIdNotificacion());
		json.put("id_campana", getIdCampana());
		if (!resumido) {
			json.put("nombre", getNombreNotificacion());
			json.put("cuerpo", getCuerpoNotificacion());
			json.put("ticker", getTickerNotificacion());
		}
		return json;
	}

	private void setDatosActivity(JSONObject json) throws NullPointerException,
			JSONException {
		JSONArray jsArray;
		setMensajeHTML(json);
		setFechaVisualizacion(new Date());
		jsArray = json.getJSONArray("botones");
		setBotones(jsArray);
	}

	private void setDatosActivity(JSONObject json, boolean resumido)
			throws NullPointerException, JSONException {
		JSONArray jsArray;
		if (!resumido) {
			setMensajeHTML(json);
		}
		setFechaVisualizacion(json);
		jsArray = json.getJSONArray("botones");
		setBotones(jsArray, resumido);
	}

	private JSONObject getDatosActivity(boolean resumido) throws JSONException {
		JSONObject json = new JSONObject();
		if (!resumido) {
			json.put("html", getMensajeHTML());
		}
		json.put("fecha_visualizacion", getFechaVisualizacion().getTime());
		json.put("botones", getBotonesJSON(resumido));

		return json;
	}

	private JSONArray getBotonesJSON(boolean resumido) throws JSONException {
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < botones.size(); i++) {
			if (resumido) {
				if (botones.get(i).getClicks() > 0) {
					jsonArray.put(botones.get(i).getJSON(resumido));
				}
			} else {
				jsonArray.put(botones.get(i).getJSON(resumido));
			}
		}
		return jsonArray;
	}


	private void setBotones(JSONArray jsArray)
			throws JSONException, NullPointerException {

		for (int i = 0; i < jsArray.length(); i++) {
			JSONObject jsonBoton = jsArray.getJSONObject(i);
			AgregaBoton(jsonBoton);

		}
	}
	
	private void setBotones(JSONArray jsArray, boolean resumido)
			throws JSONException, NullPointerException {

		for (int i = 0; i < jsArray.length(); i++) {
			JSONObject jsonBoton = jsArray.getJSONObject(i);

			AgregaBoton(jsonBoton, resumido);

		}
	}

	private void AgregaBoton(JSONObject jsonBoton)
			throws JSONException {

		Boton boton = new Boton(jsonBoton);

		if (boton.getTipo().equals(BTN_WEB)) {
			botones.add(new Boton.BotonWeb(jsonBoton));
		}

		if (boton.getTipo().equals(BTN_LLAMADA_TELEFONICA)) {
			botones.add(new Boton.BotonLlamadaTelefonica(jsonBoton));
		}

		if (boton.getTipo().equals(BTN_MAPA)) {
			botones.add(new Boton.BotonMapa(jsonBoton));
		}

		if (boton.getTipo().equals(BTN_CORREO)) {
			botones.add(new Boton.BotonCorreo(jsonBoton));
		}

	}
	
	private void AgregaBoton(JSONObject jsonBoton, boolean resumido)
			throws JSONException {

		Boton boton = new Boton(jsonBoton, resumido);

		if (boton.getTipo().equals(BTN_WEB)) {
			botones.add(new Boton.BotonWeb(jsonBoton, resumido));
		}

		if (boton.getTipo().equals(BTN_LLAMADA_TELEFONICA)) {
			botones.add(new Boton.BotonLlamadaTelefonica(jsonBoton, resumido));
		}

		if (boton.getTipo().equals(BTN_MAPA)) {
			botones.add(new Boton.BotonMapa(jsonBoton, resumido));
		}

		if (boton.getTipo().equals(BTN_CORREO)) {
			botones.add(new Boton.BotonCorreo(jsonBoton, resumido));
		}

	}

	public ArrayList<Boton> getBotones() {
		return botones;
	}

	public int getIdNotificacion() {
		return IdNotificacion;
	}

	public void setIdNotificacion(int idNotificacion) {
		IdNotificacion = idNotificacion;
	}

	public void setIdNotificacion(JSONObject json) throws JSONException,
			NullPointerException {
		setIdNotificacion(json.getInt("id_notificacion"));
	}

	public String getNombreNotificacion() {
		return NombreNotificacion;
	}

	public void setNombreNotificacion(String nombreNotificacion) {
		NombreNotificacion = nombreNotificacion;
	}

	public void setNombreNotificacion(JSONObject json) throws JSONException,
			NullPointerException {
		setNombreNotificacion(json.getString("nombre"));
	}

	public String getTickerNotificacion() {
		return TickerNotificacion;
	}

	public void setTickerNotificacion(String tickerNotificacion) {
		TickerNotificacion = tickerNotificacion;
	}

	public void setTickerNotificacion(JSONObject json) throws JSONException,
			NullPointerException {
		setTickerNotificacion(json.getString("ticker"));
	}

	public String getCuerpoNotificacion() {
		return CuerpoNotificacion;
	}

	public void setCuerpoNotificacion(String cuerpoNotificacion) {
		CuerpoNotificacion = cuerpoNotificacion;
	}

	public void setCuerpoNotificacion(JSONObject json) throws JSONException,
			NullPointerException {
		setCuerpoNotificacion(json.getString("cuerpo"));
	}

	public String getMensajeHTML() {
		return MensajeHTML;
	}

	public void setMensajeHTML(String mensajeHTML) {
		MensajeHTML = mensajeHTML;
	}

	public void setMensajeHTML(JSONObject json) throws JSONException,
			NullPointerException {
		setMensajeHTML(json.getString("html"));
	}

	public long getIdCampana() {
		return IdCampana;
	}

	public void setIdCampana(long idCampana) {
		IdCampana = idCampana;
	}

	public void setIdCampana(JSONObject json) throws JSONException,
			NullPointerException {
		setIdCampana(json.getLong("id_campana"));
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

}
