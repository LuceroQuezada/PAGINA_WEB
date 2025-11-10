<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
<%@ page import="DAO.UsuarioDAO" %>
<%@ page import="DAO.EstudianteDAO" %>
<%@ page import="modelo.SeccionInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="verificarEstudiante.jsp" %>
<%
  if ("true".equals(request.getParameter("logout"))) {
    session.invalidate();
    response.sendRedirect("../login.jsp");
    return;
  }
  String nombreEstudiante = (usuario != null && usuario.getNombre() != null && !usuario.getNombre().isEmpty())
        ? usuario.getNombre().toUpperCase() : "ESTUDIANTE";
  String inicialEstudiante = nombreEstudiante.substring(0, 1);
  request.setAttribute("sidebarActive", "dashboard");

  List<SeccionInfo> clasesAsignadas = new ArrayList<>();
  if (usuario != null) {
    clasesAsignadas = new EstudianteDAO().listarSeccionesEstudiante(usuario.getId());
  }

  Locale localeEs = new Locale("es", "ES");
  String diaActualSistema = LocalDate.now().getDayOfWeek().getDisplayName(TextStyle.FULL, localeEs);
  String diaActualCapitalizado = (diaActualSistema != null && !diaActualSistema.isEmpty())
        ? diaActualSistema.substring(0, 1).toUpperCase(localeEs) + diaActualSistema.substring(1) : "";

  List<SeccionInfo> clasesHoy = new ArrayList<>();
  for (SeccionInfo clase : clasesAsignadas) {
    if (clase.getDia() != null && clase.getDia().equalsIgnoreCase(diaActualSistema)) {
      clasesHoy.add(clase);
    }
  }
  request.setAttribute("clasesHoy", clasesHoy);
  request.setAttribute("diaActual", diaActualCapitalizado);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
  <title>Panel Estudiante</title>
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
            --color-muted-2: #6A7282;
            --color-accent: #00C2CB;
            --color-accent-2: #00A63E;
            --color-danger: #E7000B;
            --color-success: #10B981;
            --color-attendance: #F3F4F61A;
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

        .section-card+.section-card {
            margin-top: 1.5rem;
        }

        .section-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #1A1A1A;
        }

        .class-card {
            border: 1px solid var(--color-border);
            border-radius: 16px;
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            gap: .5rem;
            position: relative;
        }

        .class-card::before {
            content: "";
            position: absolute;
            inset: 0;
            width: 10px;
            background: var(--color-accent);
            border-radius: 16px 0 0 16px;
        }

        .class-card-content {
            margin-left: 1rem;
        }

        .class-meta {
            color: var(--color-muted);
            font-size: .95rem;
        }

        .badge-section {
            align-self: flex-start;
            background: #EAFBF3;
            color: var(--color-accent-2);
            border-radius: 999px;
            padding: .15rem .75rem;
            font-size: .85rem;
            font-weight: 600;
        }

        .schedule {
            display: flex;
            gap: 1.5rem;
            font-size: .9rem;
            color: var(--color-muted-2);
        }

        .attendance-list {
            background: var(--color-attendance);
            border-radius: 16px;
            padding: 1rem 1.25rem;
        }

        .attendance-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: .4rem 0;
            border-bottom: 1px dashed #D1D5DC;
            font-size: .95rem;
        }

        .attendance-item:last-child {
            border-bottom: none;
        }

        .attendance-status {
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: .3rem;
        }

        .status-success {
            color: var(--color-success);
        }

        .status-warning {
            color: var(--color-muted);
        }

        .status-danger {
            color: var(--color-danger);
        }

        .announcement-card {
            border-radius: 18px;
            overflow: hidden;
            border: 1px solid var(--color-border);
            margin-bottom: 1.25rem;
        }

        .announcement-card img {
            width: 100%;
            height: 140px;
            object-fit: cover;
        }

        .announcement-card .card-body {
            padding: 1rem 1.25rem 1.5rem;
        }

        .announcement-card h6 {
            font-weight: 600;
        }

        .announcement-card p {
            color: var(--color-muted);
            margin-bottom: .5rem;
        }

        .announcement-card a {
            text-decoration: none;
            font-weight: 600;
            color: var(--color-accent);
            display: inline-flex;
            align-items: center;
            gap: .3rem;
        }
    </style>
</head>
<body>
  <div class="dashboard-layout d-flex">
    <%@ include file="includes/sidebar.jspf" %>
    <div class="content-wrapper">
      <%@ include file="includes/topbar.jspf" %>

      <main class="dashboard-main">
        <div class="row g-4">
          <div class="col-12 col-lg-8">
            <div class="section-card">
              <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <div>
                  <h5 class="section-title mb-0">Clases de hoy</h5>
                  <p class="class-meta mb-0 text-capitalize">${empty diaActual ? "" : diaActual}</p>
                </div>
                <a class="btn btn-sm btn-outline-primary rounded-pill px-3"
                   href="${pageContext.request.contextPath}/Estudiante/Horario">
                  <i class="bi bi-calendar3 me-1"></i>Ver horario completo
                </a>
              </div>

              <c:choose>
                <c:when test="${not empty clasesHoy}">
                  <c:forEach var="clase" items="${clasesHoy}">
                    <div class="class-card mb-3">
                      <div class="class-card-content">
                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
                          <div>
                            <h6 class="mb-1">${clase.curso}</h6>
                            <p class="class-meta mb-0">
                              ${empty clase.seccion ? "Sin seccion" : clase.seccion}
                              &middot;
                              ${empty clase.profesor ? "Profesor por asignar" : clase.profesor}
                            </p>
                          </div>
                          <span class="badge-section">
                            ${empty clase.carrera ? (empty clase.grupo ? "Seccion" : clase.grupo) : clase.carrera}
                          </span>
                        </div>
                        <div class="schedule mt-3">
                          <span><i class="bi bi-clock me-1"></i>${clase.horaInicio} - ${clase.horaFin}</span>
                          <span><i class="bi bi-people me-1"></i>${empty clase.grupo ? "Grupo por asignar" : clase.grupo}</span>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <div class="class-card text-center">
                    <div class="class-card-content">
                      <h6 class="mb-2">Hoy no tienes clases programadas</h6>
                      <p class="class-meta mb-3">Revisa tu horario para conocer todas tus secciones.</p>
                      <a class="btn btn-outline-primary rounded-pill px-4"
                         href="${pageContext.request.contextPath}/Estudiante/Horario">
                        <i class="bi bi-arrow-right me-1"></i>Ir a mi horario
                      </a>
                    </div>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>

            <div class="section-card mt-4">
              <h5 class="section-title">Asistencia del día</h5>
              <div class="attendance-list">
                <div class="attendance-item"><span>Lunes, 3 de noviembre</span><span class="attendance-status status-success"><i class="bi bi-check-circle"></i> Asistió</span></div>
                <div class="attendance-item"><span>Domingo, 2 de noviembre</span><span class="attendance-status status-success"><i class="bi bi-check-circle"></i> Asistió</span></div>
                <div class="attendance-item"><span>Sábado, 1 de noviembre</span><span class="attendance-status status-warning"><i class="bi bi-dash-circle"></i> Sin registro</span></div>
                <div class="attendance-item"><span>Viernes, 31 de octubre</span><span class="attendance-status status-success"><i class="bi bi-check-circle"></i> Asistió</span></div>
                <div class="attendance-item"><span>Jueves, 30 de octubre</span><span class="attendance-status status-danger"><i class="bi bi-x-circle"></i> Falta</span></div>
                <div class="attendance-item"><span>Miércoles, 29 de octubre</span><span class="attendance-status status-success"><i class="bi bi-check-circle"></i> Asistió</span></div>
                <div class="attendance-item"><span>Martes, 28 de octubre</span><span class="attendance-status status-success"><i class="bi bi-check-circle"></i> Asistió</span></div>
              </div>
            </div>
          </div>

          <div class="col-12 col-lg-4">
            <div class="section-card">
              <h5 class="section-title">Anuncios</h5>
              <div class="announcement-card shadow-sm">
                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=600&q=60" alt="Cursos de verano">
                <div class="card-body">
                  <h6>¡Nuevos cursos de verano!</h6>
                  <p>Aprovecha el 30% de descuento en todos los cursos intensivos.</p>
                  <a href="#">Explorar cursos <i class="bi bi-box-arrow-up-right"></i></a>
                </div>
              </div>
              <div class="announcement-card shadow-sm">
                <img src="https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?auto=format&fit=crop&w=600&q=60" alt="Certificaciones">
                <div class="card-body">
                  <h6>Certificaciones profesionales</h6>
                  <p>Obtén certificados reconocidos internacionalmente y destaca.</p>
                  <a href="#">Más información <i class="bi bi-arrow-up-right"></i></a>
                </div>
              </div>
              <div class="announcement-card shadow-sm mb-0">
                <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=600&q=60" alt="Descuentos">
                <div class="card-body">
                  <h6>Descuentos estudiantes</h6>
                  <p>Presenta tu credencial y accede a beneficios exclusivos.</p>
                  <a href="#">Saber más <i class="bi bi-arrow-right"></i></a>
                </div>
              </div>
            </div>
          </div>

        </div>
      </main>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
