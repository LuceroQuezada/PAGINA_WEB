<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es" /> 
<fmt:setBundle basename="mensajes" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="resultado.titulo"/></title>
        <link rel="icon" type="image/png" href="img/LOGOS.png" />


        <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">


        <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>


        <link rel="stylesheet" href="css/resultado.css">
    </head>
    <body class="d-flex justify-content-center align-items-center min-vh-100">

        <div class="container">
            <div class="result-card text-center">
                <c:choose>
                    <c:when test="${param.estado == 'exito'}">
                        <div class="success-icon"><i class="fas fa-check-circle"></i></div>
                        <h2 class="text-success mb-3"><fmt:message key="resultado.exito.titulo" /></h2>
                        <p class="text-muted"><fmt:message key="resultado.exito.mensaje" /></p>
                    </c:when>

                    <c:when test="${param.estado == 'duplicado'}">
                        <div class="warning-icon"><i class="fas fa-exclamation-circle text-warning"></i></div>
                        <h2 class="text-warning mb-3">Ya estás registrado</h2>
                        <p class="text-muted">Este DNI o correo ya existe en el sistema. No es necesario volver a registrarte.</p>
                    </c:when>

                    <c:otherwise>
                        <div class="error-icon"><i class="fas fa-exclamation-triangle text-danger"></i></div>
                        <h2 class="text-danger mb-3"><fmt:message key="resultado.error.titulo" /></h2>
                        <p class="text-muted"><fmt:message key="resultado.error.mensaje" /></p>
                        <c:if test="${not empty requestScope.errorMessage}">
                            <div class="alert alert-danger mt-3">
                                <strong><fmt:message key="resultado.error.texto" /></strong><br>${requestScope.errorMessage}
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>


                <div class="mt-4">
                    <a href="preins.jsp" class="btn btn-custom me-3">
                        <i class="fas fa-arrow-left"></i> <fmt:message key="resultado.boton.volver" />
                    </a>
                    <a href="index.jsp" class="btn btn-outline-secondary">
                        <i class="fas fa-home"></i> <fmt:message key="resultado.boton.inicio" />
                    </a>
                </div>

       
                <div class="mt-3 text-muted small">
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy - HH:mm:ss" var="fechaActual"/>
                    <fmt:message key="resultado.fecha" />: ${fechaActual}
                </div>
            </div>
        </div>


        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
