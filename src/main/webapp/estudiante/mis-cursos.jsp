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
    <title>Mis Cursos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/estudiante/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/estudiante/css/topbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/estudiante/css/courses.css">
    <style>
        :root {
            --color-bg: #F3F4F6;
            --color-surface: #FFFFFF;
            --color-border: #E5E7EB;
            --color-muted: #6B7280;
            --color-accent: #00C2CB;
            --color-accent-2: #00A63E;
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
            border-radius: 20px;
            border: 1px solid var(--color-border);
            padding: 1.5rem;
        }

        @media (max-width: 991.98px) {
            .dashboard-main {
                padding: 1.5rem 1rem 2rem;
            }
        }
    </style>
</head>
<body>
<c:set var="courseCovers" value="${fn:split('https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=900&q=60,https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=900&q=60,https://images.unsplash.com/photo-1509221963641-49e27c514d3c?auto=format&fit=crop&w=900&q=60', ',')}" />
<c:set var="progressPattern" value="${fn:split('65,40,85', ',')}" />
    <div class="dashboard-layout d-flex">
        <%@ include file="includes/sidebar.jspf" %>
        <div class="content-wrapper">
            <%@ include file="includes/topbar.jspf" %>
            <main class="dashboard-main courses-main">
                <div class="courses-hero mb-4">
                    <div>
                        <p class="text-muted mb-1">Descubre y gestiona tus cursos</p>
                        <h1 class="mb-0">Mis Cursos</h1>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty secciones}">
                        <div class="row g-4 courses-grid">
                            <c:forEach var="curso" items="${secciones}" varStatus="status">
                                <c:set var="coverIndex" value="${status.index % fn:length(courseCovers)}" />
                                <c:set var="progressIndex" value="${status.index % fn:length(progressPattern)}" />
                                <c:set var="progressValue" value="${progressPattern[progressIndex]}" />
                                <div class="col-12 col-md-6 col-xl-4">
                                    <div class="course-card">
                                        <div class="course-cover" style="background-image: url('${courseCovers[coverIndex]}');">
                                            <div class="course-progress">
                                                <span>${progressValue}</span>
                                                <small>%</small>
                                            </div>
                                            <div class="course-progress-bar">
                                                <span style="width: ${progressValue}%;"></span>
                                            </div>
                                        </div>
                                        <div class="course-body">
                                            <span class="course-tag">${empty curso.carrera ? "Curso" : curso.carrera}</span>
                                            <h5 class="course-title">${curso.curso}</h5>
                                            <p class="text-muted mb-2">${curso.seccion} &middot; ${curso.grupo}</p>
                                            <div class="course-meta">
                                                <div class="course-avatar">${fn:substring(curso.curso, 0, 1)}</div>
                                                <div>
                                                    <p class="mb-0 fw-semibold">${empty curso.profesor ? 'Por asignar' : curso.profesor}</p>
                                                    <small class="text-muted">Instructor</small>
                                                </div>
                                            </div>
                                            <div class="course-footer">
                                                <div>
                                                    <small class="text-muted">Horario</small>
                                                    <p class="mb-0 fw-semibold">${curso.dia} &middot; ${curso.horaInicio} - ${curso.horaFin}</p>
                                                </div>
                                                <div class="course-level">
                                                    <i class="bi bi-bookmark"></i> ${empty curso.seccion ? "Seccion" : curso.seccion}
                                                </div>
                                            </div>
                                            <a class="btn btn-outline-primary w-100 mt-3" href="${pageContext.request.contextPath}/Estudiante/Cursos/Detalle?idSeccion=${curso.id}">
                                                Ver material
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="section-card text-center">
                            <h5>A&uacute;n no tienes cursos asignados</h5>
                            <p class="text-muted mb-0">Cuando te inscribas en una secci&oacute;n ver&aacute;s sus detalles aqu&iacute;.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/estudiante/panel.jsp" class="btn btn-secondary px-4">Volver al panel</a>
                </div>
            </main>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
