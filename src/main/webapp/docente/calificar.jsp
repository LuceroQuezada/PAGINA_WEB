<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>✏️ Registro de Notas</title>
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
                <h2>✏️ Calificar y Feedback</h2>

                <!-- Mensajes -->
                <c:if test="${mensaje=='exito'}">
                    <div class="alert alert-success">✅ Notas guardadas.</div>
                </c:if>
                <c:if test="${mensaje=='error'}">
                    <div class="alert alert-danger">❌ Error: seleccione sección o estudiantes.</div>
                </c:if>

                <!-- Selector de sección -->
                <form method="get" action="${pageContext.request.contextPath}/Docente/Calificar"
                      class="row g-2 align-items-center mb-4">
                    <div class="col-auto">
                        <label for="seccion" class="form-label">Sección:</label>
                    </div>
                    <div class="col-auto">
                        <select id="seccion" name="idSeccion" class="form-select"
                                onchange="this.form.submit()">
                            <option value="">-- elige una sección --</option>
                            <c:forEach var="s" items="${secciones}">
                                <option value="${s.idSeccion}"
                                        <c:if test="${s.idSeccion==selectedSeccion}">selected</c:if>>
                                    ${s.nombreCurso} • Sec ${s.seccion} • Grupo ${s.grupo}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </form>

                <c:if test="${not empty alumnos}">
                    <form action="${pageContext.request.contextPath}/Docente/RegistrarNotas"
                          method="post">
                        <input type="hidden" name="idSeccion" value="${selectedSeccion}"/>

                        <table class="table table-bordered bg-white shadow-sm">
                            <thead class="table-dark text-center">
                                <tr>
                                    <th>Alumno</th>
                                    <th>Nota 1</th>
                                    <th>Nota 2</th>
                                    <th>Nota 3</th>
                                    <th>Final</th>
                                    <th>Promedio</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="al" items="${alumnos}">
                                    <tr>
                                        <td>
                                            ${al.nombre} ${al.apellido}
                                            <input type="hidden" name="estudiantes[]" value="${al.id}"/>
                                        </td>
                                        <td>
                                            <input type="number" step="0.01" min="0" max="20"
                                                   name="nota1_${al.id}" class="form-control"
                                                   value="${notaMap[al.id].nota1}"/>
                                        </td>
                                        <td>
                                            <input type="number" step="0.01" min="0" max="20"
                                                   name="nota2_${al.id}" class="form-control"
                                                   value="${notaMap[al.id].nota2}"/>
                                        </td>
                                        <td>
                                            <input type="number" step="0.01" min="0" max="20"
                                                   name="nota3_${al.id}" class="form-control"
                                                   value="${notaMap[al.id].nota3}"/>
                                        </td>


                                        <td>
                                            <input type="number" step="0.01" min="0" max="20"
                                                   name="notaF_${al.id}" class="form-control"
                                                   value="${notaMap[al.id].notaFinal}"/>
                                        </td>
                                        <!-- nuevo campo promedio, solo lectura -->
                                        <td>
                                            <input type="number" step="0.01" min="0" max=20
                                                   name="promedio_${al.id}"
                                                   class="form-control" readonly
                                                   value="${notaMap[al.id].promedio}"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>

                        </table>

                        <button class="btn btn-primary">Guardar Notas</button>
                    </form>
                </c:if>

                <div class="col-12 text-center">

                    <a href="${pageContext.request.contextPath}/docente/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                </div>
            </div>
            <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</div>
</html>
