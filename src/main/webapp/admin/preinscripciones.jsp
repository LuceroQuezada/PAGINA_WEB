<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Preinscripcion" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Preinscripciones</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container py-5">
        <h2 class="text-center mb-4">Gestión de Preinscripciones</h2>

        
        
        <%-- Mensaje --%>
        <%
            String mensaje = request.getParameter("mensaje");
            if ("aceptado".equals(mensaje)) {
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ✅ Preinscripción aceptada exitosamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
            </div>
        <% } else if ("rechazado".equals(mensaje)) { %>
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                ⚠️ Preinscripción rechazada correctamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
            </div>
        <% } else if ("error".equals(mensaje)) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ❌ Error al procesar la solicitud.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
            </div>
        <% } %>

        <div class="table-responsive mt-4">
            <table class="table table-bordered table-hover text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>DNI</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Email</th>
                        <th>Dirección</th>
                        <th>Colegio</th>
                        <th>Carrera</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Preinscripcion> lista = (List<Preinscripcion>) request.getAttribute("listaPreinscripciones");
                    if (lista != null && !lista.isEmpty()) {
                        for (Preinscripcion p : lista) {
                %>
                    <tr>
                        <td><%= p.getDni() %></td>
                        <td><%= p.getNombres() %></td>
                        <td><%= p.getApellidos() %></td>
                        <td><%= p.getCorreo() %></td>
                        <td><%= p.getDireccion() %></td>
                        <td><%= p.getColegio() %></td>
                        <td><%= p.getCarrera() %></td>
                        <td>
                            <a href="aceptarPreinscripcion?dni=<%= p.getDni() %>" class="btn btn-success btn-sm me-1">Aceptar</a>
                            <a href="rechazarPreinscripcion?dni=<%= p.getDni() %>" class="btn btn-danger btn-sm me-1">Rechazar</a>
                            <a href="#" class="btn btn-info btn-sm">Correo</a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8">No hay preinscripciones registradas.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
                
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>