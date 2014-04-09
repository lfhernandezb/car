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
private String _descripcion;
private Integer _costo;
private String _titulo;
private String _fecha_modificacion;
private Long _id_usuario;
private Long _id_vehiculo;
private Long _id_reparacion;

    private final static String _str_sql = 
        "    SELECT" +
        "    re.descripcion AS descripcion," +
        "    re.costo AS costo," +
        "    re.titulo AS titulo," +
        "    DATE_FORMAT(re.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion," +
        "    re.id_usuario AS id_usuario," +
        "    re.id_vehiculo AS id_vehiculo," +
        "    re.id_reparacion AS id_reparacion" +
        "    FROM reparacion re";

    public Reparacion() {
        _descripcion = null;
        _costo = null;
        _titulo = null;
        _fecha_modificacion = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _id_reparacion = null;

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
     * @return the _id_reparacion
     */
    public Long get_id_reparacion() {
        return _id_reparacion;
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
     * @param _id_reparacion the _id_reparacion to set
     */
    public void set_id_reparacion(Long _id_reparacion) {
        this._id_reparacion = _id_reparacion;
    }

    public static Reparacion fromRS(ResultSet p_rs) throws SQLException {
        Reparacion ret = new Reparacion();

        ret.set_descripcion(p_rs.getString("descripcion"));
        ret.set_costo(p_rs.getInt("costo"));
        ret.set_titulo(p_rs.getString("titulo"));
        ret.set_fecha_modificacion(p_rs.getString("fecha_modificacion"));
        ret.set_id_usuario(p_rs.getLong("id_usuario"));
        ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
        ret.set_id_reparacion(p_rs.getLong("id_reparacion"));

        return ret;
    }

    public static Reparacion getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
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
                if (p.getKey().equals("id_usuario")) {
                    array_clauses.add("re.id_usuario = " + p.getValue());
                }
                else if (p.getKey().equals("id_reparacion")) {
                    array_clauses.add("re.id_reparacion = " + p.getValue());
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
            "    UPDATE reparacion" +
            "    SET" +
            "    descripcion = " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
            "    costo = " + (_costo != null ? _costo : "null") + "," +
            "    titulo = " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
            "    fecha_modificacion = " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_reparacion = " + Long.toString(this._id_reparacion);

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
            "    INSERT INTO reparacion" +
            "    (" +
            "    descripcion, " +
            "    costo, " +
            "    titulo, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    id_reparacion)" +
            "    VALUES" +
            "    (" +
            "    " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
            "    " + (_costo != null ? "'" + _costo + "'" : "null") + "," +
            "    " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
            "    " + (_id_usuario != null ? "'" + _id_usuario + "'" : "null") + "," +
            "    " + (_id_vehiculo != null ? "'" + _id_vehiculo + "'" : "null") + "," +
            "    " + (_id_reparacion != null ? "'" + _id_reparacion + "'" : "null") +
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
            "    DELETE FROM reparacion" +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_reparacion = " + Long.toString(this._id_reparacion);

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
        Reparacion obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_reparacion = " + Long.toString(this._id_reparacion) +
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

                _descripcion = obj.get_descripcion();
                _costo = obj.get_costo();
                _titulo = obj.get_titulo();
                _fecha_modificacion = obj.get_fecha_modificacion();
                _id_vehiculo = obj.get_id_vehiculo();
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
        return "Reparacion [" +
	           "    _descripcion = " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
	           "    _costo = " + (_costo != null ? _costo : "null") + "," +
	           "    _titulo = " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
	           "    _fecha_modificacion = " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_usuario = " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo = " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _id_reparacion = " + (_id_reparacion != null ? _id_reparacion : "null") +
			   "]";
    }


    public String toJSON() {
        return "Reparacion : {" +
	           "    _descripcion : " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
	           "    _costo : " + (_costo != null ? _costo : "null") + "," +
	           "    _titulo : " + (_titulo != null ? "'" + _titulo + "'" : "null") + "," +
	           "    _fecha_modificacion : " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_usuario : " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo : " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _id_reparacion : " + (_id_reparacion != null ? _id_reparacion : "null") +
			   "}";
    }

}
