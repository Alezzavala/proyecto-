package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Puesto;

@MultipartConfig
public class sr_puestos_adm extends HttpServlet {

    Puesto puesto;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar parámetros del formulario
            int idPuesto = request.getParameter("txt_idPuesto") != null && !request.getParameter("txt_idPuesto").isEmpty() 
                          ? Integer.parseInt(request.getParameter("txt_idPuesto")) 
                          : 0;
            String nombrePuesto = request.getParameter("txt_puesto");

            // Crear objeto Marca
            puesto = new Puesto(idPuesto, nombrePuesto);

            // Acción según el botón presionado
            if (request.getParameter("btn_agregar") != null) {
                if (puesto.agregarPuesto()> 0) {
                    response.sendRedirect("puestos.jsp");
                } else {
                    response.getWriter().println("Error al agregar marca.");
                }
            }

            if (request.getParameter("btn_modificar") != null) {
                if (puesto.modificarPuesto()> 0) {
                    response.sendRedirect("puestos.jsp");
                } else {
                    response.getWriter().println("Error al modificar marca.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (puesto.eliminarPuesto()> 0) {
                    response.sendRedirect("puestos.jsp");
                } else {
                    response.getWriter().println("Error al eliminar marca.");
                }
            }
        } catch (IOException | NumberFormatException e) {
            // Muestra el mensaje completo de cualquier error inesperado
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter());
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
        return "Servlet que maneja las operaciones de marcas.";
    }
}
