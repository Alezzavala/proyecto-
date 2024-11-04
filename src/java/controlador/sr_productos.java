package controlador;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import modelo.productos;

@MultipartConfig
public class sr_productos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Obtener el tipo de acción
            String action = request.getParameter("btn_agregar") != null ? "agregar" :
                            request.getParameter("btn_modificar") != null ? "modificar" :
                            request.getParameter("btn_eliminar") != null ? "eliminar" : "";

            // Obtener datos del formulario
            int idP = Integer.parseInt(request.getParameter("txt_idProducto"));
            String productoNombre = request.getParameter("txt_producto");
            int idMarca = Integer.parseInt(request.getParameter("drop_marca"));
            String descripcion = request.getParameter("txt_descripcion");
            double precioCosto = Double.parseDouble(request.getParameter("txt_precio_costo"));
            int existencia = Integer.parseInt(request.getParameter("txt_existencia"));

            // Crear objeto producto si se está agregando o modificando
            productos producto = new productos(
                    idP,
                    productoNombre,
                    idMarca,
                    descripcion,
                    null, // Para agregar la imagen más tarde
                    precioCosto,
                    existencia
            );

            // Procesar la imagen solo si se está agregando un nuevo producto
            if ("agregar".equals(action)) {
                System.out.println("Se recibió la solicitud para agregar.");
                Part filePart = request.getPart("file_imagen");
                String fileName = getFileName(filePart);
                String uploadPath = getServletContext().getRealPath("/admin/img_producto") + File.separator + fileName;
                File file = new File(uploadPath);
                filePart.write(uploadPath); // Guardar la imagen en el servidor
                producto.setImagen(fileName); // Establecer el nombre de la imagen en el objeto

                if (producto.agregar() > 0) {
                    response.sendRedirect("Productos.jsp");
                } else {
                    out.println("<h1>No se ingresó el producto</h1>");
                    out.println("<a href='Productos.jsp'>Regresar...</a>");
                }
            }

            // Botón modificar
            if ("modificar".equals(action)) {
                System.out.println("Se recibió la solicitud para modificar.");
                // Solo se actualiza el objeto producto, no se guarda la imagen nuevamente
                if (producto.modificar() > 0) {
                    response.sendRedirect("Productos.jsp?success=true");
                } else {
                    out.println("<h1>No se modificó el producto</h1>");
                    out.println("<a href='Productos.jsp'>Regresar...</a>");
                }
            }

            // Botón eliminar
            if ("eliminar".equals(action)) {
                System.out.println("Se recibió la solicitud para eliminar.");
                // Obtiene el ID del producto a eliminar
                int idProducto = Integer.parseInt(request.getParameter("txt_idProducto"));

                // Obtiene el nombre de la imagen desde la base de datos
                String nombreImagen = producto.getNombreImagen(idProducto);

                // Elimina el producto de la base de datos
                if (producto.eliminar(idProducto) > 0) {
                    // Define la ruta del archivo de imagen que deseas eliminar
                    String uploadPath = getServletContext().getRealPath("/admin/img_producto") + File.separator + nombreImagen;
                    File imagenFile = new File(uploadPath);

                    // Verifica si el archivo existe y lo elimina
                    if (imagenFile.exists()) {
                        if (imagenFile.delete()) {
                            System.out.println("Imagen eliminada: " + nombreImagen);
                        } else {
                            System.out.println("No se pudo eliminar la imagen: " + nombreImagen);
                        }
                    } else {
                        System.out.println("El archivo no existe: " + nombreImagen);
                    }

                    response.sendRedirect("Productos.jsp");
                } else {
                    out.println("<h1>No se eliminó el producto</h1>");
                    out.println("<a href='Productos.jsp'>Regresar...</a>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("inventario.jsp?error=true");
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
        return "Servlet para manejar productos";
    }

    private String getFileName(Part filePart) {
        String contentDisposition = filePart.getHeader("content-disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
