<%@ page import="modelo.Usuario" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page session="true" %>
<%@ page import="DAO.UsuarioDAO" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    UsuarioDAO dao = new UsuarioDAO();
    String nombreRol = dao.obtenerNombreRol(usuario.getIdRol());
    if (!"docente".equalsIgnoreCase(nombreRol)) {
        response.sendRedirect("../login.jsp");
        return;
    }

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
    <title>Panel Docente</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>
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

      <div class="main-content">
        <div class="text-center mb-4">
          <h2 class="dashboard-title">Bienvenido, Prof. ${usuario.nombre}</h2>
          <p class="dashboard-subtitle">¿Qué deseas realizar?</p>
        </div>

        <div class="row justify-content-center g-4">

               <div class="col-md-5">
  <div class="card text-white" style="background: linear-gradient(135deg, #a9edea, #fed687);">
    <div class="card-body d-flex flex-column justify-content-center align-items-center">
      <h5 class="card-title"><i class="fas fa-book-open"></i> Cursos, Horario, Estudiantes</h5>
      <p class="card-text">Accede rápidamente a tus cursos, tu horario y la lista de alumnos.</p>

      <div class="btn-group" role="group" aria-label="Accesos Rápidos">
        <a href="${pageContext.request.contextPath}/MisCursos" class="btn btn-light btn-sm">Cursos</a>
        <a href="${pageContext.request.contextPath}/MiHorario"  class="btn btn-light btn-sm">Horario</a>
        <a href="${pageContext.request.contextPath}/EstudiantesSeccion" class="btn btn-light btn-sm">Estudiantes</a>
      </div>
    </div>
  </div>
</div>
          

<div class="col-md-5">
  <div class="card text-white"
       style="background: linear-gradient(135deg, #4e54c8, #8f94fb);">
    <div class="card-body d-flex flex-column justify-content-center align-items-center">
      <h5 class="card-title"><i class="fas fa-clipboard-list"></i> Registro de Notas</h5>
      <p class="card-text">Califica parciales y examen final, añade feedback.</p>
      <a href="${pageContext.request.contextPath}/Docente/Calificar"
         class="btn btn-light">Ir</a>
    </div>
  </div>
</div>




<div class="col-md-5">
  <div class="card text-white" style="background: linear-gradient(135deg, #4facfe, #00f2fe);">
    <div class="card-body d-flex flex-column justify-content-center align-items-center">
      <h5 class="card-title"><i class="fas fa-calendar-check"></i> Control de Asistencia</h5>
      <p class="card-text">Marcar asistencia de tus secciones.</p>
    
   <a href="${pageContext.request.contextPath}/Docente/Asistencia" class="btn btn-light">Ir</a>


    </div>
  </div>
</div>



<div class="col-md-5">
<div class="card text-white" style="background: linear-gradient(135deg, #ffecd2, #fcb69f);">
     <h5 class="card-title"><i class="fas fa-folder-open"></i> Material Didáctico</h5>
       <p class="card-text">Selecciona tu curso y revisa el material disponible.</p>
    
  <a href="${pageContext.request.contextPath}/docente/material" class="btn btn-light">Ir</a>

    </div>
  </div>
</div>
   



        </div>
      </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
