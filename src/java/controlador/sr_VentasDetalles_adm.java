package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.VentasDetalle_adm;

@MultipartConfig
public class sr_VentasDetalles_adm extends HttpServlet {

    VentasDetalle_adm ventaDetalle;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar y convertir parámetros
            long idVentaDetalle = Long.parseLong(request.getParameter("txt_idVentaDetalle")); // Conversión a long
            int idVenta = Integer.parseInt(request.getParameter("txt_idVenta")); // Conversión a int
            int idProducto = Integer.parseInt(request.getParameter("txt_idProducto")); // Conversión a int
            int cantidad = Integer.parseInt(request.getParameter("txt_cantidad")); // Conversión a int
            double precioUnitario = Double.parseDouble(request.getParameter("txt_precioVentaUnitario")); // Conversión a double

            // Crear objeto VentasDetalle_adm
            ventaDetalle = new VentasDetalle_adm(idVentaDetalle, idVenta, idProducto, cantidad, precioUnitario);

            // Acción según el botón presionado
            if (request.getParameter("btn_agregar") != null) {
                if (ventaDetalle.agregarVentaDetalle() > 0) {
                    response.sendRedirect("ventasDetalles.jsp");
                } else {
                    response.getWriter().println("Error al agregar detalle de venta.");
                }
            }

            if (request.getParameter("btn_modificar") != null) {
                if (ventaDetalle.modificarVentaDetalle() > 0) {
                    response.sendRedirect("ventasDetalles.jsp");
                } else {
                    response.getWriter().println("Error al modificar detalle de venta.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (ventaDetalle.eliminarVentaDetalle() > 0) {
                    response.sendRedirect("ventasDetalles.jsp");
                } else {
                    response.getWriter().println("Error al eliminar detalle de venta.");
                }
            }
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Error: " + e.getMessage());
        } catch (IOException e) {
            // Manejo de errores de I/O
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter());
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
        return "Servlet que maneja las operaciones de detalles de ventas.";
    }
}
