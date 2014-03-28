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
public class Log {
    private Long _id;
    private Long _id_usuario;
    private Long _id_tipo_vehiculo;
    private Long _id_marca;
    private Long _id_modelo;
    private Long _id_vehiculo;
    private Double _latitud;
    private Double _longitud;
    private String _accion;
    private String _fecha;
    private Integer _km;

    private final static String _str_sql = 
        "    SELECT " +
        "    id_log AS id, " +
        "    id_usuario, " +
        "    id_tipo_vehiculo, " +
        "    id_marca, " +
        "    id_modelo, " +
        "    id_vehiculo, " +
        "    latitud, " +
        "    longitud, " +
        "    accion, " +
        "    DATE_FORMAT(lo.fecha, '%d-%m-%Y %H:%i:%s') AS fecha, " +
        "    km " +
        "    FROM log lo ";

    public Log() {
        _id = null;
        _id_usuario = null;
        _id_tipo_vehiculo = null;
        _id_marca = null;
        _id_modelo = null;
        _id_vehiculo = null;
        _latitud = null;
        _longitud = null;
        _accion = null;
        _fecha = null;
        _km = null;

    }

    /**
     * @return the _id
     */
    public Long get_id() {
        return _id;
    }
    /**
     * @return the _id_usuario
     */
    public Long get_id_usuario() {
        return _id_usuario;
    }
    /**
     * @return the _id_tipo_vehiculo
     */
    public Long get_id_tipo_vehiculo() {
        return _id_tipo_vehiculo;
    }
    /**
     * @return the _id_marca
     */
    public Long get_id_marca() {
        return _id_marca;
    }
    /**
     * @return the _id_modelo
     */
    public Long get_id_modelo() {
        return _id_modelo;
    }
    /**
     * @return the _id_vehiculo
     */
    public Long get_id_vehiculo() {
        return _id_vehiculo;
    }
    /**
     * @return the _latitud
     */
    public Double get_latitud() {
        return _latitud;
    }
    /**
     * @return the _longitud
     */
    public Double get_longitud() {
        return _longitud;
    }
    /**
     * @return the _accion
     */
    public String get_accion() {
        return _accion;
    }
    /**
     * @return the _fecha
     */
    public String get_fecha() {
        return _fecha;
    }
    /**
     * @return the _km
     */
    public Integer get_km() {
        return _km;
    }

    /**
     * @param _id the _id to set
     */
    public void set_id(Long _id) {
        this._id = _id;
    }
    /**
     * @param _id_usuario the _id_usuario to set
     */
    public void set_id_usuario(Long _id_usuario) {
        this._id_usuario = _id_usuario;
    }
    /**
     * @param _id_tipo_vehiculo the _id_tipo_vehiculo to set
     */
    public void set_id_tipo_vehiculo(Long _id_tipo_vehiculo) {
        this._id_tipo_vehiculo = _id_tipo_vehiculo;
    }
    /**
     * @param _id_marca the _id_marca to set
     */
    public void set_id_marca(Long _id_marca) {
        this._id_marca = _id_marca;
    }
    /**
     * @param _id_modelo the _id_modelo to set
     */
    public void set_id_modelo(Long _id_modelo) {
        this._id_modelo = _id_modelo;
    }
    /**
     * @param _id_vehiculo the _id_vehiculo to set
     */
    public void set_id_vehiculo(Long _id_vehiculo) {
        this._id_vehiculo = _id_vehiculo;
    }
    /**
     * @param _latitud the _latitud to set
     */
    public void set_latitud(Double _latitud) {
        this._latitud = _latitud;
    }
    /**
     * @param _longitud the _longitud to set
     */
    public void set_longitud(Double _longitud) {
        this._longitud = _longitud;
    }
    /**
     * @param _accion the _accion to set
     */
    public void set_accion(String _accion) {
        this._accion = _accion;
    }
    /**
     * @param _fecha the _fecha to set
     */
    public void set_fecha(String _fecha) {
        this._fecha = _fecha;
    }
    /**
     * @param _km the _km to set
     */
    public void set_km(Integer _km) {
        this._km = _km;
    }

    public static Log fromRS(ResultSet p_rs) throws SQLException {
        Log ret = new Log();

        try {
            ret.set_id(p_rs.getLong("id"));
            ret.set_id_usuario(p_rs.getLong("id_usuario"));
            ret.set_id_tipo_vehiculo(p_rs.getLong("id_tipo_vehiculo"));
            ret.set_id_marca(p_rs.getLong("id_marca"));
            ret.set_id_modelo(p_rs.getLong("id_modelo"));
            ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
            ret.set_latitud(p_rs.getDouble("latitud"));
            ret.set_longitud(p_rs.getDouble("longitud"));
            ret.set_accion(p_rs.getString("accion"));
            ret.set_fecha(p_rs.getString("fecha"));
            ret.set_km(p_rs.getInt("km"));
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

    public static Log getByParameter(Connection p_conn, String p_key, String p_value) throws Exception {
        Log ret = null;
        
        String str_sql = _str_sql +
            "  WHERE lo." + p_key + " = " + p_value +
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

    public static Log getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_log", p_id);
    }
    
    public static ArrayList<Log> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Log> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Log>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_comunidad")) {
                    array_clauses.add("lo.id_comunidad = " + p.getValue());
                }
                else if (p.getKey().equals("id_comuna")) {
                    array_clauses.add("lo.id_comuna = " + p.getValue());
                }
                else if (p.getKey().equals("latitud_mayor")) {
                    array_clauses.add("lo.latitud > " + p.getValue());
                }
                else if (p.getKey().equals("latitud_menor")) {
                    array_clauses.add("lo.latitud < " + p.getValue());
                }
                else if (p.getKey().equals("longitud_mayor")) {
                    array_clauses.add("lo.longitud > " + p.getValue());
                }
                else if (p.getKey().equals("longitud_menor")) {
                    array_clauses.add("lo.longitud < " + p.getValue());
                }
                else if (p.getKey().equals("posicion_reciente")) {
                    array_clauses.add("lo.fecha > DATE_ADD(now(), INTERVAL -" + p.getValue() + " MINUTE)");
                }
                else if (p.getKey().equals("id_distinto")) {
                    array_clauses.add("lo.id_usuario <> " + p.getValue());
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
            "    UPDATE log" +
            "    SET " +
            "    id_log, " +
            "    id_usuario, " +
            "    id_tipo_vehiculo, " +
            "    id_marca, " +
            "    id_modelo, " +
            "    id_vehiculo, " +
            "    latitud, " +
            "    longitud, " +
            "    accion, " +
            "    DATE_FORMAT(lo.fecha, '%d-%m-%Y %H:%i:%s') AS fecha, " +
            "    km " +
            "    WHERE id_log = " + Long.toString(this._id);
        
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
            "    INSERT INTO log" +
            "    (" +
            "    id_log, " +
            "    id_usuario, " +
            "    id_tipo_vehiculo, " +
            "    id_marca, " +
            "    id_modelo, " +
            "    id_vehiculo, " +
            "    latitud, " +
            "    longitud, " +
            "    accion, " +
            "    fecha, " +
            "    km " +
            "    )" +
            "    VALUES" +
            "    (" +
            "    " + (_id != null ? _id.toString() : "null") + "," +
            "    " + (_id_usuario != null ? _id_usuario.toString() : "null") + "," +
            "    " + (_id_tipo_vehiculo != null ? _id_tipo_vehiculo.toString() : "null") + "," +
            "    " + (_id_marca != null ? _id_marca.toString() : "null") + "," +
            "    " + (_id_modelo != null ? _id_modelo.toString() : "null") + "," +
            "    " + (_id_vehiculo != null ? _id_vehiculo.toString() : "null") + "," +
            "    " + (_latitud != null ? _latitud.toString() : "null") + "," +
            "    " + (_longitud != null ? _longitud.toString() : "null") + "," +
            "    " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
            "    " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_km != null ? _km.toString() : "null") +
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
                _id = rs.getLong(1);
            } else {
                // throw an exception from here
                throw new Exception("Error al obtener id");
            }

            rs.close();
            rs = null;
            System.out.println("Key returned from getGeneratedKeys():" + _id.toString());
                        
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
    
    public static int delete(Connection p_conn, Integer p_id_log) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "  DELETE FROM log";
        
        if (p_id_log != null) {
            str_sql +=
                "  WHERE id_log = " + p_id_log.toString();
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