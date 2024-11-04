package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Proveedores;

@MultipartConfig
public class sr_proveedores extends HttpServlet {

    Proveedores proveedor;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar parámetros
            int idProveedor = Integer.parseInt(request.getParameter("txt_idProveedor")); // Conversión de String a int
            String nombreProveedor = request.getParameter("txt_proveedor");
            String nit = request.getParameter("txt_nit");
            String direccion = request.getParameter("txt_direccion");
            String telefono = request.getParameter("txt_telefono");

            // Crear objeto Proveedores
            proveedor = new Proveedores(idProveedor, nombreProveedor, nit, direccion, telefono);

            // Acción según el valor del botón presionado
            if (request.getParameter("btn_agregar") != null) {
                if (proveedor.agregarProveedor() > 0) {
                    response.sendRedirect("proveedores.jsp");
                } else {
                    response.getWriter().println("Error al agregar proveedor.");
                }
            }

            if (request.getParameter("btn_modificar") != null) {
                if (proveedor.modificarProveedor() > 0) {
                    response.sendRedirect("proveedores.jsp");
                } else {
                    response.getWriter().println("Error al modificar proveedor.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (proveedor.eliminarProveedor() > 0) {
                    response.sendRedirect("proveedores.jsp");
                } else {
                    response.getWriter().println("Error al eliminar proveedor.");
                }
            }
        } catch (IOException | NumberFormatException e) {
            // Muestra el mensaje completo de cualquier error inesperado de I/O
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter()); // Imprime el stack trace
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que maneja las operaciones de proveedores.";
    }
}
