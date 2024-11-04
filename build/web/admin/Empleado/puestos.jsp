<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Puestos</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_puesto" onclick="limpiar()">Nuevo</button>
            </div>
        </div>

        <!-- Columna derecha con Buscar e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Puesto</h3>
            <div class="text-center">
                <input type="text" id="buscar" name="buscar" placeholder="Buscar por ID Puesto" class="form-control d-inline-block" style="width: auto; display: inline;">
                <button type="button" name="btn_buscar" id="btn_buscar" class="btn btn-primary" data-toggle="modal" data-target="#modal_buscarPuesto">Buscar</button>
                <a href="empleados.jsp" class="btn btn-primary">Tabla Empleados</a>
            </div>
        </div>
    </div>
</div>
<br>

<!-- Modal para Puestos -->
<div class="container">
    <div class="modal fade" id="modal_puesto" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_puestos_adm" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Puesto</b></label>
                        <input type="text" name="txt_idPuesto" id="txt_idPuesto" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_puesto"><b>Nombre Puesto</b></label>
                        <input type="text" name="txt_puesto" id="txt_puesto" class="form-control" placeholder="Nombre del puesto" required>
                        <br>

                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para Buscar Puesto -->
    <div class="modal fade" id="modal_buscarPuesto" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <h5>Lista de Puestos</h5>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Puesto</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_puesto">
                            <% 
                            Puesto puesto = new Puesto();  
                            DefaultTableModel tablaPuestos = puesto.leerPuestos();
                            
                            for (int t = 0; t < tablaPuestos.getRowCount(); t++) {
                                out.println("<tr data-id='" + tablaPuestos.getValueAt(t, 0) + "'>");
                                out.println("<td>" + tablaPuestos.getValueAt(t, 0) + "</td>");
                                out.println("<td>" + tablaPuestos.getValueAt(t, 1) + "</td>");
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
                <th>Puesto</th>
            </tr>
        </thead>
        <tbody id="tbl_puestos">
            <% 
            Puesto puesto_1 = new Puesto();  
            DefaultTableModel tablaPuestos_1 = puesto_1.leerPuestos();
            
            for (int t = 0; t < tablaPuestos_1.getRowCount(); t++) {
                out.println("<tr data-id='" + tablaPuestos_1.getValueAt(t, 0) + "'>");
                out.println("<td>" + tablaPuestos_1.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tablaPuestos_1.getValueAt(t, 1) + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    // Función para limpiar el formulario antes de abrir el modal para nuevo puesto
    function limpiar() {
        $("#txt_idPuesto").val(0);
        $("#txt_puesto").val('');
    }

    // Al hacer clic en una fila de la tabla de puestos
    $('#tbl_puestos').on('click', 'tr', function() {
        var idPuesto = $(this).find("td").eq(0).text();
        var nombrePuesto = $(this).find("td").eq(1).text();

        // Asignar los valores capturados al formulario
        $("#txt_idPuesto").val(idPuesto);
        $("#txt_puesto").val(nombrePuesto);

        // Mostrar el modal
        $('#modal_puesto').modal('show');
    });

    // Al hacer clic en una fila de la tabla de búsqueda de puestos
    $('#tbl_puesto').on('click', 'tr', function() {
        var idPuesto = $(this).find("td").eq(0).text();
        $("#txt_idPuesto").val(idPuesto);
        $('#modal_buscarPuesto').modal('hide');
    });

    // Función para filtrar la tabla de puestos
    $("#buscar").on("keyup", function() {
        var value = $(this).val().toLowerCase().trim(); // Remueve espacios en blanco
        $("#tbl_puesto tr").filter(function() {
            var id = $(this).find("td").eq(0).text().toLowerCase();
            // Cambia la condición para que coincida exactamente con el ID
            $(this).toggle(id === value);
        });
    });
    document.getElementById('closeModal').addEventListener('click', function() {
        var modal = document.querySelector('.modal');
        var bootstrapModal = bootstrap.Modal.getInstance(modal); // obtén la instancia del modal
        bootstrapModal.hide(); // oculta el modal
    });
</script>

<%@ include file="pie_administrador.jsp" %>
