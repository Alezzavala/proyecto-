package modelo;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;
import java.security.SecureRandom;

public class Empleados_adm {
    private int idEmpleado;
    private String nombres;
    private String apellidos;
    private String direccion;
    private String telefono;
    private String DPI;
    private String fechaNacimiento;
    private int idPuesto;
    private String fechaInicioLabores;
    private String fechaIngreso; // Para el campo de TIMESTAMP
    private int genero; // 0 para masculino, 1 para femenino
    private conexion conexionDB;

    // Constructor por defecto
    public Empleados_adm() {}

    // Constructor para agregar un nuevo empleado (modificado para incluir fecha de inicio de labores)
    public Empleados_adm(String nombres, String apellidos, String direccion, String telefono, String DPI, String fechaNacimiento, String fechaInicioLabores, int idPuesto, int genero) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.direccion = direccion;
        this.telefono = telefono;
        this.DPI = DPI;
        this.fechaNacimiento = fechaNacimiento;
        this.fechaInicioLabores = fechaInicioLabores;
        this.idPuesto = idPuesto;
        this.genero = genero;
    }

    // Constructor para modificar un empleado
    public Empleados_adm(int idEmpleado, String nombres, String apellidos, String direccion, String telefono, String DPI, String fechaNacimiento, String fechaInicioLabores, int idPuesto, int genero) {
        this.idEmpleado = idEmpleado;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.direccion = direccion;
        this.telefono = telefono;
        this.DPI = DPI;
        this.fechaNacimiento = fechaNacimiento;
        this.fechaInicioLabores = fechaInicioLabores;
        this.idPuesto = idPuesto;
        this.genero = genero;
    }

    // Constructor para eliminar un empleado
    public Empleados_adm(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    // Getters y Setters
    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
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

    public String getDPI() {
        return DPI;
    }

    public void setDPI(String DPI) {
        this.DPI = DPI;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public int getIdPuesto() {
        return idPuesto;
    }

    public void setIdPuesto(int idPuesto) {
        this.idPuesto = idPuesto;
    }

    public String getFechaInicioLabores() {
        return fechaInicioLabores;
    }

    public void setFechaInicioLabores(String fechaInicioLabores) {
        this.fechaInicioLabores = fechaInicioLabores;
    }

    public String getFechaIngreso() {
        return fechaIngreso; // Para obtener la fecha de ingreso
    }

    public int getGenero() {
        return genero;
    }

    public void setGenero(int genero) {
        this.genero = genero;
    }

    // Método para generar una contraseña aleatoria
    private String generarContrasena(int longitud) {
        final String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%&*!"; 
        SecureRandom random = new SecureRandom();
        StringBuilder contrasena = new StringBuilder(longitud);
        
        for (int i = 0; i < longitud; i++) {
            int indice = random.nextInt(caracteres.length());
            contrasena.append(caracteres.charAt(indice));
        }
        return contrasena.toString(); 
    }

    // Método para agregar un empleado
    public int agregarEmpleado(HttpServletRequest request) {
        int retorno = 0;
        PreparedStatement parametro = null;
        ResultSet rs = null;
        String username = ""; 
        String password = ""; 
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            // Insertar empleado en la tabla empleados
            String query = "INSERT INTO empleados (nombres, apellidos, direccion, telefono, DPI, fecha_nacimiento, idPuesto, genero, fecha_inicio_labores, fechaingreso) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW());";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setString(5, getDPI());
            parametro.setString(6, getFechaNacimiento());
            parametro.setInt(7, getIdPuesto());
            parametro.setInt(8, getGenero());
            parametro.setString(9, getFechaInicioLabores());

            retorno = parametro.executeUpdate();

            if (retorno > 0) {
                // Obtener el ID del empleado recién insertado
                String lastInsertIdQuery = "SELECT LAST_INSERT_ID() AS idEmpleado;";
                parametro = conexionDB.conectar_db.prepareStatement(lastInsertIdQuery);
                rs = parametro.executeQuery();
                if (rs.next()) {
                    setIdEmpleado(rs.getInt("idEmpleado"));
                }

                // Generar el nombre de usuario
                username = getNombres().substring(0, 1).toLowerCase() + getApellidos().toLowerCase() + getIdEmpleado();

                // Generar una contraseña aleatoria
                password = generarContrasena(8);

                // Insertar credenciales en la tabla 'users'
                String userQuery = "INSERT INTO users (username, password, idEmpleado, mec) VALUES (?, ?, ?, 'empleado');";
                parametro = conexionDB.conectar_db.prepareStatement(userQuery);
                parametro.setString(1, username);
                parametro.setString(2, password);
                parametro.setInt(3, getIdEmpleado());

                // Ejecución de la inserción en la tabla users
                int userResult = parametro.executeUpdate();
                if (userResult > 0) {
                    System.out.println("Usuario y contraseña agregados correctamente.");
                } else {
                    System.err.println("Error al agregar usuario.");
                }
            } else {
                System.err.println("Error al agregar empleado.");
            }

            // Guardar el nombre de usuario y la contraseña generados en el request
            request.setAttribute("username", username);
            request.setAttribute("password", password);

        } catch (SQLException ex) {
            System.err.println("Error al agregar empleado: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            closeResources(rs, parametro);
        }
        return retorno;
    }

    // Método para modificar un empleado
    public int modificarEmpleado() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE empleados SET nombres = ?, apellidos = ?, direccion = ?, telefono = ?, DPI = ?, fecha_nacimiento = ?, idPuesto = ?, genero = ?, fecha_inicio_labores = ? WHERE idEmpleado = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setString(5, getDPI());
            parametro.setString(6, getFechaNacimiento());
            parametro.setInt(7, getIdPuesto());
            parametro.setInt(8, getGenero());
            parametro.setString(9, getFechaInicioLabores());
            parametro.setInt(10, getIdEmpleado());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar empleado: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para eliminar un empleado
    public int eliminarEmpleado() {
        int retorno = 0;
        int retorno1 =0;
        PreparedStatement parametro = null;
        PreparedStatement parametro1 = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            String delete = "DELETE FROM users WHERE idEmpleado = ?;";
            parametro1 = conexionDB.conectar_db.prepareStatement(delete);
            parametro1.setInt(1, getIdEmpleado());
            retorno1 = parametro1.executeUpdate();
            
            String deleteEmpleadoQuery = "DELETE FROM empleados WHERE idEmpleado = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(deleteEmpleadoQuery);
            parametro.setInt(1, getIdEmpleado());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al eliminar empleado: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para leer empleados
    public DefaultTableModel leerEmpleados() {
        DefaultTableModel tabla = new DefaultTableModel();
        PreparedStatement parametro = null;
        ResultSet consulta = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "SELECT idEmpleado, nombres, apellidos, direccion, telefono, DPI, fecha_nacimiento, idPuesto, fecha_inicio_labores, fechaingreso, genero FROM empleados ORDER BY idEmpleado DESC;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            consulta = parametro.executeQuery();

            String encabezado[] = {"idEmpleado", "nombres", "apellidos", "direccion", "telefono", "DPI", "fecha_nacimiento", "idPuesto", "fecha_inicio_labores", "fechaingreso", "genero"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[11];
            while (consulta.next()) {
                datos[0] = consulta.getString("idEmpleado");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                datos[5] = consulta.getString("DPI");
                datos[6] = consulta.getString("fecha_nacimiento");
                datos[7] = consulta.getString("idPuesto");
                datos[8] = consulta.getString("fecha_inicio_labores");
                datos[9] = consulta.getString("fechaingreso");
                datos[10] = consulta.getString("genero");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.err.println("Error al leer empleados: " + ex.getMessage());
        } finally {
            closeResources(consulta, parametro);
        }
        return tabla;
    }

    // Método para cerrar conexiones y recursos
    private void closeResources(ResultSet rs, PreparedStatement parametro) {
        try {
            if (rs != null) rs.close();
            if (parametro != null) parametro.close();
            if (conexionDB != null) conexionDB.cerrar_conexion();
        } catch (SQLException ex) {
            System.err.println("Error al cerrar recursos: " + ex.getMessage());
        }
    }

    private void closeResources(PreparedStatement parametro) {
        try {
            if (parametro != null) parametro.close();
            if (conexionDB != null) conexionDB.cerrar_conexion();
        } catch (SQLException ex) {
            System.err.println("Error al cerrar recursos: " + ex.getMessage());
        }
    }
}
