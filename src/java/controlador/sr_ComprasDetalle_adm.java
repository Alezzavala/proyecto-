package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.ComprasDetalle_adm;

@MultipartConfig
public class sr_ComprasDetalle_adm extends HttpServlet {

    ComprasDetalle_adm compraDetalle;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar y convertir parámetros
            long idCompraDetalle = Long.parseLong(request.getParameter("txt_idCompraDetalle")); // Conversión a long
            int idCompra = Integer.parseInt(request.getParameter("txt_idCompra")); // Conversión a int
            int idProducto = Integer.parseInt(request.getParameter("txt_idProducto")); // Conversión a int
            int cantidad = Integer.parseInt(request.getParameter("txt_cantidad")); // Conversión a int
            double precioCostoUnitario = Double.parseDouble(request.getParameter("txt_precioCostoUnitario")); // Conversión a double

            // Crear objeto ComprasDetalle
            compraDetalle = new ComprasDetalle_adm(idCompraDetalle, idCompra, idProducto, cantidad, precioCostoUnitario);

            // Acción según el botón presionado
            if (request.getParameter("btn_agregar") != null) {
                if (compraDetalle.agregarCompraDetalle() > 0) {
                    response.sendRedirect("comprasDetalle.jsp");
                } else {
                    response.getWriter().println("Error al agregar detalle de compra.");
                }
            }

            if (request.getParameter("btn_modificar") != null) {
                if (compraDetalle.modificarCompraDetalle() > 0) {
                    response.sendRedirect("comprasDetalle.jsp");
                } else {
                    response.getWriter().println("Error al modificar detalle de compra.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (compraDetalle.eliminarCompraDetalle() > 0) {
                    response.sendRedirect("comprasDetalle.jsp");
                } else {
                    response.getWriter().println("Error al eliminar detalle de compra.");
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
        return "Servlet que maneja las operaciones de detalles de compras.";
    }
}
