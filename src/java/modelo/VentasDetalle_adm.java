package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class VentasDetalle_adm {
    private long idventa_detalle;
    private int idventa;
    private int idproducto;
    private int cantidad;
    private double precio_costo_unitario;
    private conexion conexionDB;

    // Constructor por defecto
    public VentasDetalle_adm() {}

    // Constructor para agregar un nuevo detalle de venta
    public VentasDetalle_adm(int idventa, int idproducto, int cantidad, double precio_costo_unitario) {
        this.idventa = idventa;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    // Constructor para modificar un detalle de venta
    public VentasDetalle_adm(long idventa_detalle, int idventa, int idproducto, int cantidad, double precio_costo_unitario) {
        this.idventa_detalle = idventa_detalle;
        this.idventa = idventa;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    // Constructor para eliminar un detalle de venta
    public VentasDetalle_adm(long idventa_detalle) {
        this.idventa_detalle = idventa_detalle;
    }

    // Getters y Setters
    public long getIdventa_detalle() {
        return idventa_detalle;
    }

    public void setIdventa_detalle(long idventa_detalle) {
        this.idventa_detalle = idventa_detalle;
    }

    public int getIdventa() {
        return idventa;
    }

    public void setIdventa(int idventa) {
        this.idventa = idventa;
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

    // Método para agregar detalle de venta
    public int agregarVentaDetalle() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "INSERT INTO ventas_detalle (idventa, idproducto, cantidad, precio_costo_unitario) VALUES (?, ?, ?, ?);";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdventa());
            parametro.setInt(2, getIdproducto());
            parametro.setInt(3, getCantidad());
            parametro.setDouble(4, getPrecio_costo_unitario());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al agregar detalle de venta: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para modificar detalle de venta
    public int modificarVentaDetalle() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE ventas_detalle SET idventa = ?, idproducto = ?, cantidad = ?, precio_unitario = ? WHERE idventa_detalle = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdventa());
            parametro.setInt(2, getIdproducto());
            parametro.setInt(3, getCantidad());
            parametro.setDouble(4, getPrecio_costo_unitario());
            parametro.setLong(5, getIdventa_detalle());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar detalle de venta: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para eliminar detalle de venta
    public int eliminarVentaDetalle() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "DELETE FROM ventas_detalle WHERE idventa_detalle = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setLong(1, getIdventa_detalle());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al eliminar detalle de venta: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para leer detalles de venta
    public DefaultTableModel leerVentasDetalle() {
        DefaultTableModel tabla = new DefaultTableModel();
        PreparedStatement parametro = null;
        ResultSet consulta = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "SELECT idventa_detalle, idventa, idproducto, cantidad, precio_unitario FROM ventas_detalle ORDER BY idventa_detalle DESC;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            consulta = parametro.executeQuery();

            String encabezado[] = {"idventa_detalle", "idventa", "idproducto", "cantidad", "precio_unitario"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[5];
            while (consulta.next()) {
                datos[0] = consulta.getString("idventa_detalle");
                datos[1] = consulta.getString("idventa");
                datos[2] = consulta.getString("idproducto");
                datos[3] = consulta.getString("cantidad");
                datos[4] = consulta.getString("precio_unitario");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.err.println("Error al leer detalles de venta: " + ex.getMessage());
        } finally {
            closeResources(consulta, parametro);
        }

        return tabla;
    }

    // Método para cerrar recursos
    private void closeResources(PreparedStatement parametro) {
        try {
            if (parametro != null) {
                parametro.close();
            }
            conexionDB.cerrar_conexion();
        } catch (SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }

    private void closeResources(ResultSet consulta, PreparedStatement parametro) {
        try {
            if (consulta != null) {
                consulta.close();
            }
            closeResources(parametro);
        } catch (SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}
