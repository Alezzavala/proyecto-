<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Compras</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_compra" onclick="limpiar()">Nuevo</button>
            </div>
        </div>
        
        <!-- Columna derecha con Buscar e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Proveedor</h3>
            <div class="text-center">
                <input type="text" id="buscar" name="buscar" placeholder="Buscar por ID Proveedor" class="form-control d-inline-block" style="width: auto; display: inline;">
                <button type="button" name="btn_buscar" id="btn_buscar" class="btn btn-primary" data-toggle="modal" data-target="#modal_buscarproveedor">Buscar</button>
            </div>
        </div>
    </div>
</div>
<br>

<!-- Modal para Compras -->
<div class="container">
    <div class="modal fade" id="modal_compra" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_compras" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Compra</b></label>
                        <input type="text" name="txt_idCompra" id="txt_idCompra" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_noOrdenCompra"><b>No. Orden de Compra</b></label>
                        <input type="text" name="txt_noOrdenCompra" id="txt_noOrdenCompra" class="form-control" placeholder="Ejemplo: 12312" required>
                        <br>

                        <label for="lbl_idProveedor"><b>ID Proveedor</b></label>
                        <input type="text" name="txt_idProveedor" id="txt_idProveedor" class="form-control" placeholder="ID del proveedor" required>
 
                        <!-- Campo de fecha para el formulario -->
                        <label for="lbl_fecha_orden"><b>Fecha Orden</b></label>
                        <input type="date" name="txt_fecha_orden" id="txt_fecha_orden" class="form-control" required>
                        <input type="hidden" name="txt_fechaorden" id="txt_fechaorden" class="form-control" readonly>

                        <br>
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

 <!-- Modal para Buscar Proveedor -->
<div class="modal fade" id="modal_buscarproveedor" role="dialog">
    <div class="modal-dialog modal-lg"> <!-- Clase modal-lg hace el modal más grande -->
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Proveedores</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>PROVEEDOR</th>
                            <th>NIT</th>
                            <th>DIRECCION</th>
                            <th>TELEFONO</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_proveedor">
                        <% 
                        Proveedores proveedor = new Proveedores();  
                        DefaultTableModel tablaProveedores = proveedor.leerProveedores(); 
                        
                        for (int t = 0; t < tablaProveedores.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaProveedores.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaProveedores.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaProveedores.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tablaProveedores.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tablaProveedores.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tablaProveedores.getValueAt(t, 4) + "</td>");
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
                out.println("<td>" + tablaCompras.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tablaCompras.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tablaCompras.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tablaCompras.getValueAt(t, 3) + "</td>");
                out.println("<td>" + tablaCompras.getValueAt(t, 4) + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    // Función para limpiar el formulario antes de abrir el modal para nueva compra
    function limpiar() {
        $("#txt_idCompra").val(0);
        $("#txt_noOrdenCompra").val('');
        $("#txt_idProveedor").val('');
        $("#txt_fecha_orden").val('');
        $("#txt_fechaorden").val(''); // Limpiar el campo de fecha oculto
        $('#txt_fecha_orden').prop('disabled', false);
    }

    // Al hacer clic en una fila de la tabla de compras
    $('#tbl_compras').on('click', 'tr', function(evt) {
        var target = $(this);
        var idCompra = target.find("td").eq(0).text();
        var noOrdenCompra = target.find("td").eq(1).text();
        var idProveedor = target.find("td").eq(2).text();
        var fechaOrden = target.find("td").eq(3).text(); // Capturar la fecha de la tabla en formato texto

        // Asignar los valores capturados al formulario
        $("#txt_idCompra").val(idCompra);
        $("#txt_noOrdenCompra").val(noOrdenCompra);
        $("#txt_idProveedor").val(idProveedor);

        // Asignar la fecha capturada al campo de texto y deshabilitarlo
        $("#txt_fechaorden").val(fechaOrden);
        $("#txt_fecha_orden").prop('readonly', true);
        $('#txt_fecha_orden').val(fechaOrden).prop('disabled', true);

        // Mostrar el modal
        $('#modal_compra').modal('show');
    });

    // Al hacer clic en una fila de la tabla de proveedores
    $('#tbl_proveedor').on('click', 'tr', function(evt) {
        var target = $(this);
        var idProveedor = target.find("td").eq(0).text();
        var proveedor = target.find("td").eq(1).text();
        var nit = target.find("td").eq(2).text();
        var telefono = target.find("td").eq(3).text();
        // Asignar el ID del proveedor al campo correspondiente
        $("#txt_idProveedor").val(idProveedor);

        // Mostrar el modal de compra
        $('#modal_buscarproveedor').modal('hide'); // Ocultar el modal de proveedores
    });

    // Función para filtrar la tabla de proveedores
    $("#buscar").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#tbl_proveedor tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
    document.getElementById('closeModal').addEventListener('click', function() {
        var modal = document.querySelector('.modal');
        var bootstrapModal = bootstrap.Modal.getInstance(modal); // obtén la instancia del modal
        bootstrapModal.hide(); // oculta el modal
    });
</script>

<%@ include file="pie_administrador.jsp" %>
