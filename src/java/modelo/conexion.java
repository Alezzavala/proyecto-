/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Conexion class to handle database connection.
 */
public class conexion {
//    private final String urlconexion = String.format("jdbc:mysql://localhost:3306/db_emp");
        private final String urlconexion = String.format("jdbc:mysql://localhost:3306/newdb");

    private final String user = "root";
    private final String password = "";
    private final String jdbc = "com.mysql.cj.jdbc.Driver";
    public Connection conectar_db;

    public void abrir_conexion() {
        try {
            Class.forName(jdbc);
            conectar_db = DriverManager.getConnection(urlconexion, user, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("error al conectar base de datos: " + ex.getMessage());
        }
    }

    public void cerrar_conexion() {
        try {
                conectar_db.close();
        } catch (SQLException ex) {
            System.out.println("Error al cerrar base de datos: " + ex.getMessage());
        }
    }
}
