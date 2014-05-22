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
public class Vehiculo {
private Integer _anio;
private Boolean _aire_acondicionado;
private String _alias;
private Boolean _borrado;
private Byte _id_traccion;
private Integer _km;
private Boolean _alza_vidrios;
private String _fecha_modificacion;
private Long _id_usuario;
private Long _id_vehiculo;
private String _patente;
private Long _id_modelo;
private Byte _id_combustible;
private Byte _id_tipo_transmision;

    private final static String _str_sql = 
        "    SELECT" +
        "    ve.anio AS anio," +
        "    0+ve.aire_acondicionado AS aire_acondicionado," +
        "    ve.alias AS alias," +
        "    0+ve.borrado AS borrado," +
        "    ve.id_traccion AS id_traccion," +
        "    ve.km AS km," +
        "    0+ve.alza_vidrios AS alza_vidrios," +
        "    DATE_FORMAT(ve.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion," +
        "    ve.id_usuario AS id_usuario," +
        "    ve.id_vehiculo AS id_vehiculo," +
        "    ve.patente AS patente," +
        "    ve.id_modelo AS id_modelo," +
        "    ve.id_combustible AS id_combustible," +
        "    ve.id_tipo_transmision AS id_tipo_transmision" +
        "    FROM vehiculo ve";

    public Vehiculo() {
        _anio = null;
        _aire_acondicionado = null;
        _alias = null;
        _borrado = null;
        _id_traccion = null;
        _km = null;
        _alza_vidrios = null;
        _fecha_modificacion = null;
        _id_usuario = null;
        _id_vehiculo = null;
        _patente = null;
        _id_modelo = null;
        _id_combustible = null;
        _id_tipo_transmision = null;

    }
    /**
     * @return the _anio
     */
    public Integer get_anio() {
        return _anio;
    }
    /**
     * @return the _aire_acondicionado
     */
    public Boolean get_aire_acondicionado() {
        return _aire_acondicionado;
    }
    /**
     * @return the _alias
     */
    public String get_alias() {
        return _alias;
    }
    /**
     * @return the _borrado
     */
    public Boolean get_borrado() {
        return _borrado;
    }
    /**
     * @return the _id_traccion
     */
    public Byte get_id_traccion() {
        return _id_traccion;
    }
    /**
     * @return the _km
     */
    public Integer get_km() {
        return _km;
    }
    /**
     * @return the _alza_vidrios
     */
    public Boolean get_alza_vidrios() {
        return _alza_vidrios;
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
     * @return the _patente
     */
    public String get_patente() {
        return _patente;
    }
    /**
     * @return the _id_modelo
     */
    public Long get_id_modelo() {
        return _id_modelo;
    }
    /**
     * @return the _id_combustible
     */
    public Byte get_id_combustible() {
        return _id_combustible;
    }
    /**
     * @return the _id_tipo_transmision
     */
    public Byte get_id_tipo_transmision() {
        return _id_tipo_transmision;
    }
    /**
     * @param _anio the _anio to set
     */
    public void set_anio(Integer _anio) {
        this._anio = _anio;
    }
    /**
     * @param _aire_acondicionado the _aire_acondicionado to set
     */
    public void set_aire_acondicionado(Boolean _aire_acondicionado) {
        this._aire_acondicionado = _aire_acondicionado;
    }
    /**
     * @param _alias the _alias to set
     */
    public void set_alias(String _alias) {
        this._alias = _alias;
    }
    /**
     * @param _borrado the _borrado to set
     */
    public void set_borrado(Boolean _borrado) {
        this._borrado = _borrado;
    }
    /**
     * @param _id_traccion the _id_traccion to set
     */
    public void set_id_traccion(Byte _id_traccion) {
        this._id_traccion = _id_traccion;
    }
    /**
     * @param _km the _km to set
     */
    public void set_km(Integer _km) {
        this._km = _km;
    }
    /**
     * @param _alza_vidrios the _alza_vidrios to set
     */
    public void set_alza_vidrios(Boolean _alza_vidrios) {
        this._alza_vidrios = _alza_vidrios;
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
     * @param _patente the _patente to set
     */
    public void set_patente(String _patente) {
        this._patente = _patente;
    }
    /**
     * @param _id_modelo the _id_modelo to set
     */
    public void set_id_modelo(Long _id_modelo) {
        this._id_modelo = _id_modelo;
    }
    /**
     * @param _id_combustible the _id_combustible to set
     */
    public void set_id_combustible(Byte _id_combustible) {
        this._id_combustible = _id_combustible;
    }
    /**
     * @param _id_tipo_transmision the _id_tipo_transmision to set
     */
    public void set_id_tipo_transmision(Byte _id_tipo_transmision) {
        this._id_tipo_transmision = _id_tipo_transmision;
    }

    public static Vehiculo fromRS(ResultSet p_rs) throws SQLException {
        Vehiculo ret = new Vehiculo();

        ret.set_anio(p_rs.getInt("anio"));
        ret.set_aire_acondicionado(p_rs.getBoolean("aire_acondicionado"));
        ret.set_alias(p_rs.getString("alias"));
        ret.set_borrado(p_rs.getBoolean("borrado"));
        ret.set_id_traccion(p_rs.getByte("id_traccion"));
        ret.set_km(p_rs.getInt("km"));
        ret.set_alza_vidrios(p_rs.getBoolean("alza_vidrios"));
        ret.set_fecha_modificacion(p_rs.getString("fecha_modificacion"));
        ret.set_id_usuario(p_rs.getLong("id_usuario"));
        ret.set_id_vehiculo(p_rs.getLong("id_vehiculo"));
        ret.set_patente(p_rs.getString("patente"));
        ret.set_id_modelo(p_rs.getLong("id_modelo"));
        ret.set_id_combustible(p_rs.getByte("id_combustible"));
        ret.set_id_tipo_transmision(p_rs.getByte("id_tipo_transmision"));

        return ret;
    }

    public static Vehiculo getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
        Vehiculo ret = null;
        
        String str_sql = _str_sql +
            "  WHERE ve." + p_key + " = " + p_value +
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

    
    public static ArrayList<Vehiculo> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Vehiculo> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Vehiculo>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_usuario")) {
                    array_clauses.add("ve.id_usuario = " + p.getValue());
                }
                else if (p.getKey().equals("id_vehiculo")) {
                    array_clauses.add("ve.id_vehiculo = " + p.getValue());
                }
                else if (p.getKey().equals("id_usuario")) {
                    array_clauses.add("ve.id_usuario = " + p.getValue());
                }
                else if (p.getKey().equals("id_modelo")) {
                    array_clauses.add("ve.id_modelo = " + p.getValue());
                }
                else if (p.getKey().equals("id_traccion")) {
                    array_clauses.add("ve.id_traccion = " + p.getValue());
                }
                else if (p.getKey().equals("id_tipo_transmision")) {
                    array_clauses.add("ve.id_tipo_transmision = " + p.getValue());
                }
                else if (p.getKey().equals("id_combustible")) {
                    array_clauses.add("ve.id_combustible = " + p.getValue());
                }
                else if (p.getKey().equals("mas reciente")) {
                    array_clauses.add("ve.fecha_modificacion > STR_TO_DATE('" + p.getValue() + "', '%d-%m-%Y %H:%i:%s')");
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
            "    UPDATE vehiculo" +
            "    SET" +
            "    anio = " + (_anio != null ? _anio : "null") + "," +
            "    aire_acondicionado = " + (_aire_acondicionado != null ? "b'" + _aire_acondicionado : "null") + "," +
            "    alias = " + (_alias != null ? "'" + _alias + "'" : "null") + "," +
            "    borrado = " + (_borrado != null ? "b'" + _borrado : "null") + "," +
            "    km = " + (_km != null ? _km : "null") + "," +
            "    alza_vidrios = " + (_alza_vidrios != null ? "b'" + _alza_vidrios : "null") + "," +
            "    fecha_modificacion = " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    patente = " + (_patente != null ? "'" + _patente + "'" : "null") +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_vehiculo = " + Long.toString(this._id_vehiculo);

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
            "    INSERT INTO vehiculo" +
            "    (" +
            "    anio, " +
            "    aire_acondicionado, " +
            "    alias, " +
            "    id_traccion, " +
            "    km, " +
            "    alza_vidrios, " +
            "    id_usuario, " +
            "    id_vehiculo, " +
            "    patente, " +
            "    id_modelo, " +
            "    id_combustible, " +
            "    id_tipo_transmision)" +
            "    VALUES" +
            "    (" +
            "    " + (_anio != null ? "'" + _anio + "'" : "null") + "," +
            "    " + (_aire_acondicionado != null ? "b'" + (_aire_acondicionado ? 1 : 0) + "'" : "null") + "," +
            "    " + (_alias != null ? "'" + _alias + "'" : "null") + "," +
            "    " + (_id_traccion != null ? "'" + _id_traccion + "'" : "null") + "," +
            "    " + (_km != null ? "'" + _km + "'" : "null") + "," +
            "    " + (_alza_vidrios != null ? "b'" + (_alza_vidrios ? 1 : 0) + "'" : "null") + "," +
            "    " + (_id_usuario != null ? "'" + _id_usuario + "'" : "null") + "," +
            "    " + (_id_vehiculo != null ? "'" + _id_vehiculo + "'" : "null") + "," +
            "    " + (_patente != null ? "'" + _patente + "'" : "null") + "," +
            "    " + (_id_modelo != null ? "'" + _id_modelo + "'" : "null") + "," +
            "    " + (_id_combustible != null ? "'" + _id_combustible + "'" : "null") + "," +
            "    " + (_id_tipo_transmision != null ? "'" + _id_tipo_transmision + "'" : "null") +
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
            "    DELETE FROM vehiculo" +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_vehiculo = " + Long.toString(this._id_vehiculo);

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
        Vehiculo obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_usuario = " + Long.toString(this._id_usuario) + " AND" +
            "    id_vehiculo = " + Long.toString(this._id_vehiculo) +
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

                _anio = obj.get_anio();
                _aire_acondicionado = obj.get_aire_acondicionado();
                _alias = obj.get_alias();
                _borrado = obj.get_borrado();
                _id_traccion = obj.get_id_traccion();
                _km = obj.get_km();
                _alza_vidrios = obj.get_alza_vidrios();
                _fecha_modificacion = obj.get_fecha_modificacion();
                _patente = obj.get_patente();
                _id_modelo = obj.get_id_modelo();
                _id_combustible = obj.get_id_combustible();
                _id_tipo_transmision = obj.get_id_tipo_transmision();
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
        return "Vehiculo [" +
	           "    _anio = " + (_anio != null ? _anio : "null") + "," +
	           "    _aire_acondicionado = " + (_aire_acondicionado != null ? "b'" + _aire_acondicionado : "null") + "," +
	           "    _alias = " + (_alias != null ? "'" + _alias + "'" : "null") + "," +
	           "    _borrado = " + (_borrado != null ? "b'" + _borrado : "null") + "," +
	           "    _id_traccion = " + (_id_traccion != null ? _id_traccion : "null") + "," +
	           "    _km = " + (_km != null ? _km : "null") + "," +
	           "    _alza_vidrios = " + (_alza_vidrios != null ? "b'" + _alza_vidrios : "null") + "," +
	           "    _fecha_modificacion = " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_usuario = " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo = " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _patente = " + (_patente != null ? "'" + _patente + "'" : "null") + "," +
	           "    _id_modelo = " + (_id_modelo != null ? _id_modelo : "null") + "," +
	           "    _id_combustible = " + (_id_combustible != null ? _id_combustible : "null") + "," +
	           "    _id_tipo_transmision = " + (_id_tipo_transmision != null ? _id_tipo_transmision : "null") +
			   "]";
    }


    public String toJSON() {
        return "Vehiculo : {" +
	           "    _anio : " + (_anio != null ? _anio : "null") + "," +
	           "    _aire_acondicionado : " + (_aire_acondicionado != null ? "b'" + _aire_acondicionado : "null") + "," +
	           "    _alias : " + (_alias != null ? "'" + _alias + "'" : "null") + "," +
	           "    _borrado : " + (_borrado != null ? "b'" + _borrado : "null") + "," +
	           "    _id_traccion : " + (_id_traccion != null ? _id_traccion : "null") + "," +
	           "    _km : " + (_km != null ? _km : "null") + "," +
	           "    _alza_vidrios : " + (_alza_vidrios != null ? "b'" + _alza_vidrios : "null") + "," +
	           "    _fecha_modificacion : " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_usuario : " + (_id_usuario != null ? _id_usuario : "null") + "," +
	           "    _id_vehiculo : " + (_id_vehiculo != null ? _id_vehiculo : "null") + "," +
	           "    _patente : " + (_patente != null ? "'" + _patente + "'" : "null") + "," +
	           "    _id_modelo : " + (_id_modelo != null ? _id_modelo : "null") + "," +
	           "    _id_combustible : " + (_id_combustible != null ? _id_combustible : "null") + "," +
	           "    _id_tipo_transmision : " + (_id_tipo_transmision != null ? _id_tipo_transmision : "null") +
			   "}";
    }

}
