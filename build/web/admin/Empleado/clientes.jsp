<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Clientes</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_cliente" onclick="limpiar()">Nuevo</button>
            </div>
        </div>
        
        <!-- Columna derecha con Buscar e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Cliente</h3>
            <div class="text-center">
                <input type="text" id="buscar" name="buscar" placeholder="Buscar por ID o nombre" class="form-control d-inline-block" style="width: auto; display: inline;">
                <button type="button" name="btn_buscar" id="btn_buscar" class="btn btn-primary" data-toggle="modal" data-target="#modal_buscarcliente">Buscar</button>
            </div>
        </div>
    </div>
</div>
<br>

<!-- Modal para Clientes -->
<div class="container">
    <div class="modal fade" id="modal_cliente" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_clientes_adm" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Cliente</b></label>
                        <input type="text" name="txt_idCliente" id="txt_idCliente" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_nombres"><b>Nombres</b></label>
                        <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Ejemplo: Juan" required>
                        
                        <label for="lbl_apellidos"><b>Apellidos</b></label>
                        <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Ejemplo: Pérez" required>
                        
                        <label for="lbl_nit"><b>NIT</b></label>
                        <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="NIT del cliente" required>

                        <label for="lbl_genero"><b>Género</b></label>
                        <select name="txt_genero" id="txt_genero" class="form-control" required>
                            <option value="0">Masculino</option> <!-- Cambiado a 0 -->
                            <option value="1">Femenino</option> <!-- Cambiado a 1 -->
                        </select>

                        <label for="lbl_telefono"><b>Teléfono</b></label>
                        <input type="text" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Teléfono" required>

                        <label for="lbl_correo"><b>Correo Electrónico</b></label>
                        <input type="email" name="txt_correo_electronico" id="txt_correo_electronico" class="form-control" placeholder="Ejemplo: correo@dominio.com" required>

                        <br>
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal para Buscar Cliente -->
<div class="modal fade" id="modal_buscarcliente" role="dialog">
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
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- Tabla para mostrar la lista de clientes -->
<div class="container">
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
        <tbody id="tbl_clientes">
            <% 
            DefaultTableModel tablaClientes_1 = cliente.leerClientes(); 
            
            for (int t = 0; t < tablaClientes_1.getRowCount(); t++) {
                out.println("<tr data-id='" + tablaClientes_1.getValueAt(t, 0) + "'>");
                out.println("<td>" + tablaClientes_1.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tablaClientes_1.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tablaClientes_1.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tablaClientes_1.getValueAt(t, 3) + "</td>");
                out.println("<td>" + tablaClientes_1.getValueAt(t, 4) + "</td>");
                out.println("<td>" + tablaClientes_1.getValueAt(t, 5) + "</td>");
                out.println("<td>" + tablaClientes_1.getValueAt(t, 6) + "</td>");
                out.println("<td>" + tablaClientes_1.getValueAt(t, 7) + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

<!-- Incluye los scripts de Bootstrap y jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    // Función para limpiar el formulario antes de abrir el modal para nuevo cliente
    function limpiar() {
        $("#txt_idCliente").val(0);
        $("#txt_nombres").val('');
        $("#txt_apellidos").val('');
        $("#txt_nit").val('');
        $("#txt_genero").val('true');
        $("#txt_telefono").val('');
        $("#txt_correo_electronico").val('');
    }

    // Al hacer clic en una fila de la tabla de clientes
    $('#tbl_clientes').on('click', 'tr', function(evt) {
        var target = $(this);
        $("#txt_idCliente").val(target.find("td").eq(0).text());
        $("#txt_nombres").val(target.find("td").eq(1).text());
        $("#txt_apellidos").val(target.find("td").eq(2).text());
        $("#txt_nit").val(target.find("td").eq(3).text());
        $("#txt_genero").val(target.find("td").eq(4).text());
        $("#txt_telefono").val(target.find("td").eq(5).text());
        $("#txt_correo_electronico").val(target.find("td").eq(6).text());

        // Mostrar el modal
        $('#modal_cliente').modal('show');
    });

    // Al hacer clic en una fila de la tabla de búsqueda de clientes
    $('#tbl_cliente').on('click', 'tr', function(evt) {
        var target = $(this);
        $("#txt_idCliente").val(target.find("td").eq(0).text());
        $('#modal_buscarcliente').modal('hide'); // Ocultar el modal de búsqueda de clientes
    });

    $("#buscar").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#tbl_cliente tr").filter(function() {
             var idCliente = $(this).find("td").eq(0).text().toLowerCase(); // Obtener el texto del ID (columna 0)
        
        // Mostrar la fila solo si el ID es exactamente igual al valor ingresado
        $(this).toggle(idCliente === value);
        });
    });
    
    document.getElementById('closeModal').addEventListener('click', function() {
        var modal = document.querySelector('.modal');
        var bootstrapModal = bootstrap.Modal.getInstance(modal); // obtén la instancia del modal
        bootstrapModal.hide(); // oculta el modal
    });



</script>

<%@ include file="pie_administrador.jsp" %>
