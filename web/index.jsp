<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_cliente.jsp" %>
 

   <div class="card-container">
        <% 
            productos producto = new productos();  
            DefaultTableModel tabla1 = producto.leerPro(); 
            for (int t = 0; t < tabla1.getRowCount(); t++) {
                String idProducto = tabla1.getValueAt(t, 0).toString();
                String nombreProducto = tabla1.getValueAt(t, 1).toString();
                String marcaProducto = tabla1.getValueAt(t, 2).toString();
                String descripcionProducto = tabla1.getValueAt(t, 3).toString();
                String imagenProducto = tabla1.getValueAt(t, 4).toString();
                String precioVentaProducto = tabla1.getValueAt(t, 6).toString();
        %>
        <div class="card">
            <img src="<%= request.getContextPath() + "/admin/img_producto/" + imagenProducto %>" alt="<%= nombreProducto %>">
            <div class="card-content">
                <h3><%= nombreProducto %></h3>
                <p><strong>Marca:</strong> <%= marcaProducto %></p>
                <p><%= descripcionProducto %></p>
                <p><strong>Precio: </strong>$<%= precioVentaProducto %></p>
            </div>
            <div class="button-group"> <!-- Agrupar botones dentro de un contenedor -->
                <button class="btn btn-primary"  onclick="window.location.href='comprar_cliente.jsp'">Comprar</button>
                <button class="btn btn-secondary" onclick="anadirAFavoritos('<%= idProducto %>')">Añadir a Favoritos</button>
                <button class="btn btn-info" onclick="mostrarInformacion('<%= idProducto %>')">Más Información</button>
            </div>
        </div>
    <% } %>
</div>

<%@ include file="pie_cliente.jsp" %>