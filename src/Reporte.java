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
import cl.dsoft.car.server.db.Autenticacion;
import cl.dsoft.car.server.db.CargaCombustible;
import cl.dsoft.car.server.db.InfoSincro;
import cl.dsoft.car.server.db.Log;
import cl.dsoft.car.server.db.MantencionBaseHecha;
import cl.dsoft.car.server.db.MantencionUsuarioHecha;
import cl.dsoft.car.server.db.Reparacion;
import cl.dsoft.car.server.db.SeguroVehiculo;
import cl.dsoft.car.server.db.Usuario;
import cl.dsoft.car.server.db.UsuarioInfo;
import cl.dsoft.car.server.db.Vehiculo;
import cl.dsoft.car.server.model.MantencionBaseHechaModelo;
import cl.dsoft.car.server.model.Proveedores;
import cl.dsoft.car.server.model.VehiculoModelo;
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
public class Reporte {

	/**
	 * 
	 */
	public Reporte() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 */
	@SuppressWarnings("deprecation")
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Logger logger = Logger.getLogger(Reporte.class.getName());

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
			
			String strOutput;
			Autenticacion au;
			ArrayList<Vehiculo> listV;
			ArrayList<Log> listL;
			ArrayList<InfoSincro> listIS;
			
			String header = 
				"id_usuario,id_comuna,nombre,correo,hombre,modificacion,id_red_social,#autos," +
				"auto1_anio,auto1_patente,auto1_km_anual,auto1_km_calibrados,auto1_km,auto1_fecha_ultima_calibracion," +
				"auto2_anio,auto2_patente,auto2_km_anual,auto2_km_calibrados,auto2_km,auto2_fecha_ultima_calibracion," +
				"auto3_anio,auto3_patente,auto3_km_anual,auto3_km_calibrados,auto3_km,auto3_fecha_ultima_calibracion," +
				"auto1 #seguros,auto2 #seguros,auto3 #seguros," +
				"auto1 #mantenciones_hecha,auto2 #mantenciones_hecha,auto3 #mantenciones_hecha," +
				"auto1 #mantenciones_pendientes,auto2 #mantenciones_pendientes,auto3 #mantenciones_pendientes," +
				"auto1 #carga_combustible,auto2 #carga_combustible,auto3 #carga_combustible," +
				"auto1 ultima_carga_combustible,auto2 ultima_carga_combustible,auto3 ultima_carga_combustible," +
				"auto1 #reparacion,auto2 #reparacion,auto3 #reparacion," +
				"fecha_ultimo_log,fecha_ultima_sincro,fecha_ultimo_log_posicion," +
				"fecha_ultimo_log_notificacion,fecha_ultimo_log_proveedor,comuna";

				
			System.out.println(header);
			
			for (Usuario usuario : listUsuario) {
				int count;
				boolean bFound;
				String strFecha, strComuna;
				
				strOutput = 
					String.valueOf(usuario.getId()) + "," + String.valueOf(usuario.getIdComuna()) + ",'" + 
					usuario.getNombre() + "','" + usuario.getCorreo() + "'," + String.valueOf(usuario.getHombre()) + ",'" +
					usuario.getFechaModificacion() + "',";
				
				au = Autenticacion.getByParameter(conn, "id_usuario", String.valueOf(usuario.getId()));
				
				if (au != null) {
					strOutput +=
							String.valueOf(au.getIdRedSocial()) + ",";
				}
				else {
					strOutput +=
							",";					
				}
				
				listParameters.clear();
				
				listParameters.add(new SimpleEntry<String, String>("id_usuario", String.valueOf(usuario.getId())));
				
				listV = Vehiculo.seek(conn, listParameters, null, null, 0, 10000);
				
				// # vehiculos
				strOutput +=
						String.valueOf(listV.size()) + ",";					
				
				// datos vehiculos
				count = 0;
				
				for (Vehiculo v : listV) {
					
					strOutput +=
						String.valueOf(v.getAnio()) + ",'" + String.valueOf(v.getPatente()).replaceAll("[\n\r]", "") + "'," + String.valueOf(v.getKmAnuales()) + "," +
						String.valueOf(v.getKmCalibrados()) + "," + String.valueOf(v.getKm()) + ",'" +
						v.getFechaUltimaCalibracion() + "',";
					
					count++;
					
					if (count == 3) {
						break;
					}
				}
				
				for (; count < 3; count++) {
					strOutput +=
						",'',,,,'',";
					
				}
				

				count = 0;
				
				for (Vehiculo v : listV) {
					
					ArrayList<SeguroVehiculo> listSV;
					
					listParameters.clear();
					
					listParameters.add(new SimpleEntry<String, String>("id_vehiculo", String.valueOf(v.getIdVehiculo())));
					
					listSV = SeguroVehiculo.seek(conn, listParameters, null, null, 0, 10000);
					
					strOutput +=
							String.valueOf(listSV.size()) + ",";
					
					count++;
					
					if (count == 3) {
						break;
					}
				}
				
				for (; count < 3; count++) {
					strOutput +=
						",";
					
				}
				
				// # mantenciones hechas
				count = 0;
				
				for (Vehiculo v : listV) {
					
					ArrayList<MantencionBaseHecha> listMBH;
					
					listParameters.clear();
					
					listParameters.add(new SimpleEntry<String, String>("id_vehiculo", String.valueOf(v.getIdVehiculo())));
					
					listMBH = MantencionBaseHecha.seek(conn, listParameters, null, null, 0, 10000);
					
					strOutput +=
							String.valueOf(listMBH.size()) + ",";
					
					count++;
					
					if (count == 3) {
						break;
					}
				}
				
				for (; count < 3; count++) {
					strOutput +=
						",";
					
				}
				
				// # mantenciones pendientes
				count = 0;
				
				for (Vehiculo v : listV) {
					
					VehiculoModelo vm = new VehiculoModelo(conn, v);
					
					ArrayList<MantencionBaseHechaModelo> listMBHM = vm.getMantencionesBasePendientes(conn);
					
					strOutput +=
							String.valueOf(listMBHM.size()) + ",";
					
					count++;
					
					if (count == 3) {
						break;
					}
				}
				
				for (; count < 3; count++) {
					strOutput +=
						",";
					
				}
				
				// # carga combustible
				count = 0;
				
				for (Vehiculo v : listV) {
					
					ArrayList<CargaCombustible> listCC;
					
					listParameters.clear();
					
					listParameters.add(new SimpleEntry<String, String>("id_vehiculo", String.valueOf(v.getIdVehiculo())));
					
					listCC = CargaCombustible.seek(conn, listParameters, null, null, 0, 10000);
					
					strOutput +=
							String.valueOf(listCC.size()) + ",";
					
					count++;
					
					if (count == 3) {
						break;
					}
				}
				
				for (; count < 3; count++) {
					strOutput +=
						",";
					
				}
				
				// fecha ultima carga combustible
				count = 0;
				
				for (Vehiculo v : listV) {
					
					ArrayList<CargaCombustible> listCC;
					
					listParameters.clear();
					
					listParameters.add(new SimpleEntry<String, String>("id_vehiculo", String.valueOf(v.getIdVehiculo())));
					
					listCC = CargaCombustible.seek(conn, listParameters, "fecha_modificacion", "DESC", 0, 1);
					
					if (listCC.size() > 0) {
						strOutput +=
								"'" + listCC.get(0).getFechaModificacion() + "',";
					}
					else {
						strOutput +=
								"'',";
					}
					
					count++;
					
					if (count == 3) {
						break;
					}
				}
				
				for (; count < 3; count++) {
					strOutput +=
						"'',";
					
				}

				// # reparaciones
				count = 0;
				
				for (Vehiculo v : listV) {
					
					ArrayList<Reparacion> listRep;
					
					listParameters.clear();
					
					listParameters.add(new SimpleEntry<String, String>("id_vehiculo", String.valueOf(v.getIdVehiculo())));
					
					listRep = Reparacion.seek(conn, listParameters, null, null, 0, 10000);
					
					strOutput +=
							String.valueOf(listRep.size()) + ",";
					
					count++;
					
					if (count == 3) {
						break;
					}
				}
				
				for (; count < 3; count++) {
					strOutput +=
						",";
					
				}

				// fecha ultimo log
				strFecha = "";

				listParameters.clear();
				
				listParameters.add(new SimpleEntry<String, String>("id_usuario", String.valueOf(usuario.getId())));
				
				listL = Log.seek(conn, listParameters, "fecha_modificacion", "DESC", 0, 1);
				
				if (listL.size() > 0) {
					
					Log log = listL.get(0);
					
					strFecha = log.getFechaModificacion();
					
				}

				strOutput +=
					"'" + strFecha + "',";

				// fecha ultima sincro
				strFecha = "";

				listParameters.clear();
				
				listParameters.add(new SimpleEntry<String, String>("id_usuario", String.valueOf(usuario.getId())));
				
				listIS = InfoSincro.seek(conn, listParameters, "fecha", "DESC", 0, 1);
				
				if (listIS.size() > 0) {
					
					InfoSincro is = listIS.get(0);
					
					strFecha = is.getFecha();
					
				}

				strOutput +=
						"'" + strFecha + "',";

				// fecha ultimo log de posicion
				strFecha = "";

				listParameters.clear();
				
				listParameters.add(new SimpleEntry<String, String>("id_usuario", String.valueOf(usuario.getId())));
				
				listL = Log.seek(conn, listParameters, "fecha_modificacion", "DESC", 0, 10000);
				
				bFound = false;
				
				if (listL.size() > 0) {
					
					for (Log log : listL) {
						JSONObject jo = new JSONObject(log.getData());
						
						LogMiAuto lma = new LogMiAuto(jo);
						
						if (lma.getTipo() == LogMiAuto.TipoLog.LOG_POSICION) {
							bFound = true;
							strFecha = log.getFechaModificacion();
							
							break;
						}
						
					}
					
				}
				
				strOutput +=
						"'" + strFecha + "',";

				// fecha ultimo log de notificacion
				strFecha = "";

				listParameters.clear();
				
				listParameters.add(new SimpleEntry<String, String>("id_usuario", String.valueOf(usuario.getId())));
				
				listL = Log.seek(conn, listParameters, "fecha_modificacion", "DESC", 0, 10000);
				
				bFound = false;
				
				if (listL.size() > 0) {
					
					for (Log log : listL) {
						JSONObject jo = new JSONObject(log.getData());
						
						LogMiAuto lma = new LogMiAuto(jo);
						
						if (lma.getTipo() == LogMiAuto.TipoLog.LOG_NOTIFICACION) {
							bFound = true;
							strFecha = log.getFechaModificacion();
							
							break;
						}
						
					}
					
				}
				
				strOutput +=
						"'" + strFecha + "',";

				// fecha ultimo log de notificacion
				strFecha = "";

				listParameters.clear();
				
				listParameters.add(new SimpleEntry<String, String>("id_usuario", String.valueOf(usuario.getId())));
				
				listL = Log.seek(conn, listParameters, "fecha_modificacion", "DESC", 0, 10000);
				
				bFound = false;
				
				if (listL.size() > 0) {
					
					for (Log log : listL) {
						try {
							JSONObject jo = new JSONObject(log.getData());
							
							LogMiAuto lma = new LogMiAuto(jo);
							
							if (lma.getTipo() == LogMiAuto.TipoLog.LOG_PROVEEDOR) {
								bFound = true;
								strFecha = log.getFechaModificacion();
								
								break;
							}
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
					}
					
				}
				
				strOutput +=
						"'" + strFecha + "',";
				
				// comuna
				strComuna = "";
				
				UsuarioInfo ui = UsuarioInfo.getByParameter(conn, "id_usuario", String.valueOf(usuario.getId()));
				
				if (ui != null) {
					strComuna = ui.getCity();
				}

				strOutput +=
					"'" + strComuna + "',";

				System.out.println(strOutput);
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
