<%@ page import="java.util.List" %>
<%@ page import="modelo.Curso" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ include file="verificarAdmin.jsp" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Cursos</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>
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
    
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }
            .card-title {
                font-size: 1.6rem;
                font-weight: bold;
            }
            .table-container {
                flex: 1;
                overflow-y: auto;
                margin-top: 1rem;
            }
            table th {
                background-color: #343a40;
                color: white;
            }
            .btn-form {
                padding: 10px 20px;
                font-weight: bold;
                border-radius: 20px;
            }
        </style>
    </head>
    <body>
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

            <div class="main-content">
                <c:if test="${param.mensaje == 'asignado'}">
                    <div class="alert alert-success text-center">Curso asignado correctamente.</div>
                </c:if>
                <c:if test="${param.mensaje == 'ya_asignado'}">
                    <div class="alert alert-warning text-center">El curso ya estaba asignado.</div>
                </c:if>
                <c:if test="${param.mensaje == 'error'}">
                    <div class="alert alert-danger text-center">Error al asignar curso.</div>
                </c:if>

                <div class="card p-4 table-container">
                    <h4 class="card-title text-center mb-4"><i class="fas fa-book"></i> Cursos Disponibles</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="curso" items="${listaCursos}">
                                    <tr>
                                        <td>${curso.id}</td>
                                        <td>${curso.nombre}</td>
                                        <td>${curso.descripcion}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/AsignarCursoDocenteServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="idCurso" value="${curso.id}">
                                                <select name="idDocente" class="form-select form-select-sm d-inline" style="width:auto;display:inline-block;">
                                                    <c:forEach var="doc" items="${docentes}">
                                                        <option value="${doc.id}">${doc.nombre} ${doc.apellido}</option>
                                                    </c:forEach>
                                                </select>
                                                <button type="submit" class="btn btn-primary btn-sm mt-1"><i class="fas fa-chalkboard-teacher"></i> Asignar Docente</button>
                                            </form>

                                            <form action="${pageContext.request.contextPath}/AsignarCursoEstudianteServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="idCurso" value="${curso.id}">
                                                <select name="idEstudiante" class="form-select form-select-sm d-inline" style="width:auto;display:inline-block;">
                                                    <c:forEach var="est" items="${estudiantes}">
                                                        <option value="${est.id}">${est.nombre} ${est.apellido}</option>
                                                    </c:forEach>
                                                </select>
                                                <button type="submit" class="btn btn-success btn-sm mt-1"><i class="fas fa-user-graduate"></i> Asignar Estudiante</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
