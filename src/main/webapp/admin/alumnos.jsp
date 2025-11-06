<%@ page import="java.util.List" %>
<%@ page import="modelo.Usuario" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:url value="/CrearGrupoServlet" var="crearGrupoURL"/>
<%@ page session="true" %>
<%@ include file="verificarAdmin.jsp" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Alumnos</title>
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

            <div class="main-content p-4">
                <h3>Alumnos Registrados (Aceptados)</h3>

                <!-- Filtro por Carrera -->
                <form method="get" action="ListarAlumnosServlet" class="mb-3">
                    <select name="carrera" class="form-select w-auto d-inline" onchange="this.form.submit()">
                        <option value="">-- Seleccione Carrera --</option>
                        <option value="Ingenieria" ${selectedCarrera=='Ingenieria'?'selected':''}>Ingeniería</option>
                        <option value="Medicina"   ${selectedCarrera=='Medicina'?'selected':''}>Medicina</option>
                        <option value="Derecho"    ${selectedCarrera=='Derecho'?'selected':''}>Derecho</option>
                    </select>
                </form>

                <!-- Reemplaza la sección de mensajes en tu alumnos.jsp con esto: -->

                <!-- Mensajes de éxito y error -->
                <c:if test="${not empty mensajeExito}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i>
                        <strong>¡Éxito!</strong> ${mensajeExito}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:if test="${not empty mensajeError}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i>
                        <strong>¡Error!</strong> ${mensajeError}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Mensaje tras crear grupo (si existe) -->
                <c:if test="${not empty mensajeGrupo}">
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <i class="fas fa-info-circle"></i>
                        ${mensajeGrupo}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Tabla de Alumnos -->
                <div class="table-responsive mb-4">
                    <table class="table table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th><th>Nombre</th><th>Apellido</th><th>Correo</th>
                                <th>Carrera</th><th>Contraseña</th><th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="alu" items="${alumnos}">
                                <tr>
                                    <td>${alu.id}</td>
                                    <td>${alu.nombre}</td>
                                    <td>${alu.apellido}</td>
                                    <td>${alu.correo}</td>
                                    <td>${alu.carrera}</td>
                                    <td>
                                        <span id="pass-${alu.id}">
                                            <c:forEach begin="1" end="${fn:length(alu.password)}">*</c:forEach>
                                            </span>
                                            <span id="realpass-${alu.id}" class="d-none">${alu.password}</span>
                                    </td>
                                    <td>
                                        <button class="btn btn-info btn-sm" onclick="toggle(${alu.id})">Ver</button>
                                        <!-- Editar / Bloquear igual que antes? -->
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${not empty selectedCarrera}">
                   
                   <div class="card p-3 mb-4">
    <h5><i class="fas fa-users"></i> Asignar Estudiantes a Grupo</h5>

    <form method="post" action="${pageContext.request.contextPath}/AsignarGrupoServlet">
        <input type="hidden" name="carrera" value="${selectedCarrera}"/>

        <!-- ? Tabla de estudiantes -->
        <table class="table table-hover">
            <thead class="table-light">
                <tr>
                    <th><input type="checkbox" onclick="toggleAll(this)"></th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Correo</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="alumno" items="${alumnos}">
                    <tr>
                        <td><input type="checkbox" name="idEstudiantes" value="${alumno.id}"></td>
                        <td>${alumno.nombre}</td>
                        <td>${alumno.apellido}</td>
                        <td>${alumno.correo}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- ? Selector de grupo -->
        <div class="row mt-3">
            <div class="col-md-4">
                <select name="idGrupo" class="form-select" required>
                    <option value="">Seleccione un grupo</option>
                    <c:forEach var="grupo" items="${gruposDisponibles}">
                        <option value="${grupo.id}">${grupo.nombre}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-4">
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-check"></i> Asignar Seleccionados
                </button>
            </div>
        </div>
    </form>
</div>
                </c:if>

                <!-- Alerta si no hay estudiantes disponibles -->
                <c:if test="${not empty selectedCarrera and empty alumnos}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        <strong>Todos los estudiantes de ${selectedCarrera} ya tienen grupo asignado.</strong>
                        <br>Puedes gestionar los grupos desde la <a href="${pageContext.request.contextPath}/ListarGruposServlet">sección de grupos</a>.
                    </div>
                </c:if>
                 <div class="col-12 text-center">
                            
                            <a href="${pageContext.request.contextPath}/admin/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                        </div>



            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script>
                                            function toggle(id) {
                                                const hid = document.getElementById('pass-' + id);
                                                const real = document.getElementById('realpass-' + id);
                                                if (real.classList.contains('d-none')) {
                                                    real.classList.remove('d-none');
                                                    hid.classList.add('d-none');
                                                } else {
                                                    hid.classList.remove('d-none');
                                                    real.classList.add('d-none');
                                                }
                                            }
        </script>
        
        <script>
    function toggleAll(master) {
        document.querySelectorAll('input[name="idEstudiantes"]').forEach(chk => {
            chk.checked = master.checked;
        });
    }
</script>
    </body>
</html>