package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Compras {
    private int idCompra;
    private int no_orden_compra;
    private int idproveedor;
    private String fecha_orden;
    private conexion conexionDB;

    // Constructor por defecto
    public Compras() {}

    // Constructor para agregar una nueva compra (sin fechaingreso)
    public Compras(int no_orden_compra, int idproveedor, String fecha_orden) {
        this.no_orden_compra = no_orden_compra;
        this.idproveedor = idproveedor;
        this.fecha_orden = fecha_orden;
    }

    // Constructor para modificar una compra (sin fechaingreso)
    public Compras(int idCompra, int no_orden_compra, int idproveedor, String fecha_orden) {
        this.idCompra = idCompra;
        this.no_orden_compra = no_orden_compra;
        this.idproveedor = idproveedor;
        this.fecha_orden = fecha_orden;
    }

    // Constructor para eliminar una compra
    public Compras(int idCompra) {
        this.idCompra = idCompra;
    }

    // Getters y Setters
    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public int getNo_orden_compra() {
        return no_orden_compra;
    }

    public void setNo_orden_compra(int no_orden_compra) {
        this.no_orden_compra = no_orden_compra;
    }

    public int getIdproveedor() {
        return idproveedor;
    }

    public void setIdproveedor(int idproveedor) {
        this.idproveedor = idproveedor;
    }

    public String getFecha_orden() {
        return fecha_orden;
    }

    public void setFecha_orden(String fecha_orden) {
        this.fecha_orden = fecha_orden;
    }

    // Método para agregar compras (sin incluir fechaingreso)
    public int agregarCompra() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "INSERT INTO compras (no_orden_compra, idproveedor, fecha_orden) VALUES (?, ?, ?);";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getNo_orden_compra());
            parametro.setInt(2, getIdproveedor());
            parametro.setString(3, getFecha_orden());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al agregar compra: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para modificar compras (sin incluir fechaingreso)
    public int modificarCompra() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE compras SET no_orden_compra = ?, idproveedor = ? WHERE idCompra = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getNo_orden_compra());
            parametro.setInt(2, getIdproveedor());

            parametro.setInt(3, getIdCompra());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar compra: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para eliminar compras
    public int eliminarCompra() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "DELETE FROM compras WHERE idCompra = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdCompra());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al eliminar compra: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }
// Método para leer compras
public DefaultTableModel leerCompras() {
    DefaultTableModel tabla = new DefaultTableModel();
    PreparedStatement parametro = null;
    ResultSet consulta = null;

    try {
        conexionDB = new conexion();
        conexionDB.abrir_conexion();
        
        String query = "SELECT cm.idCompra, cm.no_orden_compra, pv.idProveedore, pv.proveedor, cm.fecha_orden, cm.fechaingreso " +
                       "FROM compras cm " +
                       "INNER JOIN proveedores pv ON cm.idproveedor = pv.idProveedore " +  // Corregido idProveedor
                       "ORDER BY cm.idCompra DESC;";  
        
        parametro = conexionDB.conectar_db.prepareStatement(query);
        consulta = parametro.executeQuery();

        String encabezado[] = {"idCompra", "no_orden_compra", "idProveedore", "fecha_orden", "fechaingreso"};
        tabla.setColumnIdentifiers(encabezado);
        String datos[] = new String[5];
        while (consulta.next()) {
            datos[0] = consulta.getString("idCompra");
            datos[1] = consulta.getString("no_orden_compra");
            datos[2] = consulta.getString("idProveedore");  // Corregido a 'proveedor'
            datos[3] = consulta.getString("fecha_orden");
            datos[4] = consulta.getString("fechaingreso");
            tabla.addRow(datos);
        }
    } catch (SQLException ex) {
        System.err.println("Error al leer compras: " + ex.getMessage());
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
