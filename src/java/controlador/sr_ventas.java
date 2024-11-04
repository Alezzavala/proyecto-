package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Ventas;

@MultipartConfig
public class sr_ventas extends HttpServlet {
     
    Ventas venta = new Ventas();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    try {
        // Recuperar parámetros y convertir a int
        String idVentaParam = request.getParameter("txt_idVenta");
        if (idVentaParam == null || idVentaParam.isEmpty()) {
            throw new IllegalArgumentException("El ID de venta no puede estar vacío.");
        }
        
        int idVenta;
        try {
            idVenta = Integer.parseInt(idVentaParam);
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Error al convertir ID de venta: " + idVentaParam);
        }

        int noFactura;
        try {
            noFactura = Integer.parseInt(request.getParameter("txt_noFactura"));
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Error al convertir número de factura.");
        }
        
        // Validar que la serie sea un solo carácter
        String serieS = request.getParameter("txt_serie");
        if (serieS == null || serieS.length() != 1) {
            throw new IllegalArgumentException("La serie debe ser un solo carácter.");
        }

        String fechaFactura = request.getParameter("txt_fecha_factura");

        int idCliente;
        try {
            idCliente = Integer.parseInt(request.getParameter("drop_cliente"));
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Error al convertir ID del cliente.");
        }

        int idEmpleado;
        try {
            idEmpleado = Integer.parseInt(request.getParameter("txt_idEmpleado"));
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Error al convertir ID del empleado.");
        }

        int idProducto;
        try {
            idProducto = Integer.parseInt(request.getParameter("txt_idProducto"));
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Error al convertir ID del producto.");
        }

        int cantidad;
        try {
            cantidad = Integer.parseInt(request.getParameter("txt_cantidad"));
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Error al convertir la cantidad.");
        }

        double precioUnitario;
        try {
            precioUnitario = Double.parseDouble(request.getParameter("txt_precioVentaUnitario"));
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Error al convertir el precio unitario.");
        }

        // Crear el objeto Ventas con los datos de ambas tablas
        venta = new Ventas(idVenta, noFactura, serieS, fechaFactura, idCliente, idEmpleado, idProducto, cantidad, precioUnitario);

        // Acción según el botón presionado
        if (request.getParameter("btn_agregar") != null) {
            int resultado = venta.agregarVenta();
            if (resultado > 0) {
                response.sendRedirect("ventas.jsp");
            } else {
                response.getWriter().println("Error al agregar venta o detalles de venta.");
            }
        }

        if (request.getParameter("btn_modificar") != null) {
            int resultado = venta.modificarVenta();
            if (resultado > 0) {
                response.sendRedirect("ventas.jsp");
            } else {
                response.getWriter().println("Error al modificar venta o detalles de venta.");
            }
        }

        if (request.getParameter("btn_eliminar") != null) {
            int resultado = venta.eliminarVenta();
            if (resultado > 0) {
                response.sendRedirect("ventas.jsp");
            } else {
                response.getWriter().println("Error al eliminar venta o detalles de venta.");
            }
        }
    } catch (IOException e) {
        response.getWriter().println("Error inesperado: " + e.getMessage());
        e.printStackTrace(response.getWriter());
    } catch (NumberFormatException e) {
        response.getWriter().println("Error al convertir datos numéricos: " + e.getMessage());
    } catch (IllegalArgumentException e) {
        response.getWriter().println("Error de argumento: " + e.getMessage());
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
        return "Servlet que maneja las operaciones de ventas y detalles de ventas.";
    }
}
