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
public class InfoSincro {
private Integer _id;
private String _fecha;
private String _fecha_fin_procesamiento;
private Byte _sentido;
private String _fecha_lectura;
private String _archivo_nombre;
private String _archivo_md5;
private Long _archivo_tamano;

    private final static String _str_sql = 
        "    SELECT" +
        "    in.id_info_sincro AS id," +
        "    DATE_FORMAT(in.fecha, '%d-%m-%Y %H:%i:%s') AS fecha," +
        "    DATE_FORMAT(in.fecha_fin_procesamiento, '%d-%m-%Y %H:%i:%s') AS fecha_fin_procesamiento," +
        "    in.sentido AS sentido," +
        "    DATE_FORMAT(in.fecha_lectura, '%d-%m-%Y %H:%i:%s') AS fecha_lectura," +
        "    in.archivo_nombre AS archivo_nombre," +
        "    in.archivo_md5 AS archivo_md5," +
        "    in.archivo_tamano AS archivo_tamano" +
        "    FROM info_sincro in";

    public InfoSincro() {
        _id = null;
        _fecha = null;
        _fecha_fin_procesamiento = null;
        _sentido = null;
        _fecha_lectura = null;
        _archivo_nombre = null;
        _archivo_md5 = null;
        _archivo_tamano = null;

    }
    /**
     * @return the _id
     */
    public Integer get_id() {
        return _id;
    }
    /**
     * @return the _fecha
     */
    public String get_fecha() {
        return _fecha;
    }
    /**
     * @return the _fecha_fin_procesamiento
     */
    public String get_fecha_fin_procesamiento() {
        return _fecha_fin_procesamiento;
    }
    /**
     * @return the _sentido
     */
    public Byte get_sentido() {
        return _sentido;
    }
    /**
     * @return the _fecha_lectura
     */
    public String get_fecha_lectura() {
        return _fecha_lectura;
    }
    /**
     * @return the _archivo_nombre
     */
    public String get_archivo_nombre() {
        return _archivo_nombre;
    }
    /**
     * @return the _archivo_md5
     */
    public String get_archivo_md5() {
        return _archivo_md5;
    }
    /**
     * @return the _archivo_tamano
     */
    public Long get_archivo_tamano() {
        return _archivo_tamano;
    }
    /**
     * @param _id the _id to set
     */
    public void set_id(Integer _id) {
        this._id = _id;
    }
    /**
     * @param _fecha the _fecha to set
     */
    public void set_fecha(String _fecha) {
        this._fecha = _fecha;
    }
    /**
     * @param _fecha_fin_procesamiento the _fecha_fin_procesamiento to set
     */
    public void set_fecha_fin_procesamiento(String _fecha_fin_procesamiento) {
        this._fecha_fin_procesamiento = _fecha_fin_procesamiento;
    }
    /**
     * @param _sentido the _sentido to set
     */
    public void set_sentido(Byte _sentido) {
        this._sentido = _sentido;
    }
    /**
     * @param _fecha_lectura the _fecha_lectura to set
     */
    public void set_fecha_lectura(String _fecha_lectura) {
        this._fecha_lectura = _fecha_lectura;
    }
    /**
     * @param _archivo_nombre the _archivo_nombre to set
     */
    public void set_archivo_nombre(String _archivo_nombre) {
        this._archivo_nombre = _archivo_nombre;
    }
    /**
     * @param _archivo_md5 the _archivo_md5 to set
     */
    public void set_archivo_md5(String _archivo_md5) {
        this._archivo_md5 = _archivo_md5;
    }
    /**
     * @param _archivo_tamano the _archivo_tamano to set
     */
    public void set_archivo_tamano(Long _archivo_tamano) {
        this._archivo_tamano = _archivo_tamano;
    }

    public static InfoSincro fromRS(ResultSet p_rs) throws SQLException {
        InfoSincro ret = new InfoSincro();

        ret.set_id(p_rs.getInt("id"));
        ret.set_fecha(p_rs.getString("fecha"));
        ret.set_fecha_fin_procesamiento(p_rs.getString("fecha_fin_procesamiento"));
        ret.set_sentido(p_rs.getByte("sentido"));
        ret.set_fecha_lectura(p_rs.getString("fecha_lectura"));
        ret.set_archivo_nombre(p_rs.getString("archivo_nombre"));
        ret.set_archivo_md5(p_rs.getString("archivo_md5"));
        ret.set_archivo_tamano(p_rs.getLong("archivo_tamano"));

        return ret;
    }

    public static InfoSincro getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
        InfoSincro ret = null;
        
        String str_sql = _str_sql +
            "  WHERE in." + p_key + " = " + p_value +
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

    public static InfoSincro getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_info_sincro", p_id);
    }
    
    public static ArrayList<InfoSincro> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<InfoSincro> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<InfoSincro>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_info_sincro")) {
                    array_clauses.add("in.id_info_sincro = " + p.getValue());
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
            "    UPDATE info_sincro" +
            "    SET" +
            "    fecha = " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    fecha_fin_procesamiento = " + (_fecha_fin_procesamiento != null ? "STR_TO_DATE(" + _fecha_fin_procesamiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    sentido = " + (_sentido != null ? _sentido : "null") + "," +
            "    fecha_lectura = " + (_fecha_lectura != null ? "STR_TO_DATE(" + _fecha_lectura + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    archivo_nombre = " + (_archivo_nombre != null ? "'" + _archivo_nombre + "'" : "null") + "," +
            "    archivo_md5 = " + (_archivo_md5 != null ? "'" + _archivo_md5 + "'" : "null") + "," +
            "    archivo_tamano = " + (_archivo_tamano != null ? _archivo_tamano : "null") +
            "    WHERE" +
            "    id_info_sincro = " + Integer.toString(this._id);

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
            "    INSERT INTO info_sincro" +
            "    (" +
            "    id_info_sincro, " +
            "    fecha, " +
            "    fecha_fin_procesamiento, " +
            "    sentido, " +
            "    fecha_lectura, " +
            "    archivo_nombre, " +
            "    archivo_md5, " +
            "    archivo_tamano)" +
            "    VALUES" +
            "    (" +
            "    " + (_id != null ? "'" + _id + "'" : "null") + "," +
            "    " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_fecha_fin_procesamiento != null ? "STR_TO_DATE(" + _fecha_fin_procesamiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_sentido != null ? "'" + _sentido + "'" : "null") + "," +
            "    " + (_fecha_lectura != null ? "STR_TO_DATE(" + _fecha_lectura + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_archivo_nombre != null ? "'" + _archivo_nombre + "'" : "null") + "," +
            "    " + (_archivo_md5 != null ? "'" + _archivo_md5 + "'" : "null") + "," +
            "    " + (_archivo_tamano != null ? "'" + _archivo_tamano + "'" : "null") +
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
            "    DELETE FROM info_sincro" +
            "    WHERE" +
            "    id_info_sincro = " + Integer.toString(this._id);

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
        InfoSincro obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_info_sincro = " + Integer.toString(this._id) +
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
                _fecha_fin_procesamiento = obj.get_fecha_fin_procesamiento();
                _sentido = obj.get_sentido();
                _fecha_lectura = obj.get_fecha_lectura();
                _archivo_nombre = obj.get_archivo_nombre();
                _archivo_md5 = obj.get_archivo_md5();
                _archivo_tamano = obj.get_archivo_tamano();
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
        return "InfoSincro [" +
	           "    _id = " + (_id != null ? _id : "null") + "," +
	           "    _fecha = " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _fecha_fin_procesamiento = " + (_fecha_fin_procesamiento != null ? "STR_TO_DATE(" + _fecha_fin_procesamiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _sentido = " + (_sentido != null ? _sentido : "null") + "," +
	           "    _fecha_lectura = " + (_fecha_lectura != null ? "STR_TO_DATE(" + _fecha_lectura + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _archivo_nombre = " + (_archivo_nombre != null ? "'" + _archivo_nombre + "'" : "null") + "," +
	           "    _archivo_md5 = " + (_archivo_md5 != null ? "'" + _archivo_md5 + "'" : "null") + "," +
	           "    _archivo_tamano = " + (_archivo_tamano != null ? _archivo_tamano : "null") +
			   "]";
    }


    public String toJSON() {
        return "InfoSincro : {" +
	           "    _id : " + (_id != null ? _id : "null") + "," +
	           "    _fecha : " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _fecha_fin_procesamiento : " + (_fecha_fin_procesamiento != null ? "STR_TO_DATE(" + _fecha_fin_procesamiento + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _sentido : " + (_sentido != null ? _sentido : "null") + "," +
	           "    _fecha_lectura : " + (_fecha_lectura != null ? "STR_TO_DATE(" + _fecha_lectura + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _archivo_nombre : " + (_archivo_nombre != null ? "'" + _archivo_nombre + "'" : "null") + "," +
	           "    _archivo_md5 : " + (_archivo_md5 != null ? "'" + _archivo_md5 + "'" : "null") + "," +
	           "    _archivo_tamano : " + (_archivo_tamano != null ? _archivo_tamano : "null") +
			   "}";
    }

}
