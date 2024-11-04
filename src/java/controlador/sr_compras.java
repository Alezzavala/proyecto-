package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Compras;

@MultipartConfig
public class sr_compras extends HttpServlet {

    Compras compra;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar parámetros y convertir a int
            int idCompra = Integer.parseInt(request.getParameter("txt_idCompra")); // Conversión de String a int
            int noOrdenCompra = Integer.parseInt(request.getParameter("txt_noOrdenCompra")); // Conversión de String a int

            // Obtener fecha de orden y validar
            String fechaOrden = request.getParameter("txt_fechaorden");
            if (fechaOrden == null || fechaOrden.isEmpty()) {
                throw new IllegalArgumentException("La fecha de orden no puede estar vacía.");
            }

            // Obtener id del proveedor
            int idProveedor = Integer.parseInt(request.getParameter("txt_idProveedor")); // Conversión de String a int

            // Crear objeto Compras
            compra = new Compras(idCompra, noOrdenCompra, idProveedor, fechaOrden);

            // Acción según el valor del botón presionado
            if (request.getParameter("btn_agregar") != null) {
                if (compra.agregarCompra() > 0) {
                    response.sendRedirect("compras.jsp");
                } else {
                    response.getWriter().println("Error al agregar compra.");
                }
            }

            if (request.getParameter("btn_modificar") != null) {
                if (compra.modificarCompra() > 0) {
                    response.sendRedirect("compras.jsp");
                } else {
                    response.getWriter().println("Error al modificar compra.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (compra.eliminarCompra() > 0) {
                    response.sendRedirect("compras.jsp");
                } else {
                    response.getWriter().println("Error al eliminar compra.");
                }
            }
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Error: " + e.getMessage());
        } catch (IOException e) {
            // Muestra el mensaje completo de cualquier error inesperado de I/O
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter()); // Imprime el stack trace
        } catch (Exception e) {
            // Manejar cualquier otra excepción
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
        return "Servlet que maneja las operaciones de compras.";
    }
}
