package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Marca;

@MultipartConfig
public class sr_marcas_adm extends HttpServlet {

    Marca marca;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar parámetros del formulario
            int idMarca = request.getParameter("txt_idMarca") != null && !request.getParameter("txt_idMarca").isEmpty() 
                          ? Integer.parseInt(request.getParameter("txt_idMarca")) 
                          : 0;
            String nombreMarca = request.getParameter("txt_marca");

            // Crear objeto Marca
            marca = new Marca(idMarca, nombreMarca);

            // Acción según el botón presionado
            if (request.getParameter("btn_agregar") != null) {
                if (marca.agregarMarca() > 0) {
                    response.sendRedirect("marcas.jsp");
                } else {
                    response.getWriter().println("Error al agregar marca.");
                }
            }

            if (request.getParameter("btn_modificar") != null) {
                if (marca.modificarMarca() > 0) {
                    response.sendRedirect("marcas.jsp");
                } else {
                    response.getWriter().println("Error al modificar marca.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (marca.eliminarMarca() > 0) {
                    response.sendRedirect("marcas.jsp");
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
