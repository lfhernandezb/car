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
private String _configuracion;
private Byte _valvulas;
private Integer _torque;
private Byte _cilindros;
private String _razon_compresion;
private String _codigo_fabricante;
private String _codigo;
private Integer _desplazamiento;
private Long _id_modelo_anio;
private String _tamanio;
private String _tipo;
private Long _id;
private Integer _potencia;
private String _tipo_compresor;
private String _tipo_combustible;

    private final static String _str_sql = 
        "    SELECT" +
        "    mo.configuracion AS configuracion," +
        "    mo.valvulas AS valvulas," +
        "    mo.torque AS torque," +
        "    mo.cilindros AS cilindros," +
        "    mo.razon_compresion AS razon_compresion," +
        "    mo.codigo_fabricante AS codigo_fabricante," +
        "    mo.codigo AS codigo," +
        "    mo.desplazamiento AS desplazamiento," +
        "    mo.id_modelo_anio AS id_modelo_anio," +
        "    mo.tamanio AS tamanio," +
        "    mo.tipo AS tipo," +
        "    mo.id_motor AS id," +
        "    mo.potencia AS potencia," +
        "    mo.tipo_compresor AS tipo_compresor," +
        "    mo.tipo_combustible AS tipo_combustible" +
        "    FROM motor mo";

    public Motor() {
        _configuracion = null;
        _valvulas = null;
        _torque = null;
        _cilindros = null;
        _razon_compresion = null;
        _codigo_fabricante = null;
        _codigo = null;
        _desplazamiento = null;
        _id_modelo_anio = null;
        _tamanio = null;
        _tipo = null;
        _id = null;
        _potencia = null;
        _tipo_compresor = null;
        _tipo_combustible = null;

    }
    /**
     * @return the _configuracion
     */
    public String get_configuracion() {
        return _configuracion;
    }
    /**
     * @return the _valvulas
     */
    public Byte get_valvulas() {
        return _valvulas;
    }
    /**
     * @return the _torque
     */
    public Integer get_torque() {
        return _torque;
    }
    /**
     * @return the _cilindros
     */
    public Byte get_cilindros() {
        return _cilindros;
    }
    /**
     * @return the _razon_compresion
     */
    public String get_razon_compresion() {
        return _razon_compresion;
    }
    /**
     * @return the _codigo_fabricante
     */
    public String get_codigo_fabricante() {
        return _codigo_fabricante;
    }
    /**
     * @return the _codigo
     */
    public String get_codigo() {
        return _codigo;
    }
    /**
     * @return the _desplazamiento
     */
    public Integer get_desplazamiento() {
        return _desplazamiento;
    }
    /**
     * @return the _id_modelo_anio
     */
    public Long get_id_modelo_anio() {
        return _id_modelo_anio;
    }
    /**
     * @return the _tamanio
     */
    public String get_tamanio() {
        return _tamanio;
    }
    /**
     * @return the _tipo
     */
    public String get_tipo() {
        return _tipo;
    }
    /**
     * @return the _id
     */
    public Long get_id() {
        return _id;
    }
    /**
     * @return the _potencia
     */
    public Integer get_potencia() {
        return _potencia;
    }
    /**
     * @return the _tipo_compresor
     */
    public String get_tipo_compresor() {
        return _tipo_compresor;
    }
    /**
     * @return the _tipo_combustible
     */
    public String get_tipo_combustible() {
        return _tipo_combustible;
    }
    /**
     * @param _configuracion the _configuracion to set
     */
    public void set_configuracion(String _configuracion) {
        this._configuracion = _configuracion;
    }
    /**
     * @param _valvulas the _valvulas to set
     */
    public void set_valvulas(Byte _valvulas) {
        this._valvulas = _valvulas;
    }
    /**
     * @param _torque the _torque to set
     */
    public void set_torque(Integer _torque) {
        this._torque = _torque;
    }
    /**
     * @param _cilindros the _cilindros to set
     */
    public void set_cilindros(Byte _cilindros) {
        this._cilindros = _cilindros;
    }
    /**
     * @param _razon_compresion the _razon_compresion to set
     */
    public void set_razon_compresion(String _razon_compresion) {
        this._razon_compresion = _razon_compresion;
    }
    /**
     * @param _codigo_fabricante the _codigo_fabricante to set
     */
    public void set_codigo_fabricante(String _codigo_fabricante) {
        this._codigo_fabricante = _codigo_fabricante;
    }
    /**
     * @param _codigo the _codigo to set
     */
    public void set_codigo(String _codigo) {
        this._codigo = _codigo;
    }
    /**
     * @param _desplazamiento the _desplazamiento to set
     */
    public void set_desplazamiento(Integer _desplazamiento) {
        this._desplazamiento = _desplazamiento;
    }
    /**
     * @param _id_modelo_anio the _id_modelo_anio to set
     */
    public void set_id_modelo_anio(Long _id_modelo_anio) {
        this._id_modelo_anio = _id_modelo_anio;
    }
    /**
     * @param _tamanio the _tamanio to set
     */
    public void set_tamanio(String _tamanio) {
        this._tamanio = _tamanio;
    }
    /**
     * @param _tipo the _tipo to set
     */
    public void set_tipo(String _tipo) {
        this._tipo = _tipo;
    }
    /**
     * @param _id the _id to set
     */
    public void set_id(Long _id) {
        this._id = _id;
    }
    /**
     * @param _potencia the _potencia to set
     */
    public void set_potencia(Integer _potencia) {
        this._potencia = _potencia;
    }
    /**
     * @param _tipo_compresor the _tipo_compresor to set
     */
    public void set_tipo_compresor(String _tipo_compresor) {
        this._tipo_compresor = _tipo_compresor;
    }
    /**
     * @param _tipo_combustible the _tipo_combustible to set
     */
    public void set_tipo_combustible(String _tipo_combustible) {
        this._tipo_combustible = _tipo_combustible;
    }

    public static Motor fromRS(ResultSet p_rs) throws SQLException {
        Motor ret = new Motor();

        ret.set_configuracion(p_rs.getString("configuracion"));
        ret.set_valvulas(p_rs.getByte("valvulas"));
        ret.set_torque(p_rs.getInt("torque"));
        ret.set_cilindros(p_rs.getByte("cilindros"));
        ret.set_razon_compresion(p_rs.getString("razon_compresion"));
        ret.set_codigo_fabricante(p_rs.getString("codigo_fabricante"));
        ret.set_codigo(p_rs.getString("codigo"));
        ret.set_desplazamiento(p_rs.getInt("desplazamiento"));
        ret.set_id_modelo_anio(p_rs.getLong("id_modelo_anio"));
        ret.set_tamanio(p_rs.getString("tamanio"));
        ret.set_tipo(p_rs.getString("tipo"));
        ret.set_id(p_rs.getLong("id"));
        ret.set_potencia(p_rs.getInt("potencia"));
        ret.set_tipo_compresor(p_rs.getString("tipo_compresor"));
        ret.set_tipo_combustible(p_rs.getString("tipo_combustible"));

        return ret;
    }

    public static Motor getByParameter(Connection p_conn, String p_key, String p_value) throws SQLException {
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

    public static Motor getById(Connection p_conn, String p_id) throws Exception {
        return getByParameter(p_conn, "id_motor", p_id);
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
                if (p.getKey().equals("id_motor")) {
                    array_clauses.add("mo.id_motor = " + p.getValue());
                }
                else if (p.getKey().equals("id_modelo_anio")) {
                    array_clauses.add("mo.id_modelo_anio = " + p.getValue());
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
            "    UPDATE motor" +
            "    SET" +
            "    configuracion = " + (_configuracion != null ? "'" + _configuracion + "'" : "null") + "," +
            "    valvulas = " + (_valvulas != null ? _valvulas : "null") + "," +
            "    torque = " + (_torque != null ? _torque : "null") + "," +
            "    cilindros = " + (_cilindros != null ? _cilindros : "null") + "," +
            "    razon_compresion = " + (_razon_compresion != null ? "'" + _razon_compresion + "'" : "null") + "," +
            "    codigo_fabricante = " + (_codigo_fabricante != null ? "'" + _codigo_fabricante + "'" : "null") + "," +
            "    codigo = " + (_codigo != null ? "'" + _codigo + "'" : "null") + "," +
            "    desplazamiento = " + (_desplazamiento != null ? _desplazamiento : "null") + "," +
            "    tamanio = " + (_tamanio != null ? "'" + _tamanio + "'" : "null") + "," +
            "    tipo = " + (_tipo != null ? "'" + _tipo + "'" : "null") + "," +
            "    potencia = " + (_potencia != null ? _potencia : "null") + "," +
            "    tipo_compresor = " + (_tipo_compresor != null ? "'" + _tipo_compresor + "'" : "null") + "," +
            "    tipo_combustible = " + (_tipo_combustible != null ? "'" + _tipo_combustible + "'" : "null") +
            "    WHERE" +
            "    id_motor = " + Long.toString(this._id);

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
            "    INSERT INTO motor" +
            "    (" +
            "    configuracion, " +
            "    valvulas, " +
            "    torque, " +
            "    cilindros, " +
            "    razon_compresion, " +
            "    codigo_fabricante, " +
            "    codigo, " +
            "    desplazamiento, " +
            "    id_modelo_anio, " +
            "    tamanio, " +
            "    tipo, " +
            "    id_motor, " +
            "    potencia, " +
            "    tipo_compresor, " +
            "    tipo_combustible)" +
            "    VALUES" +
            "    (" +
            "    " + (_configuracion != null ? "'" + _configuracion + "'" : "null") + "," +
            "    " + (_valvulas != null ? "'" + _valvulas + "'" : "null") + "," +
            "    " + (_torque != null ? "'" + _torque + "'" : "null") + "," +
            "    " + (_cilindros != null ? "'" + _cilindros + "'" : "null") + "," +
            "    " + (_razon_compresion != null ? "'" + _razon_compresion + "'" : "null") + "," +
            "    " + (_codigo_fabricante != null ? "'" + _codigo_fabricante + "'" : "null") + "," +
            "    " + (_codigo != null ? "'" + _codigo + "'" : "null") + "," +
            "    " + (_desplazamiento != null ? "'" + _desplazamiento + "'" : "null") + "," +
            "    " + (_id_modelo_anio != null ? "'" + _id_modelo_anio + "'" : "null") + "," +
            "    " + (_tamanio != null ? "'" + _tamanio + "'" : "null") + "," +
            "    " + (_tipo != null ? "'" + _tipo + "'" : "null") + "," +
            "    " + (_id != null ? "'" + _id + "'" : "null") + "," +
            "    " + (_potencia != null ? "'" + _potencia + "'" : "null") + "," +
            "    " + (_tipo_compresor != null ? "'" + _tipo_compresor + "'" : "null") + "," +
            "    " + (_tipo_combustible != null ? "'" + _tipo_combustible + "'" : "null") +
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
            "    DELETE FROM motor" +
            "    WHERE" +
            "    id_motor = " + Long.toString(this._id);

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
        Motor obj = null;
        
        String str_sql = _str_sql +
            "    WHERE" +
            "    id_motor = " + Long.toString(this._id) +
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

                _configuracion = obj.get_configuracion();
                _valvulas = obj.get_valvulas();
                _torque = obj.get_torque();
                _cilindros = obj.get_cilindros();
                _razon_compresion = obj.get_razon_compresion();
                _codigo_fabricante = obj.get_codigo_fabricante();
                _codigo = obj.get_codigo();
                _desplazamiento = obj.get_desplazamiento();
                _id_modelo_anio = obj.get_id_modelo_anio();
                _tamanio = obj.get_tamanio();
                _tipo = obj.get_tipo();
                _potencia = obj.get_potencia();
                _tipo_compresor = obj.get_tipo_compresor();
                _tipo_combustible = obj.get_tipo_combustible();
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
        return "Motor [" +
	           "    _configuracion = " + (_configuracion != null ? "'" + _configuracion + "'" : "null") + "," +
	           "    _valvulas = " + (_valvulas != null ? _valvulas : "null") + "," +
	           "    _torque = " + (_torque != null ? _torque : "null") + "," +
	           "    _cilindros = " + (_cilindros != null ? _cilindros : "null") + "," +
	           "    _razon_compresion = " + (_razon_compresion != null ? "'" + _razon_compresion + "'" : "null") + "," +
	           "    _codigo_fabricante = " + (_codigo_fabricante != null ? "'" + _codigo_fabricante + "'" : "null") + "," +
	           "    _codigo = " + (_codigo != null ? "'" + _codigo + "'" : "null") + "," +
	           "    _desplazamiento = " + (_desplazamiento != null ? _desplazamiento : "null") + "," +
	           "    _id_modelo_anio = " + (_id_modelo_anio != null ? _id_modelo_anio : "null") + "," +
	           "    _tamanio = " + (_tamanio != null ? "'" + _tamanio + "'" : "null") + "," +
	           "    _tipo = " + (_tipo != null ? "'" + _tipo + "'" : "null") + "," +
	           "    _id = " + (_id != null ? _id : "null") + "," +
	           "    _potencia = " + (_potencia != null ? _potencia : "null") + "," +
	           "    _tipo_compresor = " + (_tipo_compresor != null ? "'" + _tipo_compresor + "'" : "null") + "," +
	           "    _tipo_combustible = " + (_tipo_combustible != null ? "'" + _tipo_combustible + "'" : "null") +
			   "]";
    }


    public String toJSON() {
        return "Motor : {" +
	           "    _configuracion : " + (_configuracion != null ? "'" + _configuracion + "'" : "null") + "," +
	           "    _valvulas : " + (_valvulas != null ? _valvulas : "null") + "," +
	           "    _torque : " + (_torque != null ? _torque : "null") + "," +
	           "    _cilindros : " + (_cilindros != null ? _cilindros : "null") + "," +
	           "    _razon_compresion : " + (_razon_compresion != null ? "'" + _razon_compresion + "'" : "null") + "," +
	           "    _codigo_fabricante : " + (_codigo_fabricante != null ? "'" + _codigo_fabricante + "'" : "null") + "," +
	           "    _codigo : " + (_codigo != null ? "'" + _codigo + "'" : "null") + "," +
	           "    _desplazamiento : " + (_desplazamiento != null ? _desplazamiento : "null") + "," +
	           "    _id_modelo_anio : " + (_id_modelo_anio != null ? _id_modelo_anio : "null") + "," +
	           "    _tamanio : " + (_tamanio != null ? "'" + _tamanio + "'" : "null") + "," +
	           "    _tipo : " + (_tipo != null ? "'" + _tipo + "'" : "null") + "," +
	           "    _id : " + (_id != null ? _id : "null") + "," +
	           "    _potencia : " + (_potencia != null ? _potencia : "null") + "," +
	           "    _tipo_compresor : " + (_tipo_compresor != null ? "'" + _tipo_compresor + "'" : "null") + "," +
	           "    _tipo_combustible : " + (_tipo_combustible != null ? "'" + _tipo_combustible + "'" : "null") +
			   "}";
    }

}
