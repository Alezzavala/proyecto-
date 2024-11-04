<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Marcas</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_marca" onclick="limpiar()">Nuevo</button>
            </div>
        </div>
        
        <!-- Columna derecha con Buscar e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Marca</h3>
            <div class="text-center">
                <input type="text" id="buscar" name="buscar" placeholder="Buscar por ID Marca" class="form-control d-inline-block" style="width: auto; display: inline;">
                <button type="button" name="btn_buscar" id="btn_buscar" class="btn btn-primary" data-toggle="modal" data-target="#modal_buscarmarca">Buscar</button>
                <a href="Productos.jsp" class="btn btn-primary">Tabla Productos</a>
            </div>
        </div>
    </div>
</div>
<br>

<!-- Modal para Marcas -->
<div class="container">
    <div class="modal fade" id="modal_marca" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_marcas_adm" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Marca</b></label>
                        <input type="text" name="txt_idMarca" id="txt_idMarca" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_marca"><b>Nombre Marca</b></label>
                        <input type="text" name="txt_marca" id="txt_marca" class="form-control" placeholder="Nombre de la marca" required>
                        <br>

                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('¿Desea eliminar esta marca?')">Eliminar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

 <!-- Modal para Buscar Marca -->
<div class="modal fade" id="modal_buscarmarca" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Marcas</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>MARCA</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_marca">
                        <% 
                        Marca marca = new Marca();  
                        DefaultTableModel tablaMarcas = marca.leerMarcas(); 
                        
                        for (int t = 0; t < tablaMarcas.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaMarcas.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaMarcas.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaMarcas.getValueAt(t, 1) + "</td>");
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
                <th>MARCA</th>
            </tr>
        </thead>
        <tbody id="tbl_marcas">
            <% 
            Marca marca_1 = new Marca();  
            DefaultTableModel tablaMarcas_1 = marca_1.leerMarcas();
            
            for (int t = 0; t < tablaMarcas_1.getRowCount(); t++) {
                out.println("<tr data-id='" + tablaMarcas_1.getValueAt(t, 0) + "'>");
                out.println("<td>" + tablaMarcas_1.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tablaMarcas_1.getValueAt(t, 1) + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    // Función para limpiar el formulario antes de abrir el modal para nueva marca
    function limpiar() {
        $("#txt_idMarca").val(0);
        $("#txt_marca").val('');
    }

    // Al hacer clic en una fila de la tabla de marcas
    $('#tbl_marcas').on('click', 'tr', function(evt) {
        var target = $(this);
        var idMarca = target.find("td").eq(0).text();
        var nombreMarca = target.find("td").eq(1).text();

        // Asignar los valores capturados al formulario
        $("#txt_idMarca").val(idMarca);
        $("#txt_marca").val(nombreMarca);

        // Mostrar el modal
        $('#modal_marca').modal('show');
    });

    // Al hacer clic en una fila de la tabla de búsqueda de marcas
    $('#tbl_marca').on('click', 'tr', function(evt) {
        var target = $(this);
        var idMarca = target.find("td").eq(0).text();
        var nombreMarca = target.find("td").eq(1).text();
        
        // Asignar el ID de la marca al campo correspondiente
        $("#txt_idMarca").val(idMarca);

        // Ocultar el modal de marcas
        $('#modal_buscarmarca').modal('hide');
    });

    // Función para filtrar la tabla de marcas
    $("#buscar").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#tbl_marca tr").filter(function() {
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
