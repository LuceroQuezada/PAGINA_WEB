<%@ page import="java.util.List" %> 
<%@ page import="modelo.Usuario" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ include file="verificarAdmin.jsp" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Administradores</title>
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
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .card-title {
                font-size: 1.6rem;
                font-weight: bold;
            }

            .btn-form {
                padding: 10px 20px;
                font-weight: bold;
                border-radius: 20px;
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

            .password-field {
                font-family: 'Courier New', monospace;
                letter-spacing: 2px;
            }

            .btn-ver {
                font-size: 12px;
                padding: 2px 8px;
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
                <!-- Alertas -->
                <c:if test="${param.mensaje == 'exito'}">
                    <div class="alert alert-success text-center">Administrador registrado con éxito.</div>
                </c:if>
                <c:if test="${param.mensaje == 'error'}">
                    <div class="alert alert-danger text-center">No se pudo registrar el administrador.</div>
                </c:if>
                <c:if test="${param.mensaje == 'existe'}">
                    <div class="alert alert-warning text-center">Ya existe un administrador con ese correo institucional.</div>
                </c:if>
                <c:if test="${param.mensaje == 'correo_invalido'}">
                    <div class="alert alert-warning text-center">El correo debe comenzar con 'A'.</div>
                </c:if>

                <!-- Formulario -->
                <div class="card p-4 mb-3">
                    <h3 class="card-title text-center mb-4"><i class="fas fa-user-shield"></i> Registrar nuevo administrador</h3>
                    <form action="${pageContext.request.contextPath}/RegistrarAdministradorServlet" method="post" class="row g-3">
                        <div class="col-md-6">
                            <label>Nombre:</label>
                            <input type="text" name="nombre" class="form-control" required />
                        </div>
                        <div class="col-md-6">
                            <label>Apellido:</label>
                            <input type="text" name="apellido" class="form-control" required />
                        </div>
                        <div class="col-md-6">
                            <label>Correo institucional (empieza con A):</label>
                            <input type="email" name="correo" class="form-control" required />
                        </div>
                        <div class="col-md-6">
                            <label>Contraseña:</label>
                            <input type="password" name="password" class="form-control" required />
                        </div>
                        <div class="col-12 text-center">
                            <button type="submit" class="btn btn-success btn-form">Registrar Administrador</button>
                            <a href="${pageContext.request.contextPath}/admin/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                        </div>
                    </form>
                </div>


                <div class="card p-4 table-container">
                    <h4 class="card-title text-center mb-4"><i class="fas fa-list"></i> Administradores registrados</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Correo</th>
                                    <th>Contraseña</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="admin" items="${listaAdministradores}">
                                    <tr>
                                        <td>${admin.id}</td>
                                        <td>${admin.nombre}</td>
                                        <td>${admin.apellido}</td>
                                        <td>${admin.correo}</td>
                                        <td>
                                            <span class="password-field" id="password-${admin.id}">
                                                <c:forEach begin="1" end="${admin.password.length()}">*</c:forEach>
                                                </span>
                                                <span class="password-field d-none" id="password-real-${admin.id}">
                                                ${admin.password}
                                            </span>
                                        </td>
                                        <td>
                                            <button class="btn btn-info btn-sm btn-ver" onclick="togglePassword(${admin.id})"
                                                    id="btn-toggle-${admin.id}">Ver</button>
                                            <a href="EditarAdministradorServlet?id=${admin.id}" class="btn btn-warning btn-sm">Editar</a>
                                            <a href="CambiarEstadoAdministradorServlet?id=${admin.id}&estado=${admin.estado}" 
                                               class="btn ${admin.estado == 1 ? 'btn-danger' : 'btn-success'} btn-sm"
                                               onclick="return confirm('¿Seguro que deseas ${admin.estado == 1 ? 'bloquear' : 'activar'} este administrador?');">
                                                <i class="fas ${admin.estado == 1 ? 'fa-ban' : 'fa-check'}"></i> 
                                                ${admin.estado == 1 ? 'Bloquear' : 'Activar'}
                                            </a>

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

        <script>
                                                   function togglePassword(id) {
                                                       const passwordHidden = document.getElementById('password-' + id);
                                                       const passwordReal = document.getElementById('password-real-' + id);
                                                       const toggleBtn = document.getElementById('btn-toggle-' + id);

                                                       if (passwordHidden.classList.contains('d-none')) {
                                                           passwordHidden.classList.remove('d-none');
                                                           passwordReal.classList.add('d-none');
                                                           toggleBtn.textContent = 'Ver';
                                                           toggleBtn.classList.remove('btn-secondary');
                                                           toggleBtn.classList.add('btn-info');
                                                       } else {
                                                           passwordHidden.classList.add('d-none');
                                                           passwordReal.classList.remove('d-none');
                                                           toggleBtn.textContent = 'Ocultar';
                                                           toggleBtn.classList.remove('btn-info');
                                                           toggleBtn.classList.add('btn-secondary');
                                                       }
                                                   }
        </script>
    </body>
</html>
