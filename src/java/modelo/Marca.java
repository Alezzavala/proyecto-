package modelo;

import java.sql.*;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Marca {
    private int idMarca;
    private String marca;
    conexion cn;

    public Marca() {}

    public Marca(int idMarca, String marca) {
        this.idMarca = idMarca;
        this.marca = marca;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    // Método para llenar el dropdown
    public HashMap<String, String> drop_sangre() {
        HashMap<String, String> drop = new HashMap<>();
        try {
            String query = "select idMarca as id, marca from marcas;";
            cn = new conexion();
            cn.abrir_conexion();
            ResultSet consulta = cn.conectar_db.createStatement().executeQuery(query);
            while (consulta.next()) {
                drop.put(consulta.getString("id"), consulta.getString("marca"));
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error drop_marca: " + ex.getMessage());
        }
        return drop;
    }

    // Método para agregar una marca
    public int agregarMarca() {
        int retorno = 0;
        try {
            String query = "INSERT INTO marcas (marca) VALUES (?);";
            cn = new conexion();
            cn.abrir_conexion();
            PreparedStatement parametro = cn.conectar_db.prepareStatement(query);
            parametro.setString(1, getMarca());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error agregar_marca: " + ex.getMessage());
        }
        return retorno;
    }

    // Método para modificar una marca
    public int modificarMarca() {
        int retorno = 0;
        try {
            String query = "UPDATE marcas SET marca = ? WHERE idMarca = ?;";
            cn = new conexion();
            cn.abrir_conexion();
            PreparedStatement parametro = cn.conectar_db.prepareStatement(query);
            parametro.setString(1, getMarca());
            parametro.setInt(2, getIdMarca());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error modificar_marca: " + ex.getMessage());
        }
        return retorno;
    }

    // Método para eliminar una marca
    public int eliminarMarca() {
        int retorno = 0;
        try {
            String query = "DELETE FROM marcas WHERE idMarca = ?;";
            cn = new conexion();
            cn.abrir_conexion();
            PreparedStatement parametro = cn.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdMarca());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error eliminar_marca: " + ex.getMessage());
        }
        return retorno;
    }

    // Método para leer las marcas
    public DefaultTableModel leerMarcas() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new conexion();
            cn.abrir_conexion();
            String query = "SELECT idMarca as id, marca FROM marcas;";
            ResultSet consulta = cn.conectar_db.createStatement().executeQuery(query);
            String encabezado[] = {"ID", "Marca"};
            tabla.setColumnIdentifiers(encabezado);

            String datos[] = new String[2];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("marca");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error leer_marcas: " + ex.getMessage());
        }
        return tabla;
    }
}
