<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Seccion, modelo.Horario, modelo.CursoDocente, modelo.Grupo" %>
<%@ page import="DAO.SeccionDAO, DAO.HorarioDAO, DAO.CursoDocenteDAO, DAO.GrupoDAO" %>
<%@ include file="verificarAdmin.jsp" %>
<%
    // Recuperamos las listas pre-cargadas por el servlet
    List<Seccion>      listaS        = (List<Seccion>)      request.getAttribute("listaS");
    List<Horario>      listaH        = (List<Horario>)      request.getAttribute("listaH");
    List<Grupo>        listaG        = (List<Grupo>)        request.getAttribute("listaG");
    Integer            selectedGrupo = (Integer)             request.getAttribute("selectedGrupo");
    CursoDocenteDAO    cdDao         = new CursoDocenteDAO();
    HorarioDAO         hDao          = new HorarioDAO();
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Crear Sección (A/B)</title>
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

 
            <form method="get"
                  action="${pageContext.request.contextPath}/ListarSeccion"
                  class="mb-3 d-flex align-items-center">
                <label for="filtroGrupo" class="me-2 fw-bold">Filtrar Grupo:</label>
                <select id="filtroGrupo"
                        name="filtroGrupo"
                        class="form-select w-auto"
                        onchange="this.form.submit()">
                    <option value="">Todos</option>
                    <% for (Grupo g : listaG) { %>
                    <option value="<%=g.getId()%>"
                            <%= (selectedGrupo != null && selectedGrupo.equals(g.getId())) 
                ? "selected" : "" %>>
                        <%=g.getNombre()%>
                    </option>
                    <% } %>
                </select>
            </form>

            <h2>Crear Sección (A/B)</h2>
            <c:if test="${not empty error}">
                <div class="">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/RegistrarSeccion" method="post" class="row g-2 mb-3">
                <input type="hidden" name="filtroGrupo" value="${selectedGrupo}" />
                <div class="col-4">
                    <select name="idHorario" class="form-select" required>
                        <option value="">Horario…</option>
                        <% for (Horario h : listaH) {
                             CursoDocente cd = cdDao.listar()
                                                  .stream()
                                                  .filter(x -> x.getId() == h.getIdCursoDocente())
                                                  .findFirst().orElse(null);
                             if (cd == null) continue;
                        %>
                        <option value="<%=h.getId()%>">
                            <%=cd.getNombreCurso()%>
                            – <%=cd.getNombreDocente()%>
                            – <%=cd.getCarrera()%>
                            – <%=h.getDia()%> <%=h.getHoraInicio()%>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="col-2">
                    <select name="nombre" class="form-select" required>
                        <option value="">A/B</option>
                        <option>A</option>
                        <option>B</option>
                    </select>
                </div>
                <div class="col-4">
                    <select name="idGrupo" class="form-select" required>
                        <option value="">Grupo…</option>
                        <% for (Grupo g : listaG) { %>
                        <option value="<%=g.getId()%>"><%=g.getNombre()%></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-2">
                    <button class="btn btn-primary w-100">Crear</button>
                </div>
            </form>

            <table class="table table-hover bg-white">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Sección</th>
                        <th>Grupo</th>
                        <th>Curso / Docente / Carrera</th>
                        <th>Día</th>
                        <th>Inicio</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Seccion s : listaS) {
                         Horario h = listaH.stream()
                                           .filter(x -> x.getId() == s.getIdHorario())
                                           .findFirst().orElse(null);
                         if (h == null) continue;
                         CursoDocente cd = cdDao.listar()
                                               .stream()
                                               .filter(x -> x.getId() == h.getIdCursoDocente())
                                               .findFirst().orElse(null);
                         if (cd == null) continue;
                    %>
                    <tr>
                        <td><%=s.getId()%></td>
                        <td><%=s.getNombre()%></td>
                        <td><%=s.getNombreGrupo()%></td>
                        <td>
                            <%=cd.getNombreCurso()%>
                            – <%=cd.getNombreDocente()%>
                            – <%=cd.getCarrera()%>
                        </td>
                        <td><%=h.getDia()%></td>
                        <td><%=h.getHoraInicio()%></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/EliminarSeccion?id=<%=s.getId()%>"
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
