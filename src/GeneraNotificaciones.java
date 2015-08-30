import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.AbstractMap;
import java.util.AbstractMap.SimpleEntry;
import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;
import org.json.JSONArray;
import org.json.JSONObject;

import cl.dsoft.car.server.db.CampaniaUsuario;
import cl.dsoft.car.server.db.Campania;
//import cl.dsoft.car.server.db.Usuario;
//import cl.dsoft.car.server.db.Vehiculo;

/**
 * 
 */

/**
 * @author lfhernandez
 *
 */
public class GeneraNotificaciones {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Logger logger = Logger.getLogger(GeneraNotificaciones.class.getName());

		String config_file_name;
		java.sql.Connection conn;
		Wini ini;
		DatabaseMetaData databaseMetaData;
		String   catalog;
		String   schemaPattern;
		String   tableNamePattern;
		String[] types;
		JSONObject jo_data;
		JSONArray ja_marcas;
		ArrayList<SimpleEntry<String, String>> listParameters;
		ArrayList<Campania> listCampania;
		//ArrayList<Usuario> listUsuario;

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
			
			listParameters.add(new SimpleEntry<String, String>("activa", null));
			listParameters.add(new SimpleEntry<String, String>("vigente", null));
			
			listCampania = Campania.seek(conn, listParameters, null, null, 0, 10000);
			
			for (Campania campania : listCampania) {
				
				if (campania.getActiva() == true) {
			        
					Statement stmt = null;
			        ResultSet rs = null;

					// obtengo los usuarios a notificar
					
					String strSQL = 
						"  SELECT DISTINCT(u.id_usuario)" +
						"  FROM usuario u" +
						"  LEFT JOIN vehiculo v ON v.id_usuario = u.id_usuario" +
						"  LEFT JOIN usuario_info ui ON ui.id_usuario = u.id_usuario" +
						"  LEFT JOIN region r ON r.region = ui.state" +
						"  WHERE u.id_usuario NOT IN (SELECT cu.id_usuario FROM campania_usuario cu WHERE cu.id_campania = " + String.valueOf(campania.getId()) + ")";
					
					if (!campania.getCondicion().isEmpty()) {
						strSQL += " AND (" + campania.getCondicion() + ")";
					}
					
		            stmt = conn.createStatement();
		            
		            //System.out.println(strSQL);
		            
		            rs = stmt.executeQuery(strSQL);
		            
		            while (rs.next()) {
		                
		            	CampaniaUsuario cu;
		            	
		            	Long id_usuario = rs.getLong("id_usuario");
		            	
		            	cu = new CampaniaUsuario();
		            	
		            	cu.setIdUsuario(id_usuario);
		            	cu.setIdCampania(campania.getId());
		            	
		            	cu.insert(conn);
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
