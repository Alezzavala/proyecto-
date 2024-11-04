package modelo;

import java.sql.*;
import javax.swing.table.DefaultTableModel;

public class Cuenta {
    private int id;
    private String username;
    private String password;
    private int idEmpleado;
    private int idCliente;
    private conexion cn;

    // Constructor vacío
    public Cuenta() {}

    // Constructor con parámetros
    public Cuenta(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    // Método para leer cuentas de empleados
    public DefaultTableModel leerCuentasEmpleado() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new conexion();
            cn.abrir_conexion();
            String query = "SELECT u.id, u.username, e.nombres, e.apellidos " +
                           "FROM users u " +
                           "INNER JOIN empleados e ON u.idEmpleado = e.idEmpleado;";
            ResultSet consulta = cn.conectar_db.createStatement().executeQuery(query);
            String encabezado[] = {"ID", "Username", "Nombre Empleado", "Apellido Empleado"};
            tabla.setColumnIdentifiers(encabezado);

            String datos[] = new String[5];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("username");
                datos[2] = consulta.getString("nombres");
                datos[3] = consulta.getString("apellidos");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error leer_cuentas_empleado: " + ex.getMessage());
        }
        return tabla;
    }

    // Método para modificar la cuenta de empleados
    public int modificarCuentaEmpleado() {
        int retorno = 0;
        try {
            String query = "UPDATE users SET password = ? WHERE id = ?;";
            cn = new conexion();
            cn.abrir_conexion();
            PreparedStatement parametro = cn.conectar_db.prepareStatement(query);
            parametro.setString(1, getPassword());
            parametro.setInt(2, getId()); // Usando el ID correcto
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error modificar_cuenta_empleado: " + ex.getMessage());
        }
        return retorno;
    }
    
    public DefaultTableModel leerCuentasClientes() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new conexion();
            cn.abrir_conexion();
            String query = "SELECT u.id, u.username, e.nombres, e.apellidos " +
                           "FROM users u " +
                           "INNER JOIN clientes e ON u.idCliente = e.idCliente;";
            ResultSet consulta = cn.conectar_db.createStatement().executeQuery(query);
            String encabezado[] = {"ID", "Username", "Nombre Empleado", "Apellido Empleado"};
            tabla.setColumnIdentifiers(encabezado);

            String datos[] = new String[5];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("username");
                datos[2] = consulta.getString("nombres");
                datos[3] = consulta.getString("apellidos");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error leer_cuentas_empleado: " + ex.getMessage());
        }
        return tabla;
    }
    
    // Método para modificar la cuenta de empleados
    public int modificarCuentaCliente() {
        int retorno = 0;
        try {
            String query = "UPDATE users SET password = ? WHERE id = ?;";
            cn = new conexion();
            cn.abrir_conexion();
            PreparedStatement parametro = cn.conectar_db.prepareStatement(query);
            parametro.setString(1, getPassword());
            parametro.setInt(2, getId()); // Usando el ID correcto
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error modificar_cuenta_empleado: " + ex.getMessage());
        }
        return retorno;
    }
}
