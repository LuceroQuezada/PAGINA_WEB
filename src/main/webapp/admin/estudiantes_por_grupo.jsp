<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Estudiantes por Grupo</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
  <!-- FontAwesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
    <h2>Estudiantes por Grupo</h2>

    <!-- selector de grupos -->
    <form method="get" action="${pageContext.request.contextPath}/admin/EstudiantesPorGrupo"
          class="mb-3 row g-2 align-items-center">
      <div class="col-auto">
        <label for="grupo" class="col-form-label">Grupo:</label>
      </div>
      <div class="col-auto">
        <select id="grupo" name="idGrupo" class="form-select" onchange="this.form.submit()">
          <option value="">-- Elige un grupo --</option>
          <c:forEach var="g" items="${grupos}">
            <option value="${g.id}"
              <c:if test="${g.id == selectedGrupo}">selected</c:if>>
              ${g.nombre} (${g.carrera})
            </option>
          </c:forEach>
        </select>
      </div>
    </form>

    <c:if test="${empty secciones}">
      <div class="alert alert-info">Selecciona un grupo para ver sus secciones y estudiantes.</div>
    </c:if>

    <c:if test="${not empty secciones}">
      <h4>Secciones asignadas</h4>
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>ID</th><th>Curso</th><th>Carrera</th>
            <th>Profesor</th><th>Sección</th>
            <th>Día</th><th>Hora</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="s" items="${secciones}">
            <tr>
              <td>${s.id}</td>
              <td>${s.curso}</td>
              <td>${s.carrera}</td>
              <td>${s.profesor}</td>
              <td>${s.seccion}</td>
              <td>${s.dia}</td>
              <td>${s.horaInicio}–${s.horaFin}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <h4 class="mt-4">Estudiantes del grupo</h4>
      <table class="table table-striped">
        <thead>
          <tr>
            <th>ID</th><th>Nombre</th><th>Apellido</th><th>Correo</th><th>Contraseña</th><th>Ver</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="al" items="${alumnos}">
            <tr>
              <td>${al.id}</td>
              <td>${al.nombre}</td>
              <td>${al.apellido}</td>
              <td>${al.correo}</td>
              <td>
                <!-- Input con contraseña oculta -->
                <input id="pwd${al.id}"
                       type="password"
                       class="form-control form-control-sm"
                       value="${al.password}"
                       readonly />
              </td>
              <td>
                <button type="button"
                        class="btn btn-outline-secondary btn-sm"
                        onclick="togglePassword(${al.id})">
                  <i id="icon${al.id}" class="fas fa-eye"></i>
                </button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>

    <div class="col-12 text-center">
                          
                            <a href="${pageContext.request.contextPath}/admin/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                        </div>
      
  </div>

  <!-- Script de Bootstrap (opcional, si lo necesitas) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
  
  <!-- Script de toggle password -->
  <script>
    // Esperar a que el DOM esté completamente cargado
    document.addEventListener('DOMContentLoaded', function() {
      // Función global para toggle de contraseñas
      window.togglePassword = function(id) {
        const input = document.getElementById('pwd' + id);
        const icon = document.getElementById('icon' + id);
        
        if (!input || !icon) {
          console.error('Elementos no encontrados para ID:', id);
          return;
        }
        
        if (input.type === "password") {
          input.type = "text";
          icon.classList.remove("fa-eye");
          icon.classList.add("fa-eye-slash");
        } else {
          input.type = "password";
          icon.classList.remove("fa-eye-slash");
          icon.classList.add("fa-eye");
        }
      };
    });
  </script>
  </div>
</body>
</html>