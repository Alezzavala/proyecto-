<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="modelo.Cuenta" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>
            body {
                background-image: url('img/Cover.png');
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 0;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
            }

            .card-container {
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: rgba(50, 50, 50, 0.5);
                padding: 40px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .card {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                width: 300px;
                text-align: center;
            }

            h1 {
                color: #333;
            }

            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                width: 100%;
                background-color: #4CAF50;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            p {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="card-container">
            <div class="card">
                <h1>Login</h1>
                <form method="POST">
                    Username: <input type="text" name="username" required><br>
                    Password: <input type="password" name="password" required><br>
                    <input type="submit" value="Login">
                </form>

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

                            String sql = "SELECT id, password, attempts, lock_time, mec, idEmpleado FROM users WHERE username = ?";
                            stmt = conn.prepareStatement(sql);
                            stmt.setString(1, username);
                            rs = stmt.executeQuery();

                            if (rs.next()) {
                                String dbPassword = rs.getString("password");
                                int attempts = rs.getInt("attempts");
                                Timestamp lockTime = rs.getTimestamp("lock_time");
                                String role = rs.getString("mec");
                                int idEmpleado = rs.getInt("idEmpleado");

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

                                        // Redirección según el rol
                                        if (role.equalsIgnoreCase("admin")) {
                                            response.sendRedirect("admin/Administrador/Productos.jsp");
                                        } else if (role.equalsIgnoreCase("empleado")) {
                                            response.sendRedirect("admin/Empleado/admin.jsp");
                                        } else if (role.equalsIgnoreCase("cliente")) {
                                            response.sendRedirect("admin/cliente.jsp");
                                        }

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
            </div>
        </div>
    </body>
</html>
