<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
<%@ page import="DAO.UsuarioDAO" %>
<%@ include file="verificarAdmin.jsp" %>
<%
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Panel Administrador</title>
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

            .card {
                border: none;
                border-radius: 15px;
                height: 230px;
                display: flex;
                justify-content: center;
                align-items: center;
                text-align: center;
                transition: transform 0.2s, box-shadow 0.2s;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 15px rgba(0,0,0,0.2);
            }

            .card-title {
                font-size: 1.6rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
            }

            .card-text {
                font-size: 1.2rem;
                margin-bottom: 1rem;
            }

            .btn-light {
                font-weight: bold;
                padding: 0.5rem 1.5rem;
                border-radius: 20px;
            }

            .dashboard-title {
                font-size: 2.2rem;
                font-weight: bold;
            }

            .dashboard-subtitle {
                font-size: 1.2rem;
                color: #555;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="text-center mb-4">
                    <h4><i class="fas fa-user-shield"></i> Admin Panel</h4>
                    <p><strong><i class="fas fa-user-cog"></i> Admin General</strong></p>
                </div>
                <ul class="nav flex-column w-100 px-2">
                    <li class="nav-item mb-2">
                        <a href="panel.jsp" class="nav-link sidebar-active"><i class="fas fa-home"></i> Dashboard</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="" class="nav-link">
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
                        <a href="panel.jsp?logout=true" class="btn btn-danger w-100"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a>
                    </li>
                </ul>
            </div>


            <div class="main-content">
                <div class="text-center mb-4">
                    <h2 class="dashboard-title">Bienvenido al Panel del Administrador</h2>
                    <p class="dashboard-subtitle">¿Qué deseas realizar?</p>
                </div>
                <div class="row row-cols-1 row-cols-md-3 g-4">


                    <div class="col">
                        <div class="card text-white" style="background: linear-gradient(135deg, #ff9800, #ffc107);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-user-plus"></i> Registrar Administrador</h5>
                                <p class="card-text">Crea nuevos administradores con permisos elevados.</p>
                                <a href="${pageContext.request.contextPath}/ListarAdministradoresServlet" class="btn btn-light">Ir</a>
                            </div>
                        </div>
                    </div>


                    <div class="col">
                        <div class="card text-white" style="background: linear-gradient(135deg, #43cea2, #185a9d);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-chalkboard-teacher"></i> Registrar Docente</h5>
                                <p class="card-text">Agrega nuevos docentes al sistema.</p>
                                <a href="${pageContext.request.contextPath}/ListarDocentesServlet" class="btn btn-light">Ir</a>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card text-white" style="background: linear-gradient(135deg, #5b86e5, #36d1dc);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-list-check"></i> Preinscripciones</h5>
                                <p class="card-text">Consulta la lista de estudiantes preinscritos.</p>
                               
                           
                            <div class="btn-group" role="group" aria-label="Accesos Rápidos">
        <a href="${pageContext.request.contextPath}/listarPendientes" class="btn btn-light btn-sm">Pendientes</a>
        <a href="${pageContext.request.contextPath}/listarAceptados"  class="btn btn-light btn-sm">Aceptados</a>
        <a href="${pageContext.request.contextPath}/listarRechazados" class="btn btn-light btn-sm">Rechazados</a>
      </div>
                            
                            
                            </div>
                        </div>
                    </div>



                    <div class="col">
                        <div class="card text-white" style="background: linear-gradient(135deg, #00c6ff, #0072ff);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-user-graduate"></i> Estudiantes Aceptados</h5>
                                <p class="card-text">Visualice y asigne grupos</p>
                                <a href="${pageContext.request.contextPath}/ListarAlumnosServlet" class="btn btn-light">Ir</a>
                            </div>
                        </div>
                    </div>


                    <div class="col">
                        <div class="card text-white" style="background: linear-gradient(135deg, #ff6a00, #ee0979);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-chalkboard"></i> Asignar Docentes a Cursos</h5>
                                <p class="card-text">Relaciona docentes con los cursos precargados.</p>
                                <a href="${pageContext.request.contextPath}/ListarCursoDocente" class="btn btn-light">Ir</a>
                            </div>
                        </div>
                    </div>

                    <!-- Asignar Horarios -->
                    <div class="col">
                        <div class="card text-white" style="background: linear-gradient(135deg, #00c6ff, #0072ff);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-clock"></i> Asignar Horarios</h5>
                                <p class="card-text">Define días y horas para cada curso-docente.</p>
                                <a href="${pageContext.request.contextPath}/ListarHorario" class="btn btn-light">Ir</a>
                            </div>
                        </div>
                    </div>


                    <div class="col">
                        <div class="card text-white" style="background: linear-gradient(135deg, #5b86e5, #36d1dc);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-layer-group"></i> Crear Secciones A/B</h5>
                                <p class="card-text">Genera Sección A y B para cada horario.</p>
                                <a href="${pageContext.request.contextPath}/ListarSeccion" class="btn btn-light">Ir</a>
                            </div>
                        </div>
                    </div>


                    <div class="col">
                        <div class="card text-white" style="background: linear-gradient(135deg, #5b86e5, #36d1dc);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-layer-group"></i> Estudiantes por Grupo</h5>
                                <p class="card-text">Filtra por I1, I2, M1, M2, D1, D2 y ve los detalles.</p>
                                <a href="${pageContext.request.contextPath}/admin/EstudiantesPorGrupo" class="btn btn-light">Ir</a>
                            </div>
                        </div>
                    </div>


                    <div class="">
                        <div class="card text-white" style="background: linear-gradient(135deg, #5b86e5, #36d1dc);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-folder-open"></i> Material de Curso</h5>
                                <p class="card-text">Filtra por carrera y curso para subir recursos.</p>
                                <!-- Aquí apuntas al Servlet que carga tu JSP de subida -->
                                <a href="${pageContext.request.contextPath}/admin/AsignarMaterial" class="btn btn-light">Ir</a>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
