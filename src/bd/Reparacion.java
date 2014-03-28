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
public class Reparacion {
    private Long _id_reparacion;
    private Long _id_usuario;
    private Long _id_vehiculo;
    private String _titulo;
    private String _descripcion;
    private Integer _costo;
    private String _fecha_modificacion;

    private final static String _str_sql = 
        "    SELECT " +
        "    id_reparacion, " +
        "    id_usuario, " +
        "    id_vehiculo, " +
        "    titulo, " +
        "    descripcion, " +
        "    costo, " +
        "    DATE_FORMAT(re.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion " +
        "    FROM reparacion re ";

    public Reparacion() {
        _id_reparacion = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _titulo = null;
        _descripcion = null;
        _costo = null;
        _fecha_modificacion = null;

    }

    /**
     * @return the _id_reparacion
     */
    public Long get_id_reparacion() {
        return _id_reparacion;
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
     * @return the _costo
     */
    public Integer get_costo() {
        return _costo;
    }
    /**
     * @return the _fecha_modificacion
     */
    public String get_fecha_modificacion() {
        return _fecha_modificacion;
    }

    /**
     * @param _id_reparacion the _id_reparacion to set
     */
    public void set_id_reparacion(Long _id_reparacion) {
        this._id_reparacion = _id_reparacion;
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
     * @param _costo the _costo to set
     */
    public void set_costo(Integer _costo) {
        this._costo = _costo;
    }
    /**
     * @param _fecha_modificacion the _fecha_modificacion to set
     */
    public void set_fecha_modificacion(String _fecha_modificacion) {
        this._fecha_modificacion = _fecha_modificacion;
    }

    public static Reparacion fromRS(ResultSet p_rs) throws SQLException {
        Reparacion ret = new Reparacion();

        try {
            ret.set_id_reparacion(p_rs.getLong("id_reparacion"));
            ret.set_id_usuario(p_rs.getLong("id_usuario"));
            ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
            ret.set_titulo(p_rs.getString("titulo"));
            ret.set_descripcion(p_rs.getString("descripcion"));
            ret.set_costo(p_rs.getInt("costo"));
            ret.set_fecha_modificacion(p_rs.getString("fecha_modificacion"));
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

    public static Reparacion getByParameter(Connection p_conn, String p_key, String p_value) throws Exception {
        Reparacion ret = null;
        
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

    public static Reparacion getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_reparacion", p_id);
    }
    
    public static ArrayList<Reparacion> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Reparacion> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Reparacion>();
            
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
            "    UPDATE reparacion" +
            "    SET " +
            "    id_reparacion, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    titulo, " +
            "    descripcion, " +
            "    costo, " +
            "    DATE_FORMAT(re.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion " +
            "    WHERE id_reparacion = " + Long.toString(this._id_reparacion);
        
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
            "    INSERT INTO reparacion" +
            "    (" +
            "    id_reparacion, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    titulo, " +
            "    descripcion, " +
            "    costo, " +
            "    fecha_modificacion " +
            "    )" +
            "    VALUES" +
            "    (" +
            "    " + (_id_reparacion != null ? _id_reparacion.toString() : "null") + "," +
            "    " + (_id_usuario != null ? _id_usuario.toString() : "null") + "," +
            "    " + (_id_vehiculo != null ? _id_vehiculo.toString() : "null") + "," +
            "    " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
            "    " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
            "    " + (_costo != null ? _costo.toString() : "null") + "," +
            "    " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") +
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
                _id_reparacion = rs.getLong(1);
            } else {
                // throw an exception from here
                throw new Exception("Error al obtener id");
            }

            rs.close();
            rs = null;
            System.out.println("Key returned from getGeneratedKeys():" + _id_reparacion.toString());
                        
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
    
    public static int delete(Connection p_conn, Integer p_id_reparacion) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "  DELETE FROM reparacion";
        
        if (p_id_reparacion != null) {
            str_sql +=
                "  WHERE id_reparacion = " + p_id_reparacion.toString();
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