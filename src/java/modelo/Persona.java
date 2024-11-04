
package modelo;



abstract class Persona {
    private String nombres, apellidos, direccion, telefono, nacimiento;
    private int puesto;
        
    public Persona(){}
    public Persona(String nombres, String apellidos, String direccion, String telefono, String nacimiento, int puesto) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.direccion = direccion;
        this.telefono = telefono;
        this.nacimiento = nacimiento;
        this.puesto = puesto;
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

    public String getNacimiento() {
        return nacimiento;
    }

    public void setNacimiento(String nacimiento) {
        this.nacimiento = nacimiento;
    }

    public int getPuesto() {
        return puesto;
    }

    public void setPuesto(int puesto) {
        this.puesto = puesto;
    }
    
    protected int crear(){return 0;}
    protected void actualizar(){}
    protected void borrar(){}
    
}
