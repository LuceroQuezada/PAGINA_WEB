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
    request.setAttribute("sidebarActive", "horario");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Horario</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/estudiante/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/estudiante/css/topbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/estudiante/css/schedule.css">
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
            margin: 0;
            color: #1A1A1A;
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

        @media (max-width: 991.98px) {
            .dashboard-main {
                padding: 1.5rem 1rem 2rem;
            }
        }
    </style>
</head>
<body>
<c:set var="days" value="${fn:split('Lunes,Martes,Miércoles,Jueves,Viernes,Sábado', ',')}"></c:set>
<c:set var="colors" value="${fn:split('teal,cyan,purple', ',')}"></c:set>
<c:set var="hourStart" value="7" />
<c:set var="hourEnd" value="20" />
    <div class="dashboard-layout d-flex">
        <%@ include file="includes/sidebar.jspf" %>
        <div class="content-wrapper">
            <%@ include file="includes/topbar.jspf" %>
            <main class="dashboard-main">
                <div class="schedule-hero">
                    <div>
                        <p class="text-muted mb-1">Semana actual: 12 - Del 27 de octubre al 2 de noviembre</p>
                        <h1 class="mb-0">Mi Horario</h1>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty horario}">
                        <div class="schedule-wrapper section-card">
                            <div class="schedule-grid" data-start="${hourStart}" data-end="${hourEnd}" style="--grid-start:${hourStart}; --grid-end:${hourEnd};">
                                <div class="schedule-hours">
                                    <c:forEach begin="${hourStart}" end="${hourEnd}" var="hour">
                                        <div class="hour-slot">${hour lt 10 ? '0' : ''}${hour}:00</div>
                                    </c:forEach>
                                </div>
                                <div class="schedule-days">
                                    <c:forEach var="day" items="${days}" varStatus="status">
                                        <div class="schedule-day" data-day-key="${fn:toLowerCase(day)}">
                                            <div class="day-header ${status.index == 2 ? 'is-today' : ''}">
                                                ${day}
                                            </div>
                                            <div class="day-body"></div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="schedule-events">
                                    <c:forEach var="clase" items="${horario}" varStatus="status">
                                        <c:set var="colorIdx" value="${status.index % fn:length(colors)}" />
                                        <div class="schedule-event schedule-event--${colors[colorIdx]}"
                                             data-day="${clase.dia}"
                                             data-day-key="${fn:toLowerCase(clase.dia)}"
                                             data-start="${clase.horaInicio}"
                                             data-end="${clase.horaFin}">
                                            <p class="event-code mb-1">${clase.curso}</p>
                                            <h6 class="event-name mb-1">${clase.seccion != null ? clase.seccion : 'Sección A'}</h6>
                                            <p class="event-time mb-0">${clase.horaInicio} - ${clase.horaFin}</p>
                                            <small class="text-white-50">${clase.profesor}</small>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="schedule-legend mt-3">
                                <div class="legend-item">
                                    <span class="legend-dot teal"></span> Matemáticas
                                </div>
                                <div class="legend-item">
                                    <span class="legend-dot cyan"></span> Física
                                </div>
                                <div class="legend-item">
                                    <span class="legend-dot purple"></span> Laboratorios / Otros
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="section-card text-center">
                            <h5>No se encontraron horarios activos</h5>
                            <p class="text-muted mb-0">Cuando tengas clases asignadas se mostrarán aquí.</p>
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
    <script>
        (function () {
            var sidebar = document.getElementById('studentSidebar');
            var toggle = document.getElementById('sidebarToggle');
            if (toggle && sidebar) {
                toggle.addEventListener('click', function () {
                    sidebar.classList.toggle('sidebar-open');
                });
            }

            var grid = document.querySelector('.schedule-grid');
            if (!grid) {
                return;
            }
            var startHour = parseInt(grid.dataset.start, 10) || 7;
            var endHour = parseInt(grid.dataset.end, 10) || 20;
            var totalHours = endHour - startHour;
            var hourHeight = grid.dataset.hourHeight ? parseFloat(grid.dataset.hourHeight) : 64;

            function normalizeDay(value) {
                return (value || '')
                    .toString()
                    .toLowerCase()
                    .normalize('NFD')
                    .replace(/[^a-z]/g, '');
            }

            document.querySelectorAll('.schedule-event').forEach(function (eventEl) {
                var key = normalizeDay(eventEl.dataset.dayKey || eventEl.dataset.day);
                var column = Array.from(document.querySelectorAll('.schedule-day')).find(function (col) {
                    return normalizeDay(col.dataset.dayKey) === key;
                });
                if (!column) {
                    return;
                }
                var body = column.querySelector('.day-body');
                if (!body) {
                    return;
                }
                var start = (eventEl.dataset.start || '07:00').split(':');
                var end = (eventEl.dataset.end || '08:00').split(':');
                var startMinutes = parseInt(start[0], 10) * 60 + parseInt(start[1], 10);
                var endMinutes = parseInt(end[0], 10) * 60 + parseInt(end[1], 10);
                var offset = startMinutes - startHour * 60;
                var duration = Math.max(endMinutes - startMinutes, 45);
                eventEl.style.top = (offset / 60) * hourHeight + 'px';
                eventEl.style.height = (duration / 60) * hourHeight - 8 + 'px';
                body.appendChild(eventEl);
            });

            document.querySelectorAll('.schedule-day').forEach(function (day) {
                var body = day.querySelector('.day-body');
                if (body) {
                    body.style.height = totalHours * hourHeight + 'px';
                }
            });
        })();
    </script>
</body>
</html>
