<%@page import="java.sql.*" %>
<%@page import="modelo.productos" %>
<%@page import="modelo.Marca" %>
<%@page import="modelo.Puesto" %>
<%@page import="modelo.Ventas" %>
<%@page import="modelo.Compras" %>
<%@page import="modelo.Proveedores" %>
<%@page import="modelo.Clientes_adm" %>
<%@page import="modelo.Cuenta" %>
<%@page import="modelo.Empleados_adm" %>
<%@page import="modelo.ComprasDetalle_adm" %>
<%@page import="modelo.VentasDetalle_adm" %>
<%@page import="java.util.HashMap" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="modelo.conexion" %>


<%
    // Acceder a la sesión y obtener la información del usuario
    HttpSession userSession = request.getSession();
    Cuenta usuario = (Cuenta) userSession.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("../../login.jsp"); 
        return;
    }

    // Crear una instancia de la clase conexion
    conexion con = new conexion();
    con.abrir_conexion();
    Connection conn = con.conectar_db;
    PreparedStatement stmt = null;
    PreparedStatement stmt1 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;

    // Mapa para almacenar el menú jerárquico
    HashMap<Integer, List<HashMap<String, Object>>> menuMap = new HashMap<>();
    
    int idEmpleado = 0;

    try {
        // Consulta SQL para obtener los menús en orden jerárquico
        String sql = "SELECT id_menu, nombre, padre_id, url, archivo FROM menu1 ORDER BY padre_id, id_menu";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        while (rs.next()) {
            int idMenu = rs.getInt("id_menu");
            String nombre = rs.getString("nombre");
            int padreId = rs.getInt("padre_id");
            String url = rs.getString("url");
            String archivo = rs.getString("archivo");

            // Crear un mapa para el menú actual
            HashMap<String, Object> menu = new HashMap<>();
            menu.put("id_menu", idMenu);
            menu.put("nombre", nombre);
            menu.put("url", url);
            menu.put("archivo", archivo);

            // Si el padre es 0 (es un menú principal), lo almacenamos en el mapa principal
            if (padreId == 0) {
                if (!menuMap.containsKey(idMenu)) {
                    menuMap.put(idMenu, new ArrayList<>());
                }
                menuMap.get(idMenu).add(menu);
            } else {
                // Si tiene padre, añadimos el submenú al menú correspondiente
                if (!menuMap.containsKey(padreId)) {
                    menuMap.put(padreId, new ArrayList<>());
                }
                menuMap.get(padreId).add(menu);
            }
        }

        // Consulta SQL para obtener el ID del empleado basado en el nombre de usuario
        String sql1 = "SELECT e.idEmpleado FROM users u INNER JOIN empleados e ON u.idEmpleado = e.idEmpleado WHERE u.username = ?";
        stmt1 = conn.prepareStatement(sql1);
        stmt1.setString(1, usuario.getUsername());
        rs1 = stmt1.executeQuery();

        if (rs1.next()) {
            idEmpleado = rs1.getInt("idEmpleado");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs1 != null) rs1.close();
            if (stmt1 != null) stmt1.close();
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        con.cerrar_conexion();
    }
%>


<!DOCTYPE html>
<html>
<head>
    <title>ᴀᴢ ᴛᴇᴄʜ ʜᴜʙ</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="../../img/logo.png" type="image/x-icon">
 <style>
        body {
            background-image: url('img/fondo.gif');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
            margin: 0;
        }

        .navbar {
            padding: 20px 10px;
            position: relative;
        }

        .navbar-brand img {
            width: 250px;
            height: auto;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 250px;
            background-color: rgba(52, 58, 64, 0.9);
            padding: 20px;
            z-index: 1000;
            display: none;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .sidebar h3 {
            color: white;
        }

        .sidebar .nav-link {
            color: #ffffff;
            font-weight: bold;
            margin: 5px 0;
        }

        .sidebar .nav-link:hover {
            background-color: #495057;
            color: #f8f9fa;
            border-radius: 10px;
        }

        .content {
            margin-left: 260px;
            padding: 20px;
        }

        h1 {
            font-weight: bold;
            color: white;
            font-size: 36px;
        }

        .table {
            background-color: white;
            color: black;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }

        .table th, .table td {
            vertical-align: middle;
            border: 1px solid #dee2e6;
        }

        .menu-icon {
            font-size: 35px;
            color: white;
            cursor: pointer;
            position: fixed;
            z-index: 1100;
            top: 20px;
            left: 20px;
        }

        .navbar-brand img {
            width: 13%;
            height: auto;
            margin: 0 80px 40px;
        }

        h3 {
            color: white;
            font-size: 42px;
            font-weight: bold;
            text-align: center;
            margin: 10px 0;
        }

        .center-button {
            display: block;
            margin: 0 auto;
            font-size: 30px;
            font-weight: bold;
            color: white;
            background-color: #17a2b8;
        }

        .modal-custom {
            max-width: 90%;
        }
        
        .usuario {
            color: #00FFFF; /* Color del texto */
            margin: 0 20px; /* Margen superior e inferior a 0, margen derecho de 20px */
            white-space: nowrap; /* Mantiene el texto en una sola línea */
            font-size: 25px; /* Tamaño de la fuente grande */
            overflow: visible; /* Asegúrate de que el contenido no esté oculto */
            text-overflow: clip; /* Desactiva los puntos suspensivos */
        }

        .usuario:hover {
            color: #00FFFF; /* Cambia el color al pasar el mouse */
            transform: scale(1.05); /* Aumenta ligeramente el tamaño al pasar el mouse */
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.7); /* Añade un efecto de resplandor */
        }

        .usuario::after {
            content: '\2606';
            margin-left: 10px; /* Espacio entre el nombre y la flecha */
            font-size: 25px; /* Tamaño de la flecha */
            vertical-align: middle; /* Alinea verticalmente la flecha con el texto */
            color: white; /* Color de la flecha */
            transition: transform 0.3s ease; /* Efecto de transición */
        }

        .usuario:hover::after {
            transform: rotate(180deg); /* Rota la flecha al pasar el mouse */
        }
        
        
      body {
    background-image: url('img/fondo.gif');
    background-size: auto 100vh; /* Ajusta solo la altura al 100% de la pantalla */
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-color: #000; /* Rellena con negro en los bordes si es necesario */
    margin: 0;
    font-family: Arial, sans-serif;
}




.navbar {
    padding: 10px 10px;
}

.navbar-brand img {
    width: 100px;
    height: 100px; /* Aseg�rate de que ancho y alto sean iguales */
    border-radius: 50%; /* Hace la imagen circular */
    object-fit: cover; /* Ajusta la imagen para que se vea bien en un contenedor cuadrado */
}

.navbar-nav {
    display: flex; /* Utiliza flexbox para alinear los elementos */
    align-items: center; /* Alinea verticalmente los elementos en el centro */
}

.nav-item .nav-link {
    display: flex; /* Hace que el enlace y el icono est�n alineados */
    align-items: center; /* Centra verticalmente el contenido dentro del enlace */
    height: 100%; /* Mantiene todos los enlaces a la misma altura */
    font-size: 1.3rem; /* Tama�o de fuente */
    padding: 10px 15px; /* Espaciado interno */
    color: #808080; /* Gris est�ndar */
}

.nav-item .nav-link img {
    height: 30px; /* Ajusta el tama�o del icono de carrito */
    margin-right: 5px; /* Espacio entre el icono y el texto */
}




        .form-control {
            height: 38px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap; /* Permite que las tarjetas se envuelvan en m�ltiples l�neas */
            gap: 30px; /* Espacio entre las tarjetas */
            justify-content: center; /* Centra las tarjetas horizontalmente */
            align-items: center; /* Centra las tarjetas verticalmente (opcional) */
            padding: 20px; /* Espacio alrededor del contenedor */
        }

        .card {
            background-color: rgba(211, 211, 240, 0.8); /* Gris claro */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px; /* Ancho fijo para las tarjetas */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Distribuir el contenido */
        }

        .card img {
            width: 100%;
            height: 200px; /* Altura fija */
            object-fit: cover; /* Ajuste de imagen */
            border-radius: 8px; /* Bordes redondeados */
        }

        .button-group {
    display: flex; /* Usar flexbox para los botones */
    flex-direction: column; /* Apilar botones verticalmente */
    margin-top: 10px; /* Espacio entre el contenido y los botones */
}

.button-group .btn {
    width: 100%; /* Los botones ocupan todo el ancho */
    margin: 5px 0; /* Espacio entre botones */
}

.welcome-text {
    color: white; /* Cambia el color del texto (en este caso, un azul) */
    font-size: 1rem; /* Cambia el tama�o de la fuente (puedes usar px, em, rem, etc.) */
    font-weight: bold; /* Cambia el grosor del texto (opcional) */
    margin: 0 15px;
}

/* Estilos para los botones */
.btn-long {
    display: inline-block;
    font-size: 1rem; /* Tama�o de texto grande */
    padding: 5px 30px; /* Espacio interno del bot�n */
    width: 65%; /* Hacer que el bot�n ocupe todo el ancho posible */
    max-width: 300px; /* Limitar el ancho m�ximo */
    text-align: center;
    background-color: #808080; /* Color de fondo gris */
    color: white; /* Texto blanco */
    border: none; /* Sin borde */
    border-radius: 5px; /* Bordes redondeados */
    transition: background-color 0.3s ease; /* Efecto suave al cambiar el color */
}

.btn-long:hover {
    background-color: #a9a9a9; /* Cambiar el color al pasar el mouse */
}

.btn-long:active {
    background-color: #c0c0c0; /* Cambiar el color al hacer clic */
}

.btn-long:focus {
    outline: none; /* Remover contorno de enfoque */
    box-shadow: 0 0 5px rgba(40, 167, 69, 0.5); /* Sombra al hacer foco */
}

.modal-body {
    background-color: #333; /* Color de fondo gris oscuro para el cuerpo del modal */
    color: white; /* Texto blanco en el cuerpo del modal */
}

.form-label {
    color: white; /* Color blanco para las etiquetas de los campos */
}

.form-control {
    background-color: #f0f0f0; /* Fondo gris claro para los campos de entrada */
    color: black; /* Texto negro en los campos de entrada */
    border: 1px solid #ccc; /* Borde gris claro */
}

.form-control:focus {
    border-color: #666; /* Color del borde en enfoque */
    box-shadow: 0 0 5px rgba(100, 100, 100, 0.5); /* Sombra en enfoque */
}

.btn-primary {
    background-color: black; /* Bot�n gris oscuro */
    border: none; /* Sin borde */
    color: white; /* Texto blanco en el bot�n */
}

.btn-primary:hover {
    background-color: #777; /* Color del bot�n al pasar el mouse */
}

.mt-3 {
    color: white; /* Texto blanco para el p�rrafo */
}

a {
    color: #00FFFF; /* Color azul para el enlace */
}

a:hover {
    color: #1e90ff; /* Color del enlace al pasar el mouse */
}
.modal-header {
    background-color: #444; /* Color de fondo gris oscuro para el encabezado del modal */
    color: white; /* Texto blanco en el encabezado */
}

.modal-header .modal-title {
    color: white; /* Aseg�rate de que el t�tulo del modal sea blanco */
}

.btn-close {
    filter: invert(1); /* Cambia el color del bot�n de cerrar a blanco */
}

.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    height: auto; /* Cambia de 100% a auto para que se ajuste al contenido */
    width: auto; /* Cambia el ancho para que sea más pequeño */
    background-color: rgba(52, 58, 64, 0.9);
    padding: 10px; /* Reduce el padding */
    z-index: 1000;
    display: flex; /* Cambia a flex para organizar horizontalmente */
    flex-direction: row; /* Alinea los elementos horizontalmente */
    overflow-x: auto; /* Permite el desplazamiento horizontal si es necesario */
}

.nav-link {
    color: #ffffff;
    font-weight: bold;
    margin: 0 5px; /* Espaciado horizontal entre los enlaces */
    font-size: 0.9rem; /* Tamaño de fuente más pequeño */
    padding: 5px 10px; /* Espaciado interno reducido */
}

.dropdown-menu {
    position: absolute; /* Asegúrate de que el menú desplegable aparezca correctamente */
    left: 0; /* Alinea el menú desplegable a la izquierda */
    top: 100%; /* Coloca el menú desplegable justo debajo del enlace del menú */
}

.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    height: 60%; /* Mantén la altura completa */
    width: 150px; /* Ajusta el ancho según tus necesidades */
    background-color: rgba(52, 58, 64, 0.9);
    padding: 10px;
    z-index: 1000;
    display: none; /* Oculta el menú por defecto */
}

.nav-link {
    color: #ffffff;
    font-weight: bold;
    margin: 0 5px;
    font-size: 0.9rem;
    padding: 5px 10px;
}



        
    

    </style>
    
</head>
<body>
    <header>
        <div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
        <div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
            <a class="navbar-brand">
                <img src="../../img/logo.png" alt="Logo" style="width: 100px; height: 100px;">
            </a>
            <div class="usuario"><%= usuario.getUsername() %></div>
        </div>

        <div class="sidebar">
    <nav class="nav flex-column">
        <br><br><br>
        <% 
            // Iterar sobre los menús principales
            for (Integer idMenu : menuMap.keySet()) {
                List<HashMap<String, Object>> submenus = menuMap.get(idMenu);
                HashMap<String, Object> menu = submenus.get(0); // Menú principal

                String nombre = (String) menu.get("nombre");
                String url = (String) menu.get("url");
                String archivo = (String) menu.get("archivo");

                // Menú principal
                out.println("<a class='nav-link active' href='" + url + archivo + "'>" + nombre + "</a>");

                // Verificar si tiene submenús
                if (submenus.size() > 1) {
                    out.println("<div class='dropdown'>");
                    out.println("<a class='nav-link dropdown-toggle' id='dropdown" + idMenu + "' role='button' data-bs-toggle='dropdown' aria-expanded='false'>" + nombre + "</a>");
                    out.println("<ul class='dropdown-menu' aria-labelledby='dropdown" + idMenu + "'>");
                    
                    for (int i = 1; i < submenus.size(); i++) { // Desde el segundo menú, porque el primero es el principal
                        HashMap<String, Object> submenu = submenus.get(i);
                        String subNombre = (String) submenu.get("nombre");
                        String subUrl = (String) submenu.get("url");
                        String subArchivo = (String) submenu.get("archivo");
                        out.println("<li><a class='dropdown-item' href='" + subUrl + subArchivo +"'>" + subNombre + "</a></li>");
                    }
                    
                    out.println("</ul></div>");
                }
            }
        %>
        <a class="nav-link active" href="cerrar.jsp">Cerrar Sesión</a>
    </nav>
</div>
    </header>
