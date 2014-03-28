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
public class Recordatorio {
    private Long _id_recordatorio;
    private Long _id_usuario;
    private Long _id_vehiculo;
    private Boolean _recordar_fecha;
    private Boolean _recordar_km;
    private String _fecha;
    private Integer _km;
    private String _titulo;
    private String _descripcion;
    private String _recordatoriocol;
    private String _fecha_modificacion;
    private Boolean _descartado;

    private final static String _str_sql = 
        "    SELECT " +
        "    id_recordatorio, " +
        "    id_usuario, " +
        "    id_vehiculo, " +
        "    0+recordar_fecha AS recordar_fecha, " +
        "    0+recordar_km AS recordar_km, " +
        "    DATE_FORMAT(re.fecha, '%d-%m-%Y %H:%i:%s') AS fecha, " +
        "    km, " +
        "    titulo, " +
        "    descripcion, " +
        "    recordatoriocol, " +
        "    DATE_FORMAT(re.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion, " +
        "    0+descartado AS descartado " +
        "    FROM recordatorio re ";

    public Recordatorio() {
        _id_recordatorio = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _recordar_fecha = null;
        _recordar_km = null;
        _fecha = null;
        _km = null;
        _titulo = null;
        _descripcion = null;
        _recordatoriocol = null;
        _fecha_modificacion = null;
        _descartado = null;

    }

    /**
     * @return the _id_recordatorio
     */
    public Long get_id_recordatorio() {
        return _id_recordatorio;
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
     * @return the _recordar_fecha
     */
    public Boolean get_recordar_fecha() {
        return _recordar_fecha;
    }
    /**
     * @return the _recordar_km
     */
    public Boolean get_recordar_km() {
        return _recordar_km;
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
     * @return the _titulo
     */
    public String get_titulo() {
        return _titulo;
    }
    /**
     * @return the _descripcion
     */
    public String get_descripcion() {
        return _descripcion;
    }
    /**
     * @return the _recordatoriocol
     */
    public String get_recordatoriocol() {
        return _recordatoriocol;
    }
    /**
     * @return the _fecha_modificacion
     */
    public String get_fecha_modificacion() {
        return _fecha_modificacion;
    }
    /**
     * @return the _descartado
     */
    public Boolean get_descartado() {
        return _descartado;
    }

    /**
     * @param _id_recordatorio the _id_recordatorio to set
     */
    public void set_id_recordatorio(Long _id_recordatorio) {
        this._id_recordatorio = _id_recordatorio;
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
     * @param _recordar_fecha the _recordar_fecha to set
     */
    public void set_recordar_fecha(Boolean _recordar_fecha) {
        this._recordar_fecha = _recordar_fecha;
    }
    /**
     * @param _recordar_km the _recordar_km to set
     */
    public void set_recordar_km(Boolean _recordar_km) {
        this._recordar_km = _recordar_km;
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
    /**
     * @param _titulo the _titulo to set
     */
    public void set_titulo(String _titulo) {
        this._titulo = _titulo;
    }
    /**
     * @param _descripcion the _descripcion to set
     */
    public void set_descripcion(String _descripcion) {
        this._descripcion = _descripcion;
    }
    /**
     * @param _recordatoriocol the _recordatoriocol to set
     */
    public void set_recordatoriocol(String _recordatoriocol) {
        this._recordatoriocol = _recordatoriocol;
    }
    /**
     * @param _fecha_modificacion the _fecha_modificacion to set
     */
    public void set_fecha_modificacion(String _fecha_modificacion) {
        this._fecha_modificacion = _fecha_modificacion;
    }
    /**
     * @param _descartado the _descartado to set
     */
    public void set_descartado(Boolean _descartado) {
        this._descartado = _descartado;
    }

    public static Recordatorio fromRS(ResultSet p_rs) throws SQLException {
        Recordatorio ret = new Recordatorio();

        try {
            ret.set_id_recordatorio(p_rs.getLong("id_recordatorio"));
            ret.set_id_usuario(p_rs.getLong("id_usuario"));
            ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
            ret.set_recordar_fecha(p_rs.getBoolean("recordar_fecha"));
            ret.set_recordar_km(p_rs.getBoolean("recordar_km"));
            ret.set_fecha(p_rs.getString("fecha"));
            ret.set_km(p_rs.getInt("km"));
            ret.set_titulo(p_rs.getString("titulo"));
            ret.set_descripcion(p_rs.getString("descripcion"));
            ret.set_recordatoriocol(p_rs.getString("recordatoriocol"));
            ret.set_fecha_modificacion(p_rs.getString("fecha_modificacion"));
            ret.set_descartado(p_rs.getBoolean("descartado"));
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

    public static Recordatorio getByParameter(Connection p_conn, String p_key, String p_value) throws Exception {
        Recordatorio ret = null;
        
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

    public static Recordatorio getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_recordatorio", p_id);
    }
    
    public static ArrayList<Recordatorio> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Recordatorio> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Recordatorio>();
            
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
            "    UPDATE recordatorio" +
            "    SET " +
            "    id_recordatorio, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    0+recordar_fecha AS recordar_fecha, " +
            "    0+recordar_km AS recordar_km, " +
            "    DATE_FORMAT(re.fecha, '%d-%m-%Y %H:%i:%s') AS fecha, " +
            "    km, " +
            "    titulo, " +
            "    descripcion, " +
            "    recordatoriocol, " +
            "    DATE_FORMAT(re.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion, " +
            "    0+descartado AS descartado " +
            "    WHERE id_recordatorio = " + Long.toString(this._id_recordatorio);
        
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
            "    INSERT INTO recordatorio" +
            "    (" +
            "    id_recordatorio, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    recordar_fecha, " +
            "    recordar_km, " +
            "    fecha, " +
            "    km, " +
            "    titulo, " +
            "    descripcion, " +
            "    recordatoriocol, " +
            "    fecha_modificacion, " +
            "    descartado " +
            "    )" +
            "    VALUES" +
            "    (" +
            "    " + (_id_recordatorio != null ? _id_recordatorio.toString() : "null") + "," +
            "    " + (_id_usuario != null ? _id_usuario.toString() : "null") + "," +
            "    " + (_id_vehiculo != null ? _id_vehiculo.toString() : "null") + "," +
            "    " + (_recordar_fecha != null ? "b'" + (_recordar_fecha ? 1 : 0) + "'" : "null") + "," +
            "    " + (_recordar_km != null ? "b'" + (_recordar_km ? 1 : 0) + "'" : "null") + "," +
            "    " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_km != null ? _km.toString() : "null") + "," +
            "    " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
            "    " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
            "    " + (_recordatoriocol != null ? "'" + _recordatoriocol + "'" : "null") + "," +
            "    " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_descartado != null ? "b'" + (_descartado ? 1 : 0) + "'" : "null") +
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
                _id_recordatorio = rs.getLong(1);
            } else {
                // throw an exception from here
                throw new Exception("Error al obtener id");
            }

            rs.close();
            rs = null;
            System.out.println("Key returned from getGeneratedKeys():" + _id_recordatorio.toString());
                        
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
    
    public static int delete(Connection p_conn, Integer p_id_recordatorio) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "  DELETE FROM recordatorio";
        
        if (p_id_recordatorio != null) {
            str_sql +=
                "  WHERE id_recordatorio = " + p_id_recordatorio.toString();
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