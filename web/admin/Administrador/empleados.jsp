
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Empleados</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info" data-toggle="modal" data-target="#modal_empleado" onclick="limpiar()">Nuevo</button>
            </div>
        </div>
        
        <!-- Columna derecha con Buscar e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Empleado</h3>
            <div class="text-center">
                <input type="text" id="buscar" name="buscar" placeholder="Buscar por ID" class="form-control d-inline-block" style="width: auto; display: inline;">
                <button type="button" name="btn_buscar" id="btn_buscar" class="btn btn-primary" onclick="mostrarModalBuscar()">Buscar</button>
                <a href="puestos.jsp" class="btn btn-primary">Tabla Puestos</a>
            </div>
        </div>
    </div>
</div>
<br>

<!-- Modal para Empleados -->
<div class="container">
    <div class="modal fade" id="modal_empleado" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_empleados_adm" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Empleado</b></label>
                        <input type="text" name="txt_idEmpleado" id="txt_idEmpleado" class="form-control" value="0" readonly>

                        <label for="lbl_nombres"><b>Nombres</b></label>
                        <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Ejemplo: Juan" required>

                        <label for="lbl_apellidos"><b>Apellidos</b></label>
                        <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Ejemplo: Pérez" required>

                        <label for="lbl_direccion"><b>Dirección</b></label>
                        <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Dirección del empleado" required>

                        <label for="lbl_telefono"><b>Teléfono</b></label>
                        <input type="text" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Teléfono" required>

                        <label for="lbl_dpi"><b>DPI</b></label>
                        <input type="text" name="txt_dpi" id="txt_dpi" class="form-control" placeholder="DPI del empleado" required>

                        <label for="lbl_fecha_nacimiento"><b>Fecha de Nacimiento</b></label>
                        <input type="date" name="txt_fecha_nacimiento" id="txt_fecha_nacimiento" class="form-control" required>

                        <label for="lbl_puesto"><b>Puesto</b></label>
                        <select name="drop_puesto" id="drop_puesto" class="form-control" required>
                            <option value="">Seleccione un puesto</option>
                            <% 
                                Puesto puesto = new Puesto();
                                HashMap<String, String> drop = puesto.drop_puestos();
                                for (String i : drop.keySet()) {
                                    out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                }
                            %>                                     
                        </select>

                        <label for="lbl_fecha_inicio_labores"><b>Fecha de Inicio de Labores</b></label>
                        <input type="date" name="txt_fecha_inicio_labores" id="txt_fecha_inicio_labores" class="form-control" required>
                        
                        <label for="lbl_genero"><b>Género</b></label>
                        <select name="txt_genero" id="txt_genero" class="form-control" required>
                            <option value="0">Masculino</option>
                            <option value="1">Femenino</option>
                        </select>

                        <br>
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('¿Desea eliminar este empleado?')">Eliminar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal para Buscar Empleado -->
<div class="modal fade" id="modal_buscarempleado" role="dialog">
    <div class="modal-dialog modal-custom">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Empleados</h5>
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
                            out.println("<tr data-id='" + tablaEmpleados_1.getValueAt(t, 0) + "' data-id_puesto='" + tablaEmpleados_1.getValueAt(t, 7) + "'>");
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
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- Tabla para mostrar la lista de empleados -->
<div class="container">
    <table class="table table-striped" id="tbl_empleado">
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
        <tbody>
            <% 
            Empleados_adm empleado = new Empleados_adm();
            DefaultTableModel tablaEmpleados = empleado.leerEmpleados();
            
            for (int i = 0; i < tablaEmpleados.getRowCount(); i++) {
                out.println("<tr data-id='" + tablaEmpleados.getValueAt(i, 0) + "' data-id_puesto='" + tablaEmpleados.getValueAt(i, 7) + "'>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 0) + "</td>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 1) + "</td>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 2) + "</td>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 3) + "</td>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 4) + "</td>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 5) + "</td>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 6) + "</td>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 7) + "</td>");  // Puesto
                out.println("<td>" + tablaEmpleados.getValueAt(i, 8) + "</td>");
                out.println("<td>" + tablaEmpleados.getValueAt(i, 9) + "</td>");  // Fecha Ingreso
                out.println("<td>" + (tablaEmpleados.getValueAt(i, 10).equals("0") ? "Masculino" : "Femenino") + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>
        
        
 <!-- Modal para mostrar usuario y contraseña -->
<div class="modal fade" id="modalCredenciales" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Credenciales de Empleado</h5>
            </div>
            <div class="modal-body">
                <p><strong>Nombre de usuario:</strong> ${username}</p>
                <p><strong>Contraseña:</strong> ${password}</p>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script>
    function mostrarModalBuscar() {
        var id = $("#buscar").val().trim();
        if (id === "") {
            alert("Por favor, ingrese un ID para buscar.");
            return;
        }

        // Filtrar la tabla por el ID ingresado
        var rows = $("#tbl_emp tr");
        var found = false;

        rows.each(function() {
            var row = $(this);
            var empleadoId = row.data("id").toString();

            if (empleadoId === id) {
                row.show();
                found = true;
            } else {
                row.hide();
            }
        });

        if (!found) {
            alert("No se encontró un empleado con ese ID.");
        } else {
            $("#modal_buscarempleado").modal("show");
        }
    }

// Al hacer clic en una fila de la tabla de empleados
    $('#tbl_empleado').on('click', 'tr', function() {
        var target = $(this);
        var idEmpleado = target.data('id'); 
        var idPuesto = target.data('id_puesto');

        // Obtener valores de la fila
        var nombres = target.find("td").eq(1).text(); 
        var apellidos = target.find("td").eq(2).text(); 
        var direccion = target.find("td").eq(3).text(); 
        var telefono = target.find("td").eq(4).text(); 
        var dpi = target.find("td").eq(5).text(); 
        var fechaNacimiento = target.find("td").eq(6).text(); 
        var puesto = target.find("td").eq(7).text(); 
        var fechaInicioLabores = target.find("td").eq(8).text(); 
        var fechaIngreso = target.find("td").eq(9).text(); 
        var genero = target.find("td").eq(10).text(); 

        // Llenar el formulario en el modal con los valores seleccionados
        $("#txt_idEmpleado").val(idEmpleado);
        $("#txt_nombres").val(nombres);
        $("#txt_apellidos").val(apellidos);
        $("#txt_direccion").val(direccion);
        $("#txt_telefono").val(telefono);
        $("#txt_dpi").val(dpi);
        $("#txt_fecha_nacimiento").val(fechaNacimiento);
        $("#drop_puesto").val(idPuesto);
        $("#txt_fecha_inicio_labores").val(fechaInicioLabores);
        $("#txt_genero").val(genero === "Masculino" ? "0" : "1");

        // Mostrar el modal
        $("#modal_empleado").modal("show");
    });

function limpiar() {
    $("#txt_idEmpleado").val("0");
    $("#txt_nombres").val("");
    $("#txt_apellidos").val("");
    $("#txt_direccion").val("");
    $("#txt_telefono").val("");
    $("#txt_dpi").val("");
    $("#txt_fecha_nacimiento").val("");
    $("#txt_fecha_inicio_labores").val("");
    $("#txt_genero").val("0");
    $("#drop_puesto").val("");
}

    $(document).ready(function() {
        // Mostrar el modal si se recibieron los atributos username y password
        <% if (request.getAttribute("username") != null && request.getAttribute("password") != null) { %>
            $('#modalCredenciales').modal('show');
        <% } %>
    });
    
    document.getElementById('closeModal').addEventListener('click', function() {
        var modal = document.querySelector('.modal');
        var bootstrapModal = bootstrap.Modal.getInstance(modal); // obtén la instancia del modal
        bootstrapModal.hide(); // oculta el modal
    });

</script>


<%@ include file="pie_administrador.jsp" %>