<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page import="modelo.productos" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@ page import="modelo.Cuenta" %>
<%@page import="modelo.Ventas" %>
<%@page import="modelo.Clientes_adm" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Empleados_adm" %>

<%
    // Recuperar el usuario de la sesión
    Cuenta usuario1 = (Cuenta) session.getAttribute("usuario");
    
%>

 <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newdb", "root", "");

                String sql = "SELECT id, password, attempts, lock_time, mec, idCliente FROM users WHERE username = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("password");
                    int attempts = rs.getInt("attempts");
                    Timestamp lockTime = rs.getTimestamp("lock_time");
                    String role = rs.getString("mec");
                    int idCliente = rs.getInt("idCliente");

                    long currentTimeMillis = System.currentTimeMillis();
                    boolean locked = false;

                    if (lockTime != null && (currentTimeMillis - lockTime.getTime()) < 300000) {
                        out.println("<p style='color:red;'>Tienes varios intentos fallidos. Por favor espera 5 minutos.</p>");
                        locked = true;
                    }

                    if (!locked) {
                        if (password.equals(dbPassword)) {
                            // Crear objeto Cuenta y almacenar en la sesión
                            Cuenta usuario = new Cuenta(rs.getInt("id"), username, dbPassword);
                            session.setAttribute("usuario", usuario);  // Guardar el objeto Cuenta en la sesión

                            
                            response.sendRedirect("index.jsp");   
                            

                            // Resetear intentos
                            String resetAttemptsSql = "UPDATE users SET attempts = 0, lock_time = NULL WHERE username = ?";
                            PreparedStatement resetStmt = conn.prepareStatement(resetAttemptsSql);
                            resetStmt.setString(1, username);
                            resetStmt.executeUpdate();
                            resetStmt.close();
                            } else {
                                attempts++;
                                if (attempts >= 3) {
                                    String lockSql = "UPDATE users SET lock_time = NOW() WHERE username = ?";
                                    PreparedStatement lockStmt = conn.prepareStatement(lockSql);
                                    lockStmt.setString(1, username);
                                    lockStmt.executeUpdate();
                                    lockStmt.close();
                                    out.println("<p style='color:red;'>Demasiados intentos fallidos. Cuenta bloqueada por 5 minutos.</p>");
                                } else {
                                    String updateAttemptsSql = "UPDATE users SET attempts = ? WHERE username = ?";
                                    PreparedStatement updateStmt = conn.prepareStatement(updateAttemptsSql);
                                    updateStmt.setInt(1, attempts);
                                    updateStmt.setString(2, username);
                                    updateStmt.executeUpdate();
                                    updateStmt.close();
                                    out.println("<p style='color:red;'>Credenciales inválidas. Intento " + attempts + " de 3.</p>");
                                }
                            }
                        }
            } else {
                out.println("<p style='color:red;'>Usuario no existe.</p>");
            }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error conectando a la base de datos.</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>

<!DOCTYPE html>
<html>
<head>
    <title>AZ TECH HUB</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    
    <style>
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
    height: 100px; /* Aseg?rate de que ancho y alto sean iguales */
    border-radius: 50%; /* Hace la imagen circular */
    object-fit: cover; /* Ajusta la imagen para que se vea bien en un contenedor cuadrado */
}

.navbar-nav {
    display: flex; /* Utiliza flexbox para alinear los elementos */
    align-items: center; /* Alinea verticalmente los elementos en el centro */
}

.nav-item .nav-link {
    display: flex; /* Hace que el enlace y el icono est?n alineados */
    align-items: center; /* Centra verticalmente el contenido dentro del enlace */
    height: 100%; /* Mantiene todos los enlaces a la misma altura */
    font-size: 1.3rem; /* Tama?o de fuente */
    padding: 10px 15px; /* Espaciado interno */
    color: #808080; /* Gris est?ndar */
}

.nav-item .nav-link img {
    height: 30px; /* Ajusta el tama?o del icono de carrito */
    margin-right: 5px; /* Espacio entre el icono y el texto */
}




        .form-control {
            height: 38px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap; /* Permite que las tarjetas se envuelvan en m?ltiples l?neas */
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
    font-size: 1rem; /* Cambia el tama?o de la fuente (puedes usar px, em, rem, etc.) */
    font-weight: bold; /* Cambia el grosor del texto (opcional) */
    margin: 0 15px;
}

/* Estilos para los botones */
.btn-long {
    display: inline-block;
    font-size: 1rem; /* Tama?o de texto grande */
    padding: 5px 30px; /* Espacio interno del bot?n */
    width: 65%; /* Hacer que el bot?n ocupe todo el ancho posible */
    max-width: 300px; /* Limitar el ancho m?ximo */
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
    background-color: black; /* Bot?n gris oscuro */
    border: none; /* Sin borde */
    color: white; /* Texto blanco en el bot?n */
}

.btn-primary:hover {
    background-color: #777; /* Color del bot?n al pasar el mouse */
}

.mt-3 {
    color: white; /* Texto blanco para el p?rrafo */
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
    color: white; /* Aseg?rate de que el t?tulo del modal sea blanco */
}

.btn-close {
    filter: invert(1); /* Cambia el color del bot?n de cerrar a blanco */
}


        
    </style>
</head>
<body>
    <header>
           <nav class="navbar navbar-expand-lg navbar-night bg-night">
        <div class="container-fluid">
            <a class="navbar-brand" href="login.jsp">
                <img src="img/logo.png">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button> 
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Inicio</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Catálogo</a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                           
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#.jsp"><img src="img/10.png">Carrito</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="contactanos.jsp.jsp">Contactanos</a>
                    </li>
                </ul>
                <form class="d-flex" action="buscarProductos.jsp" >
                    
                    <!-- Botón para Iniciar Sesión -->
                    <button type="button" class="btn btn-outline-success btn-long" data-bs-toggle="modal" data-bs-target="#loginModal" 
                            <%= (usuario1 != null) ? "style='display:none;'" : "" %>>
                        Iniciar Sesión
                    </button>

                    <!-- Mostrar el nombre del usuario si está logueado y agregar un enlace para cerrar sesión -->
                    <% if (usuario1 != null) { %>
                        <span class="welcome-text">
                            <a href="CerrarSesion.jsp" style="color:inherit; text-decoration:none;"><%= usuario1.getUsername() %></a>
                        </span>
                    <% } %>
                    
                    <input class="form-control me-2" type="search" name="nombreProducto" placeholder="Buscar por nombre" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">BUSCAR</button>
                </form>
            </div>
        </div>
    </nav>

    <br>
    <!-- Modal de Iniciar Sesión -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Iniciar Sesión</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Removemos el action del formulario -->
                    <form id="loginForm" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Usuario</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
                    </form>

                    <p class="mt-3">¿No tienes una cuenta? <a href="#" >Regístrate aquí</a></p>
                </div>
            </div>
        </div>
    </div>
    </header>