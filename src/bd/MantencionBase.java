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
public class MantencionBase {
private Integer _dias_entre_mantenciones;
private String _tipo_transmision;
private String _codigo_motor;
private Integer _km_entre_mantenciones;
private Boolean _depende_km;
private String _accion;
private String _url;
private String _descripcion_item;
private String _fecha_modificacion;
private Long _id_modelo_anio;
private Long _id;
private String _item;
private String _tipo_traccion;
private String _beneficios;

    private final static String _str_sql = 
        "    SELECT" +
        "    ma.dias_entre_mantenciones AS dias_entre_mantenciones," +
        "    ma.tipo_transmision AS tipo_transmision," +
        "    ma.codigo_motor AS codigo_motor," +
        "    ma.km_entre_mantenciones AS km_entre_mantenciones," +
        "    0+ma.depende_km AS depende_km," +
        "    ma.accion AS accion," +
        "    ma.url AS url," +
        "    ma.descripcion_item AS descripcion_item," +
        "    DATE_FORMAT(ma.fecha_modificacion, '%d-%m-%Y %H:%i:%s') AS fecha_modificacion," +
        "    ma.id_modelo_anio AS id_modelo_anio," +
        "    ma.id_mantencion_base AS id," +
        "    ma.item AS item," +
        "    ma.tipo_traccion AS tipo_traccion," +
        "    ma.beneficios AS beneficios" +
        "    FROM mantencion_base ma";

    public MantencionBase() {
        _dias_entre_mantenciones = null;
        _tipo_transmision = null;
        _codigo_motor = null;
        _km_entre_mantenciones = null;
        _depende_km = null;
        _accion = null;
        _url = null;
        _descripcion_item = null;
        _fecha_modificacion = null;
        _id_modelo_anio = null;
        _id = null;
        _item = null;
        _tipo_traccion = null;
        _beneficios = null;

    }
    /**
     * @return the _dias_entre_mantenciones
     */
    public Integer get_dias_entre_mantenciones() {
        return _dias_entre_mantenciones;
    }
    /**
     * @return the _tipo_transmision
     */
    public String get_tipo_transmision() {
        return _tipo_transmision;
    }
    /**
     * @return the _codigo_motor
     */
    public String get_codigo_motor() {
        return _codigo_motor;
    }
    /**
     * @return the _km_entre_mantenciones
     */
    public Integer get_km_entre_mantenciones() {
        return _km_entre_mantenciones;
    }
    /**
     * @return the _depende_km
     */
    public Boolean get_depende_km() {
        return _depende_km;
    }
    /**
     * @return the _accion
     */
    public String get_accion() {
        return _accion;
    }
    /**
     * @return the _url
     */
    public String get_url() {
        return _url;
    }
    /**
     * @return the _descripcion_item
     */
    public String get_descripcion_item() {
        return _descripcion_item;
    }
    /**
     * @return the _fecha_modificacion
     */
    public String get_fecha_modificacion() {
        return _fecha_modificacion;
    }
    /**
     * @return the _id_modelo_anio
     */
    public Long get_id_modelo_anio() {
        return _id_modelo_anio;
    }
    /**
     * @return the _id
     */
    public Long get_id() {
        return _id;
    }
    /**
     * @return the _item
     */
    public String get_item() {
        return _item;
    }
    /**
     * @return the _tipo_traccion
     */
    public String get_tipo_traccion() {
        return _tipo_traccion;
    }
    /**
     * @return the _beneficios
     */
    public String get_beneficios() {
        return _beneficios;
    }
    /**
     * @param _dias_entre_mantenciones the _dias_entre_mantenciones to set
     */
    public void set_dias_entre_mantenciones(Integer _dias_entre_mantenciones) {
        this._dias_entre_mantenciones = _dias_entre_mantenciones;
    }
    /**
     * @param _tipo_transmision the _tipo_transmision to set
     */
    public void set_tipo_transmision(String _tipo_transmision) {
        this._tipo_transmision = _tipo_transmision;
    }
    /**
     * @param _codigo_motor the _codigo_motor to set
     */
    public void set_codigo_motor(String _codigo_motor) {
        this._codigo_motor = _codigo_motor;
    }
    /**
     * @param _km_entre_mantenciones the _km_entre_mantenciones to set
     */
    public void set_km_entre_mantenciones(Integer _km_entre_mantenciones) {
        this._km_entre_mantenciones = _km_entre_mantenciones;
    }
    /**
     * @param _depende_km the _depende_km to set
     */
    public void set_depende_km(Boolean _depende_km) {
        this._depende_km = _depende_km;
    }
    /**
     * @param _accion the _accion to set
     */
    public void set_accion(String _accion) {
        this._accion = _accion;
    }
    /**
     * @param _url the _url to set
     */
    public void set_url(String _url) {
        this._url = _url;
    }
    /**
     * @param _descripcion_item the _descripcion_item to set
     */
    public void set_descripcion_item(String _descripcion_item) {
        this._descripcion_item = _descripcion_item;
    }
    /**
     * @param _fecha_modificacion the _fecha_modificacion to set
     */
    public void set_fecha_modificacion(String _fecha_modificacion) {
        this._fecha_modificacion = _fecha_modificacion;
    }
    /**
     * @param _id_modelo_anio the _id_modelo_anio to set
     */
    public void set_id_modelo_anio(Long _id_modelo_anio) {
        this._id_modelo_anio = _id_modelo_anio;
    }
    /**
     * @param _id the _id to set
     */
    public void set_id(Long _id) {
        this._id = _id;
    }
    /**
     * @param _item the _item to set
     */
    public void set_item(String _item) {
        this._item = _item;
    }
    /**
     * @param _tipo_traccion the _tipo_traccion to set
     */
    public void set_tipo_traccion(String _tipo_traccion) {
        this._tipo_traccion = _tipo_traccion;
    }
    /**
     * @param _beneficios the _beneficios to set
     */
    public void set_beneficios(String _beneficios) {
        this._beneficios = _beneficios;
    }

    public static MantencionBase fromRS(ResultSet p_rs) throws SQLException {
        MantencionBase ret = new MantencionBase();

        ret.set_dias_entre_mantenciones(p_rs.getInt("dias_entre_mantenciones"));
        ret.set_tipo_transmision(p_rs.getString("tipo_transmision"));
        ret.set_codigo_motor(p_rs.getString("codigo_motor"));
        ret.set_km_entre_mantenciones(p_rs.getInt("km_entre_mantenciones"));
        ret.set_depende_km(p_rs.getBoolean("depende_km"));
        ret.set_accion(p_rs.getString("accion"));
        ret.set_url(p_rs.getString("url"));
        ret.set_descripcion_item(p_rs.getString("descripcion_item"));
        ret.set_fecha_modificacion(p_rs.getString("fecha_modificacion"));
        ret.set_id_modelo_anio(p_rs.getLong("id_modelo_anio"));
        ret.set_id(p_rs.getLong("id"));
        ret.set_item(p_rs.getString("item"));
        ret.set_tipo_traccion(p_rs.getString("tipo_traccion"));
        ret.set_beneficios(p_rs.getString("beneficios"));

        return ret;
    }

    public static MantencionBase getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
        MantencionBase ret = null;
        
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

    public static MantencionBase getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_mantencion_base", p_id);
    }
    
    public static ArrayList<MantencionBase> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<MantencionBase> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<MantencionBase>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_mantencion_base")) {
                    array_clauses.add("ma.id_mantencion_base = " + p.getValue());
                }
                else if (p.getKey().equals("id_modelo_anio")) {
                    array_clauses.add("ma.id_modelo_anio = " + p.getValue());
                }
                else if (p.getKey().equals("mas reciente")) {
                    array_clauses.add("ma.fecha_modificacion > STR_TO_DATE('" + p.getValue() + "', '%d-%m-%Y %H:%i:%s')");
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
            "    UPDATE mantencion_base" +
            "    SET" +
            "    dias_entre_mantenciones = " + (_dias_entre_mantenciones != null ? _dias_entre_mantenciones : "null") + "," +
            "    tipo_transmision = " + (_tipo_transmision != null ? "'" + _tipo_transmision + "'" : "null") + "," +
            "    codigo_motor = " + (_codigo_motor != null ? "'" + _codigo_motor + "'" : "null") + "," +
            "    km_entre_mantenciones = " + (_km_entre_mantenciones != null ? _km_entre_mantenciones : "null") + "," +
            "    depende_km = " + (_depende_km != null ? "b'" + _depende_km : "null") + "," +
            "    accion = " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
            "    url = " + (_url != null ? "'" + _url + "'" : "null") + "," +
            "    descripcion_item = " + (_descripcion_item != null ? "'" + _descripcion_item + "'" : "null") + "," +
            "    fecha_modificacion = " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
            "    item = " + (_item != null ? "'" + _item + "'" : "null") + "," +
            "    tipo_traccion = " + (_tipo_traccion != null ? "'" + _tipo_traccion + "'" : "null") + "," +
            "    beneficios = " + (_beneficios != null ? "'" + _beneficios + "'" : "null") +
            "    WHERE" +
            "    id_mantencion_base = " + Long.toString(this._id);

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
            "    INSERT INTO mantencion_base" +
            "    (" +
            "    dias_entre_mantenciones, " +
            "    tipo_transmision, " +
            "    codigo_motor, " +
            "    km_entre_mantenciones, " +
            "    depende_km, " +
            "    accion, " +
            "    url, " +
            "    descripcion_item, " +
            "    id_modelo_anio, " +
            "    id_mantencion_base, " +
            "    item, " +
            "    tipo_traccion, " +
            "    beneficios)" +
            "    VALUES" +
            "    (" +
            "    " + (_dias_entre_mantenciones != null ? "'" + _dias_entre_mantenciones + "'" : "null") + "," +
            "    " + (_tipo_transmision != null ? "'" + _tipo_transmision + "'" : "null") + "," +
            "    " + (_codigo_motor != null ? "'" + _codigo_motor + "'" : "null") + "," +
            "    " + (_km_entre_mantenciones != null ? "'" + _km_entre_mantenciones + "'" : "null") + "," +
            "    " + (_depende_km != null ? "b'" + (_depende_km ? 1 : 0) + "'" : "null") + "," +
            "    " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
            "    " + (_url != null ? "'" + _url + "'" : "null") + "," +
            "    " + (_descripcion_item != null ? "'" + _descripcion_item + "'" : "null") + "," +
            "    " + (_id_modelo_anio != null ? "'" + _id_modelo_anio + "'" : "null") + "," +
            "    " + (_id != null ? "'" + _id + "'" : "null") + "," +
            "    " + (_item != null ? "'" + _item + "'" : "null") + "," +
            "    " + (_tipo_traccion != null ? "'" + _tipo_traccion + "'" : "null") + "," +
            "    " + (_beneficios != null ? "'" + _beneficios + "'" : "null") +
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
            "    DELETE FROM mantencion_base" +
            "    WHERE" +
            "    id_mantencion_base = " + Long.toString(this._id);

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
        MantencionBase obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_mantencion_base = " + Long.toString(this._id) +
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

                _dias_entre_mantenciones = obj.get_dias_entre_mantenciones();
                _tipo_transmision = obj.get_tipo_transmision();
                _codigo_motor = obj.get_codigo_motor();
                _km_entre_mantenciones = obj.get_km_entre_mantenciones();
                _depende_km = obj.get_depende_km();
                _accion = obj.get_accion();
                _url = obj.get_url();
                _descripcion_item = obj.get_descripcion_item();
                _fecha_modificacion = obj.get_fecha_modificacion();
                _id_modelo_anio = obj.get_id_modelo_anio();
                _item = obj.get_item();
                _tipo_traccion = obj.get_tipo_traccion();
                _beneficios = obj.get_beneficios();
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
        return "MantencionBase [" +
	           "    _dias_entre_mantenciones = " + (_dias_entre_mantenciones != null ? _dias_entre_mantenciones : "null") + "," +
	           "    _tipo_transmision = " + (_tipo_transmision != null ? "'" + _tipo_transmision + "'" : "null") + "," +
	           "    _codigo_motor = " + (_codigo_motor != null ? "'" + _codigo_motor + "'" : "null") + "," +
	           "    _km_entre_mantenciones = " + (_km_entre_mantenciones != null ? _km_entre_mantenciones : "null") + "," +
	           "    _depende_km = " + (_depende_km != null ? "b'" + _depende_km : "null") + "," +
	           "    _accion = " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
	           "    _url = " + (_url != null ? "'" + _url + "'" : "null") + "," +
	           "    _descripcion_item = " + (_descripcion_item != null ? "'" + _descripcion_item + "'" : "null") + "," +
	           "    _fecha_modificacion = " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_modelo_anio = " + (_id_modelo_anio != null ? _id_modelo_anio : "null") + "," +
	           "    _id = " + (_id != null ? _id : "null") + "," +
	           "    _item = " + (_item != null ? "'" + _item + "'" : "null") + "," +
	           "    _tipo_traccion = " + (_tipo_traccion != null ? "'" + _tipo_traccion + "'" : "null") + "," +
	           "    _beneficios = " + (_beneficios != null ? "'" + _beneficios + "'" : "null") +
			   "]";
    }


    public String toJSON() {
        return "MantencionBase : {" +
	           "    _dias_entre_mantenciones : " + (_dias_entre_mantenciones != null ? _dias_entre_mantenciones : "null") + "," +
	           "    _tipo_transmision : " + (_tipo_transmision != null ? "'" + _tipo_transmision + "'" : "null") + "," +
	           "    _codigo_motor : " + (_codigo_motor != null ? "'" + _codigo_motor + "'" : "null") + "," +
	           "    _km_entre_mantenciones : " + (_km_entre_mantenciones != null ? _km_entre_mantenciones : "null") + "," +
	           "    _depende_km : " + (_depende_km != null ? "b'" + _depende_km : "null") + "," +
	           "    _accion : " + (_accion != null ? "'" + _accion + "'" : "null") + "," +
	           "    _url : " + (_url != null ? "'" + _url + "'" : "null") + "," +
	           "    _descripcion_item : " + (_descripcion_item != null ? "'" + _descripcion_item + "'" : "null") + "," +
	           "    _fecha_modificacion : " + (_fecha_modificacion != null ? "STR_TO_DATE(" + _fecha_modificacion + ", '%d-%m-%Y %H:%i:%s')" : "null") + "," +
	           "    _id_modelo_anio : " + (_id_modelo_anio != null ? _id_modelo_anio : "null") + "," +
	           "    _id : " + (_id != null ? _id : "null") + "," +
	           "    _item : " + (_item != null ? "'" + _item + "'" : "null") + "," +
	           "    _tipo_traccion : " + (_tipo_traccion != null ? "'" + _tipo_traccion + "'" : "null") + "," +
	           "    _beneficios : " + (_beneficios != null ? "'" + _beneficios + "'" : "null") +
			   "}";
    }

}
