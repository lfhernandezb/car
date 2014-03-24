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
public class Motor {
    private Long _id;
    private String _codigo;
    private String _razon_compresion;
    private Byte _cilindros;
    private String _tamanio;
    private Integer _desplazamiento;
    private String _configuracion;
    private String _tipo_combustible;
    private Integer _potencia;
    private Integer _torque;
    private Byte _valvulas;
    private String _codigo_fabricante;
    private String _tipo;
    private String _tipo_compresor;
    private Long _id_modelo_anio;

    private final static String _str_sql = 
        "    SELECT " +
        "    id_motor AS id, " +
        "    codigo, " +
        "    razon_compresion, " +
        "    cilindros, " +
        "    tamanio, " +
        "    desplazamiento, " +
        "    configuracion, " +
        "    tipo_combustible, " +
        "    potencia, " +
        "    torque, " +
        "    valvulas, " +
        "    codigo_fabricante, " +
        "    tipo, " +
        "    tipo_compresor, " +
        "    id_modelo_anio " +
        "    FROM motor mo ";

    public Motor() {
        _id = null;
        _codigo = null;
        _razon_compresion = null;
        _cilindros = null;
        _tamanio = null;
        _desplazamiento = null;
        _configuracion = null;
        _tipo_combustible = null;
        _potencia = null;
        _torque = null;
        _valvulas = null;
        _codigo_fabricante = null;
        _tipo = null;
        _tipo_compresor = null;
        _id_modelo_anio = null;

    }

    /**
     * @return the _id
     */
    public Long get_id() {
        return _id;
    }
    /**
     * @return the _codigo
     */
    public String get_codigo() {
        return _codigo;
    }
    /**
     * @return the _razon_compresion
     */
    public String get_razon_compresion() {
        return _razon_compresion;
    }
    /**
     * @return the _cilindros
     */
    public Byte get_cilindros() {
        return _cilindros;
    }
    /**
     * @return the _tamanio
     */
    public String get_tamanio() {
        return _tamanio;
    }
    /**
     * @return the _desplazamiento
     */
    public Integer get_desplazamiento() {
        return _desplazamiento;
    }
    /**
     * @return the _configuracion
     */
    public String get_configuracion() {
        return _configuracion;
    }
    /**
     * @return the _tipo_combustible
     */
    public String get_tipo_combustible() {
        return _tipo_combustible;
    }
    /**
     * @return the _potencia
     */
    public Integer get_potencia() {
        return _potencia;
    }
    /**
     * @return the _torque
     */
    public Integer get_torque() {
        return _torque;
    }
    /**
     * @return the _valvulas
     */
    public Byte get_valvulas() {
        return _valvulas;
    }
    /**
     * @return the _codigo_fabricante
     */
    public String get_codigo_fabricante() {
        return _codigo_fabricante;
    }
    /**
     * @return the _tipo
     */
    public String get_tipo() {
        return _tipo;
    }
    /**
     * @return the _tipo_compresor
     */
    public String get_tipo_compresor() {
        return _tipo_compresor;
    }
    /**
     * @return the _id_modelo_anio
     */
    public Long get_id_modelo_anio() {
        return _id_modelo_anio;
    }

    /**
     * @param _id the _id to set
     */
    public void set_id(Long _id) {
        this._id = _id;
    }
    /**
     * @param _codigo the _codigo to set
     */
    public void set_codigo(String _codigo) {
        this._codigo = _codigo;
    }
    /**
     * @param _razon_compresion the _razon_compresion to set
     */
    public void set_razon_compresion(String _razon_compresion) {
        this._razon_compresion = _razon_compresion;
    }
    /**
     * @param _cilindros the _cilindros to set
     */
    public void set_cilindros(Byte _cilindros) {
        this._cilindros = _cilindros;
    }
    /**
     * @param _tamanio the _tamanio to set
     */
    public void set_tamanio(String _tamanio) {
        this._tamanio = _tamanio;
    }
    /**
     * @param _desplazamiento the _desplazamiento to set
     */
    public void set_desplazamiento(Integer _desplazamiento) {
        this._desplazamiento = _desplazamiento;
    }
    /**
     * @param _configuracion the _configuracion to set
     */
    public void set_configuracion(String _configuracion) {
        this._configuracion = _configuracion;
    }
    /**
     * @param _tipo_combustible the _tipo_combustible to set
     */
    public void set_tipo_combustible(String _tipo_combustible) {
        this._tipo_combustible = _tipo_combustible;
    }
    /**
     * @param _potencia the _potencia to set
     */
    public void set_potencia(Integer _potencia) {
        this._potencia = _potencia;
    }
    /**
     * @param _torque the _torque to set
     */
    public void set_torque(Integer _torque) {
        this._torque = _torque;
    }
    /**
     * @param _valvulas the _valvulas to set
     */
    public void set_valvulas(Byte _valvulas) {
        this._valvulas = _valvulas;
    }
    /**
     * @param _codigo_fabricante the _codigo_fabricante to set
     */
    public void set_codigo_fabricante(String _codigo_fabricante) {
        this._codigo_fabricante = _codigo_fabricante;
    }
    /**
     * @param _tipo the _tipo to set
     */
    public void set_tipo(String _tipo) {
        this._tipo = _tipo;
    }
    /**
     * @param _tipo_compresor the _tipo_compresor to set
     */
    public void set_tipo_compresor(String _tipo_compresor) {
        this._tipo_compresor = _tipo_compresor;
    }
    /**
     * @param _id_modelo_anio the _id_modelo_anio to set
     */
    public void set_id_modelo_anio(Long _id_modelo_anio) {
        this._id_modelo_anio = _id_modelo_anio;
    }

    public static Motor fromRS(ResultSet p_rs) throws SQLException {
        Motor ret = new Motor();

        try {
            ret.set_id(p_rs.getLong("id"));
            ret.set_codigo(p_rs.getString("codigo"));
            ret.set_razon_compresion(p_rs.getString("razon_compresion"));
            ret.set_cilindros(p_rs.getByte("cilindros"));
            ret.set_tamanio(p_rs.getString("tamanio"));
            ret.set_desplazamiento(p_rs.getInt("desplazamiento"));
            ret.set_configuracion(p_rs.getString("configuracion"));
            ret.set_tipo_combustible(p_rs.getString("tipo_combustible"));
            ret.set_potencia(p_rs.getInt("potencia"));
            ret.set_torque(p_rs.getInt("torque"));
            ret.set_valvulas(p_rs.getByte("valvulas"));
            ret.set_codigo_fabricante(p_rs.getString("codigo_fabricante"));
            ret.set_tipo(p_rs.getString("tipo"));
            ret.set_tipo_compresor(p_rs.getString("tipo_compresor"));
            ret.set_id_modelo_anio(p_rs.getLong("id_modelo_anio"));
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

    public static Motor getByParameter(Connection p_conn, String p_key, String p_value) throws Exception {
        Motor ret = null;
        
        String str_sql = _str_sql +
            "  WHERE mo." + p_key + " = " + p_value +
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

    public static Motor getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_motor", p_id);
    }
    
    public static Motor getByCodigo(Connection p_conn, String p_codigo) throws Exception {
        return getByParameter(p_conn, "codigo", "'" + p_codigo + "'");
    }

    public static ArrayList<Motor> seek(Connection p_conn, ArrayList<AbstractMap.SimpleEntry<String, String>> p_parameters, String p_order, String p_direction, int p_offset, int p_limit) throws Exception {
        Statement stmt = null;
        ResultSet rs = null;
        String str_sql;
        ArrayList<Motor> ret;
        
        str_sql = "";
        
        try {
            ArrayList<String> array_clauses = new ArrayList<String>();
            
            ret = new ArrayList<Motor>();
            
            str_sql = _str_sql;
            
            for (AbstractMap.SimpleEntry<String, String> p : p_parameters) {
                if (p.getKey().equals("id_comunidad")) {
                    array_clauses.add("mo.id_comunidad = " + p.getValue());
                }
                else if (p.getKey().equals("id_comuna")) {
                    array_clauses.add("mo.id_comuna = " + p.getValue());
                }
                else if (p.getKey().equals("latitud_mayor")) {
                    array_clauses.add("mo.latitud > " + p.getValue());
                }
                else if (p.getKey().equals("latitud_menor")) {
                    array_clauses.add("mo.latitud < " + p.getValue());
                }
                else if (p.getKey().equals("longitud_mayor")) {
                    array_clauses.add("mo.longitud > " + p.getValue());
                }
                else if (p.getKey().equals("longitud_menor")) {
                    array_clauses.add("mo.longitud < " + p.getValue());
                }
                else if (p.getKey().equals("posicion_reciente")) {
                    array_clauses.add("mo.fecha > DATE_ADD(now(), INTERVAL -" + p.getValue() + " MINUTE)");
                }
                else if (p.getKey().equals("id_distinto")) {
                    array_clauses.add("mo.id_usuario <> " + p.getValue());
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
            "    UPDATE motor" +
            "    SET " +
            "    id_motor AS id, " +
            "    codigo, " +
            "    razon_compresion, " +
            "    cilindros, " +
            "    tamanio, " +
            "    desplazamiento, " +
            "    configuracion, " +
            "    tipo_combustible, " +
            "    potencia, " +
            "    torque, " +
            "    valvulas, " +
            "    codigo_fabricante, " +
            "    tipo, " +
            "    tipo_compresor, " +
            "    id_modelo_anio " +
            "    WHERE id_motor = " + Long.toString(this._id);
        
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
            "    INSERT INTO motor" +
            "    (" +
            "    id_motor, " +
            "    codigo, " +
            "    razon_compresion, " +
            "    cilindros, " +
            "    tamanio, " +
            "    desplazamiento, " +
            "    configuracion, " +
            "    tipo_combustible, " +
            "    potencia, " +
            "    torque, " +
            "    valvulas, " +
            "    codigo_fabricante, " +
            "    tipo, " +
            "    tipo_compresor, " +
            "    id_modelo_anio " +
            "    )" +
            "    VALUES" +
            "    (" +
            "    " + (_id != null ? _id.toString() : "null") + "," +
            "    " + (_codigo != null ? "'" + _codigo + "'" : "null") + "," +
            "    " + (_razon_compresion != null ? "'" + _razon_compresion + "'" : "null") + "," +
            "    " + (_cilindros != null ? _cilindros.toString() : "null") + "," +
            "    " + (_tamanio != null ? "'" + _tamanio + "'" : "null") + "," +
            "    " + (_desplazamiento != null ? _desplazamiento.toString() : "null") + "," +
            "    " + (_configuracion != null ? "'" + _configuracion + "'" : "null") + "," +
            "    " + (_tipo_combustible != null ? "'" + _tipo_combustible + "'" : "null") + "," +
            "    " + (_potencia != null ? _potencia.toString() : "null") + "," +
            "    " + (_torque != null ? _torque.toString() : "null") + "," +
            "    " + (_valvulas != null ? _valvulas.toString() : "null") + "," +
            "    " + (_codigo_fabricante != null ? "'" + _codigo_fabricante + "'" : "null") + "," +
            "    " + (_tipo != null ? "'" + _tipo + "'" : "null") + "," +
            "    " + (_tipo_compresor != null ? "'" + _tipo_compresor + "'" : "null") + "," +
            "    " + (_id_modelo_anio != null ? _id_modelo_anio.toString() : "null") +
            "    )";
        
        try {
            stmt = p_conn.createStatement();
            
            ret = stmt.executeUpdate(str_sql, Statement.RETURN_GENERATED_KEYS);
            /*
            if (stmt.executeUpdate(str_sql) < 1) {
                throw new Exception("No hubo filas afectadas");
            }
            */
            /*
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
    
    public static int delete(Connection p_conn, Integer p_id_motor) throws Exception {

        int ret = -1;
        Statement stmt = null;

        String str_sql =
            "  DELETE FROM motor";
        
        if (p_id_motor != null) {
            str_sql +=
                "  WHERE id_motor = " + p_id_motor.toString();
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