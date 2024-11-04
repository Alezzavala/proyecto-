<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Invalida la sesión del usuario y lo redirige al login
    session.invalidate();  // Invalidar la sesión actual
    response.sendRedirect("../../login.jsp");  // Redirigir a la página de login
%>