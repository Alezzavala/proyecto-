<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Proveedores</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_buscar_proveedor" onclick="limpiar()">Nuevo</button>
            </div>
        </div>
        
        <!-- Columna derecha con Buscar e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Proveedor</h3>
            <div class="text-center">
                <input type="text" id="buscar_proveedor" name="buscar_proveedor" placeholder="Buscar por ID o nombre" class="form-control d-inline-block" style="width: auto; display: inline;">
                <button type="button" name="btn_buscar" id="btn_buscar" class="btn btn-primary" data-toggle="modal" data-target="#modal_buscar_proveedor">Buscar</button>
            </div>
        </div>
    </div>
</div>
<br>

<div class="container">
    <div class="modal fade" id="modal_proveedor" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_proveedores" method="post" class="form-group">
                        <label for="lbl_id"><b>ID Proveedor</b></label>
                        <input type="text" name="txt_idProveedor" id="txt_idProveedor" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_nombre"><b>Nombre del Proveedor</b></label>
                        <input type="text" name="txt_proveedor" id="txt_proveedor" class="form-control" placeholder="Ejemplo: Proveedor XYZ" required>
                        <br>

                        <label for="lbl_nit"><b>NIT</b></label>
                        <input type="text" name="txt_nit" id="txt_nit" class="form-control" placeholder="NIT del proveedor" required>

                        <label for="lbl_direccion"><b>Dirección</b></label>
                        <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Dirección del proveedor" required>

                        <label for="lbl_telefono"><b>Teléfono</b></label>
                        <input type="text" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Teléfono del proveedor" required>
                        
                        <br>
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('¿Desea eliminar este proveedor?')">Eliminar</button>
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
                <th>Proveedor</th>
                <th>NIT</th>
                <th>Dirección</th>
                <th>Teléfono</th>
            </tr>
        </thead>
        <tbody id="tbl_proveedores">
            <% 
            Proveedores proveedor = new Proveedores();  
            DefaultTableModel tabla = proveedor.leerProveedores(); 
            
            for (int t = 0; t < tabla.getRowCount(); t++) {
                out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

<!-- Modal para Buscar Proveedor -->
<div class="modal fade" id="modal_buscar_proveedor" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Proveedores</h5>
                <div class="form-group">
                    <input type="text" id="buscar" placeholder="Buscar por ID o nombre" class="form-control">
                </div>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Proveedor</th>
                            <th>NIT</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_proveedor">
                        <% 
                        Proveedores proveedor_1 = new Proveedores();  
                        DefaultTableModel tabla_1 = proveedor_1.leerProveedores(); 

                        for (int t = 0; t < tabla_1.getRowCount(); t++) {
                            out.println("<tr data-id='" + tabla_1.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tabla_1.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 4) + "</td>");
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
        $("#txt_idProveedor").val(0);
        $("#txt_proveedor").val('');
        $("#txt_nit").val('');
        $("#txt_direccion").val('');
        $("#txt_telefono").val('');
    }

    $('#tbl_proveedores').on('click', 'tr', function(evt) {
        var target = $(this);
        var idProveedor = target.data('id'); // Accede al ID del proveedor
        var proveedor = target.find("td").eq(1).text(); // Obtener el nombre del proveedor
        var nit = target.find("td").eq(2).text(); // NIT
        var direccion = target.find("td").eq(3).text(); // Dirección
        var telefono = target.find("td").eq(4).text(); // Teléfono

        $('#txt_idProveedor').val(idProveedor);
        $('#txt_proveedor').val(proveedor);
        $('#txt_nit').val(nit);
        $('#txt_direccion').val(direccion);
        $('#txt_telefono').val(telefono);

        $('#modal_proveedor').modal('show');
    });
    
    
    
    // Función para filtrar la tabla de proveedores
$("#buscar_proveedor").on("keyup", function() {
    var value = $(this).val().toLowerCase().trim(); // Remueve espacios en blanco
    $("#tbl_proveedor tr").filter(function() {
        var id = $(this).find("td").eq(0).text().toLowerCase();
        // Verifica si el valor de búsqueda está presente en el ID o nombre
        if (id === "") {
        alert("Ingrese un valor para buscar.");
        $("#tbl_proveedor tr").show(); // Opcional: Muestra todas las filas si el campo está vacío
        return; // Sale de la función
    }
        $(this).toggle(id.includes(value));
    });
});


// Función para filtrar la tabla de proveedores
$("#buscar_proveedor").on("keyup", function() {
    var value = $(this).val().toLowerCase().trim(); // Remueve espacios en blanco

    // Verifica si el campo está vacío
    if (value === "") {
        alert("Ingrese un valor para buscar.");
        $("#tbl_proveedor tr").show(); // Opcional: Muestra todas las filas si el campo está vacío
        return; // Sale de la función
    }

    // Filtra la tabla
    $("#tbl_proveedor tr").filter(function() {
        var id = $(this).find("td").eq(0).text().toLowerCase();
        // Verifica si el valor de búsqueda está presente en el ID
        $(this).toggle(id.includes(value));
    });
});


    document.getElementById('closeModal').addEventListener('click', function() {
        var modal = document.querySelector('.modal');
        var bootstrapModal = bootstrap.Modal.getInstance(modal); // Obtén la instancia del modal
        bootstrapModal.hide(); // Oculta el modal
    });
</script>

<%@ include file="pie_administrador.jsp" %>
