<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Detalles de Compras</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_compra_detalle" onclick="limpiar()">Nuevo</button>
            </div>
        </div>
        
        <!-- Columna derecha con Buscar Producto e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Producto</h3>
            <div class="d-flex align-items-center">
                <!-- Input de búsqueda -->
                <input type="text" id="buscar_producto" name="buscar_producto" placeholder="Buscar por ID Producto" class="form-control" style="width: 200px; margin-right: 10px;">
                
                <!-- Select para seleccionar entre Producto o Compra -->
                <select name="buscar_modal" id="buscar_modal" class="form-control" style="width: 150px; margin-right: 10px;" required>
                    <option>Seleccionar</option>
                    <option value="modal_buscar_producto">Producto</option>
                    <option value="modal_buscar_IdCompra">Compra</option>
                </select>
                
                <!-- Botón para buscar que abre el modal -->
                <button type="button" name="btn_buscar_producto" id="btn_buscar_producto" class="btn btn-primary">Buscar</button>
            </div>
        </div>
    </div>
</div>
<br>

<!-- Modal para Detalles de Compras -->
<div class="container">
    <div class="modal fade" id="modal_compra_detalle" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_ComprasDetalle_adm" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_idCompraDetalle"><b>ID Detalle Compra</b></label>
                        <input type="text" name="txt_idCompraDetalle" id="txt_idCompraDetalle" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_idCompra"><b>ID Compra</b></label>
                        <input type="text" name="txt_idCompra" id="txt_idCompra" class="form-control" placeholder="ID de la compra" required>
                        
                        <label for="lbl_idProducto"><b>ID Producto</b></label>
                        <input type="text" name="txt_idProducto" id="txt_idProducto" class="form-control" placeholder="ID del producto" required>

                        <label for="lbl_cantidad"><b>Cantidad</b></label>
                        <input type="number" name="txt_cantidad" id="txt_cantidad" class="form-control" placeholder="Cantidad" required>

                        <label for="lbl_precioCostoUnitario"><b>Precio Costo Unitario</b></label>
                        <input type="number" name="txt_precioCostoUnitario" id="txt_precioCostoUnitario" step="0.01" class="form-control" placeholder="Precio costo unitario" required>
                        <br>

                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModalDetalle">Cerrar</button>
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
                            <th>Imagen</th>
                            <th>Precio Costo</th>
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
                            for (int i = 0; i < tablaProductos.getColumnCount(); i++) {
                                out.println("<td>" + tablaProductos.getValueAt(t, i) + "</td>");
                            }
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

<!-- Tabla de Detalles de Compras -->
<div class="container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID Detalle</th>
                <th>ID Compra</th>
                <th>ID Producto</th>
                <th>Cantidad</th>
                <th>Precio Costo Unitario</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody id="tbl_compras_detalle">
            <% 
            ComprasDetalle_adm compraDetalle = new ComprasDetalle_adm();  
            DefaultTableModel tablaComprasDetalle = compraDetalle.leerComprasDetalle(); 
            
            for (int t = 0; t < tablaComprasDetalle.getRowCount(); t++) {
                out.println("<tr data-id='" + tablaComprasDetalle.getValueAt(t, 0) + "'>");
                for (int i = 0; i < tablaComprasDetalle.getColumnCount(); i++) {
                    out.println("<td>" + tablaComprasDetalle.getValueAt(t, i) + "</td>");
                }

                // Calcular total
                int cantidad = Integer.parseInt(tablaComprasDetalle.getValueAt(t, 3).toString());
                double precioUnitario = Double.parseDouble(tablaComprasDetalle.getValueAt(t, 4).toString());
                double total = cantidad * precioUnitario;

                // Mostrar total
                out.println("<td>" + total + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

<!-- Modal para Buscar Compra -->
<div class="modal fade" id="modal_buscar_IdCompra" role="dialog">
    <div class="modal-dialog modal-custom">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Compras</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>No. Orden Compra</th>
                            <th>ID Proveedor</th>
                            <th>Fecha Orden</th>
                            <th>Fecha Ingreso</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_compras">
                        <% 
                        Compras compra = new Compras();  
                        DefaultTableModel tablaCompras = compra.leerCompras(); 

                        for (int t = 0; t < tablaCompras.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaCompras.getValueAt(t, 0) + "'>");
                            for (int i = 0; i < tablaCompras.getColumnCount(); i++) {
                                out.println("<td>" + tablaCompras.getValueAt(t, i) + "</td>");
                            }
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

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    // Función para limpiar el formulario antes de abrir el modal para nuevo detalle
    function limpiar() {
        $("#txt_idCompraDetalle").val(0);
        $("#txt_idCompra").val('');
        $("#txt_idProducto").val('');
        $("#txt_cantidad").val('');
        $("#txt_precioCostoUnitario").val('');
    }

    // Al hacer clic en una fila de la tabla de detalles de compras
    $('#tbl_compras_detalle').on('click', 'tr', function() {
        var target = $(this);
        $("#txt_idCompraDetalle").val(target.find("td").eq(0).text());
        $("#txt_idCompra").val(target.find("td").eq(1).text());
        $("#txt_idProducto").val(target.find("td").eq(2).text());
        $("#txt_cantidad").val(target.find("td").eq(3).text());
        $("#txt_precioCostoUnitario").val(target.find("td").eq(4).text());

        // Mostrar el modal
        $('#modal_compra_detalle').modal('show');
    });

    // Al hacer clic en una fila de la tabla de productos
    $('#tbl_producto').on('click', 'tr', function() {
        var target = $(this);
        
        // Obtener los valores de las celdas
        $("#txt_idProducto").val(target.find("td").eq(0).text());
        // Asigna más campos según sea necesario

        // Cerrar el modal de búsqueda de productos
        $('#modal_buscarproducto').modal('hide');
    });

    $(document).ready(function() {
        // Al hacer clic en el botón de buscar
        $("#btn_buscar_producto").click(function() {
            var modalSeleccionado = $("#buscar_modal").val();
            var value = $("#buscar_producto").val().toLowerCase();

            // Verifica el valor seleccionado y abre el modal correspondiente
            if (modalSeleccionado === "modal_buscar_producto") {
                $("#tbl_producto tr").filter(function() {
                    var idProducto = $(this).find("td").eq(0).text().toLowerCase();
                    $(this).toggle(idProducto.indexOf(value) > -1);
                });
                $('#modal_buscarproducto').modal('show');

            } else if (modalSeleccionado === "modal_buscar_IdCompra") {
                $("#tbl_compras tr").filter(function() {
                    var idCompra = $(this).find("td").eq(0).text().toLowerCase();
                    $(this).toggle(idCompra.indexOf(value) > -1);
                });
                $('#modal_buscar_IdCompra').modal('show');
            }
        });

        // Botón para cerrar el modal de detalles
        $("#closeModalDetalle").click(function() {
            $("#modal_compra_detalle").modal('hide');
        });
    });
</script>
<%@ include file="pie_administrador.jsp" %>
