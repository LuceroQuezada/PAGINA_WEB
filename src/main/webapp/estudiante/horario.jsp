<%@ include file="verificarEstudiante.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
<%@ page import="DAO.UsuarioDAO" %>

<%
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css"/>
         <style>
            body {
                background: #f5f6fa;
                margin: 0;
                padding: 0;
            }

            .sidebar {
                background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
                color: white;
                min-width: 220px;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 2rem 1rem;
            }

            .sidebar .nav-link {
                color: white;
                transition: 0.2s;
            }

            .sidebar .nav-link:hover,
            .sidebar .nav-link.sidebar-active {
                background-color: rgba(255, 255, 255, 0.15);
                border-radius: 5px;
            }

            .sidebar i {
                width: 20px;
            }

            .main-content {
                padding: 3rem 2rem;
                width: 100%;
            }
            </style>
    </head>
    <body class="bg-light">
            <div class="d-flex">
            <div class="sidebar">
                <div class="text-center mb-4">
                    <h4><i class="fas fa-user-graduate"></i> Panel Estudiante</h4>
                    <p><strong><i class="fas fa-user"></i> Estudiante</strong></p>
                </div>
                <ul class="nav flex-column w-100 px-2">
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link sidebar-active"><i class="fas fa-home"></i> Dashboard</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link">
                            <i class="fas fa-book"></i> Mis Cursos
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-calendar-alt"></i> Horario</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-chart-line"></i> Notas</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-tasks"></i> Mi asistencia</a>
                    </li>

                    <li class="nav-item mt-4">
                       <a href="${pageContext.request.contextPath}/salir" class="btn btn-danger w-100">
                            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                        </a>
                    </li>
                </ul>
            </div>

        <div class="container py-4">
            <h2>Mi Horario</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Curso</th>
                        <th>Profe</th><th>Sección</th>
                        <th>Grupo</th>
                        <th>Día</th>
                        <th>Inicio</th>
                        <th>Fin</th>
                    </tr></thead>
                <tbody>
                    <c:forEach var="h" items="${horario}">
                        <tr>
                            <td>${h.curso}</td>
                            <td>${h.profesor}</td>
                            <td>${h.seccion}</td>
                            <td>${h.grupo}</td>
                            <td>${h.dia}</td>
                            <td>${h.horaInicio}</td>
                            <td>${h.horaFin}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
              <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/estudiante/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>
        </div>
        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </div>
</body>
</html>
