<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, modelo.CursoDocente, modelo.Usuario" %>
<%
    // —— 0) Verificar sesión y rol ——
    Usuario docente = (Usuario) session.getAttribute("usuario");
    if (docente == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // —— 1) Recuperar lista inyectada por el servlet ——
    List<CursoDocente> lista = (List<CursoDocente>) request.getAttribute("listaHorario");
    if (lista == null) {
        lista = Collections.emptyList();
    }

    // —— 2) Construir mapa día -> (slot -> CursoDocente) ——
    Map<String, Map<String, CursoDocente>> cal = new HashMap<>();
    for (CursoDocente cd : lista) {
        String dia  = cd.getDia();
        String slot = cd.getHoraInicio() + "–" + cd.getHoraFin();
        cal.computeIfAbsent(dia, k -> new HashMap<>())
           .put(slot, cd);
    }

    // —— 3) Extraer dinámicamente los slots existentes ——
    Set<String> slotSet = new TreeSet<>();
    for (CursoDocente cd : lista) {
        slotSet.add(cd.getHoraInicio() + "–" + cd.getHoraFin());
    }
    String[] slots = slotSet.toArray(new String[0]);

    // —— 4) Días fijos de la semana ——
    String[] dias = { "Lunes","Martes","Miércoles","Jueves","Viernes" };
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Mi Horario Semanal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
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
            
    .calendar { width: 100%; border-collapse: collapse; }
    .calendar th, .calendar td {
      border: 1px solid #dee2e6;
      padding: 0.5rem;
      text-align: center;
      vertical-align: middle;
    }
    .calendar th { background-color: #343a40; color: #fff; }
    .slot-header { background-color: #f0f0f0; font-weight: bold; }
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
    <h2 class="mb-4">🗓️ Mi Horario Semanal</h2>

    <% if (lista.isEmpty()) { %>
      <div class="alert alert-info">
        No tienes clases asignadas en este ciclo.
      </div>
    <% } else { %>
      <table class="table calendar shadow-sm">
        <thead>
          <tr>
            <th>Hora \ Día</th>
            <% for (String d : dias) { %>
              <th><%= d %></th>
            <% } %>
          </tr>
        </thead>
        <tbody>
          <% for (String slot : slots) { %>
            <tr>
              <th class="slot-header"><%= slot %></th>
              <% for (String d : dias) {
                   CursoDocente cdFor = null;
                   Map<String, CursoDocente> dayMap = cal.get(d);
                   if (dayMap != null) cdFor = dayMap.get(slot);
              %>
                <td>
                  <% if (cdFor != null) { %>
                    <strong><%= cdFor.getNombreCurso() %></strong><br/>
                    <small>
                      Sección <%= cdFor.getSeccion() %> • Grupo <%= cdFor.getGrupo() %>
                    </small>
                  <% } else { %>
                    &nbsp;
                  <% } %>
                </td>
              <% } %>
            </tr>
          <% } %>
        </tbody>
      </table>
    <% } %>

      <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/docente/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>
  </div>

  <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
  </div>
</body>
</html>
