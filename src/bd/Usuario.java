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
    private Long _id;
    private Long _id_comuna;
    private String _nombre;
    private String _correo;
    private String _fecha_nacimiento;
    private Boolean _hombre;
    private String _telefono;
    private String _fecha_vencimiento_licencia;

    private final static String _str_sql =
        "    SELECT " +
        "    id_usuario AS id, " +
        "    id_comuna, " +
        "    nombre, " +
        "    correo, " +
        "    DATE_FORMAT(us.fecha_nacimiento, '%d-%m-%Y %H:%i:%s') AS fecha_nacimiento, " +
        "    0+hombre AS hombre, " +
        "    telefono, " +
        "    DATE_FORMAT(us.fecha_vencimiento_licencia, '%d-%m-%Y %H:%i:%s') AS fecha_vencimiento_licencia " +
        "    FROM usuario us ";

    public Usuario() {
        _id = null;
        _id_comuna = null;
        _nombre = null;
        _correo = null;
        _fecha_nacimiento = null;
        _hombre = null;
        _telefono = null;
        _fecha_vencimiento_licencia = null;

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
     * @return the _nombre
     */
    public String get_nombre() {
        return _nombre;
    }
    /**
     * @return the _correo
     */
    public String get_correo() {
        return _correo;
    }
    /**
     * @return the _fecha_nacimiento
     */
    public String get_fecha_nacimiento() {
        return _fecha_nacimiento;
    }
    /**
     * @return the _hombre
     */
    public Boolean get_hombre() {
        return _hombre;
    }
    /**
     * @return the _telefono
     */
    public String get_telefono() {
        return _telefono;
    }
    /**
     * @return the _fecha_vencimiento_licencia
     */
    public String get_fecha_vencimiento_licencia() {
        return _fecha_vencimiento_licencia;
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
     * @param _nombre the _nombre to set
     */
    public void set_nombre(String _nombre) {
        this._nombre = _nombre;
    }
    /**
     * @param _correo the _correo to set
     */
    public void set_correo(String _correo) {
        this._correo = _correo;
    }
    /**
     * @param _fecha_nacimiento the _fecha_nacimiento to set
     */
    public void set_fecha_nacimiento(String _fecha_nacimiento) {
        this._fecha_nacimiento = _fecha_nacimiento;
    }
    /**
     * @param _hombre the _hombre to set
     */
    public void set_hombre(Boolean _hombre) {
        this._hombre = _hombre;
    }
    /**
     * @param _telefono the _telefono to set
     */
    public void set_telefono(String _telefono) {
        this._telefono = _telefono;
    }
    /**
     * @param _fecha_vencimiento_licencia the _fecha_vencimiento_licencia to set
     */
    public void set_fecha_vencimiento_licencia(String _fecha_vencimiento_licencia) {
        this._fecha_vencimiento_licencia = _fecha_vencimiento_licencia;
    }

    public static Usuario fromRS(ResultSet p_rs) throws SQLException {
        Usuario ret = new Usuario();

        try {
            ret.set_id(p_rs.getLong("id"));
            ret.set_id_comuna(p_rs.getLong("id_comuna"));
            ret.set_nombre(p_rs.getString("nombre"));
            ret.set_correo(p_rs.getString("correo"));
            ret.set_fecha_nacimiento(p_rs.getString("fecha_nacimiento"));
            ret.set_hombre(p_rs.getBoolean("hombre"));
            ret.set_telefono(p_rs.getString("telefono"));
            ret.set_fecha_vencimiento_licencia(p_rs.getString("fecha_vencimiento_licencia"));
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

    public static Usuario getByParameter(Connection p_conn, String p_key, String p_value) throws Exception {
        Usuario ret = null;

        String str_sql = _str_sql +
            "  WHERE u." + p_key + " = " + p_value +
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

    public static Usuario getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_usuario", p_id);
    }

    public static ArrayList<Usuario> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws SQLException {
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
                if (p.getKey().equals("id_comunidad")) {
                    array_clauses.add("c.id_comunidad = " + p.getValue());
                }
                else if (p.getKey().equals("id_comuna")) {
                    array_clauses.add("cm.id_comuna = " + p.getValue());
                }
                else if (p.getKey().equals("latitud_mayor")) {
                    array_clauses.add("up.latitud > " + p.getValue());
                }
                else if (p.getKey().equals("latitud_menor")) {
                    array_clauses.add("up.latitud < " + p.getValue());
                }
                else if (p.getKey().equals("longitud_mayor")) {
                    array_clauses.add("up.longitud > " + p.getValue());
                }
                else if (p.getKey().equals("longitud_menor")) {
                    array_clauses.add("up.longitud < " + p.getValue());
                }
                else if (p.getKey().equals("posicion_reciente")) {
                    array_clauses.add("up.fecha > DATE_ADD(now(), INTERVAL -" + p.getValue() + " MINUTE)");
                }
                else if (p.getKey().equals("id_distinto")) {
                    array_clauses.add("u.id_usuario <> " + p.getValue());
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
            "    UPDATE usuario" +
            "    SET " +
            "    id_comuna, " +
            "    nombre, " +
            "    correo, " +
            "    DATE_FORMAT(us.fecha_nacimiento, '%d-%m-%Y %H:%i:%s') AS fecha_nacimiento, " +
            "    0+hombre AS hombre, " +
            "    telefono, " +
            "    DATE_FORMAT(us.fecha_vencimiento_licencia, '%d-%m-%Y %H:%i:%s') AS fecha_vencimiento_licencia " +
            "    WHERE id_usuario = " + Long.toString(this._id);

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
            "    INSERT INTO usuario" +
            "    (" +
            "    id_comuna, " +
            "    nombre, " +
            "    correo, " +
            "    fecha_nacimiento, " +
            "    hombre, " +
            "    telefono, " +
            "    fecha_vencimiento_licencia " +
            "    )" +
            "    VALUES" +
            "    (" +
            "    " + (_id_comuna != null ? _id_comuna.toString() : "null") + "," +
            "    " + (_nombre != null ? "'" + _nombre + "'" : "null") + "," +
            "    " + (_correo != null ? "'" + _correo + "'" : "null") + "," +
            "    " + (_fecha_nacimiento != null ? "STR_TO_DATE(" + _fecha_nacimiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_hombre != null ? "b'" + (_hombre ? 1 : 0) + "'" : "null") + "," +
            "    " + (_telefono != null ? "'" + _telefono + "'" : "null") + "," +
            "    " + (_fecha_vencimiento_licencia != null ? "STR_TO_DATE(" + _fecha_vencimiento_licencia + ", '%d-%m-%Y %H:%i:%s')" : "null") +
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

    public static int delete(Connection p_conn, Integer p_id) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "  DELETE FROM usuario";

        if (p_id != null) {
            str_sql +=
                "  WHERE id_usuario = " + p_id.toString();
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