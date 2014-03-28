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
public class Autenticacion {
    private Long _id;
    private Long _id_usuario;
    private Long _id_red_social;
    private String _token;
    private String _fecha;

    private final static String _str_sql = 
        "    SELECT " +
        "    id_autenticacion AS id, " +
        "    id_usuario, " +
        "    id_red_social, " +
        "    token, " +
        "    DATE_FORMAT(au.fecha, '%d-%m-%Y %H:%i:%s') AS fecha " +
        "    FROM autenticacion au ";

    public Autenticacion() {
        _id = null;
        _id_usuario = null;
        _id_red_social = null;
        _token = null;
        _fecha = null;

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
     * @return the _id_red_social
     */
    public Long get_id_red_social() {
        return _id_red_social;
    }
    /**
     * @return the _token
     */
    public String get_token() {
        return _token;
    }
    /**
     * @return the _fecha
     */
    public String get_fecha() {
        return _fecha;
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
     * @param _id_red_social the _id_red_social to set
     */
    public void set_id_red_social(Long _id_red_social) {
        this._id_red_social = _id_red_social;
    }
    /**
     * @param _token the _token to set
     */
    public void set_token(String _token) {
        this._token = _token;
    }
    /**
     * @param _fecha the _fecha to set
     */
    public void set_fecha(String _fecha) {
        this._fecha = _fecha;
    }

    public static Autenticacion fromRS(ResultSet p_rs) throws SQLException {
        Autenticacion ret = new Autenticacion();

        try {
            ret.set_id(p_rs.getLong("id"));
            ret.set_id_usuario(p_rs.getLong("id_usuario"));
            ret.set_id_red_social(p_rs.getLong("id_red_social"));
            ret.set_token(p_rs.getString("token"));
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

    public static Autenticacion getByParameter(Connection p_conn, String p_key, String p_value) throws Exception {
        Autenticacion ret = null;
        
        String str_sql = _str_sql +
            "  WHERE au." + p_key + " = " + p_value +
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

    public static Autenticacion getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_autenticacion", p_id);
    }
    
    public static ArrayList<Autenticacion> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Autenticacion> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Autenticacion>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_comunidad")) {
                    array_clauses.add("au.id_comunidad = " + p.getValue());
                }
                else if (p.getKey().equals("id_comuna")) {
                    array_clauses.add("au.id_comuna = " + p.getValue());
                }
                else if (p.getKey().equals("latitud_mayor")) {
                    array_clauses.add("au.latitud > " + p.getValue());
                }
                else if (p.getKey().equals("latitud_menor")) {
                    array_clauses.add("au.latitud < " + p.getValue());
                }
                else if (p.getKey().equals("longitud_mayor")) {
                    array_clauses.add("au.longitud > " + p.getValue());
                }
                else if (p.getKey().equals("longitud_menor")) {
                    array_clauses.add("au.longitud < " + p.getValue());
                }
                else if (p.getKey().equals("posicion_reciente")) {
                    array_clauses.add("au.fecha > DATE_ADD(now(), INTERVAL -" + p.getValue() + " MINUTE)");
                }
                else if (p.getKey().equals("id_distinto")) {
                    array_clauses.add("au.id_usuario <> " + p.getValue());
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
            "    UPDATE autenticacion" +
            "    SET " +
            "    id_autenticacion AS id, " +
            "    id_usuario, " +
            "    id_red_social, " +
            "    token, " +
            "    DATE_FORMAT(au.fecha, '%d-%m-%Y %H:%i:%s') AS fecha " +
            "    WHERE id_autenticacion = " + Long.toString(this._id);
        
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
            "    INSERT INTO autenticacion" +
            "    (" +
            "    id_autenticacion, " +
            "    id_usuario, " +
            "    id_red_social, " +
            "    token, " +
            "    fecha " +
            "    )" +
            "    VALUES" +
            "    (" +
            "    " + (_id != null ? _id.toString() : "null") + "," +
            "    " + (_id_usuario != null ? _id_usuario.toString() : "null") + "," +
            "    " + (_id_red_social != null ? _id_red_social.toString() : "null") + "," +
            "    " + (_token != null ? "'" + _token + "'" : "null") + "," +
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
    
    public static int delete(Connection p_conn, Integer p_id_autenticacion) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "  DELETE FROM autenticacion";
        
        if (p_id_autenticacion != null) {
            str_sql +=
                "  WHERE id_autenticacion = " + p_id_autenticacion.toString();
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