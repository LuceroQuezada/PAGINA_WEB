<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, DAO.CursoDAO, modelo.Curso" %>
<%
    // 1) Listado fijo de carreras
    List<String> carreras = List.of("Ingenieria","Medicina","Derecho");
    request.setAttribute("carreras", carreras);

    // 2) Si viene 'carrera' en GET, cargo sus cursos:
    String carreraSel = request.getParameter("carrera");
    List<Curso> cursos = Collections.emptyList();
    if (carreraSel != null && !carreraSel.isEmpty()) {
        cursos = new CursoDAO().listarPorCarrera(carreraSel);
    }
    request.setAttribute("cursos", cursos);
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Subir Material de Curso</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
</head>
<body class="bg-light">
  <div class="container py-4">
    <h2 class="mb-4">📂 Subir / Gestionar Material</h2>

    <!-- Paso 1: elegir carrera -->
    <form method="get" class="row g-2 mb-4">
      <div class="col-auto">
        <label class="form-label">Carrera:</label>
      </div>
      <div class="col-auto">
        <select name="carrera" class="form-select" onchange="this.form.submit()">
          <option value="">-- selecciona carrera --</option>
          <c:forEach var="car" items="${carreras}">
            <option value="${car}"
              <c:if test="${car == param.carrera}">selected</c:if>
            >${car}</option>
          </c:forEach>
        </select>
      </div>
    </form>

    <c:if test="${not empty cursos}">
      <!-- Paso 2: formulario multipart para subir archivo -->
      <form action="${pageContext.request.contextPath}/admin/SubirMaterial" method="post"
            enctype="multipart/form-data">
        <input type="hidden" name="carrera" value="${param.carrera}" />

        <div class="mb-3">
          <label class="form-label">Curso:</label>
          <select name="idCurso" class="form-select" required>
            <option value="">-- selecciona curso --</option>
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
          <textarea name="descripcion" class="form-control"></textarea>
        </div>

        <div class="mb-3">
          <label class="form-label">Archivo (PDF, DOC, IMG, VIDEO, ZIP):</label>
          <input type="file" name="archivo" class="form-control" required>
        </div>

        <button class="btn btn-primary">Subir Material</button>

        <c:if test="${param.success=='true'}">
          <div class="alert alert-success mt-3">✅ Material subido con éxito.</div>
        </c:if>
      </form>
    </c:if>

     <div class="col-12 text-center">
                       
                            <a href="${pageContext.request.contextPath}/admin/panel.jsp" class="btn btn-secondary btn-form">Volver</a>
                        </div>
  </div>
</body>
</html>
