<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Cursos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

    <h2 class="mb-4 text-primary">
        <i class="fas fa-book-open"></i> Mis Cursos y Materiales
    </h2>

    <!-- Selección de Sección -->
    <form method="get" action="${pageContext.request.contextPath}/Estudiante/Cursos" class="row g-2 mb-4">
        <div class="col-md-8">
            <select name="idSeccion" class="form-select" onchange="this.form.submit()">
                <option value="">-- Selecciona un curso / sección --</option>
                <c:forEach var="s" items="${secciones}">
                    <option value="${s.id}" <c:if test="${s.id == selectedSeccion}">selected</c:if>>
                        ${s.curso} | ${s.seccion} | ${s.profesor}
                    </option>
                </c:forEach>
            </select>
        </div>
    </form>

    <!-- Materiales del Curso -->
    <c:if test="${not empty materiales}">
        <div class="row">
            <c:forEach var="m" items="${materiales}">
                <div class="col-md-4">
                    <div class="card shadow-sm mb-3">
                        <div class="card-body">
                            <i class="${m.icono} fa-2x mb-2"></i>
                            <h5 class="card-title text-truncate" title="${m.titulo}">
                                ${m.titulo}
                            </h5>
                            <p class="card-text small text-muted">${m.descripcion}</p>
                            <a class="btn btn-sm btn-outline-primary"
                               href="${pageContext.request.contextPath}/descargar?file=${m.archivo}">
                                <i class="fas fa-download"></i> Descargar
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty materiales and not empty selectedSeccion}">
        <div class="alert alert-info">No hay materiales disponibles para esta sección.</div>
    </c:if>

   <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/estudiante/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>

</div>
<script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
