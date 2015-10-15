import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;
import java.util.AbstractMap.SimpleEntry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;
import org.joda.time.DateTime;
import org.joda.time.Months;
import org.json.JSONException;
import org.json.JSONObject;

import cl.dsoft.car.misc.Point;
import cl.dsoft.car.misc.InvalidFormatException;
import cl.dsoft.car.misc.UnsupportedParameterException;
import cl.dsoft.car.server.db.Campania;
import cl.dsoft.car.server.db.CampaniaUsuario;
import cl.dsoft.car.server.db.CargaCombustible;
import cl.dsoft.car.server.db.Comuna;
import cl.dsoft.car.server.db.LineaDeTiempo;
import cl.dsoft.car.server.db.Log;
import cl.dsoft.car.server.db.MantencionBase;
import cl.dsoft.car.server.db.MantencionBaseHecha;
import cl.dsoft.car.server.db.Marca;
import cl.dsoft.car.server.db.Modelo;
import cl.dsoft.car.server.db.Pais;
import cl.dsoft.car.server.db.Proveedor;
import cl.dsoft.car.server.db.Provincia;
import cl.dsoft.car.server.db.ProvinciaComuna;
import cl.dsoft.car.server.db.Region;
import cl.dsoft.car.server.db.Reparacion;
import cl.dsoft.car.server.db.RevisionTecnica;
import cl.dsoft.car.server.db.SeguroVehiculo;
import cl.dsoft.car.server.db.Usuario;
import cl.dsoft.car.server.db.UsuarioCreacion;
import cl.dsoft.car.server.db.UsuarioInfo;
import cl.dsoft.car.server.db.Util;
import cl.dsoft.car.server.db.Vehiculo;
import cl.dsoft.car.server.model.MantencionBaseHechaModelo;
import cl.dsoft.car.server.model.VehiculoModelo;
import cl.manadachile.clacfactory.mycar.logsmp.LogMiAuto;
import cl.manadachile.clacfactory.mycar.logsmp.LogPosicion;
import cl.manadachile.clacfactory.mycar.logsmp.LogPosicion.LogPosicionHora;

/**
 * 
 */

/**
 * @author lfhernandez
 *
 */
public class ProcesaLineaTiempo {

	/**
	 * 
	 */

	static String strDetalleCampania =
"{" +
"	  \"datos_notif\": {" +
"	    \"nombre\": \"%s\"," +
"	    \"cuerpo\": \"%s\"," +
"	    \"ticker\": \"%s\"," +
"	    \"id_notificacion\": %d," +
"	    \"id_campana\": %d" +
"	  }," +
"	  \"activity\": {" +
"	    \"html\": \"<!DOCTYPE html><html><head><meta charset=utf-8 /></head><body>  <h1>  %s  </h1>  %s  </body></html>\"," +
"	    \"botones\": [" +
"	      {" +
"	        \"tipo\": \"BTN_WEB\"," +
"	        \"texto\": \"Ir a FanPage\"," +
"	        \"id_boton\": 1," +
"	        \"url\": \"https://www.facebook.com/miautoapp?ref=ts&fref=ts\"" +
"	      }" +
"	    ]" +
"	  }" +
"	}";
	
	
	public ProcesaLineaTiempo() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 * @throws ParseException 
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Properties prop;
		InputStream input;
		Connection conn;
		
		ArrayList<SimpleEntry<String, String>> listParameters;
		ArrayList<LineaDeTiempo> listLineaDeTiempo;
		ArrayList<Usuario> listUsuario;
		
		try {
			// leo archivo de configuracion
			
			prop = new Properties();
			
			String filename = "conf/config.properties";
			
			//load the file handle for main.properties
			input = new FileInputStream(filename);
			
			if(input==null){
			    throw new FileNotFoundException("Archivo " + filename + " no encontrado");
			}

			//load a properties file from class path, inside static method
			prop.load(input);

			// abro conexion a la BD
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://" + prop.getProperty("db.host") + "/" + prop.getProperty("db.database"), 
					prop.getProperty("db.user"), prop.getProperty("db.password"));
			
			String strDateNow = Util.getDateFromServer(conn);
			// String strDateNow = "2015-04-12 12:15:00";

			//System.out.println(String.format("strDate '%s'", strDate));
			
			Pattern p = Pattern.compile("(\\d+)-(\\d+)-(\\d+)\\s(\\d+):(\\d+):(\\d+)");
			//Pattern p = Pattern.compile("(\\d+)");
			
			Matcher m = p.matcher(strDateNow);
			//Matcher m = p.matcher("2015");
			
			if (m.find()) {
			
				//System.out.println(m.toString());
				
				int diaActual = Integer.valueOf(m.group(3));
				int mesActual = Integer.valueOf(m.group(2));
				int anioActual = Integer.valueOf(m.group(1));
				
				DateTime dtNow = new DateTime(anioActual, mesActual, diaActual, 0, 0);
				
				DateTime dtFechaNotificacion = null; //dtNow.plusMonths(1);
				
				// conn.setAutoCommit(false);
				listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
				
				listLineaDeTiempo = LineaDeTiempo.seek(conn, listParameters, null, null, 0, 10000);
				
				for (LineaDeTiempo lineaDeTiempo : listLineaDeTiempo) {
					
					System.out.println(lineaDeTiempo.toString());
					
					if (lineaDeTiempo.getUnidad().equals("D")) {
						dtFechaNotificacion = dtNow.minusDays(lineaDeTiempo.getCantidad());
					}
					else if (lineaDeTiempo.getUnidad().equals("S")) {
						dtFechaNotificacion = dtNow.minusWeeks(lineaDeTiempo.getCantidad());
					}
					else if (lineaDeTiempo.getUnidad().equals("M")) {
						dtFechaNotificacion = dtNow.minusMonths(lineaDeTiempo.getCantidad());
					}
					else if (lineaDeTiempo.getUnidad().equals("A")) {
						dtFechaNotificacion = dtNow.minusYears(lineaDeTiempo.getCantidad());
					}
					else {
						throw new UnsupportedParameterException("Unidad no soportada : '" + lineaDeTiempo.getUnidad() + "'");
					}
					
					listParameters.clear();

					listParameters.add(new SimpleEntry<String, String>("no borrado", ""));
					//listParameters.add(new SimpleEntry<String, String>("id_usuario_in", "1,3,4,5,11,86,102,1634"));
					//listParameters.add(new SimpleEntry<String, String>("id_usuario_in", "2306,2273,1952,1802,1693,2232"));
					//listParameters.add(new SimpleEntry<String, String>("id_usuario", "102"));
					listParameters.add(new SimpleEntry<String, String>("fecha_creacion", String.format("%04d-%02d-%02d", 
							dtFechaNotificacion.getYear(),
							dtFechaNotificacion.getMonthOfYear(),
							dtFechaNotificacion.getDayOfMonth())));
					
					listUsuario = Usuario.seek(conn, listParameters, null, null, 0, 10000);
					
					int countUsuario = 0;
					int count;
					
					for (Usuario usuario : listUsuario) {
						
						countUsuario++;
						/*
						if (countUsuario == 100) {
							break;
						}
						*/

						UsuarioCreacion uc = usuario.getUsuarioCreacion(conn);
						
						System.out.println(String.format("id_usuario %d, fecha_creacion %s", usuario.getId(), uc.getFechaCreacion()));
						
						//System.out.println(strOutput);
						
						// grabo notificacion
						if (lineaDeTiempo.getDetalle().length() > 0) {
					    	Date dInicial, dFinal;
					    	DateTime dtInicial, dtFinal;
	
					    	// programo notificacion
							//System.out.println(strOutput);
							
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			        		
			    			dInicial = formatter.parse(String.format("%04d-%02d-%02d", anioActual, mesActual, diaActual)); // dia de hoy
			    			
			    			dtInicial = new DateTime(dInicial);
			    			
			    			dtFinal = dtInicial.plusDays(7);
	
							Campania c = new Campania();
							
							c.setFechaInicio(dtInicial.toDate());
							c.setFechaFin(dtFinal.toDate());
							c.setDetalle("foo");
							c.setDescripcion(String.format("LineaDeTiempo %d, id_usuario %d, %s", lineaDeTiempo.getId(), usuario.getId(), String.format("%04d-%02d-%02d", anioActual, mesActual, diaActual)));
							c.setManual(false);
							c.setActiva(true);
							c.setNumeroImpresiones((short) 1);
							c.setPeriodicidad((short) 1);
							
							//System.out.println(c.toString());
							
							// * c.insert(conn);
							
							String strDetalle = String.format(ProcesaLineaTiempo.strDetalleCampania, 
								c.getDescripcion(),
								c.getDescripcion(),
								c.getDescripcion(),
								c.getId(),
								c.getId(),
								"Tip MiAuto",
								lineaDeTiempo.getDetalle()
								);
							
							c.setDetalle(strDetalle);
							
							// * c.update(conn);
							
							CampaniaUsuario cu = new CampaniaUsuario();
							
							cu.setIdCampania(c.getId());
							cu.setIdUsuario(usuario.getId());
							
							// * cu.insert(conn);
						}
						
					}
				}
								
			}
			conn.close();

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedParameterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
