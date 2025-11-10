<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
<%@ page import="DAO.UsuarioDAO" %>
<%@ include file="verificarEstudiante.jsp" %>
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
        <title>Panel Estudiante</title>
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
                            <i class="fas fa-sign-out-alt"></i> Cerrar Sesi�n
                        </a>
                    </li>
                </ul>
            </div>

            <div class="main-content">
                <div class="text-center mb-4">
                    <h2 class="dashboard-title">Bienvenido al Panel del Estudiante</h2>
                    <p class="dashboard-subtitle">�Qu� deseas hacer hoy?</p>
                </div>

                <div class="row justify-content-center g-4">

                    <div class="col-md-5">
                        <div class="card text-white" style="background: linear-gradient(135deg, #667eea, #764ba2);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-book"></i> Mis Cursos</h5>
                                <p class="card-text">Accede a todos tus cursos matriculados.</p>
                                <a href="${pageContext.request.contextPath}/Estudiante/Cursos" class="btn btn-light">Ver Cursos</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="card text-white" style="background: linear-gradient(135deg, #4facfe, #00f2fe);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-calendar-alt"></i> Mi Horario</h5>
                                <p class="card-text">Consulta tu horario de clases semanal.</p>
                                <a href="${pageContext.request.contextPath}/Estudiante/Horario" class="btn btn-light">Ver Horario</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="card text-white" style="background: linear-gradient(135deg, #43e97b, #38f9d7);">
                            <div class="card-body d-flex flex-column justify-content-center align-items-center">
                                <h5 class="card-title"><i class="fas fa-chart-line"></i> SEXO</h5>
                                <p class="card-text">Revisa tus calificaciones y progreso acad�mico.</p>
                                <!-- Bot�n para ver sus propias notas -->
<a href="${pageContext.request.contextPath}/Estudiante/MisNotas" class="btn btn-light">Ver Notas</a>



                            </div>
                        </div>
                    </div>

<!-- tarjeta de Asistencia -->
<div class="col-md-5">
  <div class="card text-white bg-info">
    <div class="card-body text-center">
      <h5 class="card-title"><i class="fas fa-calendar-check"></i> Mi Asistencia</h5>
      <p class="card-text">Consulta tus registros de asistencia.</p>
      <!-- Aqu� apuntamos al Servlet EstudianteMisAsistenciaServlet -->
     <a href="${pageContext.request.contextPath}/Estudiante/Asistencia"
   class="btn btn-light">Ver Asistencias</a>

    </div>
  </div>
</div>



                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>