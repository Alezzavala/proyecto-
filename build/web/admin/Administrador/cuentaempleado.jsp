<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<%
    // Instanciar la clase Cuenta y leer las cuentas de empleados
    Cuenta cuenta = new Cuenta();
    DefaultTableModel tablaCuentas = cuenta.leerCuentasEmpleado();
%>

<!-- Modal para modificar la cuenta -->
<div class="modal fade" id="modal_modificar" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modificar Cuenta</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form action="sr_cuentaempleado" method="post" id="form_modificar">
                    <input type="hidden" name="txt_idEmpleado" id="txt_idEmpleado">
                    <div class="form-group">
                        <label for="txt_username">Username</label>
                        <input type="text" class="form-control" id="txt_username" name="txt_username" readonly>
                    </div>
                    <div class="form-group">
                        <label for="txt_password">Nueva Contraseña</label>
                        <input type="password" class="form-control" id="txt_password" name="txt_password" required>
                    </div>
                    <button type="submit" class="btn btn-primary" name="btn_modificar">Guardar Cambios</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <h3>Cuenta</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Nombre Empleado</th>
                <th>Apellido Empleado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <% 
                for (int t = 0; t < tablaCuentas.getRowCount(); t++) {
                    out.println("<tr>");
                    for (int j = 0; j < tablaCuentas.getColumnCount(); j++) {
                        out.println("<td>" + tablaCuentas.getValueAt(t, j) + "</td>");
                    }
                    // Cambia aquí para agregar el botón de modificación
                    out.println("<td><button class='btn btn-warning btn-sm' onclick='editarCuenta(" + 
                        tablaCuentas.getValueAt(t, 0) + ", \"" + 
                        tablaCuentas.getValueAt(t, 1) + "\", \"" + 
                        tablaCuentas.getValueAt(t, 2) + "\")'>Modificar</button></td>");
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
    $(document).ready(function() {
        // Obtener el username del div con la clase 'usuario'
        var username = $('.usuario').text().trim();
        
        // Filtrar la tabla para mostrar solo el usuario correspondiente
        $('.table tbody tr').each(function() {
            var rowUsername = $(this).find('td').eq(1).text().trim(); // Asumiendo que el username está en la segunda columna (índice 1)
            if (rowUsername !== username) {
                $(this).hide(); // Ocultar la fila si el username no coincide
            }
        });
    });
</script>

<%@ include file="pie_administrador.jsp" %>
