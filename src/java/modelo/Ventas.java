package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.swing.table.DefaultTableModel;

public class Ventas {
    private int idVenta;
    private int no_factura;
    private String serie;
    private String fecha_factura;
    private int idcliente;
    private int idempleado;
    private int idproducto;
    private int cantidad;
    private double precio_costo_unitario;
    private conexion conexionDB;

    // Constructor por defecto
    public Ventas() {}

    // Constructor para agregar una nueva venta
    public Ventas(int idVenta, int no_factura, String serie, String fecha_factura, int idcliente, int idempleado, int idproducto, int cantidad, double precio_costo_unitario) {
        this.idVenta = idVenta;
        this.no_factura = no_factura;
        this.serie = serie;
        this.fecha_factura = fecha_factura;
        this.idcliente = idcliente;
        this.idempleado = idempleado;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public int getNo_factura() {
        return no_factura;
    }

    public void setNo_factura(int no_factura) {
        this.no_factura = no_factura;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getFecha_factura() {
        return fecha_factura;
    }

    public void setFecha_factura(String fecha_factura) {
        this.fecha_factura = fecha_factura;
    }

    public int getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(int idcliente) {
        this.idcliente = idcliente;
    }

    public int getIdempleado() {
        return idempleado;
    }

    public void setIdempleado(int idempleado) {
        this.idempleado = idempleado;
    }

    public int getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio_costo_unitario() {
        return precio_costo_unitario;
    }

    public void setPrecio_costo_unitario(double precio_costo_unitario) {
        this.precio_costo_unitario = precio_costo_unitario;
    }

    public conexion getConexionDB() {
        return conexionDB;
    }

    public void setConexionDB(conexion conexionDB) {
        this.conexionDB = conexionDB;
    }

    // Métodos para obtener y establecer campos...
    // Agregar aquí getters y setters

    // Método para agregar ventas y detalles de venta
    public int agregarVenta() {
        int retorno = 0;
        PreparedStatement parametroVenta = null;
        PreparedStatement parametroDetalle = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            // Insertar en la tabla ventas
            String queryVenta = "INSERT INTO ventas (nofactura, serie, fechafactura, idcliente, idempleado) VALUES (?, ?, ?, ?, ?);";
            parametroVenta = conexionDB.conectar_db.prepareStatement(queryVenta, PreparedStatement.RETURN_GENERATED_KEYS);
            parametroVenta.setInt(1, getNo_factura());
            parametroVenta.setString(2, getSerie());
            parametroVenta.setString(3, getFecha_factura());
            parametroVenta.setInt(4, getIdcliente());
            parametroVenta.setInt(5, getIdempleado());
            parametroVenta.executeUpdate();

            // Obtener el idVenta generado
            ResultSet generatedKeys = parametroVenta.getGeneratedKeys();
            if (generatedKeys.next()) {
                idVenta = generatedKeys.getInt(1);
            }

            // Insertar en la tabla ventas_detalle
            String queryDetalle = "INSERT INTO ventas_detalle (idventa, idproducto, cantidad, precio_unitario) VALUES (?, ?, ?, ?);";
            parametroDetalle = conexionDB.conectar_db.prepareStatement(queryDetalle);
            parametroDetalle.setInt(1, idVenta);
            parametroDetalle.setInt(2, getIdproducto());
            parametroDetalle.setInt(3, getCantidad());
            parametroDetalle.setDouble(4, getPrecio_costo_unitario());
            retorno = parametroDetalle.executeUpdate();

        } catch (SQLException ex) {
            System.err.println("Error al agregar venta: " + ex.getMessage());
        } finally {
            closeResources(parametroVenta, parametroDetalle);
        }
        return retorno;
    }

     // Método para modificar ventas y detalles de venta
    public int modificarVenta() {
        int retorno = 0;
        PreparedStatement parametroVenta = null;
        PreparedStatement parametroDetalle = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            // Actualizar la tabla ventas
            String queryVenta = "UPDATE ventas SET nofactura = ?, serie = ?,  idcliente = ?, idempleado = ? WHERE idVenta = ?;";
            parametroVenta = conexionDB.conectar_db.prepareStatement(queryVenta);
            parametroVenta.setInt(1, getNo_factura());
            parametroVenta.setString(2, getSerie());
            parametroVenta.setInt(3, getIdcliente());
            parametroVenta.setInt(4, getIdempleado());
            parametroVenta.setInt(5, getIdVenta());
            parametroVenta.executeUpdate();

            // Actualizar la tabla ventas_detalle
            String queryDetalle = "UPDATE ventas_detalle SET idproducto = ?, cantidad = ? WHERE idVenta = ?;";
            parametroDetalle = conexionDB.conectar_db.prepareStatement(queryDetalle);
            parametroDetalle.setInt(1, getIdproducto());
            parametroDetalle.setInt(2, getCantidad());
            parametroDetalle.setInt(3, getIdVenta());
            retorno = parametroDetalle.executeUpdate();

        } catch (SQLException ex) {
            System.err.println("Error al modificar venta: " + ex.getMessage());
        } finally {
            closeResources(parametroVenta, parametroDetalle);
        }
        return retorno;
    }

    // Método para eliminar ventas y detalles de venta
    public int eliminarVenta() {
        int retorno = 0;
        PreparedStatement parametroVenta = null;
        PreparedStatement parametroDetalle = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            // Eliminar de la tabla ventas_detalle
            String queryDetalle = "DELETE FROM ventas_detalle WHERE idventa = ?;";
            parametroDetalle = conexionDB.conectar_db.prepareStatement(queryDetalle);
            parametroDetalle.setInt(1, getIdVenta());
            parametroDetalle.executeUpdate();

            // Eliminar de la tabla ventas
            String queryVenta = "DELETE FROM ventas WHERE idVenta = ?;";
            parametroVenta = conexionDB.conectar_db.prepareStatement(queryVenta);
            parametroVenta.setInt(1, getIdVenta());
            retorno = parametroVenta.executeUpdate();

        } catch (SQLException ex) {
            System.err.println("Error al eliminar venta: " + ex.getMessage());
        } finally {
            closeResources(parametroVenta, parametroDetalle);
        }
        return retorno;
    }

    // Método para leer ventas y detalles de venta
    public DefaultTableModel leerVentas() {
        DefaultTableModel tabla = new DefaultTableModel();
        PreparedStatement parametro = null;
        ResultSet consulta = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "SELECT v.idVenta, v.nofactura, v.serie, v.fechafactura, v.idcliente, v.idempleado, v.fechaingreso, " +
                           "vd.idproducto, vd.cantidad, vd.precio_unitario " +
                           "FROM ventas v INNER JOIN ventas_detalle vd ON v.idVenta = vd.idventa ORDER BY v.idVenta DESC;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            consulta = parametro.executeQuery();

            String encabezado[] = {"idVenta", "nofactura", "serie", "fechafactura", "idcliente", "idempleado", "fechaingreso", "idproducto", "cantidad", "precio_unitario"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[10];

            while (consulta.next()) {
                datos[0] = consulta.getString("idVenta");
                datos[1] = consulta.getString("nofactura");
                datos[2] = consulta.getString("serie");
                datos[3] = consulta.getString("fechafactura");
                datos[4] = consulta.getString("idcliente");
                datos[5] = consulta.getString("idempleado");
                datos[6] = consulta.getString("fechaingreso");
                datos[7] = consulta.getString("idproducto");
                datos[8] = consulta.getString("cantidad");
                datos[9] = consulta.getString("precio_unitario");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.err.println("Error al leer ventas: " + ex.getMessage());
        } finally {
            closeResources(consulta, parametro);
        }

        return tabla;
    }
    


// Método para leer ventas y detalles de venta
public DefaultTableModel leerVentas_1() {
    DefaultTableModel tabla = new DefaultTableModel();
    PreparedStatement parametro = null;
    ResultSet consulta = null;

    try {
        conexionDB = new conexion();
        conexionDB.abrir_conexion();

        String query = "SELECT v.idVenta, v.nofactura, v.serie, v.fechafactura, v.idcliente, v.idempleado, v.fechaingreso, " +
                       "p.idProducto AS producto, vd.cantidad, vd.precio_unitario " +
                       "FROM ventas v " +
                       "INNER JOIN ventas_detalle vd ON v.idVenta = vd.idventa " +
                       "INNER JOIN productos p ON vd.idproducto = p.idProducto " +
                       "ORDER BY v.idVenta DESC;";
        parametro = conexionDB.conectar_db.prepareStatement(query);
        consulta = parametro.executeQuery();

        String encabezado[] = {"idVenta", "nofactura", "serie", "fechafactura", "idcliente", "idempleado", "fechaingreso", "idProducto", "cantidad", "precio_unitario"};
        tabla.setColumnIdentifiers(encabezado);
        String datos[] = new String[10];
        
        while (consulta.next()) {
            datos[0] = consulta.getString("idVenta");
            datos[1] = consulta.getString("nofactura");
            datos[2] = consulta.getString("serie");
            datos[3] = consulta.getString("fechafactura");
            datos[4] = consulta.getString("idcliente");
            datos[5] = consulta.getString("idempleado");
            datos[6] = consulta.getString("fechaingreso");
            datos[7] = consulta.getString("producto"); // Asegúrate de que 'nombre' sea el campo correcto
            datos[8] = consulta.getString("cantidad");
            datos[9] = consulta.getString("precio_unitario");
            tabla.addRow(datos);
        }
    } catch (SQLException ex) {
        System.err.println("Error al leer ventas: " + ex.getMessage());
    } finally {
        closeResources(consulta, parametro);
    }

    return tabla;
}


    // Método para cerrar recursos
    private void closeResources(PreparedStatement... parametros) {
        try {
            for (PreparedStatement parametro : parametros) {
                if (parametro != null) parametro.close();
            }
            conexionDB.cerrar_conexion();
        } catch (SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }

    private void closeResources(ResultSet consulta, PreparedStatement parametro) {
        try {
            if (consulta != null) consulta.close();
            closeResources(parametro);
        } catch (SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
    
    // Dropdown de clientes
    public HashMap<String, List<String>> drop_cliente() {
        HashMap<String, List<String>> drop = new HashMap<>();
        try {
            String query = "SELECT idCliente, nombres, nit FROM clientes;";
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            ResultSet consulta = conexionDB.conectar_db.createStatement().executeQuery(query);

            while (consulta.next()) {
                List<String> valores = new ArrayList<>();
                valores.add(consulta.getString("nombres"));
                valores.add(consulta.getString("nit"));
                drop.put(consulta.getString("idCliente"), valores);
            }

            conexionDB.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error drop_cliente: " + ex.getMessage());
        }
        return drop;
    }
}
