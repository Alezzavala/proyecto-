package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Empleados_adm;

@MultipartConfig
public class sr_empleados_adm extends HttpServlet {

    Empleados_adm empleado;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar parámetros del formulario
            int idEmpleado = request.getParameter("txt_idEmpleado") != null && !request.getParameter("txt_idEmpleado").isEmpty() 
                             ? Integer.parseInt(request.getParameter("txt_idEmpleado")) 
                             : 0;
            String nombres = request.getParameter("txt_nombres");
            String apellidos = request.getParameter("txt_apellidos");
            String direccion = request.getParameter("txt_direccion");
            String telefono = request.getParameter("txt_telefono");
            String DPI = request.getParameter("txt_dpi");
            String fechaNacimiento = request.getParameter("txt_fecha_nacimiento");
            int idPuesto = Integer.parseInt(request.getParameter("drop_puesto"));
            int genero = Integer.parseInt(request.getParameter("txt_genero"));
            String fechalabores = request.getParameter("txt_fecha_inicio_labores");

            // Crear objeto Empleados_adm
            empleado = new Empleados_adm(idEmpleado, nombres, apellidos, direccion, telefono, DPI, fechaNacimiento, fechalabores, idPuesto, genero);

            // Acción según el botón presionado
            if (request.getParameter("btn_agregar") != null) {
                // Si el empleado fue agregado correctamente
                if (empleado.agregarEmpleado(request) > 0) {
                    // Los valores de username y password ya están almacenados en el request
                    // Redirigir a empleados.jsp con los atributos para mostrar el modal
                    request.getRequestDispatcher("empleados.jsp").forward(request, response);
                } else {
                    response.getWriter().println("Error al agregar empleado.");
                }
            }

            if (request.getParameter("btn_modificar") != null) {
                if (empleado.modificarEmpleado() > 0) {
                    response.sendRedirect("empleados.jsp");
                } else {
                    response.getWriter().println("Error al modificar empleado.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (empleado.eliminarEmpleado() > 0) {
                    response.sendRedirect("empleados.jsp");
                } else {
                    response.getWriter().println("Error al eliminar empleado.");
                }
            }
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Error: " + e.getMessage());
        } catch (IOException e) {
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter()); // Imprimir stack trace para depuración
        } catch (Exception e) {
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
        return "Servlet que maneja las operaciones de empleados.";
    }
}
