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
private String _fecha;
private String _descripcion;
private Boolean _recordar_km;
private Integer _km;
private Boolean _recordar_fecha;
private Boolean _descartado;
private Long _id_recordatorio;
private String _titulo;
private String _fecha_modificacion;
private Long _id_usuario;
private Long _id_vehiculo;
private String _recordatoriocol;

    private final static String _str_sql = 
        "    SELECT" +
        "    DATE_FORMAT(re.fecha, '%d-%m-%Y %H:%i:%s') AS fecha," +
        "    re.descripcion AS descripcion," +
        "    0+re.recordar_km AS recordar_km," +
        "    re.km AS km," +
        "    0+re.recordar_fecha AS recordar_fecha," +
        "    0+re.descartado AS descartado," +
        "    re.id_recordatorio AS id_recordatorio," +
        "    re.titulo AS titulo," +
        "    DATE_FORMAT(re.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion," +
        "    re.id_usuario AS id_usuario," +
        "    re.id_vehiculo AS id_vehiculo," +
        "    re.recordatoriocol AS recordatoriocol" +
        "    FROM recordatorio re";

    public Recordatorio() {
        _fecha = null;
        _descripcion = null;
        _recordar_km = null;
        _km = null;
        _recordar_fecha = null;
        _descartado = null;
        _id_recordatorio = null;
        _titulo = null;
        _fecha_modificacion = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _recordatoriocol = null;

    }
    /**
     * @return the _fecha
     */
    public String get_fecha() {
        return _fecha;
    }
    /**
     * @return the _descripcion
     */
    public String get_descripcion() {
        return _descripcion;
    }
    /**
     * @return the _recordar_km
     */
    public Boolean get_recordar_km() {
        return _recordar_km;
    }
    /**
     * @return the _km
     */
    public Integer get_km() {
        return _km;
    }
    /**
     * @return the _recordar_fecha
     */
    public Boolean get_recordar_fecha() {
        return _recordar_fecha;
    }
    /**
     * @return the _descartado
     */
    public Boolean get_descartado() {
        return _descartado;
    }
    /**
     * @return the _id_recordatorio
     */
    public Long get_id_recordatorio() {
        return _id_recordatorio;
    }
    /**
     * @return the _titulo
     */
    public String get_titulo() {
        return _titulo;
    }
    /**
     * @return the _fecha_modificacion
     */
    public String get_fecha_modificacion() {
        return _fecha_modificacion;
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
     * @return the _recordatoriocol
     */
    public String get_recordatoriocol() {
        return _recordatoriocol;
    }
    /**
     * @param _fecha the _fecha to set
     */
    public void set_fecha(String _fecha) {
        this._fecha = _fecha;
    }
    /**
     * @param _descripcion the _descripcion to set
     */
    public void set_descripcion(String _descripcion) {
        this._descripcion = _descripcion;
    }
    /**
     * @param _recordar_km the _recordar_km to set
     */
    public void set_recordar_km(Boolean _recordar_km) {
        this._recordar_km = _recordar_km;
    }
    /**
     * @param _km the _km to set
     */
    public void set_km(Integer _km) {
        this._km = _km;
    }
    /**
     * @param _recordar_fecha the _recordar_fecha to set
     */
    public void set_recordar_fecha(Boolean _recordar_fecha) {
        this._recordar_fecha = _recordar_fecha;
    }
    /**
     * @param _descartado the _descartado to set
     */
    public void set_descartado(Boolean _descartado) {
        this._descartado = _descartado;
    }
    /**
     * @param _id_recordatorio the _id_recordatorio to set
     */
    public void set_id_recordatorio(Long _id_recordatorio) {
        this._id_recordatorio = _id_recordatorio;
    }
    /**
     * @param _titulo the _titulo to set
     */
    public void set_titulo(String _titulo) {
        this._titulo = _titulo;
    }
    /**
     * @param _fecha_modificacion the _fecha_modificacion to set
     */
    public void set_fecha_modificacion(String _fecha_modificacion) {
        this._fecha_modificacion = _fecha_modificacion;
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
     * @param _recordatoriocol the _recordatoriocol to set
     */
    public void set_recordatoriocol(String _recordatoriocol) {
        this._recordatoriocol = _recordatoriocol;
    }

    public static Recordatorio fromRS(ResultSet p_rs) throws SQLException {
        Recordatorio ret = new Recordatorio();

        ret.set_fecha(p_rs.getString("fecha"));
        ret.set_descripcion(p_rs.getString("descripcion"));
        ret.set_recordar_km(p_rs.getBoolean("recordar_km"));
        ret.set_km(p_rs.getInt("km"));
        ret.set_recordar_fecha(p_rs.getBoolean("recordar_fecha"));
        ret.set_descartado(p_rs.getBoolean("descartado"));
        ret.set_id_recordatorio(p_rs.getLong("id_recordatorio"));
        ret.set_titulo(p_rs.getString("titulo"));
        ret.set_fecha_modificacion(p_rs.getString("fecha_modificacion"));
        ret.set_id_usuario(p_rs.getLong("id_usuario"));
        ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
        ret.set_recordatoriocol(p_rs.getString("recordatoriocol"));

        return ret;
    }

    public static Recordatorio getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
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
                if (p.getKey().equals("id_recordatorio")) {
                    array_clauses.add("re.id_recordatorio = " + p.getValue());
                }
                else if (p.getKey().equals("id_usuario")) {
                    array_clauses.add("re.id_usuario = " + p.getValue());
                }
                else if (p.getKey().equals("id_usuario")) {
                    array_clauses.add("re.id_usuario = " + p.getValue());
                }
                else if (p.getKey().equals("id_vehiculo")) {
                    array_clauses.add("re.id_vehiculo = " + p.getValue());
                }
                else if (p.getKey().equals("mas reciente")) {
                    array_clauses.add("re.fecha_modificacion > STR_TO_DATE('" + p.getValue() + "', '%d-%m-%Y %H:%i:%s')");
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
            "    UPDATE recordatorio" +
            "    SET" +
            "    fecha = " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    descripcion = " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
            "    recordar_km = " + (_recordar_km != null ? "b'" + _recordar_km : "null") + "," +
            "    km = " + (_km != null ? _km : "null") + "," +
            "    recordar_fecha = " + (_recordar_fecha != null ? "b'" + _recordar_fecha : "null") + "," +
            "    descartado = " + (_descartado != null ? "b'" + _descartado : "null") + "," +
            "    titulo = " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
            "    fecha_modificacion = " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    recordatoriocol = " + (_recordatoriocol != null ? "'" + _recordatoriocol + "'" : "null") +
            "    WHERE" +
            "    id_recordatorio = " + Long.toString(this._id_recordatorio) + " AND" +
            "    id_usuario = " + Long.toString(this._id_usuario);

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
            "    INSERT INTO recordatorio" +
            "    (" +
            "    fecha, " +
            "    descripcion, " +
            "    recordar_km, " +
            "    km, " +
            "    recordar_fecha, " +
            "    id_recordatorio, " +
            "    titulo, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    recordatoriocol)" +
            "    VALUES" +
            "    (" +
            "    " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
            "    " + (_recordar_km != null ? "b'" + (_recordar_km ? 1 : 0) + "'" : "null") + "," +
            "    " + (_km != null ? "'" + _km + "'" : "null") + "," +
            "    " + (_recordar_fecha != null ? "b'" + (_recordar_fecha ? 1 : 0) + "'" : "null") + "," +
            "    " + (_id_recordatorio != null ? "'" + _id_recordatorio + "'" : "null") + "," +
            "    " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
            "    " + (_id_usuario != null ? "'" + _id_usuario + "'" : "null") + "," +
            "    " + (_id_vehiculo != null ? "'" + _id_vehiculo + "'" : "null") + "," +
            "    " + (_recordatoriocol != null ? "'" + _recordatoriocol + "'" : "null") +
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
            "    DELETE FROM recordatorio" +
            "    WHERE" +
            "    id_recordatorio = " + Long.toString(this._id_recordatorio) + " AND" +
            "    id_usuario = " + Long.toString(this._id_usuario);

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
        Recordatorio obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_recordatorio = " + Long.toString(this._id_recordatorio) + " AND" +
            "    id_usuario = " + Long.toString(this._id_usuario) +
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

                _fecha = obj.get_fecha();
                _descripcion = obj.get_descripcion();
                _recordar_km = obj.get_recordar_km();
                _km = obj.get_km();
                _recordar_fecha = obj.get_recordar_fecha();
                _descartado = obj.get_descartado();
                _titulo = obj.get_titulo();
                _fecha_modificacion = obj.get_fecha_modificacion();
                _id_vehiculo = obj.get_id_vehiculo();
                _recordatoriocol = obj.get_recordatoriocol();
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
        return "Recordatorio [" +
	           "    _fecha = " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _descripcion = " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
	           "    _recordar_km = " + (_recordar_km != null ? "b'" + _recordar_km : "null") + "," +
	           "    _km = " + (_km != null ? _km : "null") + "," +
	           "    _recordar_fecha = " + (_recordar_fecha != null ? "b'" + _recordar_fecha : "null") + "," +
	           "    _descartado = " + (_descartado != null ? "b'" + _descartado : "null") + "," +
	           "    _id_recordatorio = " + (_id_recordatorio != null ? _id_recordatorio : "null") + "," +
	           "    _titulo = " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
	           "    _fecha_modificacion = " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_usuario = " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo = " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _recordatoriocol = " + (_recordatoriocol != null ? "'" + _recordatoriocol + "'" : "null") +
			   "]";
    }


    public String toJSON() {
        return "Recordatorio : {" +
	           "    _fecha : " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _descripcion : " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
	           "    _recordar_km : " + (_recordar_km != null ? "b'" + _recordar_km : "null") + "," +
	           "    _km : " + (_km != null ? _km : "null") + "," +
	           "    _recordar_fecha : " + (_recordar_fecha != null ? "b'" + _recordar_fecha : "null") + "," +
	           "    _descartado : " + (_descartado != null ? "b'" + _descartado : "null") + "," +
	           "    _id_recordatorio : " + (_id_recordatorio != null ? _id_recordatorio : "null") + "," +
	           "    _titulo : " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
	           "    _fecha_modificacion : " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_usuario : " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo : " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _recordatoriocol : " + (_recordatoriocol != null ? "'" + _recordatoriocol + "'" : "null") +
			   "}";
    }

}
