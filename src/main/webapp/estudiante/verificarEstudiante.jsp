<%@ page import="modelo.Usuario" %>
<%@ page import="DAO.UsuarioDAO" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    UsuarioDAO dao = new UsuarioDAO();
    String nombreRol = dao.obtenerNombreRol(usuario.getIdRol());
    
    if (!"estudiante".equals(nombreRol)) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    request.setAttribute("nombreRol", nombreRol);
%>