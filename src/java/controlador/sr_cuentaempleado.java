package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Cuenta;

@MultipartConfig
public class sr_cuentaempleado extends HttpServlet {
    
    private Cuenta cuenta;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar parámetros
            String username = request.getParameter("txt_username");
            String password = request.getParameter("txt_password");
            int id = Integer.parseInt(request.getParameter("txt_idEmpleado")); // Asegúrate de que el ID esté correcto

            // Crear objeto Cuenta
            cuenta = new Cuenta(id, username, password);

            System.out.println("Username: " + username);
            System.out.println("Password: " + password);
            System.out.println("ID Empleado: " + id);

            if (request.getParameter("btn_modificar") != null) {
                if (cuenta.modificarCuentaEmpleado() > 0) {
                    response.sendRedirect("cuentaempleado.jsp");
                } else {
                    response.getWriter().println("Error al modificar cuenta.");
                }
            }
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Error: " + e.getMessage());
        } catch (IOException e) {
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter());
        } catch (Exception e) {
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que maneja las operaciones de cuentas de empleados.";
    }
}
