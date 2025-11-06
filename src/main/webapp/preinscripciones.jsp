<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="modelo.PreinscripcionCompleta" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Preinscripciones - Academia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-container {
            padding: 20px;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .card-header {
            background: linear-gradient(135deg, #5b86e5, #36d1dc);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 20px;
        }
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }
        .table th {
            background-color: #f8f9fa;
            color: #495057;
            font-weight: 600;
            border: none;
        }
        .table td {
            border: none;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
        }
        .btn-sm {
            padding: 5px 10px;
            font-size: 12px;
            margin: 2px;
        }
        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            border: none;
        }
        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #fd7e14);
            border: none;
        }
        .btn-info {
            background: linear-gradient(135deg, #17a2b8, #6f42c1);
            border: none;
        }
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #495057);
            border: none;
        }
        .alert {
            border: none;
            border-radius: 10px;
        }
        .badge {
            font-size: 11px;
            padding: 5px 8px;
        }
        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        .action-buttons {
            white-space: nowrap;
        }
        .student-info {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        @media (max-width: 768px) {
            .table-responsive {
                font-size: 12px;
            }
            .student-info {
                max-width: 150px;
            }
            .btn-sm {
                padding: 3px 6px;
                font-size: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="back-btn">
        <a href="../panel_admin.jsp" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Volver al Panel
        </a>
    </div>

    <div class="container main-container">
        <div class="card">
            <div class="card-header">
                <h3 class="mb-0">
                    <i class="fas fa-list-check"></i> Gestión de Preinscripciones
                </h3>
                <p class="mb-0 mt-2">Administra las solicitudes de preinscripción de los estudiantes</p>
            </div>
            
            <div class="card-body">
                <!-- Alertas -->
                <% 
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i>
                        <% if ("aceptado".equals(success)) { %>
                            Preinscripción aceptada correctamente. El estudiante ha sido movido a la lista de interesados.
                        <% } else if ("rechazado".equals(success)) { %>
                            Preinscripción rechazada correctamente.
                        <% } %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <% if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i>
                        <% if ("aceptar".equals(error)) { %>
                            Error al aceptar la preinscripción. Intente nuevamente.
                        <% } else if ("rechazar".equals(error)) { %>
                            Error al rechazar la preinscripción. Intente nuevamente.
                        <% } else if ("parametros".equals(error)) { %>
                            Error en los parámetros de la solicitud.
                        <% } else if ("formato".equals(error)) { %>
                            Error en el formato de los datos.
                        <% } else if ("accion".equals(error)) { %>
                            Acción no válida.
                        <% } %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <!-- Tabla de preinscripciones -->
                <% 
                List<PreinscripcionCompleta> preinscripciones = (List<PreinscripcionCompleta>) request.getAttribute("preinscripciones");
                if (preinscripciones != null && !preinscripciones.isEmpty()) { %>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <span class="badge bg-primary">
                                <i class="fas fa-users"></i> Total: <%= preinscripciones.size() %> preinscripciones
                            </span>
                        </div>
                        <div class="col-md-6 text-end">
                            <button class="btn btn-sm btn-outline-secondary" onclick="window.location.reload();">
                                <i class="fas fa-refresh"></i> Actualizar
                            </button>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Estudiante</th>
                                    <th>DNI</th>
                                    <th>Contacto</th>
                                    <th>Carrera</th>
                                    <th>Fecha</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < preinscripciones.size(); i++) { 
                                    PreinscripcionCompleta p = preinscripciones.get(i); %>
                                    <tr>
                                        <td><strong><%= i + 1 %></strong></td>
                                        <td>
                                            <div class="student-info">
                                                <strong><%= p.getNombres() %> <%= p.getApellidos() %></strong><br>
                                                <small class="text-muted"><%= p.getColegio() %></small>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-secondary"><%= p.getDni() %></span></td>
                                        <td>
                                            <div class="student-info">
                                                <i class="fas fa-envelope"></i> <%= p.getCorreo() %><br>
                                                <i class="fas fa-phone"></i> <%= p.getTelefono() != null ? p.getTelefono() : "No registrado" %>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-info"><%= p.getCarrera() %></span></td>
                                        <td>
                                            <small class="text-muted">
                                                <%= p.getFechaRegistro() != null ? p.getFechaRegistro().substring(0, 10) : "No disponible" %>
                                            </small>
                                        </td>
                                        <td class="action-buttons">
                                            <form method="post" action="PreinscripcionAdminServlet" style="display: inline;">
                                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                                <input type="hidden" name="accion" value="aceptar">
                                                <button type="submit" class="btn btn-success btn-sm" 
                                                        onclick="return confirm('¿Estás seguro de aceptar esta preinscripción?')">
                                                    <i class="fas fa-check"></i> Aceptar
                                                </button>
                                            </form>
                                            
                                            <form method="post" action="PreinscripcionAdminServlet" style="display: inline;">
                                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                                <input type="hidden" name="accion" value="rechazar">
                                                <button type="submit" class="btn btn-danger btn-sm" 
                                                        onclick="return confirm('¿Estás seguro de rechazar esta preinscripción?')">
                                                    <i class="fas fa-times"></i> Rechazar
                                                </button>
                                            </form>
                                            
                                            <a href="mailto:<%= p.getCorreo() %>?subject=Preinscripción Academia&body=Estimado(a) <%= p.getNombres() %> <%= p.getApellidos() %>,%0D%0A%0D%0AGracias por tu interés en nuestra academia.%0D%0A%0D%0ASaludos cordiales." 
                                               class="btn btn-info btn-sm">
                                                <i class="fas fa-envelope"></i> Correo
                                            </a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } else { %>
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h4>No hay preinscripciones</h4>
                        <p>No se encontraron preinscripciones pendientes de revisión.</p>
                        <a href="../panel.jsp" class="btn btn-primary">
                            <i class="fas fa-arrow-left"></i> Volver al Panel
                        </a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>