import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.AbstractMap;
import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import bd.Estilo;
import bd.MantencionBase;
import bd.Marca;
import bd.Modelo;
import bd.ModeloAnio;
import bd.Motor;
import bd.TipoVehiculo;
import bd.Usuario;

/**
 * 
 */

/**
 * @author Owner
 *
 */
public class DataLoader {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		/*
		if (args.length != 3) {
			System.err
					.println("Utilice: java ShopInvoice <template.xml> <certDigital.p12> <password>");
			System.exit(-1);
		*/
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
		ArrayList<AbstractMap.SimpleEntry<String, String>> listParameters;
		
		conn = null;

		try {
			
        	// leo archivo de configuracion
        	
        	ini = new Wini();
        	
        	config_file_name = System.getProperty("config_file");
        	
        	File f = new File(config_file_name);
        	
        	if (!f.exists()) {
        		throw new Exception("Config file does not exists");
        	}
        	
        	ini.load(new File(config_file_name));
        	
        	// abro conexion a la BD
        	Class.forName("com.mysql.jdbc.Driver");
        	conn = DriverManager.getConnection("jdbc:mysql://" + ini.get("DB", "host") + "/" + ini.get("DB", "database"), 
        			ini.get("DB", "user"), ini.get("DB", "password"));
        	
        	// conn.setAutoCommit(false);
        	
        	String str_tipo_vehiculo = "vehiculo liviano";
        	
        	TipoVehiculo tv = TipoVehiculo.getByDescripcion(conn, str_tipo_vehiculo);
        	
        	if (tv == null) {
        		tv = new TipoVehiculo();
        		
        		tv.set_descripcion(str_tipo_vehiculo);
        		
        		tv.insert(conn);
        	}
        	
        	logger.debug("conn: " + conn);

        	String data;
        	
        	// leo archivo de datos
        	
        	// data = Util.getFileContent(System.getProperty("data_directory") + "/vehicle_2010.json");
        	for (int anios = 2010; anios < 2013; anios++) {
        	
	        	data = Util.sendGet("https://api.edmunds.com/api/vehicle/v2/makes?state=used&year=" + String.valueOf(anios) + "&view=basic&fmt=json&api_key=7b2c2ymje3mz2h8q8r9t4cp8");
	        	
	        	//System.out.println("Response:" + data);
	        	
	        	jo_data = new JSONObject(data);
	        	
	        	ja_marcas = jo_data.getJSONArray("makes");
	        	
	        	listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
	        	
				for (int i = 0; i < ja_marcas.length(); i++) {
					Marca marca;
					JSONArray ja_modelos;
					
					String str_marca = ja_marcas.getJSONObject(i).getString("name");
					
					System.out.println(str_marca);
					
		        	marca = Marca.getByDescripcion(conn, str_marca);
		        	
		        	if (marca == null) {
		        		marca = new Marca();
		        		
		        		marca.set_descripcion(str_marca);
		        		
		        		marca.insert(conn);
		        	}
	
		        	ja_modelos = ja_marcas.getJSONObject(i).getJSONArray("models");
					
					for (int j = 0; j < ja_modelos.length(); j++) {
						ArrayList<Modelo> listaModelo;
						JSONArray ja_anios;
						Modelo modelo;
						
						String str_modelo = ja_modelos.getJSONObject(j).getString("name");
						
						System.out.println("\t" + str_modelo);
						
						listParameters.clear();
						
						listParameters.add(new AbstractMap.SimpleEntry<String, String>("id_marca", marca.get_id().toString()));
						listParameters.add(new AbstractMap.SimpleEntry<String, String>("id_tipo_vehiculo", tv.get_id().toString()));
						listParameters.add(new AbstractMap.SimpleEntry<String, String>("descripcion", str_modelo));
						
						listaModelo = Modelo.seek(conn, listParameters, null, null, 0, 1);
						
						if (listaModelo.size() == 0) {
							modelo = new Modelo();
							
							modelo.set_id_marca(marca.get_id());
							modelo.set_id_tipo_vehiculo(tv.get_id());
							modelo.set_descripcion(str_modelo);
							
							modelo.insert(conn);
							//System.out.println("\tinserted");
						}
						else {
							modelo = listaModelo.get(0);
						}
						
						ja_anios = ja_modelos.getJSONObject(j).getJSONArray("years");
						
						for (int k = 0; k < ja_anios.length(); k++) {
							Long id_modelo_anio;
							ModeloAnio ma;
							
							int anio = ja_anios.getJSONObject(k).getInt("year");
							
							id_modelo_anio = ja_anios.getJSONObject(k).getLong("id");
							
							//System.out.println("\t" + String.valueOf(id_modelo_anio) + " year " + str_anio);
							
							ma = ModeloAnio.getById(conn, id_modelo_anio.toString());
							
							if (ma == null) {
								ma = new ModeloAnio();
								
								ma.set_id(id_modelo_anio);
								ma.set_anio(anio);
								ma.set_id_modelo(modelo.get_id());
								
								ma.insert(conn);
							
							}
	
				        	// leo archivo de datos de mantenciones
				        	
				        	// data = Util.getFileContent(System.getProperty("data_directory") + "/toyota_yaris_2010_maintenance.json");
							
							Thread.sleep(100);
							
							data = Util.sendGet("https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=" + id_modelo_anio.toString() + "&fmt=json&api_key=7b2c2ymje3mz2h8q8r9t4cp8");
							
							//System.out.println("Response:" + data);
				        	
				        	jo_data = new JSONObject(data);
				        	
				        	JSONArray ja_mantencion = jo_data.getJSONArray("actionHolder");
				        	
				        	//listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
				        	
							for (int l = 0; l < ja_mantencion.length(); l++) {
								MantencionBase mb;
								
								Long id_mantencion_base = ja_mantencion.getJSONObject(l).getLong("id");
								
								//System.out.println(str_marca);
								
					        	mb = MantencionBase.getById(conn, id_mantencion_base.toString());
					        	
					        	if (mb == null) {
					        		mb = new MantencionBase();
					        		
					        		mb.set_id(id_mantencion_base);
					        		mb.set_id_modelo_anio(id_modelo_anio);
					        		mb.set_km_entre_mantenciones(ja_mantencion.getJSONObject(l).getInt("intervalMileage"));
					        		try {
										mb.set_dias_entre_mantenciones(ja_mantencion.getJSONObject(l).getInt("intervalMonth"));
									} catch (Exception e) {
										// TODO Auto-generated catch block
										//e.printStackTrace();
									}
					        		mb.set_accion(ja_mantencion.getJSONObject(l).getString("action"));
					        		mb.set_item(ja_mantencion.getJSONObject(l).getString("item"));
					        		mb.set_descripcion_item(ja_mantencion.getJSONObject(l).getString("itemDescription"));
					        		mb.set_tipo_traccion(ja_mantencion.getJSONObject(l).getString("driveType"));
					        		mb.set_tipo_transmision(ja_mantencion.getJSONObject(l).getString("transmissionCode"));
					        		mb.set_codigo_motor(ja_mantencion.getJSONObject(l).getString("engineCode"));
					        		
					        		mb.insert(conn);
					        	}
	
							} // end for mantenciones
							


							// leo archivo de datos de estilos
				        	
				        	// data = Util.getFileContent(System.getProperty("data_directory") + "/toyota_yaris_2010_maintenance.json");
							
							Thread.sleep(100);
							
							System.out.println("Consultando estilos");
							
							data = Util.sendGet("https://api.edmunds.com/api/vehicle/v2/" + ja_marcas.getJSONObject(i).getString("niceName") + "/" + ja_modelos.getJSONObject(j).getString("niceName") + "/" + String.valueOf(anios) + "/styles?fmt=json&api_key=7b2c2ymje3mz2h8q8r9t4cp8&view=full");
							
							System.out.println("Leidos " + data.length() + " bytes");
				        	
				        	jo_data = new JSONObject(data);
				        	
				        	JSONArray ja_estilo = jo_data.getJSONArray("styles");
				        	
				        	//listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
				        	
							for (int l = 0; l < ja_estilo.length(); l++) {
								Estilo estilo;
								Motor motor;
								JSONObject jo_motor;
								
								Long id_estilo = ja_estilo.getJSONObject(l).getLong("id");
								
								//System.out.println(str_marca);
								
					        	estilo = Estilo.getById(conn, id_estilo.toString());
					        	
					        	if (estilo == null) {
					        		JSONObject jo_mpg;
					        		estilo = new Estilo();
					        		
					        		try {
										jo_mpg = ja_estilo.getJSONObject(l).getJSONObject("MPG");

						        		estilo.set_rendimiento_ciudad(Short.decode(jo_mpg.getString("city")));
						        		estilo.set_rendimiento_carretera(Short.decode(jo_mpg.getString("highway")));
					        		} catch (Exception e) {
										// TODO Auto-generated catch block
										//e.printStackTrace();
									}
					        		
					        		estilo.set_id(id_estilo);
					        		estilo.set_id_modelo_anio(id_modelo_anio);
					        		estilo.set_traccion(ja_estilo.getJSONObject(l).getString("drivenWheels"));
					        		estilo.set_puertas(Byte.decode(ja_estilo.getJSONObject(l).getString("numOfDoors")));
					        		estilo.set_nombre(ja_estilo.getJSONObject(l).getString("name"));
					        		
					        		estilo.insert(conn);
					        	}
					        	
					        	jo_motor = ja_estilo.getJSONObject(l).getJSONObject("engine");
					        	
					        	String codigo = jo_motor.getString("code");
					        	
					        	motor = Motor.getByCodigo(conn, codigo);
					        	
					        	if (motor == null) {
					        		motor = new Motor();
					        		
					        		motor.set_id(Long.decode(jo_motor.getString("id")));
					        		motor.set_codigo(jo_motor.getString("code"));
					        		motor.set_razon_compresion(String.valueOf(jo_motor.getDouble("compressionRatio")));
					        		motor.set_cilindros((byte) jo_motor.getInt("cylinder"));
					        		motor.set_tamanio(String.valueOf(jo_motor.getDouble("size")));
					        		try {
										motor.set_desplazamiento(jo_motor.getInt("displacement"));
									} catch (Exception e1) {
										// TODO Auto-generated catch block
										//e1.printStackTrace();
									}
					        		motor.set_configuracion(jo_motor.getString("configuration"));
					        		motor.set_tipo_combustible(jo_motor.getString("fuelType"));
					        		motor.set_potencia(jo_motor.getInt("horsepower"));
					        		motor.set_torque(jo_motor.getInt("torque"));
					        		motor.set_valvulas((byte) jo_motor.getInt("totalValves"));
					        		try {
										motor.set_codigo_fabricante(jo_motor.getString("manufacturerEngineCode"));
									} catch (Exception e) {
										// TODO Auto-generated catch block
										//e.printStackTrace();
									}
					        		motor.set_tipo(jo_motor.getString("type"));
					        		motor.set_tipo_compresor(jo_motor.getString("compressorType"));
					        		motor.set_id_modelo_anio(id_modelo_anio);
					        		
					        		motor.insert(conn);
					        	}
	
							} // end for mantenciones
							
							
							
							
						} // end for anios
					} // end for modelos
					
					/*
					Usuario uc = Usuario.getByEmail(m_conn, correo);
					
					Contacto ct = new Contacto();
					
					ct.set_id_usuario(m_usuario.get_id());
					ct.set_relacion(relacion);
					ct.set_correo(correo);
					
					if (uc != null) {
						
						ct.set_id_usuario_contacto(uc.get_id());
					}
					else {
						// si el contacto no esta registrado, no tengo id_usuario... me quedo con correo
					}
					
					ct.insert(m_conn);
					*/
				} // end for marcas
        	} // end for anio
			/*
        	// leo archivo de datos de mantenciones
        	
        	data = Util.getFileContent(System.getProperty("data_directory") + "/toyota_yaris_2010_maintenance.json");
        	
        	jo_data = new JSONObject(data);
        	
        	JSONArray ja_mantencion = jo_data.getJSONArray("actionHolder");
        	
        	//listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
        	
			for (int i = 0; i < ja_mantencion.length(); i++) {
				MantencionBase mb;
				
				Long id_mantencion_base = ja_mantencion.getJSONObject(i).getLong("id");
				
				//System.out.println(str_marca);
				
	        	mb = MantencionBase.getById(conn, id_mantencion_base.toString());
	        	
	        	if (mb == null) {
	        		mb = new MantencionBase();
	        		
	        		mb.set_id(id_mantencion_base);
	        		mb.set_id_modelo_anio(100529009L); // Toyota Yaris 2010
	        		mb.set_km_entre_mantenciones(ja_mantencion.getJSONObject(i).getInt("intervalMileage"));
	        		try {
						mb.set_dias_entre_mantenciones(ja_mantencion.getJSONObject(i).getInt("intervalMonth"));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						//e.printStackTrace();
					}
	        		mb.set_accion(ja_mantencion.getJSONObject(i).getString("action"));
	        		mb.set_item(ja_mantencion.getJSONObject(i).getString("item"));
	        		mb.set_descripcion_item(ja_mantencion.getJSONObject(i).getString("itemDescription"));
	        		mb.set_tipo_traccion(ja_mantencion.getJSONObject(i).getString("driveType"));
	        		mb.set_tipo_transmision(ja_mantencion.getJSONObject(i).getString("transmissionCode"));
	        		mb.set_codigo_motor(ja_mantencion.getJSONObject(i).getString("engineCode"));
	        		
	        		mb.insert(conn);
	        	}

			}
        	*/
        	
    		conn.close();
    		
        	

        }
		catch(JSONException ex) {
			logger.debug("JSONException: " + ex.getMessage());
			ex.printStackTrace();
		}
		catch (ClassNotFoundException ex) {
			logger.debug("ClassNotFoundException: " + ex.getMessage());
			ex.printStackTrace();
		}
		catch(InvalidFileFormatException ex) {
			logger.debug("InvalidFileFormatException: " + ex.getMessage());
			ex.printStackTrace();
		}
		catch (IOException ex) {
			logger.debug("IOException: " + ex.getMessage());
			ex.printStackTrace();
		}
		catch (SQLException ex) {
			// TODO Auto-generated catch block
			
        	logger.debug("SQLException: " + ex.getMessage());
        	logger.debug("SQLState: " + ex.getSQLState());
        	logger.debug("VendorError: " + ex.getErrorCode());
			ex.printStackTrace();
			
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} 
        catch (Exception ex) {
        	logger.debug("Exception: " + ex.getMessage());
        	ex.printStackTrace();
        }
	}

}
