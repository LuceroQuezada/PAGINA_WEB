<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>🗓️ Mi Asistencia</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
  <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>
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
    <h2 class="mb-4 text-primary"><i class="fas fa-calendar-alt"></i> Mi Asistencia</h2>

    <!-- Selector de sección -->
    <form method="get" action="${pageContext.request.contextPath}/Estudiante/Asistencia"
          class="row g-2 align-items-center mb-4">
      <div class="col-auto">
        <label for="seccion" class="form-label"><i class="fas fa-list"></i> Sección:</label>
      </div>
      <div class="col-auto flex-grow-1">
        <select id="seccion" name="idSeccion" class="form-select"
                onchange="this.form.submit()">
          <option value="">-- Selecciona sección --</option>
          <c:forEach var="s" items="${secciones}">
            <option value="${s.id}"
              <c:if test="${s.id == selectedSeccion}">selected</c:if>>
              ${s.curso} • Sec ${s.seccion} • Grupo ${s.grupo}
            </option>
          </c:forEach>
        </select>
      </div>
    </form>

    <!-- Mensaje cuando no hay asistencias -->
    <c:if test="${empty asistencias}">
      <div class="alert alert-info">
        <c:choose>
          <c:when test="${empty selectedSeccion}">
            Selecciona una sección para ver tu asistencia.
          </c:when>
          <c:otherwise>
            Aún no tienes registros de asistencia en esta sección.
          </c:otherwise>
        </c:choose>
      </div>
    </c:if>

    <!-- Tabla de asistencias -->
    <c:if test="${not empty asistencias}">
      <div class="card shadow-sm">
        <div class="card-header bg-white">
          <h5 class="mb-0">
            <i class="fas fa-clock"></i>
            Historial de Asistencia
          </h5>
        </div>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead class="table-light">
              <tr>
                <th>Fecha</th>
                <th class="text-center">Asistencia</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="a" items="${asistencias}">
                <tr>
                  <td>${a.fecha}</td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${a.presente}">
                        <span class="text-success fw-bold">Presente</span>
                      </c:when>
                      <c:otherwise>
                        <span class="text-danger fw-bold">Falta</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </c:if>


   <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/estudiante/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>
  </div>

  <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
  </div>
</body>
</html>
