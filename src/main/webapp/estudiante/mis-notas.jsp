<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>📊 Mis Notas</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
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
    <h2 class="mb-4 text-primary"><i class="fas fa-chart-line"></i> Mis Notas</h2>

    <c:if test="${empty secciones}">
      <div class="alert alert-info">No estás matriculado en ninguna sección.</div>
    </c:if>

    <c:if test="${not empty secciones}">
      <div class="row">
        <c:forEach var="s" items="${secciones}">
          <div class="col-md-4 mb-3">
            <div class="card shadow-sm h-100">
              <div class="card-body d-flex flex-column">
                <h5 class="card-title mb-2">
                  📘 ${s.nombreCurso}
                </h5>
                <p class="mb-2">
                  Sección: <strong>${s.nombreSeccion}</strong>
                </p>
                <hr/>
                <c:choose>
                  <c:when test="${s.nota1 != null}">
                    <p>Nota 1: <strong>${s.nota1}</strong></p>
                    <p>Nota 2: <strong>${s.nota2}</strong></p>
                    <p>Nota 3: <strong>${s.nota3}</strong></p>
                    <p>Final: <strong>${s.notaFinal}</strong></p>
                    <p class="mt-auto text-primary">
                      Promedio: <strong>${s.promedio}</strong>
                    </p>
                  </c:when>
                  <c:otherwise>
                    <div class="alert alert-warning mt-auto">
                      Aún no tienes notas en esta sección.
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </c:forEach>
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
