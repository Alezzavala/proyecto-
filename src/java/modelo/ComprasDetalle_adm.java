package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class ComprasDetalle_adm {
    private long idcompra_detalle;
    private int idcompra;
    private int idproducto;
    private int cantidad;
    private double precio_costo_unitario;
    private conexion conexionDB;

    // Constructor por defecto
    public ComprasDetalle_adm() {}

    // Constructor para agregar un nuevo detalle de compra
    public ComprasDetalle_adm(int idcompra, int idproducto, int cantidad, double precio_costo_unitario) {
        this.idcompra = idcompra;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    // Constructor para modificar un detalle de compra
    public ComprasDetalle_adm(long idcompra_detalle, int idcompra, int idproducto, int cantidad, double precio_costo_unitario) {
        this.idcompra_detalle = idcompra_detalle;
        this.idcompra = idcompra;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    // Constructor para eliminar un detalle de compra
    public ComprasDetalle_adm(long idcompra_detalle) {
        this.idcompra_detalle = idcompra_detalle;
    }

    // Getters y Setters
    public long getIdcompra_detalle() {
        return idcompra_detalle;
    }

    public void setIdcompra_detalle(long idcompra_detalle) {
        this.idcompra_detalle = idcompra_detalle;
    }

    public int getIdcompra() {
        return idcompra;
    }

    public void setIdcompra(int idcompra) {
        this.idcompra = idcompra;
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

    // Método para agregar detalle de compra
    public int agregarCompraDetalle() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "INSERT INTO compras_detalle (idcompra, idproducto, cantidad, precio_costo_unitario) VALUES (?, ?, ?, ?);";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdcompra());
            parametro.setInt(2, getIdproducto());
            parametro.setInt(3, getCantidad());
            parametro.setDouble(4, getPrecio_costo_unitario());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al agregar detalle de compra: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para modificar detalle de compra
    public int modificarCompraDetalle() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE compras_detalle SET idcompra = ?, idproducto = ?, cantidad = ?, precio_costo_unitario = ? WHERE idcompra_detalle = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdcompra());
            parametro.setInt(2, getIdproducto());
            parametro.setInt(3, getCantidad());
            parametro.setDouble(4, getPrecio_costo_unitario());
            parametro.setLong(5, getIdcompra_detalle());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar detalle de compra: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para eliminar detalle de compra
    public int eliminarCompraDetalle() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "DELETE FROM compras_detalle WHERE idcompra_detalle = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setLong(1, getIdcompra_detalle());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al eliminar detalle de compra: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para leer detalles de compra
    public DefaultTableModel leerComprasDetalle() {
        DefaultTableModel tabla = new DefaultTableModel();
        PreparedStatement parametro = null;
        ResultSet consulta = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "SELECT idcompra_detalle, idcompra, idproducto, cantidad, precio_costo_unitario FROM compras_detalle ORDER BY idcompra_detalle DESC;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            consulta = parametro.executeQuery();

            String encabezado[] = {"idcompra_detalle", "idcompra", "idproducto", "cantidad", "precio_costo_unitario"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[5];
            while (consulta.next()) {
                datos[0] = consulta.getString("idcompra_detalle");
                datos[1] = consulta.getString("idcompra");
                datos[2] = consulta.getString("idproducto");
                datos[3] = consulta.getString("cantidad");
                datos[4] = consulta.getString("precio_costo_unitario");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.err.println("Error al leer detalles de compra: " + ex.getMessage());
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
