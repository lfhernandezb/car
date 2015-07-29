import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.AbstractMap.SimpleEntry;

import org.apache.commons.lang.StringEscapeUtils;
//import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import cl.dsoft.car.misc.MyCarException;
import cl.dsoft.car.server.db.Log;
import cl.dsoft.car.server.db.Usuario;
import cl.dsoft.car.server.db.UsuarioInfo;
import cl.dsoft.car.server.model.Proveedores;
import cl.manadachile.clacfactory.mycar.logsmp.LogMiAuto;
import cl.manadachile.clacfactory.mycar.logsmp.LogPosicion;
import cl.manadachile.clacfactory.mycar.logsmp.LogPosicion.LogPosicionHora;

import eu.bitm.NominatimReverseGeocoding.NominatimReverseGeocodingJAPI;
import eu.bitm.NominatimReverseGeocoding.Address;

/**
 * 
 */

/**
 * @author lfhernandez
 *
 */
public class ProcesaLogs {

	/**
	 * 
	 */
	public ProcesaLogs() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 */
	@SuppressWarnings("deprecation")
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Logger logger = Logger.getLogger(ProcesaLogs.class.getName());

		String config_file_name;
		java.sql.Connection conn;
		Properties prop;
		DatabaseMetaData databaseMetaData;
		String   catalog;
		String   schemaPattern;
		String   tableNamePattern;
		String[] types;
		JSONObject jo_data;
		JSONArray ja_marcas;
		ArrayList<SimpleEntry<String, String>> listParameters;
		ArrayList<Usuario> listUsuario;
		ArrayList<Log> listLog;
		//ArrayList<Usuario> listUsuario;
		InputStream input;

		conn = null;

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
			
			// conn.setAutoCommit(false);
			
			listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
			
			//listParameters.add(new SimpleEntry<String, String>("no borrado", null));
			
			listUsuario = Usuario.seek(conn, listParameters, null, null, 0, 10000);
			
			for (Usuario usuario : listUsuario) {
				
				boolean bFound = false;
				
				listParameters.clear();
				
				listParameters.add(new SimpleEntry<String, String>("id_usuario", String.valueOf(usuario.getId())));
				
				listLog = Log.seek(conn, listParameters, "fecha_modificacion", "DESC", 0, 10000);
				
				for (Log log : listLog) {
			        try {
						JSONObject jo = new JSONObject(log.getData());
						
						LogMiAuto lma = new LogMiAuto(jo);
						
						if (lma.getTipo() == LogMiAuto.TipoLog.LOG_POSICION) {
							
							LogPosicion lp = new LogPosicion(jo);
							
							for (LogPosicionHora lph : lp.getPosiciones()) {
								if (lph.isValido() && lph.getFecha().getDay() != Calendar.SATURDAY && lph.getFecha().getDay() != Calendar.SUNDAY && lph.getLatitud() != 0) {
									
									System.out.println("id_usuario: " + String.valueOf(usuario.getId()) + " lat: " + String.valueOf(lph.getLatitud()) + " lon: " + String.valueOf(lph.getLongitud()));
									
									bFound = true;
									
									UsuarioInfo ui = UsuarioInfo.getByParameter(conn, "id_usuario", String.valueOf(usuario.getId()));
									
							        NominatimReverseGeocodingJAPI nominatim1 = new NominatimReverseGeocodingJAPI(); //create instance with default zoom level (18)
							        
							        Address address = nominatim1.getAdress(lph.getLatitud(), lph.getLongitud()); //returns Address object for the given position

									
									if (ui == null) {		
										ui = new UsuarioInfo();
									}
									
									ui.setIdUsuario(usuario.getId());
									ui.setLatitud(lph.getLatitud());
									ui.setLongitud(lph.getLongitud());
									ui.setCity(StringEscapeUtils.escapeSql(address.getCity()));
									ui.setCountry(StringEscapeUtils.escapeSql(address.getCounty()));
									ui.setCountry(StringEscapeUtils.escapeSql(address.getCountry()));
									ui.setCountryCode(address.getCountryCode());
									//ui.setHouseNumber(address.)
									//ui.setNeighbourhood(address.ge)
									ui.setRoad(StringEscapeUtils.escapeSql(address.getRoad()));
									ui.setState(StringEscapeUtils.escapeSql(address.getState()));
									ui.setSuburb(StringEscapeUtils.escapeSql(address.getSuburb()));
										
									if (ui.getId() == null) {
										ui.insert(conn);
									}
									else {
										ui.update(conn);
									}
									
									if (bFound) {
										break;
									}
								}
							}
						}
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						//e.printStackTrace();
					}

					if (bFound) {
						break;
					}
			        
				}
			}
			conn.close();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidFileFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
