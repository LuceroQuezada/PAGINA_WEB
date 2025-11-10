<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
<%@ page import="DAO.UsuarioDAO" %>
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
    request.setAttribute("sidebarActive", "dashboard");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
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
                --color-sidebar-top: #1E1B4B;
                --color-sidebar-bottom: #2F0059;
                --color-sidebar-text: #FFFFFFB2;
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

            .welcome-card {
                background: var(--color-surface);
                border-radius: 24px;
                padding: 2rem;
                border: 1px solid var(--color-border);
            }

            .welcome-card h1 {
                font-size: 1.75rem;
                font-weight: 600;
            }

            .section-card {
                background: var(--color-surface);
                border-radius: 20px;
                border: 1px solid var(--color-border);
                padding: 1.5rem;
            }

            .section-card + .section-card {
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
                gap: 0.5rem;
                position: relative;
            }

            .class-card::before {
                content: "";
                position: absolute;
                inset: 0;
                width: 6px;
                background: linear-gradient(180deg, var(--color-accent), var(--color-accent-2));
                border-radius: 16px 0 0 16px;
            }

            .class-card-content {
                margin-left: 1rem;
            }

            .class-meta {
                color: var(--color-muted);
                font-size: 0.95rem;
            }

            .badge-section {
                align-self: flex-start;
                background: #EAFBF3;
                color: var(--color-accent-2);
                border-radius: 999px;
                padding: 0.15rem 0.75rem;
                font-size: 0.85rem;
                font-weight: 600;
            }

            .schedule {
                display: flex;
                gap: 1.5rem;
                font-size: 0.9rem;
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
                padding: 0.4rem 0;
                border-bottom: 1px dashed #D1D5DC;
                font-size: 0.95rem;
            }

            .attendance-item:last-child {
                border-bottom: none;
            }

            .attendance-status {
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 0.3rem;
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
                margin-bottom: 0.5rem;
            }

            .announcement-card a {
                text-decoration: none;
                font-weight: 600;
                color: var(--color-accent);
                display: inline-flex;
                align-items: center;
                gap: 0.3rem;
            }

            @media (max-width: 991.98px) {
                .dashboard-main {
                    padding: 1.5rem 1rem 2rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="dashboard-layout d-flex">
            <%@ include file="includes/sidebar.jspf" %>
            <div class="content-wrapper">
                <%@ include file="includes/topbar.jspf" %>
                <main class="dashboard-main">
                    <div class="welcome-card mb-4">
                        <p class="text-muted mb-1">Clases programadas</p>
                        <h1>Organiza tu dia</h1>
                        <p class="text-muted mb-0">Estas son las actividades destacadas de hoy.</p>
                    </div>
                    <div class="row g-4">
                        <div class="col-12 col-lg-8">
                            <div class="section-card">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class="section-title mb-0">Clases de hoy</h5>
                                    <button class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                        <i class="bi bi-plus-lg me-1"></i>Agregar recordatorio
                                    </button>
                                </div>
                                <div class="class-card mb-3">
                                    <div class="class-card-content">
                                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
                                            <div>
                                                <h6 class="mb-1">Calculo Diferencial</h6>
                                                <p class="class-meta mb-0">MAT-101 &middot; Hebert Perez</p>
                                            </div>
                                            <span class="badge-section">A-1</span>
                                        </div>
                                        <div class="schedule mt-3">
                                            <span><i class="bi bi-clock me-1"></i>09:00 - 11:00</span>
                                            <span><i class="bi bi-geo-alt me-1"></i>Sala 302</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="class-card">
                                    <div class="class-card-content">
                                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
                                            <div>
                                                <h6 class="mb-1">Fisica Mecanica</h6>
                                                <p class="class-meta mb-0">FIS-101 &middot; Hebert Perez</p>
                                            </div>
                                            <span class="badge-section">A-1</span>
                                        </div>
                                        <div class="schedule mt-3">
                                            <span><i class="bi bi-clock me-1"></i>11:30 - 13:30</span>
                                            <span><i class="bi bi-geo-alt me-1"></i>Laboratorio 1</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section-card mt-4">
                                <h5 class="section-title">Asistencia del dia</h5>
                                <div class="attendance-list">
                                    <div class="attendance-item">
                                        <span>Lunes, 3 de noviembre</span>
                                        <span class="attendance-status status-success">
                                            <i class="bi bi-check-circle"></i> Asistio
                                        </span>
                                    </div>
                                    <div class="attendance-item">
                                        <span>Domingo, 2 de noviembre</span>
                                        <span class="attendance-status status-success">
                                            <i class="bi bi-check-circle"></i> Asistio
                                        </span>
                                    </div>
                                    <div class="attendance-item">
                                        <span>Sabado, 1 de noviembre</span>
                                        <span class="attendance-status status-warning">
                                            <i class="bi bi-dash-circle"></i> Sin registro
                                        </span>
                                    </div>
                                    <div class="attendance-item">
                                        <span>Viernes, 31 de octubre</span>
                                        <span class="attendance-status status-success">
                                            <i class="bi bi-check-circle"></i> Asistio
                                        </span>
                                    </div>
                                    <div class="attendance-item">
                                        <span>Jueves, 30 de octubre</span>
                                        <span class="attendance-status status-danger">
                                            <i class="bi bi-x-circle"></i> Falta
                                        </span>
                                    </div>
                                    <div class="attendance-item">
                                        <span>Miercoles, 29 de octubre</span>
                                        <span class="attendance-status status-success">
                                            <i class="bi bi-check-circle"></i> Asistio
                                        </span>
                                    </div>
                                    <div class="attendance-item">
                                        <span>Martes, 28 de octubre</span>
                                        <span class="attendance-status status-success">
                                            <i class="bi bi-check-circle"></i> Asistio
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="section-card">
                                <h5 class="section-title">Anuncios</h5>
                                <div class="announcement-card shadow-sm">
                                    <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=600&q=60" alt="Cursos de verano">
                                    <div class="card-body">
                                        <h6>&#161;Nuevos cursos de verano!</h6>
                                        <p>Aprovecha el 30% de descuento en todos los cursos intensivos.</p>
                                        <a href="#">
                                            Explorar cursos <i class="bi bi-box-arrow-up-right"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="announcement-card shadow-sm">
                                    <img src="https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?auto=format&fit=crop&w=600&q=60" alt="Certificaciones">
                                    <div class="card-body">
                                        <h6>Certificaciones profesionales</h6>
                                        <p>Obten certificados reconocidos internacionalmente y destaca.</p>
                                        <a href="#">
                                            Mas informacion <i class="bi bi-arrow-up-right"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="announcement-card shadow-sm mb-0">
                                    <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=600&q=60" alt="Descuentos">
                                    <div class="card-body">
                                        <h6>Descuentos estudiantes</h6>
                                        <p>Presenta tu credencial y accede a beneficios exclusivos.</p>
                                        <a href="#">
                                            Saber mas <i class="bi bi-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
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
            })();
        </script>
    </body>
</html>
