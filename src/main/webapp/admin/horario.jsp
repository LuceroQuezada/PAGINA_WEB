<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.stream.Collectors" %>
<%@ page import="modelo.Horario, modelo.CursoDocente" %>
<%@ page import="DAO.HorarioDAO, DAO.CursoDocenteDAO" %>
<%@ include file="verificarAdmin.jsp" %>
<%
    // Parámetro opcional de filtro
    String selectedCarrera = request.getParameter("carrera");

    // Cargo todos los curso-docente
    CursoDocenteDAO cdDao = new CursoDocenteDAO();
    List<CursoDocente> listaCD = cdDao.listar();

    // Aplico filtro si selectedCarrera no es nulo ni vacío
    List<CursoDocente> filteredCD = (selectedCarrera == null || selectedCarrera.isEmpty())
        ? listaCD
        : listaCD.stream()
                 .filter(cd -> cd.getCarrera().equals(selectedCarrera))
                 .collect(Collectors.toList());

    // Cargo todos los horarios y luego filtro por los curso-docente válidos
    HorarioDAO hDao = new HorarioDAO();
    List<Horario> listaH = hDao.listar().stream()
        .filter(h -> filteredCD.stream()
                               .anyMatch(cd -> cd.getId() == h.getIdCursoDocente()))
        .collect(Collectors.toList());
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Asignar Horarios</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
 <style>
            body {
                background: #f5f6fa;
                margin: 0;
                padding: 0;
            }

            .sidebar {
                background: linear-gradient(180deg, #6a11cb 0%, #2575fc 100%);
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

            .main-content {
                padding: 2rem;
                width: 100%;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }
            </style>
</head>
<body class="bg-light">
      <div class="d-flex">
    <div class="sidebar">
                <div class="text-center mb-4">
                    <h4><i class="fas fa-user-shield"></i> Admin Panel</h4>
                    <p><strong><i class="fas fa-user-cog"></i> Admin General</strong></p>
                </div>
                <ul class="nav flex-column w-100 px-2">
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-home"></i> Dashboard</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link sidebar-active"
                            <i class="fas fa-user-shield"></i> Administradores
                        </a>
                    </li>

                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-chalkboard-teacher"></i> Docentes</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link"><i class="fas fa-user-graduate"></i> Preinscripciones</a>
                    </li>

                    <li class="nav-item mb-2">
                        <a href="" class="nav-link">
                            <i class="fas fa-clock"></i> Esudiantes Aceptados
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link">
                            <i class="fas fa-user-check"></i> Asignar Docentes a Cursos
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link">
                            <i class="fas fa-user-times"></i> Asignar Horarios
                        </a>
                    </li>

                    <li class="nav-item mb-2">
                        <a href="" class="nav-link">
                            <i class="fas fa-user-times"></i> Crear Secciones A/B
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link">
                            <i class="fas fa-user-times"></i> Estudiantes por Grupo
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link">
                            <i class="fas fa-user-times"></i> Material de Curso
                        </a>
                    </li>


                    <li class="nav-item mt-4">
                        <a href="${pageContext.request.contextPath}/salir" class="btn btn-danger w-100">
                            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                        </a>
                    </li>
                </ul>
            </div>
  <div class="container py-4">
    <h2>Asignar Horarios</h2>

    <c:if test="${not empty error}">
      <div class="">${error}</div>
    </c:if>

    <!-- Filtro por Carrera -->
    <form method="get" action="${pageContext.request.contextPath}/ListarHorario" class="mb-3 row g-2 align-items-center">
      <div class="col-auto">
        <label for="carreraFilter" class="col-form-label">Filtrar por carrera:</label>
      </div>
      <div class="col-auto">
        <select id="carreraFilter" name="carrera" class="form-select" onchange="this.form.submit()">
          <option value="">Todas</option>
          <option value="Ingenieria" <%= "Ingenieria".equals(selectedCarrera) ? "selected" : "" %>>
            Ingeniería
          </option>
          <option value="Medicina" <%= "Medicina".equals(selectedCarrera) ? "selected" : "" %>>
            Medicina
          </option>
          <option value="Derecho" <%= "Derecho".equals(selectedCarrera) ? "selected" : "" %>>
            Derecho
          </option>
        </select>
      </div>
    </form>

    <!-- Formulario de asignación -->
    <form action="${pageContext.request.contextPath}/RegistrarHorario" method="post" class="row g-2 mb-3">
      <div class="col-4">
        <select name="idCursoDocente" class="form-select" required>
          <option value="">Curso–Docente…</option>
          <% for (CursoDocente cd : filteredCD) { %>
            <option value="<%= cd.getId() %>">
              <%= cd.getNombreCurso() %> (<%= cd.getCarrera() %>) – <%= cd.getNombreDocente() %>
            </option>
          <% } %>
        </select>
      </div>
      <!-- resto del formulario igual -->
      <div class="col-2">
        <select name="dia" class="form-select" required>
          <option value="">Día</option>
          <option>Lunes</option><option>Martes</option><option>Miercoles</option>
          <option>Jueves</option><option>Viernes</option>
        </select>
      </div>
      <div class="col-2">
        <input type="time" name="horaInicio" class="form-control" required>
      </div>
      <div class="col-2">
        <input type="time" name="horaFin" class="form-control" required>
      </div>
      <div class="col-2">
        <button class="btn btn-primary w-100">Asignar</button>
      </div>
    </form>

    <!-- Tabla de horarios filtrada -->
    <table class="table table-bordered bg-white shadow-sm">
      <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Curso (Carrera)</th>
          <th>Docente</th>
          <th>Día</th>
          <th>Inicio</th>
          <th>Fin</th>
          <th>Acción</th>
        </tr>
      </thead>
      <tbody>
        <% for (Horario h : listaH) {
             CursoDocente cd = cdDao.listar().stream()
                                    .filter(x -> x.getId() == h.getIdCursoDocente())
                                    .findFirst()
                                    .orElse(null);
             if (cd == null) continue;
        %>
        <tr>
          <td><%= h.getId() %></td>
          <td><%= cd.getNombreCurso() %> (<%= cd.getCarrera() %>)</td>
          <td><%= cd.getNombreDocente() %></td>
          <td><%= h.getDia() %></td>
          <td><%= h.getHoraInicio() %></td>
          <td><%= h.getHoraFin() %></td>
          <td>
            <a href="${pageContext.request.contextPath}/EliminarHorario?id=<%= h.getId() %>"
               class="btn btn-sm btn-danger">Eliminar</a>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
       <div class="col-12 text-center">

                            <a href="${pageContext.request.contextPath}/admin/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                        </div>
  </div>
        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
 </div>
</body>
</html>
