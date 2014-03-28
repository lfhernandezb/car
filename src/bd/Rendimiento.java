/**
 * 
 */
package bd;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.AbstractMap;
import java.util.ArrayList;

/**
 * @author petete-ntbk
 *
 */
public class Rendimiento {
    private Long _id_rendimiento;
    private Long _id_usuario;
    private Long _id_vehiculo;
    private Integer _km;
    private Integer _litros;
    private Boolean _estanque_lleno;
    private Integer _costo;
    private Integer _latitud;
    private Integer _longitud;
    private String _fecha;

    private final static String _str_sql = 
        "    SELECT " +
        "    id_rendimiento, " +
        "    id_usuario, " +
        "    id_vehiculo, " +
        "    km, " +
        "    litros, " +
        "    0+estanque_lleno AS estanque_lleno, " +
        "    costo, " +
        "    latitud, " +
        "    longitud, " +
        "    DATE_FORMAT(re.fecha, '%d-%m-%Y %H:%i:%s') AS fecha " +
        "    FROM rendimiento re ";

    public Rendimiento() {
        _id_rendimiento = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _km = null;
        _litros = null;
        _estanque_lleno = null;
        _costo = null;
        _latitud = null;
        _longitud = null;
        _fecha = null;

    }

    /**
     * @return the _id_rendimiento
     */
    public Long get_id_rendimiento() {
        return _id_rendimiento;
    }
    /**
     * @return the _id_usuario
     */
    public Long get_id_usuario() {
        return _id_usuario;
    }
    /**
     * @return the _id_vehiculo
     */
    public Long get_id_vehiculo() {
        return _id_vehiculo;
    }
    /**
     * @return the _km
     */
    public Integer get_km() {
        return _km;
    }
    /**
     * @return the _litros
     */
    public Integer get_litros() {
        return _litros;
    }
    /**
     * @return the _estanque_lleno
     */
    public Boolean get_estanque_lleno() {
        return _estanque_lleno;
    }
    /**
     * @return the _costo
     */
    public Integer get_costo() {
        return _costo;
    }
    /**
     * @return the _latitud
     */
    public Integer get_latitud() {
        return _latitud;
    }
    /**
     * @return the _longitud
     */
    public Integer get_longitud() {
        return _longitud;
    }
    /**
     * @return the _fecha
     */
    public String get_fecha() {
        return _fecha;
    }

    /**
     * @param _id_rendimiento the _id_rendimiento to set
     */
    public void set_id_rendimiento(Long _id_rendimiento) {
        this._id_rendimiento = _id_rendimiento;
    }
    /**
     * @param _id_usuario the _id_usuario to set
     */
    public void set_id_usuario(Long _id_usuario) {
        this._id_usuario = _id_usuario;
    }
    /**
     * @param _id_vehiculo the _id_vehiculo to set
     */
    public void set_id_vehiculo(Long _id_vehiculo) {
        this._id_vehiculo = _id_vehiculo;
    }
    /**
     * @param _km the _km to set
     */
    public void set_km(Integer _km) {
        this._km = _km;
    }
    /**
     * @param _litros the _litros to set
     */
    public void set_litros(Integer _litros) {
        this._litros = _litros;
    }
    /**
     * @param _estanque_lleno the _estanque_lleno to set
     */
    public void set_estanque_lleno(Boolean _estanque_lleno) {
        this._estanque_lleno = _estanque_lleno;
    }
    /**
     * @param _costo the _costo to set
     */
    public void set_costo(Integer _costo) {
        this._costo = _costo;
    }
    /**
     * @param _latitud the _latitud to set
     */
    public void set_latitud(Integer _latitud) {
        this._latitud = _latitud;
    }
    /**
     * @param _longitud the _longitud to set
     */
    public void set_longitud(Integer _longitud) {
        this._longitud = _longitud;
    }
    /**
     * @param _fecha the _fecha to set
     */
    public void set_fecha(String _fecha) {
        this._fecha = _fecha;
    }

    public static Rendimiento fromRS(ResultSet p_rs) throws SQLException {
        Rendimiento ret = new Rendimiento();

        try {
            ret.set_id_rendimiento(p_rs.getLong("id_rendimiento"));
            ret.set_id_usuario(p_rs.getLong("id_usuario"));
            ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
            ret.set_km(p_rs.getInt("km"));
            ret.set_litros(p_rs.getInt("litros"));
            ret.set_estanque_lleno(p_rs.getBoolean("estanque_lleno"));
            ret.set_costo(p_rs.getInt("costo"));
            ret.set_latitud(p_rs.getInt("latitud"));
            ret.set_longitud(p_rs.getInt("longitud"));
            ret.set_fecha(p_rs.getString("fecha"));
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());

            throw ex;
        }

        return ret;
    }

    public static Rendimiento getByParameter(Connection p_conn, String p_key, String p_value) throws Exception {
        Rendimiento ret = null;
        
        String str_sql = _str_sql +
            "  WHERE re." + p_key + " = " + p_value +
            "  LIMIT 0, 1";
        
        //System.out.println(str_sql);
        
        // assume that conn is an already created JDBC connection (see previous examples)
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = p_conn.createStatement();
            //System.out.println("stmt = p_conn.createStatement() ok");
            rs = stmt.executeQuery(str_sql);
            //System.out.println("rs = stmt.executeQuery(str_sql) ok");

            // Now do something with the ResultSet ....
            
            if (rs.next()) {
                //System.out.println("rs.next() ok");
                ret = fromRS(rs);
                //System.out.println("fromRS(rs) ok");
            }
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage() + " sentencia: " + str_sql);
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            
            throw new Exception("Error al obtener registro");
        }
        catch (Exception e){
            // handle any errors
            throw new Exception("Excepcion del tipo " + e.getClass() + " Info: " + e.getMessage());
        }
        finally {
            // it is a good idea to release
            // resources in a finally{} block
            // in reverse-order of their creation
            // if they are no-longer needed
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException sqlEx) { 
                    
                } // ignore
                rs = null;
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) {
                    
                } // ignore
                stmt = null;
            }
        }        
        
        return ret;        
    }

    public static Rendimiento getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_rendimiento", p_id);
    }
    
    public static ArrayList<Rendimiento> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Rendimiento> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Rendimiento>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_comunidad")) {
                    array_clauses.add("re.id_comunidad = " + p.getValue());
                }
                else if (p.getKey().equals("id_comuna")) {
                    array_clauses.add("re.id_comuna = " + p.getValue());
                }
                else if (p.getKey().equals("latitud_mayor")) {
                    array_clauses.add("re.latitud > " + p.getValue());
                }
                else if (p.getKey().equals("latitud_menor")) {
                    array_clauses.add("re.latitud < " + p.getValue());
                }
                else if (p.getKey().equals("longitud_mayor")) {
                    array_clauses.add("re.longitud > " + p.getValue());
                }
                else if (p.getKey().equals("longitud_menor")) {
                    array_clauses.add("re.longitud < " + p.getValue());
                }
                else if (p.getKey().equals("posicion_reciente")) {
                    array_clauses.add("re.fecha > DATE_ADD(now(), INTERVAL -" + p.getValue() + " MINUTE)");
                }
                else if (p.getKey().equals("id_distinto")) {
                    array_clauses.add("re.id_usuario <> " + p.getValue());
                }
                else {
                	throw new Exception("Parametro no soportado: " + p.getKey());
                }
            }
                                
            boolean bFirstTime = false;
            
            for(String clause : array_clauses) {
                if (!bFirstTime) {
                     bFirstTime = true;
                     str_sql += " WHERE ";
                }
                else {
                     str_sql += " AND ";
                }
                str_sql += clause;
            }
            
            if (p_order != null && p_direction != null) {
                str_sql += " ORDER BY " + p_order + " " + p_direction;
            }
            
            if (p_offset != -1 && p_limit != -1) {
                str_sql += "  LIMIT " +  Integer.toString(p_offset) + ", " + Integer.toString(p_limit);
            }
            
            //echo "<br>" . str_sql . "<br>";
        
            stmt = p_conn.createStatement();
            
            rs = stmt.executeQuery(str_sql);
            
            while (rs.next()) {
                ret.add(fromRS(rs));
            }
            /*
            if (ret.size() == 0) {
                ret = null;
            }
            */
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage() + " sentencia: " + str_sql);
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            
            throw ex;
        }
        catch (Exception ex) {
        	throw ex;
        }
        finally {
            // it is a good idea to release
            // resources in a finally{} block
            // in reverse-order of their creation
            // if they are no-longer needed
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException sqlEx) { 
                    
                } // ignore
                rs = null;
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) {
                    
                } // ignore
                stmt = null;
            }
        }        

        return ret;
    }

    public int update(Connection p_conn) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "    UPDATE rendimiento" +
            "    SET " +
            "    id_rendimiento, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    km, " +
            "    litros, " +
            "    0+estanque_lleno AS estanque_lleno, " +
            "    costo, " +
            "    latitud, " +
            "    longitud, " +
            "    DATE_FORMAT(re.fecha, '%d-%m-%Y %H:%i:%s') AS fecha " +
            "    WHERE id_rendimiento = " + Long.toString(this._id_rendimiento);
        
        try {
            stmt = p_conn.createStatement();
            
            ret = stmt.executeUpdate(str_sql);
            /*
            if (stmt.executeUpdate(str_sql) < 1) {
                throw new Exception("No hubo filas afectadas");
            }
            */
            
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage() + " sentencia: " + str_sql);
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            
            throw new Exception("Error al obtener registros");
        }
        finally {
            // it is a good idea to release
            // resources in a finally{} block
            // in reverse-order of their creation
            // if they are no-longer needed
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) {
                    
                } // ignore
                stmt = null;
            }
        }
        
        return ret;
    }
    
    public int insert(Connection p_conn) throws Exception {
        
        int ret = -1;
        Statement stmt = null;
        ResultSet rs = null;

        String str_sql =
            "    INSERT INTO rendimiento" +
            "    (" +
            "    id_rendimiento, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    km, " +
            "    litros, " +
            "    estanque_lleno, " +
            "    costo, " +
            "    latitud, " +
            "    longitud, " +
            "    fecha " +
            "    )" +
            "    VALUES" +
            "    (" +
            "    " + (_id_rendimiento != null ? _id_rendimiento.toString() : "null") + "," +
            "    " + (_id_usuario != null ? _id_usuario.toString() : "null") + "," +
            "    " + (_id_vehiculo != null ? _id_vehiculo.toString() : "null") + "," +
            "    " + (_km != null ? _km.toString() : "null") + "," +
            "    " + (_litros != null ? _litros.toString() : "null") + "," +
            "    " + (_estanque_lleno != null ? "b'" + (_estanque_lleno ? 1 : 0) + "'" : "null") + "," +
            "    " + (_costo != null ? _costo.toString() : "null") + "," +
            "    " + (_latitud != null ? _latitud.toString() : "null") + "," +
            "    " + (_longitud != null ? _longitud.toString() : "null") + "," +
            "    " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") +
            "    )";
        
        try {
            stmt = p_conn.createStatement();
            
            ret = stmt.executeUpdate(str_sql, Statement.RETURN_GENERATED_KEYS);
            /*
            if (stmt.executeUpdate(str_sql) < 1) {
                throw new Exception("No hubo filas afectadas");
            }
            */
            
            rs = stmt.getGeneratedKeys();

            if (rs.next()) {
                _id_rendimiento = rs.getLong(1);
            } else {
                // throw an exception from here
                throw new Exception("Error al obtener id");
            }

            rs.close();
            rs = null;
            System.out.println("Key returned from getGeneratedKeys():" + _id_rendimiento.toString());
                        
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage() + " sentencia: " + str_sql);
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            
            throw new Exception("Error al obtener registros");
        }
        finally {
            // it is a good idea to release
            // resources in a finally{} block
            // in reverse-order of their creation
            // if they are no-longer needed
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException sqlEx) { 
                    
                } // ignore
                rs = null;
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) {
                    
                } // ignore
                stmt = null;
            }
        }
        
        return ret;
    }
    
    public static int delete(Connection p_conn, Integer p_id_rendimiento) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "  DELETE FROM rendimiento";
        
        if (p_id_rendimiento != null) {
            str_sql +=
                "  WHERE id_rendimiento = " + p_id_rendimiento.toString();
        }
        
        try {
            stmt = p_conn.createStatement();
            
            ret = stmt.executeUpdate(str_sql);
            /*
            if (stmt.executeUpdate(str_sql) < 1) {
                throw new Exception("No hubo filas afectadas");
            }
            */
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage() + " sentencia: " + str_sql);
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            
            throw new Exception("Error al borrar registros");
        }
        finally {
            // it is a good idea to release
            // resources in a finally{} block
            // in reverse-order of their creation
            // if they are no-longer needed
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) {
                    
                } // ignore
                stmt = null;
            }
        }
        
        return ret;
    }
}