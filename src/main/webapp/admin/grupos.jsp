<%@ page import="java.util.List" %>
<%@ page import="modelo.Grupo" %>
<%@ page import="modelo.Usuario" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<%@ include file="verificarAdmin.jsp" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Grupos</title>
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

            .grupo-card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                transition: transform 0.2s, box-shadow 0.2s;
                margin-bottom: 1.5rem;
            }

            .grupo-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            }

            .grupo-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 15px 15px 0 0;
            }

            .carrera-ingenieria {
                background: linear-gradient(135deg, #ff9800, #ffc107);
            }
            .carrera-medicina {
                background: linear-gradient(135deg, #43cea2, #185a9d);
            }
            .carrera-derecho {
                background: linear-gradient(135deg, #5b86e5, #36d1dc);
            }

            .estudiante-item {
                background: #f8f9fa;
                border-radius: 8px;
                padding: 0.5rem 0.75rem;
                margin-bottom: 0.3rem;
                border-left: 3px solid #007bff;
            }

            .badge-count {
                font-size: 1rem;
                padding: 0.5rem 0.75rem;
            }

            .collapse-toggle {
                cursor: pointer;
                transition: transform 0.3s ease;
            }

            .collapse-toggle.collapsed {
                transform: rotate(180deg);
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

            <!-- Main Content -->
            <div class="main-content p-4" style="width: 100%;">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-users"></i> Gestión de Grupos</h3>
                    <!-- CAMBIAR ESTA LÍNEA: -->
                    <a href="${pageContext.request.contextPath}/ListarAlumnosServlet" class="btn btn-success">
                        <i class="fas fa-users-cog"></i> Gestionar Asignaciones
                    </a>
                </div>

                <!-- Filtro por Carrera -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <form method="get" action="ListarGruposServlet">
                            <select name="carrera" class="form-select" onchange="this.form.submit()">
                                <option value="">-- Todas las Carreras --</option>
                                <option value="Ingenieria" ${selectedCarrera=='Ingenieria'?'selected':''}>Ingeniería</option>
                                <option value="Medicina" ${selectedCarrera=='Medicina'?'selected':''}>Medicina</option>
                                <option value="Derecho" ${selectedCarrera=='Derecho'?'selected':''}>Derecho</option>
                            </select>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="alert alert-info mb-0">
                            <i class="fas fa-info-circle"></i> 
                            Total de grupos: <strong>${fn:length(grupos)}</strong>
                        </div>
                    </div>
                </div>

                <!-- Mensajes -->
                <c:if test="${not empty mensajeExito}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle"></i> ${mensajeExito}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty mensajeError}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle"></i> ${mensajeError}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Lista de Grupos -->
                <c:choose>
                    <c:when test="${empty grupos}">
                        <div class="text-center py-5">
                            <i class="fas fa-users fa-5x text-muted mb-3"></i>
                            <h4 class="text-muted">No hay grupos creados</h4>
                            <p class="text-muted">Crea tu primer grupo desde la sección de alumnos</p>
                            <a href="${pageContext.request.contextPath}/ListarAlumnosServlet" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Crear Grupo
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach var="grupo" items="${grupos}">
                                <div class="col-lg-6 mb-4">
                                    <div class="card grupo-card">
                                        <!-- Header del Grupo -->
                                        <div class="card-header grupo-header 
                                             <c:choose>
                                                 <c:when test='${grupo.carrera == "Ingenieria"}'>carrera-ingenieria</c:when>
                                                 <c:when test='${grupo.carrera == "Medicina"}'>carrera-medicina</c:when>
                                                 <c:when test='${grupo.carrera == "Derecho"}'>carrera-derecho</c:when>
                                             </c:choose>
                                             ">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h5 class="mb-1">
                                                        <i class="fas fa-users"></i> ${grupo.nombre}
                                                    </h5>
                                                    <small>${grupo.carrera}</small>
                                                </div>
                                                <span class="badge bg-light text-dark badge-count">
                                                    ${fn:length(grupo.estudiantes)} estudiantes
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Contenido del Grupo -->
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar"></i> 
                                                    Creado: ${grupo.fechaCreacion}
                                                </small>
                                                <button class="btn btn-sm btn-outline-primary collapse-toggle" 
                                                        type="button" 
                                                        data-bs-toggle="collapse" 
                                                        data-bs-target="#estudiantes-${grupo.id}">
                                                    <i class="fas fa-chevron-up"></i>
                                                </button>
                                            </div>

                                            <!-- Lista de Estudiantes -->
                                            <div class="collapse show" id="estudiantes-${grupo.id}">
                                                <h6 class="text-muted mb-2">
                                                    <i class="fas fa-user-graduate"></i> Estudiantes:
                                                </h6>
                                                <c:choose>
                                                    <c:when test="${empty grupo.estudiantes}">
                                                        <div class="alert alert-warning">
                                                            <i class="fas fa-exclamation-triangle"></i>
                                                            No hay estudiantes asignados
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="max-height-200" style="max-height: 200px; overflow-y: auto;">
                                                            <c:forEach var="estudiante" items="${grupo.estudiantes}">
                                                                <div class="estudiante-item">
                                                                    <div class="d-flex justify-content-between">
                                                                        <strong>${estudiante.nombre} ${estudiante.apellido}</strong>
                                                                        <small class="text-muted">ID: ${estudiante.id}</small>
                                                                    </div>
                                                                    <small class="text-muted">
                                                                        <i class="fas fa-envelope"></i> ${estudiante.correo}
                                                                    </small>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Acciones -->
                                            <div class="mt-3 text-end">
                                                <button class="btn btn-warning btn-sm me-2" 
                                                        onclick="editarGrupo(${grupo.id}, '${grupo.nombre}')">
                                                    <i class="fas fa-edit"></i> Editar
                                                </button>
                                                <button class="btn btn-danger btn-sm" 
                                                        onclick="confirmarEliminar(${grupo.id}, '${grupo.nombre}')">
                                                    <i class="fas fa-trash"></i> Eliminar
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
                 <div class="col-12 text-center">
                    
                            <a href="${pageContext.request.contextPath}/admin/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                        </div>
            </div>
        </div>

        <!-- Modal de Confirmación -->
        <div class="modal fade" id="modalEliminar" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmar Eliminación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Estás seguro de que deseas eliminar el grupo <strong id="nombreGrupoEliminar"></strong>?</p>
                        <p class="text-danger">
                            <i class="fas fa-exclamation-triangle"></i>
                            Esta acción no se puede deshacer y eliminará todas las asignaciones de estudiantes.
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a href="#" id="btnConfirmarEliminar" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Eliminar
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script>
                                                            function confirmarEliminar(idGrupo, nombreGrupo) {
                                                                document.getElementById('nombreGrupoEliminar').textContent = nombreGrupo;
                                                                document.getElementById('btnConfirmarEliminar').href =
                                                                        'ListarGruposServlet?accion=eliminar&idGrupo=' + idGrupo;
                                                                new bootstrap.Modal(document.getElementById('modalEliminar')).show();
                                                            }

                                                            function editarGrupo(idGrupo, nombreGrupo) {
                                                                // Implementar funcionalidad de edición
                                                                alert('Funcionalidad de edición para el grupo: ' + nombreGrupo + ' (ID: ' + idGrupo + ')');
                                                            }

                                                            // Manejar colapso de estudiantes
                                                            document.querySelectorAll('.collapse-toggle').forEach(btn => {
                                                                btn.addEventListener('click', function () {
                                                                    this.classList.toggle('collapsed');
                                                                });
                                                            });
        </script>

    </body>
</html>