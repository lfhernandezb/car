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
public class Usuario {
private String _fecha_vencimiento_licencia;
private Boolean _hombre;
private Boolean _borrado;
private String _telefono;
private String _fecha_modifiacion;
private String _fecha_nacimiento;
private String _nombre;
private Long _id;
private Long _id_comuna;
private String _correo;

    private final static String _str_sql = 
        "    SELECT" +
        "    DATE_FORMAT(us.fecha_vencimiento_licencia, '%d-%m-%Y %H:%i:%s') AS fecha_vencimiento_licencia," +
        "    0+us.hombre AS hombre," +
        "    0+us.borrado AS borrado," +
        "    us.telefono AS telefono," +
        "    DATE_FORMAT(us.fecha_modifiacion, '%d-%m-%Y %H:%i:%s') AS fecha_modifiacion," +
        "    DATE_FORMAT(us.fecha_nacimiento, '%d-%m-%Y %H:%i:%s') AS fecha_nacimiento," +
        "    us.nombre AS nombre," +
        "    us.id_usuario AS id," +
        "    us.id_comuna AS id_comuna," +
        "    us.correo AS correo" +
        "    FROM usuario us";

    public Usuario() {
        _fecha_vencimiento_licencia = null;
        _hombre = null;
        _borrado = null;
        _telefono = null;
        _fecha_modifiacion = null;
        _fecha_nacimiento = null;
        _nombre = null;
        _id = null;
        _id_comuna = null;
        _correo = null;

    }
    /**
     * @return the _fecha_vencimiento_licencia
     */
    public String get_fecha_vencimiento_licencia() {
        return _fecha_vencimiento_licencia;
    }
    /**
     * @return the _hombre
     */
    public Boolean get_hombre() {
        return _hombre;
    }
    /**
     * @return the _borrado
     */
    public Boolean get_borrado() {
        return _borrado;
    }
    /**
     * @return the _telefono
     */
    public String get_telefono() {
        return _telefono;
    }
    /**
     * @return the _fecha_modifiacion
     */
    public String get_fecha_modifiacion() {
        return _fecha_modifiacion;
    }
    /**
     * @return the _fecha_nacimiento
     */
    public String get_fecha_nacimiento() {
        return _fecha_nacimiento;
    }
    /**
     * @return the _nombre
     */
    public String get_nombre() {
        return _nombre;
    }
    /**
     * @return the _id
     */
    public Long get_id() {
        return _id;
    }
    /**
     * @return the _id_comuna
     */
    public Long get_id_comuna() {
        return _id_comuna;
    }
    /**
     * @return the _correo
     */
    public String get_correo() {
        return _correo;
    }
    /**
     * @param _fecha_vencimiento_licencia the _fecha_vencimiento_licencia to set
     */
    public void set_fecha_vencimiento_licencia(String _fecha_vencimiento_licencia) {
        this._fecha_vencimiento_licencia = _fecha_vencimiento_licencia;
    }
    /**
     * @param _hombre the _hombre to set
     */
    public void set_hombre(Boolean _hombre) {
        this._hombre = _hombre;
    }
    /**
     * @param _borrado the _borrado to set
     */
    public void set_borrado(Boolean _borrado) {
        this._borrado = _borrado;
    }
    /**
     * @param _telefono the _telefono to set
     */
    public void set_telefono(String _telefono) {
        this._telefono = _telefono;
    }
    /**
     * @param _fecha_modifiacion the _fecha_modifiacion to set
     */
    public void set_fecha_modifiacion(String _fecha_modifiacion) {
        this._fecha_modifiacion = _fecha_modifiacion;
    }
    /**
     * @param _fecha_nacimiento the _fecha_nacimiento to set
     */
    public void set_fecha_nacimiento(String _fecha_nacimiento) {
        this._fecha_nacimiento = _fecha_nacimiento;
    }
    /**
     * @param _nombre the _nombre to set
     */
    public void set_nombre(String _nombre) {
        this._nombre = _nombre;
    }
    /**
     * @param _id the _id to set
     */
    public void set_id(Long _id) {
        this._id = _id;
    }
    /**
     * @param _id_comuna the _id_comuna to set
     */
    public void set_id_comuna(Long _id_comuna) {
        this._id_comuna = _id_comuna;
    }
    /**
     * @param _correo the _correo to set
     */
    public void set_correo(String _correo) {
        this._correo = _correo;
    }

    public static Usuario fromRS(ResultSet p_rs) throws SQLException {
        Usuario ret = new Usuario();

        ret.set_fecha_vencimiento_licencia(p_rs.getString("fecha_vencimiento_licencia"));
        ret.set_hombre(p_rs.getBoolean("hombre"));
        ret.set_borrado(p_rs.getBoolean("borrado"));
        ret.set_telefono(p_rs.getString("telefono"));
        ret.set_fecha_modifiacion(p_rs.getString("fecha_modifiacion"));
        ret.set_fecha_nacimiento(p_rs.getString("fecha_nacimiento"));
        ret.set_nombre(p_rs.getString("nombre"));
        ret.set_id(p_rs.getLong("id"));
        ret.set_id_comuna(p_rs.getLong("id_comuna"));
        ret.set_correo(p_rs.getString("correo"));

        return ret;
    }

    public static Usuario getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
        Usuario ret = null;
        
        String str_sql = _str_sql +
            "  WHERE us." + p_key + " = " + p_value +
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

    public static Usuario getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_usuario", p_id);
    }
    
    public static ArrayList<Usuario> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Usuario> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Usuario>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_usuario")) {
                    array_clauses.add("us.id_usuario = " + p.getValue());
                }
                else if (p.getKey().equals("id_comuna")) {
                    array_clauses.add("us.id_comuna = " + p.getValue());
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
            "    UPDATE usuario" +
            "    SET" +
            "    fecha_vencimiento_licencia = " + (_fecha_vencimiento_licencia != null ? "STR_TO_DATE(" + _fecha_vencimiento_licencia + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    hombre = " + (_hombre != null ? "b'" + _hombre : "null") + "," +
            "    borrado = " + (_borrado != null ? "b'" + _borrado : "null") + "," +
            "    telefono = " + (_telefono != null ? "'" + _telefono + "'" : "null") + "," +
            "    fecha_modifiacion = " + (_fecha_modifiacion != null ? "STR_TO_DATE(" + _fecha_modifiacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    fecha_nacimiento = " + (_fecha_nacimiento != null ? "STR_TO_DATE(" + _fecha_nacimiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    nombre = " + (_nombre != null ? "'" + _nombre + "'" : "null") + "," +
            "    correo = " + (_correo != null ? "'" + _correo + "'" : "null") +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id);

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
            "    INSERT INTO usuario" +
            "    (" +
            "    fecha_vencimiento_licencia, " +
            "    hombre, " +
            "    telefono, " +
            "    fecha_nacimiento, " +
            "    nombre, " +
            "    id_usuario, " +
            "    id_comuna, " +
            "    correo)" +
            "    VALUES" +
            "    (" +
            "    " + (_fecha_vencimiento_licencia != null ? "STR_TO_DATE(" + _fecha_vencimiento_licencia + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_hombre != null ? "b'" + (_hombre ? 1 : 0) + "'" : "null") + "," +
            "    " + (_telefono != null ? "'" + _telefono + "'" : "null") + "," +
            "    " + (_fecha_nacimiento != null ? "STR_TO_DATE(" + _fecha_nacimiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_nombre != null ? "'" + _nombre + "'" : "null") + "," +
            "    " + (_id != null ? "'" + _id + "'" : "null") + "," +
            "    " + (_id_comuna != null ? "'" + _id_comuna + "'" : "null") + "," +
            "    " + (_correo != null ? "'" + _correo + "'" : "null") +
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
            "    DELETE FROM usuario" +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id);

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
        Usuario obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id) +
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

                _fecha_vencimiento_licencia = obj.get_fecha_vencimiento_licencia();
                _hombre = obj.get_hombre();
                _borrado = obj.get_borrado();
                _telefono = obj.get_telefono();
                _fecha_modifiacion = obj.get_fecha_modifiacion();
                _fecha_nacimiento = obj.get_fecha_nacimiento();
                _nombre = obj.get_nombre();
                _id_comuna = obj.get_id_comuna();
                _correo = obj.get_correo();
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
        return "Usuario [" +
	           "    _fecha_vencimiento_licencia = " + (_fecha_vencimiento_licencia != null ? "STR_TO_DATE(" + _fecha_vencimiento_licencia + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _hombre = " + (_hombre != null ? "b'" + _hombre : "null") + "," +
	           "    _borrado = " + (_borrado != null ? "b'" + _borrado : "null") + "," +
	           "    _telefono = " + (_telefono != null ? "'" + _telefono + "'" : "null") + "," +
	           "    _fecha_modifiacion = " + (_fecha_modifiacion != null ? "STR_TO_DATE(" + _fecha_modifiacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _fecha_nacimiento = " + (_fecha_nacimiento != null ? "STR_TO_DATE(" + _fecha_nacimiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _nombre = " + (_nombre != null ? "'" + _nombre + "'" : "null") + "," +
	           "    _id = " + (_id != null ? _id : "null") + "," +
	           "    _id_comuna = " + (_id_comuna != null ? _id_comuna : "null") + "," +
	           "    _correo = " + (_correo != null ? "'" + _correo + "'" : "null") +
			   "]";
    }


    public String toJSON() {
        return "Usuario : {" +
	           "    _fecha_vencimiento_licencia : " + (_fecha_vencimiento_licencia != null ? "STR_TO_DATE(" + _fecha_vencimiento_licencia + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _hombre : " + (_hombre != null ? "b'" + _hombre : "null") + "," +
	           "    _borrado : " + (_borrado != null ? "b'" + _borrado : "null") + "," +
	           "    _telefono : " + (_telefono != null ? "'" + _telefono + "'" : "null") + "," +
	           "    _fecha_modifiacion : " + (_fecha_modifiacion != null ? "STR_TO_DATE(" + _fecha_modifiacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _fecha_nacimiento : " + (_fecha_nacimiento != null ? "STR_TO_DATE(" + _fecha_nacimiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _nombre : " + (_nombre != null ? "'" + _nombre + "'" : "null") + "," +
	           "    _id : " + (_id != null ? _id : "null") + "," +
	           "    _id_comuna : " + (_id_comuna != null ? _id_comuna : "null") + "," +
	           "    _correo : " + (_correo != null ? "'" + _correo + "'" : "null") +
			   "}";
    }

}
