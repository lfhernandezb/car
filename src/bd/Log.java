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
private Long _id_tipo_vehiculo;
private String _fecha;
private Long _id_usuario;
private Long _id_vehiculo;
private Double _latitud;
private Long _id;
private Long _id_modelo;
private Double _longitud;
private String _accion;
private Integer _km;
private Long _id_marca;

    private final static String _str_sql = 
        "    SELECT" +
        "    lo.id_tipo_vehiculo AS id_tipo_vehiculo," +
        "    DATE_FORMAT(lo.fecha, '%d-%m-%Y %H:%i:%s') AS fecha," +
        "    lo.id_usuario AS id_usuario," +
        "    lo.id_vehiculo AS id_vehiculo," +
        "    lo.latitud AS latitud," +
        "    lo.id_log AS id," +
        "    lo.id_modelo AS id_modelo," +
        "    lo.longitud AS longitud," +
        "    lo.accion AS accion," +
        "    lo.km AS km," +
        "    lo.id_marca AS id_marca" +
        "    FROM log lo";

    public Log() {
        _id_tipo_vehiculo = null;
        _fecha = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _latitud = null;
        _id = null;
        _id_modelo = null;
        _longitud = null;
        _accion = null;
        _km = null;
        _id_marca = null;

    }
    /**
     * @return the _id_tipo_vehiculo
     */
    public Long get_id_tipo_vehiculo() {
        return _id_tipo_vehiculo;
    }
    /**
     * @return the _fecha
     */
    public String get_fecha() {
        return _fecha;
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
     * @return the _latitud
     */
    public Double get_latitud() {
        return _latitud;
    }
    /**
     * @return the _id
     */
    public Long get_id() {
        return _id;
    }
    /**
     * @return the _id_modelo
     */
    public Long get_id_modelo() {
        return _id_modelo;
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
     * @return the _km
     */
    public Integer get_km() {
        return _km;
    }
    /**
     * @return the _id_marca
     */
    public Long get_id_marca() {
        return _id_marca;
    }
    /**
     * @param _id_tipo_vehiculo the _id_tipo_vehiculo to set
     */
    public void set_id_tipo_vehiculo(Long _id_tipo_vehiculo) {
        this._id_tipo_vehiculo = _id_tipo_vehiculo;
    }
    /**
     * @param _fecha the _fecha to set
     */
    public void set_fecha(String _fecha) {
        this._fecha = _fecha;
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
     * @param _latitud the _latitud to set
     */
    public void set_latitud(Double _latitud) {
        this._latitud = _latitud;
    }
    /**
     * @param _id the _id to set
     */
    public void set_id(Long _id) {
        this._id = _id;
    }
    /**
     * @param _id_modelo the _id_modelo to set
     */
    public void set_id_modelo(Long _id_modelo) {
        this._id_modelo = _id_modelo;
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
     * @param _km the _km to set
     */
    public void set_km(Integer _km) {
        this._km = _km;
    }
    /**
     * @param _id_marca the _id_marca to set
     */
    public void set_id_marca(Long _id_marca) {
        this._id_marca = _id_marca;
    }

    public static Log fromRS(ResultSet p_rs) throws SQLException {
        Log ret = new Log();

        ret.set_id_tipo_vehiculo(p_rs.getLong("id_tipo_vehiculo"));
        ret.set_fecha(p_rs.getString("fecha"));
        ret.set_id_usuario(p_rs.getLong("id_usuario"));
        ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
        ret.set_latitud(p_rs.getDouble("latitud"));
        ret.set_id(p_rs.getLong("id"));
        ret.set_id_modelo(p_rs.getLong("id_modelo"));
        ret.set_longitud(p_rs.getDouble("longitud"));
        ret.set_accion(p_rs.getString("accion"));
        ret.set_km(p_rs.getInt("km"));
        ret.set_id_marca(p_rs.getLong("id_marca"));

        return ret;
    }

    public static Log getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
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
                if (p.getKey().equals("id_log")) {
                    array_clauses.add("lo.id_log = " + p.getValue());
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

    public int update(Connection p_conn) throws SQLException {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "    UPDATE log" +
            "    SET" +
            "    id_tipo_vehiculo = " + (_id_tipo_vehiculo != null ? _id_tipo_vehiculo : "null") + "," +
            "    fecha = " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    id_usuario = " + (_id_usuario != null ? _id_usuario : "null") + "," +
            "    id_vehiculo = " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
            "    latitud = " + (_latitud != null ? _latitud : "null") + "," +
            "    id_modelo = " + (_id_modelo != null ? _id_modelo : "null") + "," +
            "    longitud = " + (_longitud != null ? _longitud : "null") + "," +
            "    accion = " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
            "    km = " + (_km != null ? _km : "null") + "," +
            "    id_marca = " + (_id_marca != null ? _id_marca : "null") +
            "    WHERE" +
            "    id_log = " + Long.toString(this._id);

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
            
            throw ex;
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
    
    public int insert(Connection p_conn) throws SQLException {
        
        int ret = -1;
        Statement stmt = null;
        ResultSet rs = null;

        String str_sql =
            "    INSERT INTO log" +
            "    (" +
            "    id_tipo_vehiculo, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    latitud, " +
            "    id_log, " +
            "    id_modelo, " +
            "    longitud, " +
            "    accion, " +
            "    km, " +
            "    id_marca)" +
            "    VALUES" +
            "    (" +
            "    " + (_id_tipo_vehiculo != null ? "'" + _id_tipo_vehiculo + "'" : "null") + "," +
            "    " + (_id_usuario != null ? "'" + _id_usuario + "'" : "null") + "," +
            "    " + (_id_vehiculo != null ? "'" + _id_vehiculo + "'" : "null") + "," +
            "    " + (_latitud != null ? "'" + _latitud + "'" : "null") + "," +
            "    " + (_id != null ? "'" + _id + "'" : "null") + "," +
            "    " + (_id_modelo != null ? "'" + _id_modelo + "'" : "null") + "," +
            "    " + (_longitud != null ? "'" + _longitud + "'" : "null") + "," +
            "    " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
            "    " + (_km != null ? "'" + _km + "'" : "null") + "," +
            "    " + (_id_marca != null ? "'" + _id_marca + "'" : "null") +
            "    )";
        
        try {
            stmt = p_conn.createStatement();

            ret = stmt.executeUpdate(str_sql);

            load(p_conn);

        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage() + " sentencia: " + str_sql);
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            
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

    public int delete(Connection p_conn) throws SQLException {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "    DELETE FROM log" +
            "    WHERE" +
            "    id_log = " + Long.toString(this._id);

        try {
            stmt = p_conn.createStatement();
            
            ret = stmt.executeUpdate(str_sql);
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage() + " sentencia: " + str_sql);
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            
            throw ex;
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

    public void load(Connection p_conn) throws SQLException {
        Log obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_log = " + Long.toString(this._id) +
            "    LIMIT 0, 1";
        
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
                obj = fromRS(rs);
                //System.out.println("fromRS(rs) ok");

                _id_tipo_vehiculo = obj.get_id_tipo_vehiculo();
                _fecha = obj.get_fecha();
                _id_usuario = obj.get_id_usuario();
                _id_vehiculo = obj.get_id_vehiculo();
                _latitud = obj.get_latitud();
                _id_modelo = obj.get_id_modelo();
                _longitud = obj.get_longitud();
                _accion = obj.get_accion();
                _km = obj.get_km();
                _id_marca = obj.get_id_marca();
            }
        }
        catch (SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage() + " sentencia: " + str_sql);
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            
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
        
    }


@Override
    public String toString() {
        return "Log [" +
	           "    _id_tipo_vehiculo = " + (_id_tipo_vehiculo != null ? _id_tipo_vehiculo : "null") + "," +
	           "    _fecha = " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_usuario = " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo = " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _latitud = " + (_latitud != null ? _latitud : "null") + "," +
	           "    _id = " + (_id != null ? _id : "null") + "," +
	           "    _id_modelo = " + (_id_modelo != null ? _id_modelo : "null") + "," +
	           "    _longitud = " + (_longitud != null ? _longitud : "null") + "," +
	           "    _accion = " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
	           "    _km = " + (_km != null ? _km : "null") + "," +
	           "    _id_marca = " + (_id_marca != null ? _id_marca : "null") +
			   "]";
    }


    public String toJSON() {
        return "Log : {" +
	           "    _id_tipo_vehiculo : " + (_id_tipo_vehiculo != null ? _id_tipo_vehiculo : "null") + "," +
	           "    _fecha : " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_usuario : " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo : " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _latitud : " + (_latitud != null ? _latitud : "null") + "," +
	           "    _id : " + (_id != null ? _id : "null") + "," +
	           "    _id_modelo : " + (_id_modelo != null ? _id_modelo : "null") + "," +
	           "    _longitud : " + (_longitud != null ? _longitud : "null") + "," +
	           "    _accion : " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
	           "    _km : " + (_km != null ? _km : "null") + "," +
	           "    _id_marca : " + (_id_marca != null ? _id_marca : "null") +
			   "}";
    }

}
