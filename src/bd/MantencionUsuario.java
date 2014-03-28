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
public class MantencionUsuario {
    private Long _id_mantencion_usuario;
    private Long _id_usuario;
    private Long _id_vehiculo;
    private String _nombre;
    private String _descripcion;
    private String _beneficios;
    private String _URL;
    private Boolean _DependeKm;
    private Integer _KmEntreMantenciones;
    private Integer _DiasEntreMantenciones;
    private String _MantencionUsuariocol;
    private Long _id_mantencion_base;
    private Boolean _mantecion_base;
    private String _mantencion_usuariocol;
    private String _fecha_modificacion;

    private final static String _str_sql = 
        "    SELECT " +
        "    id_mantencion_usuario, " +
        "    id_usuario, " +
        "    id_vehiculo, " +
        "    nombre, " +
        "    descripcion, " +
        "    beneficios, " +
        "    URL, " +
        "    0+DependeKm AS DependeKm, " +
        "    KmEntreMantenciones, " +
        "    DiasEntreMantenciones, " +
        "    MantencionUsuariocol, " +
        "    id_mantencion_base, " +
        "    0+mantecion_base AS mantecion_base, " +
        "    mantencion_usuariocol, " +
        "    DATE_FORMAT(ma.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion " +
        "    FROM mantencion_usuario ma ";

    public MantencionUsuario() {
        _id_mantencion_usuario = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _nombre = null;
        _descripcion = null;
        _beneficios = null;
        _URL = null;
        _DependeKm = null;
        _KmEntreMantenciones = null;
        _DiasEntreMantenciones = null;
        _MantencionUsuariocol = null;
        _id_mantencion_base = null;
        _mantecion_base = null;
        _mantencion_usuariocol = null;
        _fecha_modificacion = null;

    }

    /**
     * @return the _id_mantencion_usuario
     */
    public Long get_id_mantencion_usuario() {
        return _id_mantencion_usuario;
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
     * @return the _nombre
     */
    public String get_nombre() {
        return _nombre;
    }
    /**
     * @return the _descripcion
     */
    public String get_descripcion() {
        return _descripcion;
    }
    /**
     * @return the _beneficios
     */
    public String get_beneficios() {
        return _beneficios;
    }
    /**
     * @return the _URL
     */
    public String get_URL() {
        return _URL;
    }
    /**
     * @return the _DependeKm
     */
    public Boolean get_DependeKm() {
        return _DependeKm;
    }
    /**
     * @return the _KmEntreMantenciones
     */
    public Integer get_KmEntreMantenciones() {
        return _KmEntreMantenciones;
    }
    /**
     * @return the _DiasEntreMantenciones
     */
    public Integer get_DiasEntreMantenciones() {
        return _DiasEntreMantenciones;
    }
    /**
     * @return the _MantencionUsuariocol
     */
    public String get_MantencionUsuariocol() {
        return _MantencionUsuariocol;
    }
    /**
     * @return the _id_mantencion_base
     */
    public Long get_id_mantencion_base() {
        return _id_mantencion_base;
    }
    /**
     * @return the _mantecion_base
     */
    public Boolean get_mantecion_base() {
        return _mantecion_base;
    }
    /**
     * @return the _mantencion_usuariocol
     */
    public String get_mantencion_usuariocol() {
        return _mantencion_usuariocol;
    }
    /**
     * @return the _fecha_modificacion
     */
    public String get_fecha_modificacion() {
        return _fecha_modificacion;
    }

    /**
     * @param _id_mantencion_usuario the _id_mantencion_usuario to set
     */
    public void set_id_mantencion_usuario(Long _id_mantencion_usuario) {
        this._id_mantencion_usuario = _id_mantencion_usuario;
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
     * @param _nombre the _nombre to set
     */
    public void set_nombre(String _nombre) {
        this._nombre = _nombre;
    }
    /**
     * @param _descripcion the _descripcion to set
     */
    public void set_descripcion(String _descripcion) {
        this._descripcion = _descripcion;
    }
    /**
     * @param _beneficios the _beneficios to set
     */
    public void set_beneficios(String _beneficios) {
        this._beneficios = _beneficios;
    }
    /**
     * @param _URL the _URL to set
     */
    public void set_URL(String _URL) {
        this._URL = _URL;
    }
    /**
     * @param _DependeKm the _DependeKm to set
     */
    public void set_DependeKm(Boolean _DependeKm) {
        this._DependeKm = _DependeKm;
    }
    /**
     * @param _KmEntreMantenciones the _KmEntreMantenciones to set
     */
    public void set_KmEntreMantenciones(Integer _KmEntreMantenciones) {
        this._KmEntreMantenciones = _KmEntreMantenciones;
    }
    /**
     * @param _DiasEntreMantenciones the _DiasEntreMantenciones to set
     */
    public void set_DiasEntreMantenciones(Integer _DiasEntreMantenciones) {
        this._DiasEntreMantenciones = _DiasEntreMantenciones;
    }
    /**
     * @param _MantencionUsuariocol the _MantencionUsuariocol to set
     */
    public void set_MantencionUsuariocol(String _MantencionUsuariocol) {
        this._MantencionUsuariocol = _MantencionUsuariocol;
    }
    /**
     * @param _id_mantencion_base the _id_mantencion_base to set
     */
    public void set_id_mantencion_base(Long _id_mantencion_base) {
        this._id_mantencion_base = _id_mantencion_base;
    }
    /**
     * @param _mantecion_base the _mantecion_base to set
     */
    public void set_mantecion_base(Boolean _mantecion_base) {
        this._mantecion_base = _mantecion_base;
    }
    /**
     * @param _mantencion_usuariocol the _mantencion_usuariocol to set
     */
    public void set_mantencion_usuariocol(String _mantencion_usuariocol) {
        this._mantencion_usuariocol = _mantencion_usuariocol;
    }
    /**
     * @param _fecha_modificacion the _fecha_modificacion to set
     */
    public void set_fecha_modificacion(String _fecha_modificacion) {
        this._fecha_modificacion = _fecha_modificacion;
    }

    public static MantencionUsuario fromRS(ResultSet p_rs) throws SQLException {
        MantencionUsuario ret = new MantencionUsuario();

        try {
            ret.set_id_mantencion_usuario(p_rs.getLong("id_mantencion_usuario"));
            ret.set_id_usuario(p_rs.getLong("id_usuario"));
            ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
            ret.set_nombre(p_rs.getString("nombre"));
            ret.set_descripcion(p_rs.getString("descripcion"));
            ret.set_beneficios(p_rs.getString("beneficios"));
            ret.set_URL(p_rs.getString("URL"));
            ret.set_DependeKm(p_rs.getBoolean("DependeKm"));
            ret.set_KmEntreMantenciones(p_rs.getInt("KmEntreMantenciones"));
            ret.set_DiasEntreMantenciones(p_rs.getInt("DiasEntreMantenciones"));
            ret.set_MantencionUsuariocol(p_rs.getString("MantencionUsuariocol"));
            ret.set_id_mantencion_base(p_rs.getLong("id_mantencion_base"));
            ret.set_mantecion_base(p_rs.getBoolean("mantecion_base"));
            ret.set_mantencion_usuariocol(p_rs.getString("mantencion_usuariocol"));
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

    public static MantencionUsuario getByParameter(Connection p_conn, String p_key, String p_value) throws Exception {
        MantencionUsuario ret = null;
        
        String str_sql = _str_sql +
            "  WHERE ma." + p_key + " = " + p_value +
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

    public static MantencionUsuario getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_mantencion_usuario", p_id);
    }
    
    public static ArrayList<MantencionUsuario> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<MantencionUsuario> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<MantencionUsuario>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_comunidad")) {
                    array_clauses.add("ma.id_comunidad = " + p.getValue());
                }
                else if (p.getKey().equals("id_comuna")) {
                    array_clauses.add("ma.id_comuna = " + p.getValue());
                }
                else if (p.getKey().equals("latitud_mayor")) {
                    array_clauses.add("ma.latitud > " + p.getValue());
                }
                else if (p.getKey().equals("latitud_menor")) {
                    array_clauses.add("ma.latitud < " + p.getValue());
                }
                else if (p.getKey().equals("longitud_mayor")) {
                    array_clauses.add("ma.longitud > " + p.getValue());
                }
                else if (p.getKey().equals("longitud_menor")) {
                    array_clauses.add("ma.longitud < " + p.getValue());
                }
                else if (p.getKey().equals("posicion_reciente")) {
                    array_clauses.add("ma.fecha > DATE_ADD(now(), INTERVAL -" + p.getValue() + " MINUTE)");
                }
                else if (p.getKey().equals("id_distinto")) {
                    array_clauses.add("ma.id_usuario <> " + p.getValue());
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
            "    UPDATE mantencion_usuario" +
            "    SET " +
            "    id_mantencion_usuario, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    nombre, " +
            "    descripcion, " +
            "    beneficios, " +
            "    URL, " +
            "    0+DependeKm AS DependeKm, " +
            "    KmEntreMantenciones, " +
            "    DiasEntreMantenciones, " +
            "    MantencionUsuariocol, " +
            "    id_mantencion_base, " +
            "    0+mantecion_base AS mantecion_base, " +
            "    mantencion_usuariocol, " +
            "    DATE_FORMAT(ma.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion " +
            "    WHERE id_mantencion_usuario = " + Long.toString(this._id_mantencion_usuario);
        
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
            "    INSERT INTO mantencion_usuario" +
            "    (" +
            "    id_mantencion_usuario, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    nombre, " +
            "    descripcion, " +
            "    beneficios, " +
            "    URL, " +
            "    DependeKm, " +
            "    KmEntreMantenciones, " +
            "    DiasEntreMantenciones, " +
            "    MantencionUsuariocol, " +
            "    id_mantencion_base, " +
            "    mantecion_base, " +
            "    mantencion_usuariocol, " +
            "    fecha_modificacion " +
            "    )" +
            "    VALUES" +
            "    (" +
            "    " + (_id_mantencion_usuario != null ? _id_mantencion_usuario.toString() : "null") + "," +
            "    " + (_id_usuario != null ? _id_usuario.toString() : "null") + "," +
            "    " + (_id_vehiculo != null ? _id_vehiculo.toString() : "null") + "," +
            "    " + (_nombre != null ? "'" + _nombre + "'" : "null") + "," +
            "    " + (_descripcion != null ? "'" + _descripcion + "'" : "null") + "," +
            "    " + (_beneficios != null ? "'" + _beneficios + "'" : "null") + "," +
            "    " + (_URL != null ? "'" + _URL + "'" : "null") + "," +
            "    " + (_DependeKm != null ? "b'" + (_DependeKm ? 1 : 0) + "'" : "null") + "," +
            "    " + (_KmEntreMantenciones != null ? _KmEntreMantenciones.toString() : "null") + "," +
            "    " + (_DiasEntreMantenciones != null ? _DiasEntreMantenciones.toString() : "null") + "," +
            "    " + (_MantencionUsuariocol != null ? "'" + _MantencionUsuariocol + "'" : "null") + "," +
            "    " + (_id_mantencion_base != null ? _id_mantencion_base.toString() : "null") + "," +
            "    " + (_mantecion_base != null ? "b'" + (_mantecion_base ? 1 : 0) + "'" : "null") + "," +
            "    " + (_mantencion_usuariocol != null ? "'" + _mantencion_usuariocol + "'" : "null") + "," +
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
                _id_mantencion_usuario = rs.getLong(1);
            } else {
                // throw an exception from here
                throw new Exception("Error al obtener id");
            }

            rs.close();
            rs = null;
            System.out.println("Key returned from getGeneratedKeys():" + _id_mantencion_usuario.toString());
                        
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
    
    public static int delete(Connection p_conn, Integer p_id_mantencion_usuario) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "  DELETE FROM mantencion_usuario";
        
        if (p_id_mantencion_usuario != null) {
            str_sql +=
                "  WHERE id_mantencion_usuario = " + p_id_mantencion_usuario.toString();
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