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
public class Rendimiento {
private String _fecha;
private Boolean _estanque_lleno;
private Long _id_rendimiento;
private Integer _costo;
private Integer _km;
private Integer _litros;
private Long _id_usuario;
private Long _id_vehiculo;
private Integer _latitud;
private Integer _longitud;

    private final static String _str_sql = 
        "    SELECT" +
        "    DATE_FORMAT(re.fecha, '%d-%m-%Y %H:%i:%s') AS fecha," +
        "    0+re.estanque_lleno AS estanque_lleno," +
        "    re.id_rendimiento AS id_rendimiento," +
        "    re.costo AS costo," +
        "    re.km AS km," +
        "    re.litros AS litros," +
        "    re.id_usuario AS id_usuario," +
        "    re.id_vehiculo AS id_vehiculo," +
        "    re.latitud AS latitud," +
        "    re.longitud AS longitud" +
        "    FROM rendimiento re";

    public Rendimiento() {
        _fecha = null;
        _estanque_lleno = null;
        _id_rendimiento = null;
        _costo = null;
        _km = null;
        _litros = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _latitud = null;
        _longitud = null;

    }
    /**
     * @return the _fecha
     */
    public String get_fecha() {
        return _fecha;
    }
    /**
     * @return the _estanque_lleno
     */
    public Boolean get_estanque_lleno() {
        return _estanque_lleno;
    }
    /**
     * @return the _id_rendimiento
     */
    public Long get_id_rendimiento() {
        return _id_rendimiento;
    }
    /**
     * @return the _costo
     */
    public Integer get_costo() {
        return _costo;
    }
    /**
     * @return the _km
     */
    public Integer get_km() {
        return _km;
    }
    /**
     * @return the _litros
     */
    public Integer get_litros() {
        return _litros;
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
    public Integer get_latitud() {
        return _latitud;
    }
    /**
     * @return the _longitud
     */
    public Integer get_longitud() {
        return _longitud;
    }
    /**
     * @param _fecha the _fecha to set
     */
    public void set_fecha(String _fecha) {
        this._fecha = _fecha;
    }
    /**
     * @param _estanque_lleno the _estanque_lleno to set
     */
    public void set_estanque_lleno(Boolean _estanque_lleno) {
        this._estanque_lleno = _estanque_lleno;
    }
    /**
     * @param _id_rendimiento the _id_rendimiento to set
     */
    public void set_id_rendimiento(Long _id_rendimiento) {
        this._id_rendimiento = _id_rendimiento;
    }
    /**
     * @param _costo the _costo to set
     */
    public void set_costo(Integer _costo) {
        this._costo = _costo;
    }
    /**
     * @param _km the _km to set
     */
    public void set_km(Integer _km) {
        this._km = _km;
    }
    /**
     * @param _litros the _litros to set
     */
    public void set_litros(Integer _litros) {
        this._litros = _litros;
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
    public void set_latitud(Integer _latitud) {
        this._latitud = _latitud;
    }
    /**
     * @param _longitud the _longitud to set
     */
    public void set_longitud(Integer _longitud) {
        this._longitud = _longitud;
    }

    public static Rendimiento fromRS(ResultSet p_rs) throws SQLException {
        Rendimiento ret = new Rendimiento();

        ret.set_fecha(p_rs.getString("fecha"));
        ret.set_estanque_lleno(p_rs.getBoolean("estanque_lleno"));
        ret.set_id_rendimiento(p_rs.getLong("id_rendimiento"));
        ret.set_costo(p_rs.getInt("costo"));
        ret.set_km(p_rs.getInt("km"));
        ret.set_litros(p_rs.getInt("litros"));
        ret.set_id_usuario(p_rs.getLong("id_usuario"));
        ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
        ret.set_latitud(p_rs.getInt("latitud"));
        ret.set_longitud(p_rs.getInt("longitud"));

        return ret;
    }

    public static Rendimiento getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
        Rendimiento ret = null;
        
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

    
    public static ArrayList<Rendimiento> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Rendimiento> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Rendimiento>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_usuario")) {
                    array_clauses.add("re.id_usuario = " + p.getValue());
                }
                else if (p.getKey().equals("id_rendimiento")) {
                    array_clauses.add("re.id_rendimiento = " + p.getValue());
                }
                else if (p.getKey().equals("id_usuario")) {
                    array_clauses.add("re.id_usuario = " + p.getValue());
                }
                else if (p.getKey().equals("id_vehiculo")) {
                    array_clauses.add("re.id_vehiculo = " + p.getValue());
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
            "    UPDATE rendimiento" +
            "    SET" +
            "    fecha = " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    estanque_lleno = " + (_estanque_lleno != null ? "b'" + _estanque_lleno : "null") + "," +
            "    costo = " + (_costo != null ? _costo : "null") + "," +
            "    km = " + (_km != null ? _km : "null") + "," +
            "    litros = " + (_litros != null ? _litros : "null") + "," +
            "    latitud = " + (_latitud != null ? _latitud : "null") + "," +
            "    longitud = " + (_longitud != null ? _longitud : "null") +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_rendimiento = " + Long.toString(this._id_rendimiento);

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
            "    INSERT INTO rendimiento" +
            "    (" +
            "    fecha, " +
            "    estanque_lleno, " +
            "    id_rendimiento, " +
            "    costo, " +
            "    km, " +
            "    litros, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    latitud, " +
            "    longitud)" +
            "    VALUES" +
            "    (" +
            "    " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    " + (_estanque_lleno != null ? "b'" + (_estanque_lleno ? 1 : 0) + "'" : "null") + "," +
            "    " + (_id_rendimiento != null ? "'" + _id_rendimiento + "'" : "null") + "," +
            "    " + (_costo != null ? "'" + _costo + "'" : "null") + "," +
            "    " + (_km != null ? "'" + _km + "'" : "null") + "," +
            "    " + (_litros != null ? "'" + _litros + "'" : "null") + "," +
            "    " + (_id_usuario != null ? "'" + _id_usuario + "'" : "null") + "," +
            "    " + (_id_vehiculo != null ? "'" + _id_vehiculo + "'" : "null") + "," +
            "    " + (_latitud != null ? "'" + _latitud + "'" : "null") + "," +
            "    " + (_longitud != null ? "'" + _longitud + "'" : "null") +
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
            "    DELETE FROM rendimiento" +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_rendimiento = " + Long.toString(this._id_rendimiento);

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
        Rendimiento obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_rendimiento = " + Long.toString(this._id_rendimiento) +
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
                _estanque_lleno = obj.get_estanque_lleno();
                _costo = obj.get_costo();
                _km = obj.get_km();
                _litros = obj.get_litros();
                _id_vehiculo = obj.get_id_vehiculo();
                _latitud = obj.get_latitud();
                _longitud = obj.get_longitud();
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
        return "Rendimiento [" +
	           "    _fecha = " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _estanque_lleno = " + (_estanque_lleno != null ? "b'" + _estanque_lleno : "null") + "," +
	           "    _id_rendimiento = " + (_id_rendimiento != null ? _id_rendimiento : "null") + "," +
	           "    _costo = " + (_costo != null ? _costo : "null") + "," +
	           "    _km = " + (_km != null ? _km : "null") + "," +
	           "    _litros = " + (_litros != null ? _litros : "null") + "," +
	           "    _id_usuario = " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo = " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _latitud = " + (_latitud != null ? _latitud : "null") + "," +
	           "    _longitud = " + (_longitud != null ? _longitud : "null") +
			   "]";
    }


    public String toJSON() {
        return "Rendimiento : {" +
	           "    _fecha : " + (_fecha != null ? "STR_TO_DATE(" + _fecha + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _estanque_lleno : " + (_estanque_lleno != null ? "b'" + _estanque_lleno : "null") + "," +
	           "    _id_rendimiento : " + (_id_rendimiento != null ? _id_rendimiento : "null") + "," +
	           "    _costo : " + (_costo != null ? _costo : "null") + "," +
	           "    _km : " + (_km != null ? _km : "null") + "," +
	           "    _litros : " + (_litros != null ? _litros : "null") + "," +
	           "    _id_usuario : " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo : " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _latitud : " + (_latitud != null ? _latitud : "null") + "," +
	           "    _longitud : " + (_longitud != null ? _longitud : "null") +
			   "}";
    }

}
