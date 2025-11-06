<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="modelo.Curso, modelo.CursoDocente, modelo.Usuario" %>
<%@ include file="verificarAdmin.jsp" %>
<%
    String selectedCarrera = (String) request.getAttribute("selectedCarrera");
    List<Curso> listaCursos = (List<Curso>) request.getAttribute("listaCursos");
    List<Usuario> listaDocentes = (List<Usuario>) request.getAttribute("listaDocentes");
    List<CursoDocente> listaCD = (List<CursoDocente>) request.getAttribute("listaCD");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Asignar Cursos a Docentes</title>
        <link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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

            <!-- FILTRO POR CARRERA -->
            <form method="get"
                  action="${pageContext.request.contextPath}/ListarCursoDocente"
                  class="mb-3 d-flex align-items-center">
                <label for="filtroCarrera" class="me-2 fw-bold">Filtrar Carrera:</label>
                <select id="filtroCarrera"
                        name="filtroCarrera"
                        class="form-select w-auto"
                        onchange="this.form.submit()">
                    <option value="">Todas</option>
                    <option value="Ingenieria" <%= "Ingenieria".equals(selectedCarrera)?"selected":"" %>>Ingeniería</option>
                    <option value="Medicina"    <%= "Medicina".equals(selectedCarrera)?"selected":"" %>>Medicina</option>
                    <option value="Derecho"     <%= "Derecho".equals(selectedCarrera)?"selected":"" %>>Derecho</option>
                </select>
            </form>

            <h2>Asignar Docentes a Cursos</h2>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/RegistrarCursoDocente"
                  method="post" class="row g-2 mb-3">
                <!-- Mantener filtro al enviar -->
                <input type="hidden" name="filtroCarrera" value="<%=selectedCarrera%>"/>

                <div class="col">
                    <select name="idCurso" class="form-select" required>
                        <option value="">Seleccione curso…</option>
                        <% for (Curso c : listaCursos) { %>
                        <option value="<%=c.getId()%>">
                            <%=c.getNombre()%> (<%=c.getCarrera()%>)
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="col">
                    <select name="idDocente" class="form-select" required>
                        <option value="">Seleccione docente…</option>
                        <% for (Usuario u : listaDocentes) { %>
                        <option value="<%=u.getId()%>">
                            <%=u.getNombre()%> <%=u.getApellido()%>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="col-auto">
                    <button class="btn btn-primary">Asignar</button>
                </div>
            </form>

            <table class="table table-striped bg-white shadow-sm">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th><th>Curso (Carrera)</th><th>Docente</th><th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CursoDocente cd : listaCD) {
                           // Solo mostrar si no hay filtro o la carrera coincide
                           if (selectedCarrera == null 
                               || selectedCarrera.isEmpty() 
                               || cd.getCarrera().equals(selectedCarrera)) {
                    %>
                    <tr>
                        <td><%=cd.getId()%></td>
                        <td><%=cd.getNombreCurso()%> (<%=cd.getCarrera()%>)</td>
                        <td><%=cd.getNombreDocente()%></td>
                        <td>
                            <!-- OPCIÓN 1: Solo con scriptlets (recomendado para consistencia) -->
                            <%
                                String deleteUrl = request.getContextPath() + "/EliminarCursoDocente?id=" + cd.getId();
                                if (selectedCarrera != null && !selectedCarrera.isEmpty()) {
                                    deleteUrl += "&filtroCarrera=" + selectedCarrera;
                                }
                            %>
                            <a href="<%=deleteUrl%>" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('¿Está seguro de eliminar esta asignación?')">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                    <%   }  // fin if
                       }    // fin for
                    %>
                </tbody>
            </table>
                 <div class="col-12 text-center">
                          
                            <a href="${pageContext.request.contextPath}/admin/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                        </div>
        </div>
                </div>
        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>