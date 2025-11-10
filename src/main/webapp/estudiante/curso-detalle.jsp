<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
<%@ page import="DAO.UsuarioDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="verificarEstudiante.jsp" %>
<%
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("../login.jsp");
        return;
    }
    String nombreEstudiante = (usuario != null && usuario.getNombre() != null && !usuario.getNombre().isEmpty())
            ? usuario.getNombre().toUpperCase()
            : "ESTUDIANTE";
    String inicialEstudiante = nombreEstudiante.substring(0, 1);
    request.setAttribute("sidebarActive", "cursos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle del Curso</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/estudiante/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/estudiante/css/topbar.css">
    <style>
        :root {
            --color-bg: #F3F4F6;
            --color-surface: #FFFFFF;
            --color-border: #E5E7EB;
            --color-muted: #6B7280;
            --color-sidebar-top: #1E1B4B;
            --color-sidebar-bottom: #2F0059;
            --color-sidebar-text: #FFFFFFB2;
        }

        body {
            font-family: "Segoe UI", "Inter", system-ui, -apple-system, sans-serif;
            background: var(--color-bg);
            color: #1A1A1A;
            margin: 0;
        }

        .dashboard-layout {
            min-height: 100vh;
            background: var(--color-bg);
        }

        .content-wrapper {
            flex: 1;
            display: flex;
            flex-direction: column;
            background: var(--color-bg);
        }

        .dashboard-main {
            flex: 1;
            padding: 2rem;
        }

        .section-card {
            background: var(--color-surface);
            border-radius: 24px;
            border: 1px solid var(--color-border);
            padding: 1.75rem;
        }

        .back-link {
            color: #00a8e8;
            font-weight: 600;
            text-decoration: none;
        }

        .course-pill {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.9rem;
            border-radius: 999px;
            background: #e0f7fa;
            color: #006d77;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .course-title {
            font-size: 1.9rem;
            font-weight: 700;
        }

        .instructor-card .instructor-avatar {
            width: 54px;
            height: 54px;
            border-radius: 50%;
            background: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            color: #0f172a;
        }

        .detail-cover {
            width: 280px;
            height: 150px;
            border-radius: 20px;
            background-size: cover;
            background-position: center;
        }

        .progress-thin {
            height: 12px;
            background: #e0f2f1;
            border-radius: 999px;
        }

        .progress-thin .progress-bar {
            background: linear-gradient(90deg, #01d4f6, #00a8e8);
            border-radius: 999px;
        }

        .tabs-card .nav-link {
            border: none;
            font-weight: 600;
            color: var(--color-muted);
        }

        .tabs-card .nav-link.active {
            color: #00a8e8;
            border-bottom: 2px solid #00a8e8;
        }

        .content-accordion .accordion-button {
            background: #f7f8fc;
            border-radius: 16px;
            margin-bottom: 0.75rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 1.25rem;
        }

        .content-accordion .resource-item {
            display: flex;
            gap: 1rem;
            align-items: center;
            padding: 0.85rem 1.25rem;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .content-accordion .resource-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: #eef2ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .grade-card {
            border: 1px solid var(--color-border);
            border-radius: 18px;
            padding: 1rem 1.25rem;
            background: #f9fafb;
            text-align: center;
        }

        .grade-card.highlight {
            background: #e0f7fa;
            border-color: #00c2cb;
        }

        .attendance-list .attendance-item {
            padding: 1rem 1.25rem;
            border-radius: 16px;
            border: 1px solid var(--color-border);
            margin-bottom: 0.75rem;
        }

        .attendance-item.status-success {
            border-color: rgba(16, 185, 129, 0.4);
        }

        .attendance-item.status-danger {
            border-color: rgba(231, 0, 11, 0.3);
        }

        .attendance-status {
            font-weight: 600;
        }

        @media (max-width: 991.98px) {
            .dashboard-main {
                padding: 1.5rem 1rem 2rem;
            }

            .detail-cover {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<c:set var="courseCovers" value="${fn:split('https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=900&q=60,https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=900&q=60,https://images.unsplash.com/photo-1509221963641-49e27c514d3c?auto=format&fit=crop&w=900&q=60', ',')}" />
    <div class="dashboard-layout d-flex">
        <%@ include file="includes/sidebar.jspf" %>
        <div class="content-wrapper">
            <%@ include file="includes/topbar.jspf" %>
            <main class="dashboard-main courses-main">
                <c:choose>
                    <c:when test="${not empty cursoSeleccionado}">
                        <c:set var="detailCoverIndex" value="${cursoSeleccionado.id % fn:length(courseCovers)}" />
                        <c:set var="progressDetail" value="${empty progresoCurso ? 45 : progresoCurso}" />

                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-3">
                            <a href="${pageContext.request.contextPath}/Estudiante/Cursos" class="back-link d-inline-flex align-items-center gap-2">
                                <i class="bi bi-arrow-left"></i> Volver a cursos
                            </a>
                            <a href="${pageContext.request.contextPath}/estudiante/panel.jsp" class="btn btn-link text-decoration-none">
                                Ir al panel
                            </a>
                        </div>

                        <div class="section-card mb-4">
                            <div class="d-flex flex-wrap gap-4 align-items-start">
                                <div class="flex-grow-1">
                                    <span class="course-pill">${empty cursoSeleccionado.carrera ? "Curso" : cursoSeleccionado.carrera}</span>
                                    <h2 class="course-title mt-2 mb-1">${cursoSeleccionado.curso}</h2>
                                    <p class="text-muted mb-3">${cursoSeleccionado.seccion} &middot; ${cursoSeleccionado.grupo}</p>
                                    <div class="instructor-card d-flex align-items-center gap-3 mb-3">
                                        <div class="instructor-avatar">
                                            ${not empty cursoSeleccionado.profesor ? fn:substring(cursoSeleccionado.profesor,0,1) : "I"}
                                        </div>
                                        <div>
                                            <small class="text-muted d-block">Instructor</small>
                                            <strong>${empty cursoSeleccionado.profesor ? "Asignaci&oacute;n pendiente" : cursoSeleccionado.profesor}</strong>
                                        </div>
                                    </div>
                                    <p class="text-muted mb-4">
                                        Consulta el contenido, calificaciones y asistencia de tu curso. La informaci&oacute;n se actualiza cuando el docente publica nuevos recursos.
                                    </p>
                                </div>
                                <div class="detail-cover" style="background-image: url('${courseCovers[detailCoverIndex]}');"></div>
                            </div>
                            <div class="progress-wrapper mt-4">
                                <div class="d-flex justify-content-between small text-muted mb-1">
                                    <span>Tu progreso en el curso</span>
                                    <span>${progressDetail}%</span>
                                </div>
                                <div class="progress progress-thin">
                                    <div class="progress-bar" style="width: ${progressDetail}%;"></div>
                                </div>
                            </div>
                        </div>

                        <div class="section-card tabs-card">
                            <ul class="nav nav-tabs flex-nowrap overflow-auto" id="courseTabs" role="tablist">
                                <li class="nav-item">
                                    <button class="nav-link active" id="tab-contenido" data-bs-toggle="tab" data-bs-target="#pane-contenido" type="button">Contenido</button>
                                </li>
                                <li class="nav-item">
                                    <button class="nav-link" id="tab-calificaciones" data-bs-toggle="tab" data-bs-target="#pane-calificaciones" type="button">Calificaciones</button>
                                </li>
                                <li class="nav-item">
                                    <button class="nav-link" id="tab-asistencia" data-bs-toggle="tab" data-bs-target="#pane-asistencia" type="button">Asistencia</button>
                                </li>
                            </ul>
                            <div class="tab-content pt-4">
                                <div class="tab-pane fade show active" id="pane-contenido" role="tabpanel">
                                    <c:choose>
                                        <c:when test="${not empty materialesPorSemana}">
                                            <div class="accordion content-accordion" id="courseContentAccordion">
                                                <c:forEach var="entry" items="${materialesPorSemana}" varStatus="status">
                                                    <div class="accordion-item content-week">
                                                        <h2 class="accordion-header" id="heading-${status.index}">
                                                            <button class="accordion-button ${status.index ne 0 ? 'collapsed' : ''}" type="button"
                                                                    data-bs-toggle="collapse" data-bs-target="#collapse-${status.index}"
                                                                    aria-expanded="${status.index eq 0 ? 'true' : 'false'}" aria-controls="collapse-${status.index}">
                                                                <div>
                                                                    <span class="week-title">${entry.key}</span>
                                                                    <small class="text-muted d-block">${fn:length(entry.value)} recurso(s)</small>
                                                                </div>
                                                                <i class="bi bi-check-circle-fill text-success ms-2" aria-hidden="true"></i>
                                                            </button>
                                                        </h2>
                                                        <div id="collapse-${status.index}" class="accordion-collapse collapse ${status.index eq 0 ? 'show' : ''}" aria-labelledby="heading-${status.index}" data-bs-parent="#courseContentAccordion">
                                                            <div class="accordion-body p-0">
                                                                <c:forEach var="m" items="${entry.value}">
                                                                    <c:set var="tipoLower" value="${fn:toLowerCase(empty m.tipo ? '' : m.tipo)}" />
                                                                    <c:choose>
                                                                        <c:when test="${fn:contains(tipoLower, 'video')}">
                                                                            <c:set var="iconClass" value="bi bi-play-circle-fill text-primary" />
                                                                        </c:when>
                                                                        <c:when test="${fn:contains(tipoLower, 'quiz')}">
                                                                            <c:set var="iconClass" value="bi bi-patch-question-fill text-warning" />
                                                                        </c:when>
                                                                        <c:when test="${fn:contains(tipoLower, 'pdf')}">
                                                                            <c:set var="iconClass" value="bi bi-file-earmark-pdf-fill text-danger" />
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <c:set var="iconClass" value="bi bi-file-earmark-text text-muted" />
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <div class="resource-item">
                                                                        <div class="resource-icon">
                                                                            <i class="${iconClass}"></i>
                                                                        </div>
                                                                        <div class="resource-body">
                                                                            <h6 class="mb-1">${m.titulo}</h6>
                                                                            <p class="text-muted mb-0 small">${m.descripcion}</p>
                                                                        </div>
                                                                        <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/descargar?file=${m.archivo}">
                                                                            <i class="bi bi-download me-1"></i>Descargar
                                                                        </a>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info mb-0">El docente a&uacute;n no publica material para esta secci&oacute;n.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="tab-pane fade" id="pane-calificaciones" role="tabpanel">
                                    <c:choose>
                                        <c:when test="${not empty notasSeccion}">
                                            <div class="row g-3">
                                                <div class="col-12 col-md-6 col-xl-3">
                                                    <div class="grade-card">
                                                        <span class="label">Nota 1:</span>
                                                        <strong>${empty notasSeccion.nota1 ? '-' : notasSeccion.nota1}</strong>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-md-6 col-xl-3">
                                                    <div class="grade-card">
                                                        <span class="label">Nota 2:</span>
                                                        <strong>${empty notasSeccion.nota2 ? '-' : notasSeccion.nota2}</strong>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-md-6 col-xl-3">
                                                    <div class="grade-card">
                                                        <span class="label">Nota 3:</span>
                                                        <strong>${empty notasSeccion.nota3 ? '-' : notasSeccion.nota3}</strong>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-md-6 col-xl-3">
                                                    <div class="grade-card">
                                                        <span class="label">Nota final:</span>
                                                        <strong>${empty notasSeccion.notaFinal ? '-' : notasSeccion.notaFinal}</strong>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="grade-card highlight mt-4">
                                                <p class="mb-0 text-muted">Promedio </p>
                                                <h3 class="mb-0">${empty notasSeccion.promedio ? '-' : notasSeccion.promedio}</h3>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-warning mb-0">A&uacute;n no se registran calificaciones para esta secci&oacute;n.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="tab-pane fade" id="pane-asistencia" role="tabpanel">
                                    <c:choose>
                                        <c:when test="${not empty asistenciasVista}">
                                            <div class="attendance-list mt-2">
                                                <c:forEach var="asis" items="${asistenciasVista}">
                                                    <div class="attendance-item d-flex justify-content-between align-items-center ${asis.presente ? 'status-success' : 'status-danger'}">
                                                        <div>
                                                            <strong>${asis.fechaTexto}</strong>
                                                            <p class="mb-0 text-muted small">${asis.presente ? 'Sesi&oacute;n registrada' : 'Sin asistencia registrada'}</p>
                                                        </div>
                                                        <span class="attendance-status">
                                                            <i class="bi ${asis.presente ? 'bi-check-circle' : 'bi-x-circle'} me-1"></i>
                                                            ${asis.presente ? 'Asisti&oacute;' : 'Falta'}
                                                        </span>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info mb-0">La asistencia aparecer&aacute; cuando el docente registre tus sesiones.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="section-card text-center">
                            <h5>No encontramos el curso solicitado</h5>
                            <p class="text-muted mb-3">Vuelve a la lista de cursos para seleccionar uno disponible.</p>
                            <a href="${pageContext.request.contextPath}/Estudiante/Cursos" class="btn btn-primary px-4">Ir a Mis Cursos</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
