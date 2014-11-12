import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.AbstractMap;
import java.util.AbstractMap.SimpleEntry;
import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;
import org.json.JSONArray;
import org.json.JSONObject;

import cl.dsoft.car.server.db.Alerta;
import cl.dsoft.car.server.db.MantencionBaseHecha;
import cl.dsoft.car.server.db.Usuario;
import cl.dsoft.car.server.db.Vehiculo;

/**
 * 
 */

/**
 * @author lfhernandez
 *
 */
public class GeneraAlertas {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Logger logger = Logger.getLogger(DataLoader.class.getName());

		String config_file_name;
		java.sql.Connection conn;
		Wini ini;
		DatabaseMetaData databaseMetaData;
		ResultSet rs;
		String   catalog;
		String   schemaPattern;
		String   tableNamePattern;
		String[] types;
		JSONObject jo_data;
		JSONArray ja_marcas;
		ArrayList<SimpleEntry<String, String>> listParameters;
		ArrayList<Vehiculo> listVehiculo;
		ArrayList<Usuario> listUsuario;

		conn = null;

    	try {
			// leo archivo de configuracion
			
			ini = new Wini();
			
			config_file_name = System.getProperty("config_file");
			
			File f = new File(config_file_name);
			
			if (!f.exists()) {
				throw new FileNotFoundException("Config file does not exists");
			}
			
			ini.load(new File(config_file_name));
			
			// abro conexion a la BD
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://" + ini.get("DB", "host") + "/" + ini.get("DB", "database"), 
					ini.get("DB", "user"), ini.get("DB", "password"));
			
			// conn.setAutoCommit(false);
			
			listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
			
			listParameters.add(new SimpleEntry<String, String>("no borrado", null));
			
			listUsuario = Usuario.seek(conn, listParameters, null, null, 0, 10000);
			
			for (Usuario u : listUsuario) {
				
				listParameters.clear();
				
				listParameters.add(new SimpleEntry<String, String>("no borrado", null));
				listParameters.add(new SimpleEntry<String, String>("id_usuario", String.valueOf(u.getId())));
				
				listVehiculo = Vehiculo.seek(conn, listParameters, null, null, 0, 10000);
				
				for (Vehiculo v : listVehiculo) {
					
					ArrayList<MantencionBaseHecha> listMBH = v.getMantencionesBasePendientes(conn);
					
					for (MantencionBaseHecha mbh : listMBH) {
						
						ArrayList<Alerta> listAlerta;
						// hay alerta ya generada para esta mantencion pendiente?
						
						listParameters.clear();
						
						listParameters.add(new SimpleEntry<String, String>("id_mantencion_base", String.valueOf(mbh.getIdMantencionBase())));
						
						if (mbh.getKm() == 0) {
							// por fecha
							listParameters.add(new SimpleEntry<String, String>("fecha", mbh.getFecha()));
						}
						else {
							// por km
							listParameters.add(new SimpleEntry<String, String>("km", String.valueOf(mbh.getKm())));
						}
						
						listAlerta = Alerta.seek(conn, listParameters, null, null, 0, 10000);
						
						if (listAlerta.size() == 0) {
							// alertamos
							System.out.println("Alerta para mbh: " + mbh.toString());
							
							// grabamos registro en 'alerta'
							Alerta alerta = new Alerta();
							
							alerta.setIdMantencionBase(mbh.getIdMantencionBase());
							alerta.setIdUsuario(u.getId());
							alerta.setIdVehiculo(v.getIdVehiculo());
							
							if (mbh.getKm() == 0) {
								// por fecha
								alerta.setFecha(mbh.getFecha());
							}
							else {
								// por km
								alerta.setKm(mbh.getKm());
							}
							
							alerta.save(conn);
						}
						else {
							// ya hay alerta... ignoramos
						}

					}
				}
				
			} // end for
			
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
