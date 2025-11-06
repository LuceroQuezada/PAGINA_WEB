<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    
    if (!"docente".equals(nombreRol)) {
        response.sendRedirect("../login.jsp");
        return;
    }
  
    request.setAttribute("nombreRol", nombreRol);
%>