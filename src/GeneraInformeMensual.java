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
import cl.dsoft.car.misc.UnsupportedParameterException;
import cl.dsoft.car.server.db.Campania;
import cl.dsoft.car.server.db.CampaniaUsuario;
import cl.dsoft.car.server.db.CargaCombustible;
import cl.dsoft.car.server.db.Comuna;
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
import cl.dsoft.car.server.db.RevisionTecnica;
import cl.dsoft.car.server.db.SeguroVehiculo;
import cl.dsoft.car.server.db.Usuario;
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
		
		TreeMap<String, MantencionBaseHechaModelo> treeMapMBHMFecha;  
		
		TreeMap<Integer, MantencionBaseHechaModelo> treeMapMBHMKm;

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
				String strOutput;
			
				//System.out.println(m.toString());
				
				int diaActual = Integer.valueOf(m.group(3));
				int mesActual = Integer.valueOf(m.group(2));
				int anioActual = Integer.valueOf(m.group(1));
				
				DateTime dtNow = new DateTime(anioActual, mesActual, diaActual, 0, 0);
				
				DateTime dtNextMonth = dtNow.plusMonths(1);
				
				DateTime dtPrevMonth = dtNow.plusMonths(-1);
				
				int mesProximo = dtNextMonth.getMonthOfYear();
				int mesAnterior = dtPrevMonth.getMonthOfYear();
				
				String nombreMesActual = new DateFormatSymbols(new Locale("es")).getMonths()[mesActual - 1];
				String nombreMesAnterior = new DateFormatSymbols(new Locale("es")).getMonths()[mesAnterior - 1];
				String nombreMesProximo = new DateFormatSymbols(new Locale("es")).getMonths()[mesProximo - 1];
				
				
				int anioProximo = dtNextMonth.getYear();
				int anioAnterior = dtPrevMonth.getYear();
				
				//System.out.println(String.format("day %d month %d", diaActual, mesActual));
				
				treeMapMBHMFecha = new TreeMap<String, MantencionBaseHechaModelo>();  
				
				treeMapMBHMKm = new TreeMap<Integer, MantencionBaseHechaModelo>();

	
				// conn.setAutoCommit(false);
				listParameters = new ArrayList<AbstractMap.SimpleEntry<String, String>>();
				
				listParameters.add(new SimpleEntry<String, String>("no borrado", ""));
				listParameters.add(new SimpleEntry<String, String>("id_usuario_in", "1,3,4,5,11,86,102,1634"));
				//listParameters.add(new SimpleEntry<String, String>("id_usuario", "102"));
				
				listUsuario = Usuario.seek(conn, listParameters, null, null, 0, 10000);
				
				int countUsuario = 0;
				int count;
				
				for (Usuario usuario : listUsuario) {
					
					countUsuario++;
					
					if (countUsuario == 100) {
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
						if (v.getBorrado()) {
							continue;
						}
						
						//System.out.println(String.format("revision tecnica alerta (proximo mes) id_usuario %d id_vehiculo %d", usuario.getId(), v.getIdVehiculo()));
						if (v.getPatente() != null) {
							if (v.getPatente().trim().length() > 0) {
								String strDigito = v.getPatente().trim().substring(v.getPatente().trim().length() - 1);
								//System.out.println(String.format("strDigito '%s'", strDigito));
								if (strDigito.matches("\\d")) {
									int digito = Integer.valueOf(strDigito);
									
									Marca marca = v.getMarca(conn);
									Modelo modelo = v.getModelo(conn); 
									
									RevisionTecnica rt = RevisionTecnica.getByParameter(conn, "digito", String.valueOf(digito));
									
									if (rt != null) {
										if (rt.getMes() == mesProximo) {
											// revision tecnica proximo mes
											strOutput += String.format(
												"<p>Te recordamos que de acuerdo al calendario de Revisi&oacute;n T&eacute;cnica vigente, el pr&oacute;ximo mes de %s deber&aacute;s llevar tu veh&iacute;culo %s %s a&ntilde;o %d patente %s a realizar este tr&aacute;mite</p>",
												nombreMesProximo, 
												marca.getDescripcion(),
												modelo.getDescripcion(),
												v.getAnio(),
												v.getPatente());
										}
									}
								}
								else {
									//System.out.println(String.format("no es numero '%s'", strDigito));
								}
							}
						}
					}
					
					
					// revision tecnica alarma (este mes)
					for (Vehiculo v : listV) {
						if (v.getBorrado()) {
							continue;
						}

						//System.out.println(String.format("revision tecnica alarma (este mes) id_usuario %d id_vehiculo %d", usuario.getId(), v.getIdVehiculo()));
						Marca marca = v.getMarca(conn);
						Modelo modelo = v.getModelo(conn); 

						flag = false;
						if (v.getPatente() != null) {
							if (v.getPatente().trim().length() > 0) {
								String strDigito = v.getPatente().trim().substring(v.getPatente().trim().length() - 1);
								//System.out.println(String.format("strDigito '%s'", strDigito));
								if (strDigito.matches("\\d")) {
									flag = true;
									int digito = Integer.valueOf(strDigito);
									
									RevisionTecnica rt = RevisionTecnica.getByParameter(conn, "digito", String.valueOf(digito));
									
									if (rt != null) {
										if (rt.getMes() == mesActual) {
											// revision tecnica este mes
											strOutput += String.format(
												"<p>Te recordamos que de acuerdo al calendario de Revisi&oacute;n T&eacute;cnica vigente, este mes de %s deber&aacute;s llevar tu veh&iacute;culo %s %s a&ntilde;o %d patente %s a realizar este tr&aacute;mite.</p>",
												nombreMesActual, 
												marca.getDescripcion(),
												modelo.getDescripcion(),
												v.getAnio(),
												v.getPatente());
										}
									}
								}
								else {
									//System.out.println(String.format("no es numero '%s'", strDigito));
								}
							}
						}
						
						if (!flag) {
							strOutput += String.format(
									"<p>Te invitamos a ingresar o corregir en la aplicaci&oacute;n la patente de tu veh&iacute;culo %s %s a&ntilde;o %d para que podamos avisarte en qu&eacute; mes tienes que llevarlo a la Revisi&oacute;n T&eacute;cnica.", 
									marca.getDescripcion(),
									modelo.getDescripcion(),
									v.getAnio());

							RevisionTecnica rt = RevisionTecnica.getByParameter(conn, "mes", String.valueOf(mesActual));
							
							if (rt != null) {
								strOutput += String.format(
									" Este mes de %s corresponde a los veh&iacute;culos cuyas patentes terminan en %d.",
									nombreMesActual,
									rt.getDigito());
							}
						
							strOutput += "</p>";
						}
					}
					
					
					// seguro 
					for (Vehiculo v : listV) {
						if (v.getBorrado()) {
							continue;
						}

						//System.out.println(String.format("seguro id_usuario %d id_vehiculo %d", usuario.getId(), v.getIdVehiculo()));
						Marca marca = v.getMarca(conn);
						Modelo modelo = v.getModelo(conn); 
						ArrayList<SeguroVehiculo> listSV = v.getSeguroVehiculos(conn);
						
						for (SeguroVehiculo sv : listSV) {
							Pattern pfv = Pattern.compile("(\\d+)-(\\d+)-(\\d+)");
							//Pattern p = Pattern.compile("(\\d+)");
							
							Matcher mfv = p.matcher(sv.getFechaVencimiento());
							
							if (mfv.find()) {
							
								//System.out.println(mfv.toString());
								
								int dia_vencimiento = Integer.valueOf(m.group(3));
								int mes_vencimiento = Integer.valueOf(m.group(2));
								
								if (mes_vencimiento == mesProximo) {
									
									strOutput += String.format(
											"<p>Te recordamos que el d&iacute;a %d del pr&oacute;ximo de %s mes vence la p&oacute;liza %s de %s de tu veh&iacute;culo %s %s a&ntilde;o %d.</p>",
											dia_vencimiento,
											nombreMesProximo,
											sv.getPoliza(),
											sv.getCiaSeguros(conn).getNombre(),
											marca.getDescripcion(),
											modelo.getDescripcion(),
											v.getAnio());
								}
								else if (mes_vencimiento == mesActual) {
									
									strOutput += String.format(
											"<p>Te recordamos que el d&iacute;a %d de este mes de %s vence la p&oacute;liza %s de %s de tu veh&iacute;culo %s %s a&ntilde;o %d.</p>",
											dia_vencimiento,
											nombreMesActual,
											sv.getPoliza(),
											sv.getCiaSeguros(conn).getNombre(),
											marca.getDescripcion(),
											modelo.getDescripcion(),
											v.getAnio());
								}
							}
						}
					}
					
					/*
					// proximas 3 mantenciones por cada vehiculo
					for (Vehiculo v : listV) {
						if (v.getBorrado()) {
							continue;
						}

						VehiculoModelo vm = new VehiculoModelo(conn, v);
						
						ArrayList<MantencionBaseHechaModelo> listMBH = vm.getMantencionesBasePendientes(conn);
						
						// obtengo las proximas mantenciones por fecha
						treeMapMBHMFecha.clear();
						
						for (MantencionBaseHechaModelo mbh : listMBH) {

							if (mbh.getFecha() != null) {
								if (mbh.getFecha().compareTo(strDateNow) > 0) {
									treeMapMBHMFecha.put(mbh.getFecha(), mbh);
								}
							}
							
						}

						// obtengo las proximas mantenciones por kilometraje
						treeMapMBHMKm.clear();
						
						for (MantencionBaseHechaModelo mbh : listMBH) {
							
							if (mbh.getKm() != null) {
								if (mbh.getKm() > v.getKm()) {
									treeMapMBHMKm.put(mbh.getKm(), mbh);
								}
							}
							
						}

						// trato de seleccionar 3 mantenciones, priorizando por km
						if (treeMapMBHMFecha.size() > 0 || treeMapMBHMKm.size() > 0) {
							
							Marca marca = v.getMarca(conn);
							Modelo modelo = v.getModelo(conn); 

							strOutput += String.format(
								"<H2>Pr&oacute;ximas Mantenciones de tu veh&iacute;culo %s %s a&ntilde;o %d.</H2>",
								marca.getDescripcion(),
								modelo.getDescripcion(),
								v.getAnio());
						}
						
						count = 0;
						
						for(Map.Entry<Integer, MantencionBaseHechaModelo> tmk : treeMapMBHMKm.entrySet()) {
							Integer key = tmk.getKey();
							MantencionBaseHechaModelo mbh = tmk.getValue();
							
							count++;

							//System.out.println(key + " => " + p);
							
							// formo las 3 mantenciones con 2 por km y 1  por fecha
							if (treeMapMBHMFecha.size() > 0 && count > 2) {
								break;
							}
							else if (treeMapMBHMFecha.size() == 0 && count > 3) {
								break;
							}
							
							MantencionBase mb = MantencionBase.getById(conn, String.valueOf(mbh.getIdMantencionBase()));
							
							strOutput += String.format(
								"<p>%s a los %d Km.</p>",
								mb.getNombre(),
								mbh.getKm());
							
						}
						
						for(Map.Entry<String, MantencionBaseHechaModelo> tmf : treeMapMBHMFecha.entrySet()) {
							String key = tmf.getKey();
							MantencionBaseHechaModelo mbh = tmf.getValue();
							
							count++;

							//System.out.println(key + " => " + p);
							
							// completo hasta llegar a 3 mantenciones
							if (count > 3) {
								break;
							}
							
							MantencionBase mb = MantencionBase.getById(conn, String.valueOf(mbh.getIdMantencionBase()));
							
							strOutput += String.format(
								"<p>%s el día %s.</p>",
								mb.getNombre(),
								mbh.getFecha());
							
						}
					}
					*/
					
					// gasto mensual
					for (Vehiculo v : listV) {
						if (v.getBorrado()) {
							continue;
						}
						
						int gasto_mantencion = 0;
						int gasto_combustible = 0;
						
						// obtengo principio de mes anterior
						String comienzoMesAnterior = String.format("%04d-%02d-01", anioActual, mesAnterior);
						
						// obtengo principio de este mes
						String comienzoMesActual = String.format("%04d-%02d-01", anioActual, mesActual);

						ArrayList<MantencionBaseHecha> listMBH = v.getMantencionBaseHechas(conn);
						
						for (MantencionBaseHecha mbh : listMBH) {
							
							if (mbh.getFecha().compareTo(comienzoMesAnterior) >= 0 && mbh.getFecha().compareTo(comienzoMesActual) < 0) {
								gasto_mantencion += mbh.getCosto();
							}
						}

						ArrayList<CargaCombustible> listCC = v.getCargaCombustibles(conn);
						
						for (CargaCombustible cc : listCC) {
							
							// ******** EXISTE BUG EN APP MOVIL, fecha queda en NULL cuando estanque_lleno = true
							if (cc.getFecha() != null) {
								if (cc.getFecha().compareTo(comienzoMesAnterior) >= 0 && cc.getFecha().compareTo(comienzoMesActual) < 0) {
									gasto_combustible += cc.getCosto();
								}
							}
						}

						Marca marca = v.getMarca(conn);
						Modelo modelo = v.getModelo(conn);
						
						if (gasto_combustible > 0 || gasto_mantencion > 0) {

							strOutput += String.format(
								"<H2>Gastos de %s de %d de tu veh&iacute;culo %s %s a&ntilde;o %d.</H2>",
								nombreMesAnterior,
								anioActual,
								marca.getDescripcion(),
								modelo.getDescripcion(),
								v.getAnio());
							
							if (gasto_mantencion > 0) {
								
								strOutput += String.format(
										"<p>En mantenciones: $%d.</p>",
										gasto_mantencion);
							}
							// ************* EXISTE BUG EN APP MOVIL, fecha queda en NULL cuando estanque_lleno = true
							if (gasto_combustible > 0) {
								
								strOutput += String.format(
										"<p>En combustible: $%d.</p>",
										gasto_combustible);
							}
							
						}
					
					}
					
					System.out.println(strOutput);
					
					// grabo notificacion
					if (strOutput.length() > 0) {
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
						c.setDescripcion(String.format("InformeMensual id_usuario %d, %s", usuario.getId(), nombreMesActual + " " + String.valueOf(anioActual)));
						c.setManual(false);
						c.setActiva(true);
						c.setNumeroImpresiones((short) 1);
						c.setPeriodicidad((short) 1);
						
						System.out.println(c.toString());
						
						c.insert(conn);
						
						String strDetalle = String.format(GeneraInformeMensual.strDetalleCampania, 
							c.getDescripcion(),
							c.getDescripcion(),
							c.getDescripcion(),
							c.getId(),
							c.getId(),
							"Informe Mensual MiAuto" + nombreMesActual + " " + String.valueOf(anioActual),
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
