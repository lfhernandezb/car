package cl.manadachile.clacfactory.mycar.logsmp;

import java.util.Date;

import org.json.JSONException;
import org.json.JSONObject;



public class LogPublicidad extends LogMiAuto{

	private int IdImagen;
	private Date FechaIni;
	private Date FechaFin;
	private int NumImpresiones;
	private long TotalMilisegundos;

	public int getIdImagen() {
		return IdImagen;
	}

	public void setIdImagen(int idImagen) {
		IdImagen = idImagen;
	}

	public void setIdImagen(JSONObject json) throws JSONException {
		IdImagen = json.getInt("id_imagen");
	}

	public Date getFechaIni() {
		return FechaIni;
	}

	public void setFechaIni(Date fechaIni) {
		FechaIni = fechaIni;
	}

	public void setFechaIni(JSONObject json) throws JSONException {
		FechaIni.setTime(json.getLong("fecha_ini"));
	}

	public Date getFechaFin() {
		return FechaFin;
	}

	public void setFechaFin(Date fechaFin) {
		FechaFin = fechaFin;
	}

	public void setFechaFin(JSONObject json) throws JSONException {
		FechaFin.setTime(json.getLong("fecha_fin"));
	}

	public int getNumImpresiones() {
		return NumImpresiones;
	}

	public void setNumImpresiones(int numImpresiones) {
		NumImpresiones = numImpresiones;
	}

	public void setNumImpresiones(JSONObject json) throws JSONException {
		NumImpresiones = json.getInt("num_impresiones");
	}
	
	public long getTotalMilisegundos() {
		return TotalMilisegundos;
	}

	public void setTotalMilisegundos(long totalMilisegundos) {
		TotalMilisegundos = totalMilisegundos;
	}

	public void setTotalMilisegundos(JSONObject json) throws JSONException {
		TotalMilisegundos = json.getLong("total_ms");
	}

	public LogPublicidad() throws JSONException,
			NullPointerException {
		super(TipoLog.LOG_PUBLICIDAD);
		setIdImagen(0);
		setFechaIni(new Date() );
		setFechaFin(new Date() );
		setNumImpresiones(0);
		setTotalMilisegundos(0);
	}
	
	public LogPublicidad(JSONObject json, boolean resumido) throws JSONException,
			NullPointerException {
		super(json);
		setIdImagen(0);
		setFechaIni(json);
		setFechaFin(json);
		setNumImpresiones(json);
		setTotalMilisegundos(json);
	}
	
	public JSONObject getJSON( boolean resumido) throws JSONException{

		JSONObject json = super.getJSON();
		json.put("id_imagen", getIdImagen());
		json.put("fecha_ini", getFechaIni());
		json.put("fecha_fin", getFechaFin());
		json.put("num_impresiones", getNumImpresiones());
		json.put("total_ms", getTotalMilisegundos());
		return json;

	}
}
