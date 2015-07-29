package cl.manadachile.clacfactory.mycar.logsmp;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class LogPosicion extends LogMiAuto {

	private String Version = "";
	private String Equipo = "";
	private Date Fecha = new Date();
	
	private ArrayList<LogPosicionHora> posiciones;

	public LogPosicion(String version, String equipo){
		super(TipoLog.LOG_POSICION);
		Version = version;
		Equipo = equipo;
		Fecha = new Date();
		posiciones= new ArrayList<LogPosicionHora>();
		for (int i=0; i<24; i++){
			LogPosicionHora pos = new LogPosicionHora();
			posiciones.add(pos);
		}
	}
	
	public LogPosicion(JSONObject json) throws JSONException {
		super(json);
		setVersion(json);
		setEquipo(json);
		setFecha(json);
		JSONArray jsonArray = json.getJSONArray("posiciones");
		posiciones= new ArrayList<LogPosicionHora>();
		for (int i=0; i<jsonArray.length(); i++){
			LogPosicionHora pos = new LogPosicionHora((JSONObject)jsonArray.get(i));
			posiciones.add(pos);
		}
		
	}

	public JSONObject getJSON() throws JSONException {
		JSONObject json = super.getJSON();
		json.put("version", getVersion());
		json.put("equipo", getEquipo());
		json.put("fecha", getFecha().getTime());
		JSONArray jsonArray = new JSONArray();
		for (int i=0; i<posiciones.size(); i++){
			jsonArray.put(posiciones.get(i).getJSON());
		}
		json.put("posiciones", jsonArray);
		return json;
	}

	public void setPosicion( double Latitud, double Longitud){
		Calendar c = Calendar.getInstance();
		int hora = c.get(Calendar.HOUR_OF_DAY);
		if (posiciones.size() > hora){
			posiciones.get(hora).setLatitud(Latitud);
			posiciones.get(hora).setLongitud(Longitud);
			posiciones.get(hora).setValido(true);
			posiciones.get(hora).setFecha(c.getTime());
		}
	}
	
	public String getVersion() {
		return Version;
	}

	public void setVersion(String version) {
		Version = version;
	}

	public void setVersion(JSONObject json) throws JSONException {
		Version = json.getString("version");
	}

	/**
	 * @return the posiciones
	 */
	public ArrayList<LogPosicionHora> getPosiciones() {
		return posiciones;
	}

	/**
	 * @param posiciones the posiciones to set
	 */
	public void setPosiciones(ArrayList<LogPosicionHora> posiciones) {
		this.posiciones = posiciones;
	}

	public String getEquipo() {
		return Equipo;
	}

	public void setEquipo(String equipo) {
		Equipo = equipo;
	}

	public void setEquipo(JSONObject json) throws JSONException {
		Equipo = json.getString("equipo");
	}

	public Date getFecha() {
		return Fecha;
	}

	public void setFecha(Date fecha) {
		Fecha = fecha;
	}

	public void setFecha(JSONObject json) throws JSONException {
		long msecs = 0;
		msecs = json.getLong("fecha");
		Date fecha = new Date();
		fecha.setTime(msecs);
		Fecha = fecha;
	}
	
	public static class LogPosicionHora{
		
		private Date Fecha=new Date();
		private boolean Valido;
		private double  Latitud;
		private double Longitud;

		public Date getFecha() {
			return Fecha;
		}

		public void setFecha(Date fecha) {
			Fecha = fecha;
		}

		public void setFecha(JSONObject json) throws JSONException, NullPointerException{
			Fecha.setTime(json.getLong("fecha"));
		}
		
		public boolean isValido() {
			return Valido;
		}

		public void setValido(boolean valido) {
			Valido = valido;
		}

		public void setValido(JSONObject json) throws JSONException, NullPointerException{
			Valido = json.getBoolean("es_valido");;
		}
		
		public double getLatitud() {
			return Latitud;
		}

		public void setLatitud(double latitud) {
			Latitud = latitud;
		}

		public void setLatitud(JSONObject json) throws JSONException, NullPointerException{
			Latitud = json.getDouble("lat");
		}
		public double getLongitud() {
			return Longitud;
		}

		public void setLongitud(double longitud) {
			Longitud = longitud;
		}

		public void setLongitud(JSONObject json) throws JSONException, NullPointerException{
			Longitud = json.getDouble("lon");
		}
		
		public LogPosicionHora(){
			setValido(false);
			setLatitud(0);
			setLongitud(0);
			setFecha(new Date());
		}
		
		public LogPosicionHora(String strJSON) throws JSONException{
			JSONObject json = new JSONObject(strJSON);
			setFecha(json);
			setValido(json);
			setLatitud(json);
			setLongitud(json);
		}
		
		public LogPosicionHora(JSONObject json) throws JSONException{
			if (json == null){
				throw new NullPointerException();
			}
			setFecha(json);
			setValido(json);
			setLatitud(json);
			setLongitud(json);
		}
		
		public JSONObject getJSON() throws JSONException{
			JSONObject json = new JSONObject();
			json.put("fecha", Fecha.getTime());
			json.put("es_valido", Valido);
			json.put("lat", Latitud);
			json.put("lon", Longitud);
			return json;
		}
		
	}

}
