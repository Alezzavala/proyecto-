<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Detalles de Ventas</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_venta_detalle" onclick="limpiar()">Nuevo</button>
            </div>
        </div>
        
        <!-- Columna derecha con Buscar Producto e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Producto</h3>
            <div class="d-flex align-items-center">
                <!-- Input de búsqueda -->
                <input type="text" id="buscar_producto" name="buscar_producto" placeholder="Buscar por ID Producto" class="form-control" style="width: 200px; margin-right: 10px;">
                
                <!-- Select para seleccionar entre Producto o Venta -->
                <select name="buscar_modal" id="buscar_modal" class="form-control" style="width: 150px; margin-right: 10px;" required>
                    <option value="">Seleccionar</option>
                    <option value="modal_buscar_producto">Producto</option>
                    <option value="modal_buscar_IdVenta">Venta</option>
                </select>
                
                <!-- Botón para buscar que abre el modal -->
                <button type="button" name="btn_buscar_producto" id="btn_buscar_producto" class="btn btn-primary">Buscar</button>
            </div>
        </div>
    </div>
</div>
<br>

<!-- Modal para Detalles de Ventas -->
<div class="container">
    <div class="modal fade" id="modal_venta_detalle" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_VentasDetalles_adm" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_idVentaDetalle"><b>ID Detalle Venta</b></label>
                        <input type="text" name="txt_idVentaDetalle" id="txt_idVentaDetalle" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_idVenta"><b>ID Venta</b></label>
                        <input type="text" name="txt_idVenta" id="txt_idVenta" class="form-control" placeholder="ID de la venta" required>
                        
                        <label for="lbl_idProducto"><b>ID Producto</b></label>
                        <input type="text" name="txt_idProducto" id="txt_idProducto" class="form-control" placeholder="ID del producto" required>

                        <label for="lbl_cantidad"><b>Cantidad</b></label>
                        <input type="number" name="txt_cantidad" id="txt_cantidad" class="form-control" placeholder="Cantidad" required>

                        <label for="lbl_precioVentaUnitario"><b>Precio Venta Unitario</b></label>
                        <input type="number" name="txt_precioVentaUnitario" id="txt_precioVentaUnitario" step="0.01" class="form-control" placeholder="Precio venta unitario" required>
                        <br>

                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('¿Desea eliminar este detalle de venta?')">Eliminar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal para Buscar Producto -->
<div class="modal fade" id="modal_buscarproducto" role="dialog">
    <div class="modal-dialog modal-custom">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Productos</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Producto</th>
                            <th>Marca</th>
                            <th>Descripción</th>
                            <th>Precio Venta</th>
                            <th>Existencia</th>
                            <th>Fecha Ingreso</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_producto">
                        <% 
                        productos producto = new productos();  
                        DefaultTableModel tablaProductos = producto.leer(); 
                        
                        for (int t = 0; t < tablaProductos.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaProductos.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaProductos.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaProductos.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tablaProductos.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tablaProductos.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tablaProductos.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tablaProductos.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tablaProductos.getValueAt(t, 6) + "</td>");
                            out.println("</tr>");
                        }
                        %>
                    </tbody>
                </table>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
                    
<!-- Tabla de Detalles de Ventas -->
<div class="container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID Detalle</th>
                <th>ID Venta</th>
                <th>ID Producto</th>
                <th>Cantidad</th>
                <th>Precio Venta Unitario</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody id="tbl_ventas_detalle">
            <% 
            VentasDetalle_adm ventaDetalle = new VentasDetalle_adm();  
            DefaultTableModel tablaVentasDetalle = ventaDetalle.leerVentasDetalle(); 
            
            for (int t = 0; t < tablaVentasDetalle.getRowCount(); t++) {
                out.println("<tr data-id='" + tablaVentasDetalle.getValueAt(t, 0) + "'>");
                out.println("<td>" + tablaVentasDetalle.getValueAt(t, 0) + "</td>"); // ID Detalle
                out.println("<td>" + tablaVentasDetalle.getValueAt(t, 1) + "</td>"); // ID Venta
                out.println("<td>" + tablaVentasDetalle.getValueAt(t, 2) + "</td>"); // ID Producto

                // Obtener cantidad y precio unitario
                int cantidad = 0;
                double precioUnitario = 0.0;

                try {
                    cantidad = Integer.parseInt(tablaVentasDetalle.getValueAt(t, 3).toString());
                    precioUnitario = Double.parseDouble(tablaVentasDetalle.getValueAt(t, 4).toString());
                } catch (NumberFormatException e) {
                    out.println("<td colspan='5'>Error al obtener datos</td>");
                    out.println("</tr>");
                    continue; // Salta a la siguiente fila si hay un error
                }

                // Calcular el total
                double total = cantidad * precioUnitario;

                // Mostrar los datos en la tabla
                out.println("<td>" + cantidad + "</td>"); // Cantidad
                out.println("<td>" + precioUnitario + "</td>"); // Precio Venta Unitario
                out.println("<td>" + total + "</td>"); // Total
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

<!-- Modal para Buscar Venta -->
<div class="modal fade" id="modal_buscar_IdVenta" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Ventas</h5>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>No. Factura</th>
                                <th>ID Cliente</th>
                                <th>Fecha Factura</th>
                                <th>Fecha Ingreso</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_ventas">
                            <% 
                            Ventas venta = new Ventas();  
                            DefaultTableModel tablaVentas = venta.leerVentas(); 
                            
                            for (int t = 0; t < tablaVentas.getRowCount(); t++) {
                                out.println("<tr data-id='" + tablaVentas.getValueAt(t, 0) + "'>");
                                out.println("<td>" + tablaVentas.getValueAt(t, 0) + "</td>"); // ID Venta
                                out.println("<td>" + tablaVentas.getValueAt(t, 1) + "</td>"); // No. Factura
                                out.println("<td>" + tablaVentas.getValueAt(t, 2) + "</td>"); // ID Cliente
                                out.println("<td>" + tablaVentas.getValueAt(t, 3) + "</td>"); // Fecha Factura
                                out.println("<td>" + tablaVentas.getValueAt(t, 6) + "</td>"); // Fecha Ingreso
                                out.println("</tr>");
                            }
                            %>
                        </tbody>
                    </table>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<script type="text/javascript">
    // Función para limpiar el formulario antes de abrir el modal para nuevo detalle
    function limpiar() {
        $("#txt_idVentaDetalle").val(0);
        $("#txt_idVenta").val('');
        $("#txt_idProducto").val('');
        $("#txt_cantidad").val('');
        $("#txt_precioVentaUnitario").val('');
    }

    // Al hacer clic en una fila de la tabla de detalles de ventas
    $('#tbl_ventas_detalle').on('click', 'tr', function() {
        var target = $(this);
        var idVentaDetalle = target.find("td").eq(0).text();
        var idVenta = target.find("td").eq(1).text();
        var idProducto = target.find("td").eq(2).text();
        var cantidad = target.find("td").eq(3).text();
        var precioVentaUnitario = target.find("td").eq(4).text();

        // Asignar los valores capturados al formulario
        $("#txt_idVentaDetalle").val(idVentaDetalle);
        $("#txt_idVenta").val(idVenta);
        $("#txt_idProducto").val(idProducto);
        $("#txt_cantidad").val(cantidad);
        $("#txt_precioVentaUnitario").val(precioVentaUnitario);

        // Mostrar el modal
        $('#modal_venta_detalle').modal('show');
    });

    // Al hacer clic en una fila de la tabla de productos
    $('#tbl_producto').on('click', 'tr', function() {
        var target = $(this);

        // Obtener el ID del producto seleccionado
        var idProducto = target.find("td").eq(0).text();

        // Asignar el ID del producto al campo correspondiente
        $("#txt_idProducto").val(idProducto);

        // Cerrar el modal de búsqueda de productos
        $('#modal_buscarproducto').modal('hide');
    });

    $(document).ready(function() {
        $("#btn_buscar_producto").click(function() {
            var modalSeleccionado = $("#buscar_modal").val();
            var value = $("#buscar_producto").val().toLowerCase(); // Obtener el valor del campo de búsqueda

            // Verifica el valor seleccionado y abre el modal correspondiente
            if (modalSeleccionado === "modal_buscar_producto") {
                // Filtrar productos por el ID ingresado
                $("#tbl_producto tr").filter(function() {
                    var idProducto = $(this).find("td").eq(0).text().toLowerCase(); // ID del producto en la tabla
                    $(this).toggle(idProducto.indexOf(value) > -1); // Mostrar solo las filas que coincidan
                });
                // Mostrar el modal de productos
                $('#modal_buscarproducto').modal('show');

            } else if (modalSeleccionado === "modal_buscar_IdVenta") {
                // Filtrar ventas por el ID ingresado
                $("#tbl_ventas tr").filter(function() {
                    var idVenta = $(this).find("td").eq(0).text().toLowerCase(); // ID de la venta en la tabla
                    $(this).toggle(idVenta.indexOf(value) > -1); // Mostrar solo las filas que coincidan
                });
                // Mostrar el modal de ventas
                $('#modal_buscar_IdVenta').modal('show');
            } else {
                alert("Por favor, selecciona un tipo de búsqueda.");
            }
        });
    });
    
    document.getElementById('closeModal').addEventListener('click', function() {
            var modal = document.querySelector('.modal');
            var bootstrapModal = bootstrap.Modal.getInstance(modal); // obtén la instancia del modal
            bootstrapModal.hide(); // oculta el modal
        });
</script>

<%@ include file="pie_administrador.jsp" %>
