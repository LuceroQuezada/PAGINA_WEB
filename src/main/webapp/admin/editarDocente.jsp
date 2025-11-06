<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
<%@ include file="verificarAdmin.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Docente</title>
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
  
        .main-content {
            padding: 3rem 2rem;
            width: 100%;
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
        <div class="card p-4">
            <h3 class="card-title text-center mb-4"><i class="fas fa-edit"></i> Editar Docente</h3>
            <form action="${pageContext.request.contextPath}/ActualizarDocenteServlet" method="post" class="row g-3">
                <input type="hidden" name="id" value="${docente.id}" />

                <div class="col-md-6">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" class="form-control" value="${docente.nombre}" required />
                </div>
                <div class="col-md-6">
                    <label>Apellido:</label>
                    <input type="text" name="apellido" class="form-control" value="${docente.apellido}" required />
                </div>
                <div class="col-md-6">
                    <label>Correo institucional:</label>
                    <input type="email" name="correo" class="form-control" value="${docente.correo}" required />
                </div>
                <div class="col-md-6">
                    <label>Contraseña:</label>
                    <input type="text" name="password" class="form-control" value="${docente.password}" required />
                </div>
                <div class="col-12 text-center">
                    <button type="submit" class="btn btn-success btn-form">Actualizar Docente</button>
                    <a href="${pageContext.request.contextPath}/ListarDocentesServlet" class="btn btn-secondary btn-form">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
