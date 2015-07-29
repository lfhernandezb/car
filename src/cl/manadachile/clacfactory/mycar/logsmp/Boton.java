package cl.manadachile.clacfactory.mycar.logsmp;

import org.json.JSONException;
import org.json.JSONObject;

public class Boton extends Object {

	private String Texto;
	private long IdBoton;
	private String Tipo;
	private int Clicks = 0;
	private boolean salirClick = false;

	public Boton(long id, String tipo, String texto) {
		setTexto(texto);
		setSalirClick(false);
		setIdBoton(id);
		setTipo(tipo);
		setClicks(0);
	}

	public Boton(JSONObject json) throws JSONException {
		setTexto(json);
		setSalirClick(false);
		setIdBoton(json);
		setTipo(json);
		setClicks(0);
	}

	public Boton(JSONObject json, boolean resumido) throws JSONException {

		if (!resumido) {
			setTexto(json);
			setSalirClick(json);
		}
		setIdBoton(json);
		setTipo(json);
		setClicks(json);

	}

	public JSONObject getJSON(boolean resumido) throws JSONException {

		JSONObject json = new JSONObject();
		if (!resumido) {
			json.put("texto", getTexto());
			json.put("salir", isSalirClick());
		}

		json.put("id_boton", getIdBoton());
		json.put("tipo", getTipo());
		json.put("clicks", getClicks());
		return json;
	}

	public long getIdBoton() {
		return IdBoton;
	}

	public void setIdBoton(long idBoton) {
		IdBoton = idBoton;
	}

	public void setIdBoton(JSONObject json) throws JSONException,
			NullPointerException {
		setIdBoton(json.getLong("id_boton"));
	}

	public String getTipo() {
		return Tipo;
	}

	public void setTipo(String tipo) {
		Tipo = tipo;
	}

	public void setTipo(JSONObject json) throws JSONException,
			NullPointerException {
		setTipo(json.getString("tipo"));
	}

	public String getTexto() {
		return Texto;
	}

	public void setTexto(String texto) {
		Texto = texto;
	}

	public void setTexto(JSONObject json) throws JSONException,
			NullPointerException {

		setTexto(json.getString("texto"));
	}

	public void OnClick() {
		Clicks++;
	}

	public int getClicks() {
		return Clicks;
	}

	public void setClicks(int clicks) {
		this.Clicks = clicks;
	}

	public void setClicks(JSONObject json) throws JSONException,
			NullPointerException {
		setClicks(json.getInt("clicks"));
	}

	public boolean isSalirClick() {
		return salirClick;
	}

	public void setSalirClick(boolean salirClick) {
		this.salirClick = salirClick;
	}

	public void setSalirClick(JSONObject json) throws JSONException,
			NullPointerException {
		setSalirClick(json.getBoolean("salir"));
	}

	public static class BotonWeb extends Boton {

		private String URL;

		public BotonWeb(long id, String tipo, String texto, String url) {
			super(id, tipo, texto);
			setURL(url);
		}

		public BotonWeb(JSONObject json) throws JSONException {
			super(json);
			setURL(json);
		}

		public BotonWeb(JSONObject json, boolean resumido) throws JSONException {
			super(json, resumido);
			setURL(json);
		}

		public String getURL() {
			if (URL.indexOf("http://") == -1){
				return "http://" + URL;
			}
			return URL;
		}

		public void setURL(String uRL) {
			URL = uRL;
		}

		public void setURL(JSONObject json) throws JSONException,
				NullPointerException {
			setURL(json.getString("url"));
		}

		@Override
		public JSONObject getJSON(boolean resumido) throws JSONException,
				NullPointerException {
			JSONObject json = super.getJSON(resumido);
			if (resumido) {
				return json;
			}
			json.put("url", getURL());
			return json;
		}

	}

	public static class BotonLlamadaTelefonica extends Boton {

		private String Telefono;

		public BotonLlamadaTelefonica(long id, String tipo, String texto,
				String telefono) {
			super(id, tipo, texto);
			setTelefono(telefono);
		}

		public BotonLlamadaTelefonica(JSONObject json) throws JSONException {
			super(json);
			setTelefono(json);
		}

		public BotonLlamadaTelefonica(JSONObject json, boolean resumido)
				throws JSONException {
			super(json, resumido);
			setTelefono(json);
		}

		public String getTelefono() {
			return Telefono;
		}

		public void setTelefono(String telefono) {
			Telefono = telefono;
		}

		public void setTelefono(JSONObject json) throws JSONException,
				NullPointerException {
			setTelefono(json.getString("telefono"));
		}

		@Override
		public JSONObject getJSON(boolean resumido) throws JSONException,
				NullPointerException {
			JSONObject json = super.getJSON(resumido);

			if (resumido) {
				return json;
			}
			json.put("telefono", getTelefono());
			return json;
		}
	}

	public static class BotonMapa extends Boton {

		private String uriMapa;

		public BotonMapa(long id, String tipo, String texto, String uri) {
			super(id, tipo, texto);
			setUriMapa(uri);
		}

		public BotonMapa(JSONObject json) throws JSONException {
			super(json);
			setUriMapa(json);
		}

		public BotonMapa(JSONObject json, boolean resumido)
				throws JSONException {
			super(json, resumido);
			setUriMapa(json);
		}

		@Override
		public JSONObject getJSON(boolean resumido) throws JSONException,
				NullPointerException {
			JSONObject json = super.getJSON(resumido);

			if (resumido) {
				return json;
			}
			json.put("uri_mapa", getUriMapa());
			return json;
		}

		public String getUriMapa() {
			return uriMapa;
		}

		public void setUriMapa(String uriMapa) {
			this.uriMapa = uriMapa;
		}

		public void setUriMapa(JSONObject json) throws JSONException,
				NullPointerException {
			setUriMapa(json.getString("uri_mapa"));
		}
	}

	public static class BotonCorreo extends Boton {
		private String DireccionEmail = null;
		private String Asunto = null;
		private String Mensaje = null;

		public BotonCorreo(long id, String tipo, String texto,
				String direccion, String asunto, String mensaje) {
			super(id, tipo, texto);
			setDireccionEmail(direccion);
			setAsunto(asunto);
			setMensaje(mensaje);
		}

		public BotonCorreo(JSONObject json) throws JSONException {
			super(json);
			setDireccionEmail(json);
			setAsunto(json);
			setMensaje(json);
		}

		public BotonCorreo(JSONObject json, boolean resumido)
				throws JSONException {
			super(json, resumido);
			if (!resumido) {
				setDireccionEmail(json);
				setAsunto(json);
				setMensaje(json);
			}
		}

		@Override
		public JSONObject getJSON(boolean resumido) throws JSONException {
			JSONObject json = super.getJSON(resumido);

			if (resumido) {
				return json;
			}
			if (!resumido) {
				json.put("para", getDireccionEmail());
				json.put("asunto", getAsunto());
				json.put("mensaje", getMensaje());
			}
			return json;
		}

		public String getDireccionEmail() {
			return DireccionEmail;
		}

		public void setDireccionEmail(String direccionEmail) {
			DireccionEmail = direccionEmail;
		}

		public void setDireccionEmail(JSONObject json) throws JSONException,
				NullPointerException {
			setDireccionEmail(json.getString("para"));
		}

		public String getAsunto() {
			return Asunto;
		}

		public void setAsunto(String asunto) {
			Asunto = asunto;
		}

		public void setAsunto(JSONObject json) throws JSONException,
				NullPointerException {
			setAsunto(json.getString("asunto"));
		}

		public String getMensaje() {
			return Mensaje;
		}

		public void setMensaje(String mensaje) {
			Mensaje = mensaje;
		}

		public void setMensaje(JSONObject json) throws JSONException,
				NullPointerException {
			setMensaje(json.getString("mensaje"));
		}

	}

}
