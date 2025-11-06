<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>🗓️ Registrar Asistencia</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
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
    <h2 class="mb-4">✅ Control de Asistencia</h2>

    <!-- ✅ Mensajes -->
    <c:if test="${mensaje == 'exito'}">
      <div class="alert alert-success">✅ Asistencia guardada con éxito.</div>
    </c:if>
    <c:if test="${mensaje == 'NoHayEstudiantes'}">
      <div class="alert alert-warning">⚠️ No se encontraron estudiantes para marcar.</div>
    </c:if>
    <c:if test="${mensaje == 'ParametrosInvalidos'}">
      <div class="alert alert-danger">❌ Parámetros inválidos.</div>
    </c:if>
    <c:if test="${mensaje == 'FechaInvalida'}">
      <div class="alert alert-danger">❌ La fecha es inválida. Solo puedes registrar asistencias HOY (${fecha}).</div>
    </c:if>

    <!-- Selector de sección y fecha -->
    <form method="get" action="${pageContext.request.contextPath}/Docente/Asistencia"
          class="row g-2 align-items-center mb-4">
      <div class="col-auto">
        <label for="seccion" class="form-label">Sección:</label>
      </div>
      <div class="col-auto">
        <select id="seccion" name="idSeccion" class="form-select" onchange="this.form.submit()">
          <option value="">-- elige una sección --</option>
          <c:forEach var="s" items="${secciones}">
            <option value="${s.idSeccion}"
              <c:if test="${s.idSeccion == selectedSeccion}">selected</c:if>>
              ${s.nombreCurso} – Sec ${s.seccion} • Grupo ${s.grupo}
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="col-auto">
        <label for="fecha" class="form-label">Fecha:</label>
      </div>
      <div class="col-auto">
        <input type="date" id="fecha" name="fecha" class="form-control"
               value="${fecha}" onchange="this.form.submit()" />
      </div>
    </form>

    <c:if test="${empty alumnos}">
      <div class="alert alert-info">
        Selecciona una sección y fecha para marcar asistencia.
      </div>
    </c:if>

    <c:if test="${not empty alumnos}">
      <form action="${pageContext.request.contextPath}/Docente/RegistrarAsistencia"
            method="post">
        <input type="hidden" name="idSeccion" value="${selectedSeccion}" />
        <input type="hidden" name="fecha" value="${fecha}" />

        <table class="table table-bordered bg-white shadow-sm">
          <thead class="table-dark">
            <tr>
              <th>Estudiante</th><th>Correo</th><th>Presente</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="al" items="${alumnos}">
              <tr>
                <td>${al.nombre} ${al.apellido}</td>
                <td>${al.correo}</td>
                <td class="text-center">
                  <input type="hidden" name="estudiantes[]" value="${al.id}" />
                  <input type="checkbox" name="asist_${al.id}"
                    <c:if test="${presentMap[al.id]}">checked</c:if> />
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>

        <button class="btn btn-primary">Guardar Asistencia</button>
      </form>
    </c:if>

      <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/docente/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>
  </div>
  <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
  </div>
</body>
</html>
