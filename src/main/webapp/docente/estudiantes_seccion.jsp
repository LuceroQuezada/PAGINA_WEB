<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, modelo.Seccion, modelo.Usuario, modelo.Horario, modelo.CursoDocente" %>
<%@ page import="DAO.HorarioDAO, DAO.CursoDocenteDAO" %>
<%
    // 0) sesión
    modelo.Usuario docente = (modelo.Usuario) session.getAttribute("usuario");
    if (docente == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Seccion> listaS = (List<Seccion>) request.getAttribute("listaSecciones");
    String selected  = (String)          request.getAttribute("selectedSeccion");
    List<Usuario> alumnos = (List<Usuario>) request.getAttribute("listaEstudiantes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Estudiantes por Sección</title>
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
    <h2 class="mb-4">👩‍🎓 Estudiantes por Sección</h2>

    <!-- selector de sección -->
    <form method="get" action="${pageContext.request.contextPath}/EstudiantesSeccion"
          class="row g-2 mb-4 align-items-center">
      <div class="col-auto">
        <label class="col-form-label">Sección:</label>
      </div>
      <div class="col-auto">
        <select name="idSeccion" class="form-select" onchange="this.form.submit()">
          <option value="">– Seleccione –</option>
          <% 
            // para mostrar Curso (Carrera) – Sección
            List<Horario> allH = new HorarioDAO().listar();
            CursoDocenteDAO cdDao = new CursoDocenteDAO();
            for (Seccion s : listaS) {
                Horario h = allH.stream()
                    .filter(x->x.getId()==s.getIdHorario())
                    .findFirst().orElse(null);
                String label = "Sec " + s.getNombre();
                if (h!=null) {
                    CursoDocente cd = cdDao.obtenerPorId(h.getIdCursoDocente());
                    if (cd!=null) {
                      label = cd.getNombreCurso()
                            + " ("+cd.getCarrera()+") – Sec " + s.getNombre();
                    }
                }
          %>
          <option value="<%=s.getId()%>"
            <%= (selected!=null && selected.equals(""+s.getId())) ? "selected" : "" %>>
            <%=label%>
          </option>
          <% } %>
        </select>
      </div>
    </form>

    <!-- tabla de alumnos -->
    <%
      if (alumnos == null || alumnos.isEmpty()) {
    %>
      <div class="alert alert-info">
        No hay estudiantes en esta sección.
      </div>
    <%
      } else {
    %>
      <div class="table-responsive">
        <table class="table table-bordered bg-white shadow-sm">
          <thead class="table-dark">
            <tr>
              <th>ID</th><th>Nombre</th><th>Apellido</th><th>Correo</th><th>Carrera</th>
            </tr>
          </thead>
          <tbody>
            <% for (Usuario u : alumnos) { %>
            <tr>
              <td><%=u.getId()%></td>
              <td><%=u.getNombre()%></td>
              <td><%=u.getApellido()%></td>
              <td><%=u.getCorreo()%></td>
              <td><%=u.getCarrera()%></td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    <%
      }
    %>

    <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/docente/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>
  </div>
  <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
  </div>
</body>
</html>
