import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.AbstractMap.SimpleEntry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;
import org.joda.time.DateTime;
import org.joda.time.Months;
import org.json.JSONException;
import org.json.JSONObject;

import cl.dsoft.car.misc.UnsupportedParameterException;
import cl.dsoft.car.server.db.Campania;
import cl.dsoft.car.server.db.CampaniaUsuario;
import cl.dsoft.car.server.db.Comuna;
import cl.dsoft.car.server.db.Log;
import cl.dsoft.car.server.db.Marca;
import cl.dsoft.car.server.db.Modelo;
import cl.dsoft.car.server.db.Pais;
import cl.dsoft.car.server.db.Provincia;
import cl.dsoft.car.server.db.ProvinciaComuna;
import cl.dsoft.car.server.db.Region;
import cl.dsoft.car.server.db.RevisionTecnica;
import cl.dsoft.car.server.db.SeguroVehiculo;
import cl.dsoft.car.server.db.Usuario;
import cl.dsoft.car.server.db.UsuarioInfo;
import cl.dsoft.car.server.db.Util;
import cl.dsoft.car.server.db.Vehiculo;
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
public class GeneraInformeMensual {

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
	
	
	public GeneraInformeMensual() {
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
			
			String strDate = Util.getDateFromServer(conn);

			System.out.println(String.format("strDate '%s'", strDate));
			
			Pattern p = Pattern.compile("(\\d+)-(\\d+)-(\\d+)\\s(\\d+):(\\d+):(\\d+)");
			//Pattern p = Pattern.compile("(\\d+)");
			
			Matcher m = p.matcher(strDate);
			//Matcher m = p.matcher("2015");
			
			if (m.find()) {
				String strOutput;
			
				System.out.println(m.toString());
				
				int dia_actual = Integer.valueOf(m.group(3));
				int mes_actual = Integer.valueOf(m.group(2));
				int anio_actual = Integer.valueOf(m.group(1));
				int mes_proximo = (mes_actual + 1) % 12;
				
				//System.out.println(String.format("day %d month %d", dia_actual, mes_actual));
	
				// conn.setAutoCommit(false);
				listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
				
				listParameters.add(new SimpleEntry<String, String>("no borrado", ""));
				//listParameters.add(new SimpleEntry<String, String>("sin posicion", ""));
				
				listUsuario = Usuario.seek(conn, listParameters, null, null, 0, 10000);
				
				int count = 0;
				for (Usuario usuario : listUsuario) {
					
					count++;
					
					if (count == 12) {
						break;
					}
					
					boolean flag;
					ArrayList<Vehiculo> listV;
					
					listV = usuario.getVehiculos(conn);
					
					strOutput = "";
					
					System.out.println(String.format("id_usuario %d", usuario.getId()));
					
					// promocion de fidelizacion
					
					// revision tecnica alerta (proximo mes)
					for (Vehiculo v : listV) {
						System.out.println(String.format("revision tecnica alerta (proximo mes) id_usuario %d id_vehiculo %d", usuario.getId(), v.getIdVehiculo()));
						if (v.getPatente() != null) {
							if (v.getPatente().trim().length() > 0) {
								String strDigito = v.getPatente().trim().substring(v.getPatente().trim().length() - 1);
								System.out.println(String.format("strDigito '%s'", strDigito));
								if (strDigito.matches("\\d")) {
									int digito = Integer.valueOf(strDigito);
									
									Marca marca = v.getMarca(conn);
									Modelo modelo = v.getModelo(conn); 
									
									RevisionTecnica rt = RevisionTecnica.getByParameter(conn, "digito", String.valueOf(digito));
									
									if (rt != null) {
										if (rt.getMes() == mes_proximo) {
											// revision tecnica proximo mes
											strOutput += String.format(
												"<p>Te recordamos que de acuerdo al calendario de Revisi&oacute;n T&eacute;cnica vigente, el pr&oacute;ximo mes deber&aacute;s llevar tu veh&iacute;culo %s %s a&ntilde;o %d patente %s a realizar este tr&aacute;mite</p>", 
												marca.getDescripcion(),
												modelo.getDescripcion(),
												v.getAnio(),
												v.getPatente());
										}
									}
								}
								else {
									System.out.println(String.format("no es numero '%s'", strDigito));
								}
							}
						}
					}
					
					// revision tecnica alarma (este mes)
					for (Vehiculo v : listV) {
						System.out.println(String.format("revision tecnica alarma (este mes) id_usuario %d id_vehiculo %d", usuario.getId(), v.getIdVehiculo()));
						Marca marca = v.getMarca(conn);
						Modelo modelo = v.getModelo(conn); 

						flag = false;
						if (v.getPatente() != null) {
							if (v.getPatente().trim().length() > 0) {
								String strDigito = v.getPatente().trim().substring(v.getPatente().trim().length() - 1);
								System.out.println(String.format("strDigito '%s'", strDigito));
								if (strDigito.matches("\\d")) {
									flag = true;
									int digito = Integer.valueOf(strDigito);
									
									RevisionTecnica rt = RevisionTecnica.getByParameter(conn, "digito", String.valueOf(digito));
									
									if (rt != null) {
										if (rt.getMes() == mes_actual) {
											// revision tecnica este mes
											strOutput += String.format(
												"<p>Te recordamos que de acuerdo al calendario de Revisi&oacute;n T&eacute;cnica vigente, este mes deber&aacute;s llevar tu veh&iacute;culo %s %s a&ntilde;o %d patente %s a realizar este tr&aacute;mite.</p>", 
												marca.getDescripcion(),
												modelo.getDescripcion(),
												v.getAnio(),
												v.getPatente());
										}
									}
								}
								else {
									System.out.println(String.format("no es numero '%s'", strDigito));
								}
							}
						}
						
						if (!flag) {
							strOutput += String.format(
									"<p>Te invitamos a ingresar o corregir en la aplicaci&oacute; la patente de tu veh&iacute;culo %s %s a&ntilde;o %d para que podamos avisarte en qu&eacute; mes tienes que llevarlo a la Revisi&oacute;n T&eacute;cnica.", 
									marca.getDescripcion(),
									modelo.getDescripcion(),
									v.getAnio());

							RevisionTecnica rt = RevisionTecnica.getByParameter(conn, "mes", String.valueOf(mes_actual));
							
							if (rt != null) {
								strOutput += String.format(
									" Este mes corresponde a los veh&iacute;culos cuyas patentes terminan en %d.", 
									rt.getDigito());
							}
						
							strOutput += "</p>";
						}
					}
					
					// seguro 
					for (Vehiculo v : listV) {
						System.out.println(String.format("seguro id_usuario %d id_vehiculo %d", usuario.getId(), v.getIdVehiculo()));
						Marca marca = v.getMarca(conn);
						Modelo modelo = v.getModelo(conn); 
						ArrayList<SeguroVehiculo> listSV = v.getSeguroVehiculos(conn);
						
						for (SeguroVehiculo sv : listSV) {
							Pattern pfv = Pattern.compile("(\\d+)-(\\d+)-(\\d+)");
							//Pattern p = Pattern.compile("(\\d+)");
							
							Matcher mfv = p.matcher(sv.getFechaVencimiento());
							
							if (mfv.find()) {
							
								System.out.println(mfv.toString());
								
								int dia_vencimiento = Integer.valueOf(m.group(3));
								int mes_vencimiento = Integer.valueOf(m.group(2));
								
								if (mes_vencimiento == mes_proximo) {
									
									strOutput += String.format(
											"<p>Te recordamos que el d&iacute;a %d del pr&oacute;ximo mes vence la p&oacute;liza %s de %s de tu veh&iacute;culo %s %s a&ntilde;o %d.</p>",
											dia_vencimiento,
											sv.getPoliza(),
											sv.getCiaSeguros(conn).getNombre(),
											marca.getDescripcion(),
											modelo.getDescripcion(),
											v.getAnio());
								}
								else if (mes_vencimiento == mes_actual) {
									
									strOutput += String.format(
											"<p>Te recordamos que el d&iacute;a %d de este mes vence la p&oacute;liza %s de %s de tu veh&iacute;culo %s %s a&ntilde;o %d.</p>",
											dia_vencimiento,
											sv.getPoliza(),
											sv.getCiaSeguros(conn).getNombre(),
											marca.getDescripcion(),
											modelo.getDescripcion(),
											v.getAnio());
								}
							}
						}
					}
					
					// proximas mantenciones
					
					// gasto mensual
					
					if (strOutput.length() > 0) {
				    	Date dInicial, dFinal;
				    	DateTime dtInicial, dtFinal;

				    	// programo notificacion
						System.out.println(strOutput);
						
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		        		
		    			dInicial = formatter.parse(String.format("%04d-%02d-%02d", anio_actual, mes_actual, dia_actual)); // dia de hoy
		    			
		    			dtInicial = new DateTime(dInicial);
		    			
		    			dtFinal = dtInicial.plusDays(7);

						Campania c = new Campania();
						
						c.setFechaInicio(dtInicial.toDate());
						c.setFechaFin(dtFinal.toDate());
						c.setDetalle("foo");
						c.setDescripcion(String.format("InformeMensual id_usuario %d %s", usuario.getId(), strDate));
						c.setManual(false);
						c.setNumeroImpresiones((short) 1);
						c.setPeriodicidad((short) 1);
						
						c.insert(conn);
						
						String strDetalle = String.format(GeneraInformeMensual.strDetalleCampania, 
							c.getDescripcion(),
							c.getDescripcion(),
							c.getDescripcion(),
							c.getId(),
							c.getId(),
							"Informe Mensual " + strDate,
							strOutput
							);
						
						c.setDetalle(strDetalle);
						
						c.update(conn);
						
						CampaniaUsuario cu = new CampaniaUsuario();
						
						cu.setIdCampania(c.getId());
						cu.setIdUsuario(usuario.getId());
						
						cu.insert(conn);
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
		}

	}

}
