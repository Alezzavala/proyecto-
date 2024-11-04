package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Puesto {
    private int id_puesto;
    private String puesto;
    conexion cn;

    public Puesto(){}

    public Puesto(int id_puesto, String puesto) {
        this.id_puesto = id_puesto;
        this.puesto = puesto;
    }

    public int getId_puesto() {
        return id_puesto;
    }

    public void setId_puesto(int id_puesto) {
        this.id_puesto = id_puesto;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    // Leer todos los puestos
// Leer todos los puestos
public DefaultTableModel leerPuestos() {
    DefaultTableModel tableModel = new DefaultTableModel();
    cn = new conexion();
    try {
        String query = "SELECT idpuesto, puesto FROM puestos;";
        cn.abrir_conexion();
        ResultSet rs = cn.conectar_db.createStatement().executeQuery(query);
        
        // Definir las columnas del DefaultTableModel
        tableModel.addColumn("ID Puesto");
        tableModel.addColumn("Puesto");
        
        // Llenar el DefaultTableModel con los datos del ResultSet
        while (rs.next()) {
            Object[] fila = new Object[2];
            fila[0] = rs.getInt("idpuesto");
            fila[1] = rs.getString("puesto");
            tableModel.addRow(fila);
        }
        
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println("Error leer_puestos: " + ex.getMessage());
    }
    return tableModel;
}

    // Agregar puesto
    public int agregarPuesto() {
        int retorno = 0;
        try {
            String query = "INSERT INTO puestos(puesto) VALUES (?);";
            cn = new conexion();
            cn.abrir_conexion();
            var ps = cn.conectar_db.prepareStatement(query);
            ps.setString(1, this.getPuesto());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error agregar_puesto: " + ex.getMessage());
        }
        return retorno;
    }

    // Modificar puesto
    public int modificarPuesto() {
        int retorno = 0;
        try {
            String query = "UPDATE puestos SET puesto=? WHERE idpuesto=?;";
            cn = new conexion();
            cn.abrir_conexion();
            var ps = cn.conectar_db.prepareStatement(query);
            ps.setString(1, this.getPuesto());
            ps.setInt(2, this.getId_puesto());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error modificar_puesto: " + ex.getMessage());
        }
        return retorno;
    }

    // Eliminar puesto
    public int eliminarPuesto() {
        int retorno = 0;
        try {
            String query = "DELETE FROM puestos WHERE idpuesto=?;";
            cn = new conexion();
            cn.abrir_conexion();
            var ps = cn.conectar_db.prepareStatement(query);
            ps.setInt(1, this.getId_puesto());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error eliminar_puesto: " + ex.getMessage());
        }
        return retorno;
    }

    // Dropdown de puestos
    public HashMap<String, String> drop_puestos() {
        HashMap<String, String> drop = new HashMap<>();
        try {
            String query = "SELECT idpuesto, puesto FROM puestos;";
            cn = new conexion();
            cn.abrir_conexion();
            ResultSet consulta = cn.conectar_db.createStatement().executeQuery(query);
            while (consulta.next()) {
                drop.put(consulta.getString("idpuesto"), consulta.getString("puesto"));
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error drop_puesto: " + ex.getMessage());
        }
        return drop;
    }
}
