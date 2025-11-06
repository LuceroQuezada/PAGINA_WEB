<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mis Materiales</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

        .material-card {
            transition: transform 0.2s;
        }
        .material-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .file-icon {
            font-size: 2rem;
        }
    </style>
</head>
<body class="bg-light">
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
    <div class="container py-4">
        <h2><i class="fas fa-book"></i> Mis Materiales</h2>
        

        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title"><i class="fas fa-filter"></i> Seleccionar Curso</h5>
                <form class="row g-2" method="get" action="${pageContext.request.contextPath}/docente/material">
                    <div class="col-auto">
                        <label for="idCurso" class="form-label">Curso:</label>
                    </div>
                    <div class="col-auto">
                        <select id="idCurso" name="idCurso" class="form-select" onchange="this.form.submit()">
                            <option value="">-- Elige tu curso --</option>
                            <c:forEach var="c" items="${cursos}">
                                <option value="${c.idCurso}" <c:if test="${c.idCurso == selectedCurso}">selected</c:if>>
                                    ${c.nombreCurso} (${c.carrera})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Lista de Materiales -->
        <c:if test="${not empty selectedCurso}">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-list"></i> Materiales del Curso
                        <span class="badge bg-secondary">${materiales.size()}</span>
                    </h5>
                    
                    <c:if test="${empty materiales}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i> No hay material subido para este curso.
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty materiales}">
                        <div class="row g-3">
                            <c:forEach var="m" items="${materiales}">
                                <div class="col-md-6 col-lg-4">
                                    <div class="card material-card h-100">
                                        <div class="card-body d-flex flex-column">
                                            <div class="text-center mb-3">
                                                <i class="${m.icono} file-icon"></i>
                                            </div>
                                            
                                            <h6 class="card-title text-truncate" title="${m.titulo}">
                                                ${m.titulo}
                                            </h6>
                                            
                                            <p class="card-text small text-muted mb-2">
                                                <strong>Archivo:</strong> ${m.nombreOriginal}<br>
                                                <strong>Tipo:</strong> ${m.tipo}
                                            </p>
                                            
                                            <c:if test="${not empty m.descripcion}">
                                                <p class="card-text small text-muted">
                                                    ${m.descripcion}
                                                </p>
                                            </c:if>
                                            
                                            <p class="card-text">
                                                <small class="text-muted">
                                                    <i class="fas fa-clock"></i>
                                                    <fmt:formatDate value="${m.fechaSubida}" pattern="dd/MM/yyyy HH:mm"/>
                                                </small>
                                            </p>
                                            
                                            <div class="mt-auto">
                                                <a href="${pageContext.request.contextPath}/descargar?file=${m.archivo}" 
                                                   class="btn btn-primary w-100">
                                                    <i class="fas fa-download"></i> Descargar
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
        
          <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/docente/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </div>
</body>
</html>