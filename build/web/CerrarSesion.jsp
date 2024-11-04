<% 
    // Invalida la sesión actual
    session.invalidate();
    
    // Redirige al usuario a la página de inicio o a la página que prefieras
    response.sendRedirect("index.jsp");
%>