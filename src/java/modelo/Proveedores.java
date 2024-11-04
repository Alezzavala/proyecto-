package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Proveedores {
    private int idProveedor;
    private String proveedor;
    private String nit;
    private String direccion;
    private String telefono;
    private conexion conexionDB;

    // Constructor por defecto
    public Proveedores() {}

    // Constructor para agregar un nuevo proveedor
    public Proveedores(String proveedor, String nit, String direccion, String telefono) {
        this.proveedor = proveedor;
        this.nit = nit;
        this.direccion = direccion;
        this.telefono = telefono;
    }

    // Constructor para modificar un proveedor
    public Proveedores(int idProveedor, String proveedor, String nit, String direccion, String telefono) {
        this.idProveedor = idProveedor;
        this.proveedor = proveedor;
        this.nit = nit;
        this.direccion = direccion;
        this.telefono = telefono;
    }

    // Constructor para eliminar un proveedor
    public Proveedores(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    // Getters y Setters
    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    // Método para agregar proveedores
    public int agregarProveedor() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "INSERT INTO proveedores (proveedor, nit, direccion, telefono) VALUES (?, ?, ?, ?);";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getProveedor());
            parametro.setString(2, getNit());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al agregar proveedor: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para modificar proveedores
    public int modificarProveedor() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE proveedores SET proveedor = ?, nit = ?, direccion = ?, telefono = ? WHERE idProveedor = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getProveedor());
            parametro.setString(2, getNit());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setInt(5, getIdProveedor());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar proveedor: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para eliminar proveedores
    public int eliminarProveedor() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "DELETE FROM proveedores WHERE idProveedor = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdProveedor());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al eliminar proveedor: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para leer proveedores
    public DefaultTableModel leerProveedores() {
        DefaultTableModel tabla = new DefaultTableModel();
        PreparedStatement parametro = null;
        ResultSet consulta = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            
            String query = "SELECT idProveedore, proveedor, nit, direccion, telefono FROM proveedores ORDER BY idProveedore DESC;";
            
            parametro = conexionDB.conectar_db.prepareStatement(query);
            consulta = parametro.executeQuery();

            String encabezado[] = {"idProveedore", "proveedor", "nit", "direccion", "telefono"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[5];
            while (consulta.next()) {
                datos[0] = consulta.getString("idProveedore");
                datos[1] = consulta.getString("proveedor");
                datos[2] = consulta.getString("nit");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.err.println("Error al leer proveedores: " + ex.getMessage());
        } finally {
            closeResources(consulta, parametro);
        }
        
        return tabla; // No olvides retornar la tabla
    }
    
    public DefaultTableModel buscarProveedorPorId(int idProveedore) {
    DefaultTableModel tabla = new DefaultTableModel();
    PreparedStatement parametro = null;
    ResultSet consulta = null;

    try {
        conexionDB = new conexion();
        conexionDB.abrir_conexion();
        
        String query = "SELECT idProveedore, proveedor, nit, direccion, telefono FROM proveedores WHERE idProveedore = ?;";
        
        parametro = conexionDB.conectar_db.prepareStatement(query);
        parametro.setInt(1, idProveedore);  // Asignamos el valor de idProveedore
        
        consulta = parametro.executeQuery();

        String encabezado[] = {"idProveedore", "proveedor", "nit", "direccion", "telefono"};
        tabla.setColumnIdentifiers(encabezado);
        String datos[] = new String[5];
        if (consulta.next()) {
            datos[0] = consulta.getString("idProveedore");
            datos[1] = consulta.getString("proveedor");
            datos[2] = consulta.getString("nit");
            datos[3] = consulta.getString("direccion");
            datos[4] = consulta.getString("telefono");
            tabla.addRow(datos);
        } else {
            System.out.println("No se encontró ningún proveedor con el ID: " + idProveedore);
        }
    } catch (SQLException ex) {
        System.err.println("Error al buscar proveedor por ID: " + ex.getMessage());
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
