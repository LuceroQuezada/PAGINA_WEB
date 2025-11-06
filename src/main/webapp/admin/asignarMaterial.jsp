<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asignar Material</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
    
    

    <h2 class="mb-4 text-center">
        <i class="fas fa-upload text-primary"></i> Asignar Material a Cursos
    </h2>

    <!-- ✅ Mensajes -->
    <c:if test="${mensaje=='exito'}">
        <div class="alert alert-success">✅ Material subido con éxito.</div>
    </c:if>
    <c:if test="${mensaje=='error' || mensaje=='error_bd' || mensaje=='error_excepcion'}">
        <div class="alert alert-danger">❌ Ocurrió un error al subir el material. Verifique los datos.</div>
    </c:if>

    <!-- ✅ Paso 1: elegir carrera -->
    <form method="get" class="row g-2 mb-4">
        <div class="col-md-4">
            <label class="form-label">Carrera:</label>
            <select name="carrera" class="form-select" onchange="this.form.submit()">
                <option value="">-- Selecciona carrera --</option>
                <c:forEach var="car" items="${carreras}">
                    <option value="${car}" <c:if test="${car==selectedCarrera}">selected</c:if>>
                        ${car}
                    </option>
                </c:forEach>
            </select>
        </div>
    </form>

    <!-- ✅ Paso 2: formulario para subir material -->
    <c:if test="${not empty cursos}">
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h5 class="card-title mb-3">📂 Subir nuevo material</h5>
                <form action="${pageContext.request.contextPath}/admin/AsignarMaterial" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="carrera" value="${selectedCarrera}" />

                    <div class="mb-3">
                        <label class="form-label">Curso:</label>
                        <select name="idCurso" class="form-select" required>
                            <option value="">-- Selecciona curso --</option>
                            <c:forEach var="c" items="${cursos}">
                                <option value="${c.id}">${c.nombre}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Título:</label>
                        <input type="text" name="titulo" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Descripción:</label>
                        <textarea name="descripcion" class="form-control" rows="2"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Archivo:</label>
                        <input type="file" name="archivo" class="form-control" required>
                        <div class="form-text">Formatos permitidos: PDF, DOC, IMG, VIDEO, ZIP</div>
                    </div>

                    <button class="btn btn-primary">
                        <i class="fas fa-cloud-upload-alt"></i> Subir Material
                    </button>
                </form>
            </div>
        </div>
    </c:if>

    <!-- ✅ Paso 3: Lista de materiales existentes -->
    <c:if test="${not empty materiales}">
        <div class="card shadow-sm">
            <div class="card-body">
                <h5 class="card-title mb-3">📜 Materiales ya subidos</h5>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Curso</th>
                            <th>Título</th>
                            <th>Descripción</th>
                            <th>Archivo</th>
                            <th>Tipo</th>
                            <th>Fecha</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="m" items="${materiales}" varStatus="st">
                            <tr>
                                <td>${st.index + 1}</td>
                                <td>${m.cursoNombre}</td>
                                <td>${m.titulo}</td>
                                <td>${m.descripcion}</td>
                                <td>
                                    <a class="btn btn-sm btn-outline-primary" 
                                       href="${pageContext.request.contextPath}/descargar?file=${m.archivo}">
                                        <i class="${m.icono}"></i> Descargar
                                    </a>
                                </td>
                                <td>${m.tipo}</td>
                                <td><fmt:formatDate value="${m.fechaSubida}" pattern="dd/MM/yyyy HH:mm"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>

    <a href="${pageContext.request.contextPath}/admin/panel.jsp" class="btn btn-link mt-3">← Volver al Panel</a>
</div>
</div>


<script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
