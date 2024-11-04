package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;
import java.security.SecureRandom;

public class Clientes_adm {
    private int idCliente;
    private String nombres;
    private String apellidos;
    private String nit;
    private int genero; // 0 para masculino, 1 para femenino
    private String telefono;
    private String correoElectronico;
    private conexion conexionDB;

    // Constructor por defecto
    public Clientes_adm() {}

    // Constructor para agregar un nuevo cliente
    public Clientes_adm(String nombres, String apellidos, String nit, int genero, String telefono, String correoElectronico) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.nit = nit;
        this.genero = genero;
        this.telefono = telefono;
        this.correoElectronico = correoElectronico;
    }

    // Constructor para modificar un cliente
    public Clientes_adm(int idCliente, String nombres, String apellidos, String nit, int genero, String telefono, String correoElectronico) {
        this.idCliente = idCliente;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.nit = nit;
        this.genero = genero;
        this.telefono = telefono;
        this.correoElectronico = correoElectronico;
    }

    // Constructor para eliminar un cliente
    public Clientes_adm(int idCliente) {
        this.idCliente = idCliente;
    }

    // Getters y Setters
    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public int getGenero() {
        return genero;
    }

    public void setGenero(int genero) {
        this.genero = genero;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    // Método para generar una contraseña aleatoria
    private String generarContrasena(int longitud) {
        final String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%&*!"; // Caracteres permitidos
        SecureRandom random = new SecureRandom(); // Generador de números aleatorios seguro
        StringBuilder contrasena = new StringBuilder(longitud);
        
        for (int i = 0; i < longitud; i++) {
            int indice = random.nextInt(caracteres.length());
            contrasena.append(caracteres.charAt(indice));
        }
        return contrasena.toString(); // Devuelve la contraseña generada
    }


// Método para agregar un cliente y sus credenciales
public int agregarCliente() {
    int retorno = 0;
    PreparedStatement parametro = null;
    ResultSet rs = null;
    try {
        conexionDB = new conexion();
        conexionDB.abrir_conexion(); // Asegúrate de que este método se ejecute correctamente


        // Insertar cliente
        String query = "INSERT INTO clientes (nombres, apellidos, nit, genero, telefono, correo_electronico) VALUES (?, ?, ?, ?, ?, ?);";
        parametro = conexionDB.conectar_db.prepareStatement(query);
        parametro.setString(1, getNombres());
        parametro.setString(2, getApellidos());
        parametro.setString(3, getNit());
        parametro.setInt(4, getGenero());
        parametro.setString(5, getTelefono());
        parametro.setString(6, getCorreoElectronico());
        
        retorno = parametro.executeUpdate();

        if (retorno > 0) {
            // Obtener el ID del cliente recién insertado
            String lastInsertIdQuery = "SELECT LAST_INSERT_ID() AS idCliente;";
            parametro = conexionDB.conectar_db.prepareStatement(lastInsertIdQuery);
            rs = parametro.executeQuery();
            if (rs.next()) {
                setIdCliente(rs.getInt("idCliente"));
            }

            // Generar el nombre de usuario
            String username = getNombres().substring(0, 1).toLowerCase() + getApellidos().toLowerCase() + getIdCliente();

            // Generar una contraseña aleatoria
            String password = generarContrasena(8); // Cambia la longitud según tus necesidades

            // Insertar credenciales
            String userQuery = "INSERT INTO users (username, password, idCliente, mec) VALUES (?, ?, ?, 'cliente');";
            parametro = conexionDB.conectar_db.prepareStatement(userQuery);
            parametro.setString(1, username);
            parametro.setString(2, password);
            parametro.setInt(3, getIdCliente());

            // Ejecución de la inserción en la tabla users
            int result = parametro.executeUpdate();
            if (result > 0) {
                System.out.println("Usuario agregado correctamente.");
            } else {
                System.err.println("Error al agregar usuario.");
            }
        } else {
            System.err.println("Error al insertar el cliente.");
        }

    } catch (SQLException ex) {
        System.err.println("Error al agregar cliente: " + ex.getMessage());
        ex.printStackTrace(); // Imprimir la traza de la excepción
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (parametro != null) {
                parametro.close();
            }
            if (conexionDB != null) {
                conexionDB.cerrar_conexion(); // Cerrar la conexión si la abriste
            }
        } catch (SQLException e) {
        }
    }
    return retorno;
}



    // Método para modificar un cliente
    public int modificarCliente() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE clientes SET nombres = ?, apellidos = ?, nit = ?, genero = ?, telefono = ?, correo_electronico = ? WHERE idCliente = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getNit());
            parametro.setInt(4, getGenero());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getCorreoElectronico());
            parametro.setInt(7, getIdCliente());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar cliente: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para eliminar un cliente
  // Método para eliminar un cliente
public int eliminarCliente() {
    int retorno = 0;
    PreparedStatement parametro = null;
    try {
        conexionDB = new conexion();
        conexionDB.abrir_conexion();

        // Primero eliminar credenciales de la tabla users
        String deleteUserQuery = "DELETE FROM users WHERE idCliente = ?;";
        parametro = conexionDB.conectar_db.prepareStatement(deleteUserQuery);
        parametro.setInt(1, getIdCliente());
        int rowsAffectedUsers = parametro.executeUpdate();
        if (rowsAffectedUsers > 0) {
            System.out.println("Usuario eliminado correctamente.");
        } else {
            System.err.println("No se encontró el usuario para eliminar.");
        }

        // Luego eliminar cliente
        String deleteClienteQuery = "DELETE FROM clientes WHERE idCliente = ?;";
        parametro = conexionDB.conectar_db.prepareStatement(deleteClienteQuery);
        parametro.setInt(1, getIdCliente());
        int rowsAffectedClientes = parametro.executeUpdate();
        if (rowsAffectedClientes > 0) {
            System.out.println("Cliente eliminado correctamente.");
            retorno = rowsAffectedUsers + rowsAffectedClientes; // Devuelve el total de eliminaciones
        } else {
            System.err.println("No se encontró el cliente para eliminar.");
        }

    } catch (SQLException ex) {
        System.err.println("Error al eliminar cliente: " + ex.getMessage());
    } finally {
        closeResources(parametro);
    }
    return retorno;
}


    // Método para leer clientes
    public DefaultTableModel leerClientes() {
        DefaultTableModel tabla = new DefaultTableModel();
        PreparedStatement parametro = null;
        ResultSet consulta = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "SELECT idCliente, nombres, apellidos, nit, genero, telefono, correo_electronico, fecha_ingreso FROM clientes ORDER BY idCliente DESC;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            consulta = parametro.executeQuery();

            String encabezado[] = {"idCliente", "nombres", "apellidos", "nit", "genero", "telefono", "correo_electronico", "fecha_ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[8];
            while (consulta.next()) {
                datos[0] = consulta.getString("idCliente");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("nit");
                datos[4] = consulta.getString("genero");
                datos[5] = consulta.getString("telefono");
                datos[6] = consulta.getString("correo_electronico");
                datos[7] = consulta.getString("fecha_ingreso");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.err.println("Error al leer clientes: " + ex.getMessage());
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
