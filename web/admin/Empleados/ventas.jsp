<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>


<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Ventas</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info center-button" data-toggle="modal" data-target="#modal_producto" onclick="limpiar()">Nuevo</button>
            </div>
        </div>

        <!-- Columna derecha con Buscar Producto e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Venta</h3>
            <div class="d-flex align-items-center">
                <!-- Input de búsqueda -->
                <input type="text" id="buscar_id" name="buscar_venta" placeholder="Buscar por ID" class="form-control" style="width: 200px; margin-right: 10px;">
                
                <!-- Select para seleccionar entre Producto o Venta -->
                <select name="buscar_modal" id="buscar_modal" class="form-control" style="width: 150px; margin-right: 10px;" required>
                    <option value="">Seleccionar</option>
                    <option value="modal_buscarVenta">Venta</option>
                    <option value="modal_buscarCliente">Cliente</option>
                    <option value="modal_buscarEmpleado">Empleado</option>
                </select>
                
                <!-- Botón para buscar que abre el modal -->
                <button type="button" name="btn_buscar_producto" id="btn_buscar_producto" class="btn btn-primary">Buscar</button>
            </div>
        </div>
    </div>
</div>
<br>



<div class="container">
    <div class="modal fade" id="modal_producto" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_ventas" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Venta</b></label>
                        <input type="text" name="txt_idVenta" id="txt_idVenta" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_noFactura"><b>No. Factura</b></label>
                        <input type="text" name="txt_noFactura" id="txt_noFactura" class="form-control" placeholder="Ejemplo: 12312" required>
                        <br>

                        <label for="lbl_serie"><b>Serie</b></label>
                        <input type="text" name="txt_serie" id="txt_serie" class="form-control" placeholder="Ejemplo: E" maxlength="1" required>

                        <!-- Campo de fecha para el formulario -->
                        <label for="lbl_fecha_factura"><b>Fecha Factura</b></label>
                        <input type="date" name="txt_fecha_factura" id="txt_fecha_factura" class="form-control" required>
                        <br>

                        <select name="drop_cliente" id="drop_cliente" class="form-control">
                            <option value="">Seleccione un cliente</option>
                            <% 
                                Ventas ven = new Ventas();
                                HashMap<String, List<String>> dropCliente = ven.drop_cliente();
                                for (String idCliente : dropCliente.keySet()) {
                                    List<String> datos = dropCliente.get(idCliente);
                                    String nombres = datos.get(0);
                                    String nit = datos.get(1);
                                    out.println("<option value='" + idCliente + "'>" + nombres + " " + nit + "</option>");
                                }
                            %>                                     
                        </select>
                        
<label for="lbl_idEmpleado"><b>Id Empleado</b></label> 
    <input type="text" name="txt_idEmpleado" id="txt_idEmpleado" class="form-control" value="<%= idEmpleado %>" readonly>
    <br>
                        
                        <label for="lbl_idProducto"><b>ID Producto</b></label>
                        <input type="text" name="txt_idProducto" id="txt_idProducto" class="form-control" placeholder="ID del producto" required>

                        <label for="lbl_cantidad"><b>Cantidad</b></label>
                        <input type="number" name="txt_cantidad" id="txt_cantidad" class="form-control" placeholder="Cantidad" required>
                        <br>
                        
                        <label for="lbl_precioVentaUnitario"><b>Precio Venta Unitario</b></label>
                        <input type="number" name="txt_precioVentaUnitario" id="txt_precioVentaUnitario" step="0.01" class="form-control" placeholder="Precio venta unitario" required>
                        
                        
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>No. Factura</th>
                <th>Serie</th>
                <th>Fecha Factura</th>
                <th>ID Cliente</th>
                <th>ID Empleado</th>
                <th>Fecha Ingreso</th>
                <th>ID Producto</th>
                <th>Cantidad</th>
                <th>Costo</th>
            </tr>
        </thead>
        <tbody id="tbl_ventas">
            <% 
            Ventas venta = new Ventas();  
            DefaultTableModel tabla = venta.leerVentas_1(); 
            
            for (int t = 0; t < tabla.getRowCount(); t++) {
                out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "' data-id_cliente='" + tabla.getValueAt(t, 4) + "'>");

                out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 9) + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

        
        
  <div class="modal fade" id="modal_buscar_venta" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Venta</h5>
                <div class="form-group">
                    <input type="text" id="buscar" placeholder="Buscar ID venta" class="form-control">
                </div>      
                    <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>No. Factura</th>
                            <th>Serie</th>
                            <th>Fecha Factura</th>
                            <th>ID Cliente</th>
                            <th>ID Empleado</th>
                            <th>Fecha Ingreso</th>
                            <th>ID Producto</th>
                            <th>Cantidad</th>
                            <th>Costo</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_venta">
                        <% 
                        Ventas venta_1 = new Ventas();  
                        DefaultTableModel tabla_1 = venta_1.leerVentas(); 

                        for (int t = 0; t < tabla_1.getRowCount(); t++) {
                            out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "' data-id_cliente='" + tabla_1.getValueAt(t, 4) + "'>");
                            out.println("<td>" + tabla_1.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 6) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 7) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 8) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 9) + "</td>");
                            out.println("</tr>");
                        }
                        %>
                    </tbody>
                </table>
                    <button type="button" class="btn btn-secondary" id="closeModal">Cerrar</button>
            </div>
        </div>
    </div>
</div>    
        
        


<!-- Modal para Buscar Empleado -->
<div class="modal fade" id="modal_buscar_empleado" role="dialog">
    <div class="modal-dialog modal-custom">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Empleado</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOMBRES</th>
                            <th>APELLIDOS</th>
                            <th>DIRECCIÓN</th>
                            <th>TELEFONO</th>
                            <th>DPI</th>
                            <th>FECHA NACIMIENTO</th>
                            <th>PUESTO</th>
                            <th>FECHA INICIO LABORES</th>
                            <th>FECHA INGRESO</th>
                            <th>GÉNERO</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_emp">
                        <% 
                        Empleados_adm emp = new Empleados_adm();  
                        DefaultTableModel tablaEmpleados_1 = emp.leerEmpleados(); 
                        
                        for (int t = 0; t < tablaEmpleados_1.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaEmpleados_1.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 6) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 7) + "</td>");  // Puesto
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 8) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 9) + "</td>");  // Fecha Ingreso
                            out.println("<td>" + (tablaEmpleados_1.getValueAt(t, 10).equals("0") ? "Masculino" : "Femenino") + "</td>");
                            out.println("</tr>");
                        }
                        %>
                    </tbody>
                </table>
                <button type="button" class="btn btn-secondary" id="closeModal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal para Buscar Cliente -->
<div class="modal fade" id="modal_buscar_cliente" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Clientes</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOMBRES</th>
                            <th>APELLIDOS</th>
                            <th>NIT</th>
                            <th>GENERO</th>
                            <th>TELEFONO</th>
                            <th>CORREO ELECTRONICO</th>
                            <th>FECHA INGRESO</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_cliente">
                        <% 
                        Clientes_adm cliente = new Clientes_adm();  
                        DefaultTableModel tablaClientes = cliente.leerClientes(); 
                        
                        for (int t = 0; t < tablaClientes.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaClientes.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 6) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 7) + "</td>");
                            out.println("</tr>");
                        }
                        %>
                    </tbody>
                </table>
                <button type="button" class="btn btn-secondary" id="closeModal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

        
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    // Función para limpiar el formulario antes de abrir el modal para nueva venta
    function limpiar() {
        $("#txt_idVenta").val(0);
        $("#txt_noFactura").val('');
        $("#txt_serie").val('');
        $("#txt_fecha_factura").val('');
        $("#drop_cliente").val('');
        $("#txt_idProducto").val('');
        $("#txt_cantidad").val('');
        $("#txt_precioVentaUnitario").val('');

        // Habilitar el campo de fecha
        $('#txt_fecha_factura').prop('disabled', false);
    }

    // Al hacer clic en una fila de la tabla
$('#tbl_ventas').on('click', 'tr', function(evt) {
    var target = $(this);
    var idVenta = target.find("td").eq(0).text();
    var noFactura = target.find("td").eq(1).text();
    var serie = target.find("td").eq(2).text();
    var fechaFactura = target.find("td").eq(3).text();
    var idCliente = parseInt(target.data('id_cliente'));
    var idEmpleado = parseInt(target.find("td").eq(5).text());
    var idProducto = target.find("td").eq(7).text();
    var cantidad = target.find("td").eq(8).text();
    var precio = target.find("td").eq(9).text();

    // Asignar los valores capturados al formulario
    $("#txt_idVenta").val(idVenta);
    $("#txt_noFactura").val(noFactura);
    $("#txt_serie").val(serie);
    $("#txt_fecha_factura").val(fechaFactura);
    $("#txt_fecha_factura").prop('readonly', true);
    $('#txt_fecha_factura').val(fechaFactura).prop('disabled', true);
    $("#drop_cliente").val(idCliente);
    $("#txt_idEmpleado").val(idEmpleado);
    $("#txt_idProducto").val(idProducto);
    $("#txt_cantidad").val(cantidad);
    $("#txt_precioVentaUnitario").val(precio);

    // Mostrar el modal
    $('#modal_producto').modal('show');
});


    
    
    $("#buscar_venta").on("keyup", function() {
        var value = $(this).val().toLowerCase().trim(); // Remueve espacios en blanco
        $("#tbl_venta tr").filter(function() {
            var id = $(this).find("td").eq(0).text().toLowerCase();
            // Verifica si el valor de búsqueda está presente en el ID o nombre
            $(this).toggle(id.includes(value));
        });
    });
    
        
        
    $(document).ready(function() {
        $("#btn_buscar_producto").click(function() {
            var modalSeleccionado = $("#buscar_modal").val();
            var value = $("#buscar_id").val().toLowerCase(); // Obtener el valor del campo de búsqueda

            // Verifica el valor seleccionado y abre el modal correspondiente
            if (modalSeleccionado === "modal_buscarVenta") {
                // Filtrar productos por el ID ingresado
                $("#tbl_venta tr").filter(function() {
                    var id = $(this).find("td").eq(0).text().toLowerCase(); // ID del producto en la tabla
                    $(this).toggle(id === value); // Mostrar solo las filas que coincidan
                });
                // Mostrar el modal de productos
                $('#modal_buscar_venta').modal('show');

            } else if (modalSeleccionado === "modal_buscarEmpleado") {
                // Filtrar ventas por el ID ingresado
                $("#tbl_emp tr").filter(function() {
                    var id = $(this).find("td").eq(0).text().toLowerCase();  // ID de la venta en la tabla
                    $(this).toggle(id === value);  // Mostrar solo las filas que coincidan
                });
                // Mostrar el modal de ventas
                $('#modal_buscar_empleado').modal('show');
                
            } else if (modalSeleccionado === "modal_buscarCliente") {
                // Filtrar ventas por el ID ingresado
                $("#tbl_cliente tr").filter(function() {
                    var id = $(this).find("td").eq(0).text().toLowerCase();  // ID de la venta en la tabla
                    $(this).toggle(id === value); // Mostrar solo las filas que coincidan
                });
                // Mostrar el modal de ventas
                $('#modal_buscar_cliente').modal('show');
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
</script>

<%@ include file="pie_administrador.jsp" %>
