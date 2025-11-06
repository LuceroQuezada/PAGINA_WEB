<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Usuario, DAO.UsuarioDAO" %>
<%
    // — Verificar sesión y rol —
    Usuario docente = (Usuario) session.getAttribute("usuario");
    if (docente == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    String rol = new UsuarioDAO().obtenerNombreRol(docente.getIdRol());
    if (!"docente".equalsIgnoreCase(rol)) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Mis Cursos - Panel Docente</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
  <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>
  <style>
            body {
                background: #f5f6fa;
                margin: 0;
                padding: 0;
            }

            .sidebar {
                background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
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
                    <h4><i class="fas fa-chalkboard-teacher"></i> Panel Docente</h4>
                    <p><strong><i class="fas fa-user-tie"></i> Profesor</strong></p>
                </div>
                <ul class="nav flex-column w-100 px-2">
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link sidebar-active"><i class="fas fa-home"></i> Dashboard</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-clipboard-check"></i> Calificaciones</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-calendar-check"></i> Asistencia</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-clock"></i> Horarios</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-folder-open"></i> Material Didáctico</a>
                    </li>
                    <li class="nav-item mt-4">
                        <a href="${pageContext.request.contextPath}/salir" class="btn btn-danger w-100">
                            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                        </a>
                    </li>
                </ul>
            </div>
  <div class="container py-4">
    <h2 class="mb-4">🎓 Mis Cursos y Secciones</h2>

    <c:if test="${empty listaMisCursos}">
      <div class="alert alert-info">
        No tienes cursos asignados en este ciclo.
      </div>
    </c:if>

    <c:if test="${not empty listaMisCursos}">
      <table class="table table-striped table-bordered shadow-sm">
        <thead class="table-dark">
          <tr>
            <th>Curso (Carrera)</th>
            <th>Sección</th>
            <th>Grupo</th>
            <th>Día / Hora</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="cd" items="${listaMisCursos}">
            <tr>
              <td><c:out value="${cd.nombreCurso}"/> (<c:out value="${cd.carrera}"/>)</td>
              <td><c:out value="${cd.seccion}"/></td>
              <td><c:out value="${cd.grupo}"/></td>
              <td>
                <c:out value="${cd.dia}"/>
                &nbsp;
                <c:out value="${cd.horaInicio}"/>–<c:out value="${cd.horaFin}"/>
              </td>
              
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>

      <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/docente/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>
  </div>

  <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
  </div>
</body>
</html>
