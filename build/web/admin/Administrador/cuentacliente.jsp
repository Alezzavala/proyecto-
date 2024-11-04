<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Cuenta Cliente</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_cliente" onclick="limpiar()">Nuevo</button>
            </div>
        </div>
        
        <!-- Columna derecha con Buscar e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Cuenta Cliente</h3>
            <div class="text-center">
                <input type="text" id="buscar" name="buscar" placeholder="Buscar por ID Cliente" class="form-control d-inline-block" style="width: auto; display: inline;">
                <button type="button" name="btn_buscar" id="btn_buscar" class="btn btn-primary" data-toggle="modal" data-target="#modal_buscarcliente">Buscar</button>
            </div>
        </div>
    </div>
</div>
<br>

<!-- Modal para Cuentas de Clientes -->
<div class="container">
    <div class="modal fade" id="modal_cliente" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_cuentacliente" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Cliente</b></label>
                        <input type="text" name="txt_idCliente" id="txt_idCliente" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_password"><b>Password</b></label>
                        <input type="password" name="txt_password" id="txt_password" class="form-control" placeholder="Contraseña" required>
                        
                        <label for="lbl_attempts"><b>Intentos</b></label>
                        <input type="number" name="txt_attempts" id="txt_attempts" class="form-control" placeholder="Intentos">
                        
                        <label for="lbl_mec"><b>MEC</b></label>
                        <input type="text" name="txt_mec" id="txt_mec" class="form-control" placeholder="Código MEC">
                        <br>

                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('¿Desea eliminar esta cuenta?')">Eliminar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

<!-- Modal para Buscar Cuenta Cliente -->
<div class="modal fade" id="modal_buscarcliente" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Clientes</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_cliente">

                        
                        for (int t = 0; t < tablaClientes.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaClientes.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 1) + "</td>");
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
    function limpiar() {
        $("#txt_idCliente").val(0);
        $("#txt_password").val('');
        $("#txt_attempts").val('');
        $("#txt_mec").val('');
    }

    $('#tbl_cliente').on('click', 'tr', function(evt) {
        var target = $(this);
        var idCliente = target.find("td").eq(0).text();

        $("#txt_idCliente").val(idCliente);
        $('#modal_buscarcliente').modal('hide');
    });

    $("#buscar").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#tbl_cliente tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });

    document.getElementById('closeModal').addEventListener('click', function() {
        var modal = document.querySelector('.modal');
        var bootstrapModal = bootstrap.Modal.getInstance(modal);
        bootstrapModal.hide();
    });
</script>

<%@ include file="pie_administrador.jsp" %>
