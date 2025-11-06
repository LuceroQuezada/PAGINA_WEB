<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es" />
<fmt:setBundle basename="mensajes" />
<%
    request.setAttribute("paginaActual", "estado");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Consultar Estado de Pre-inscripción - Academia</title>
        <link rel="icon" type="image/png" href="img/LOGOS.png" />

        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/estilos.css">
        <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>

        <style>
            @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Poppins:wght@400;500;600;700;800&display=swap');
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                text-decoration: none;
                list-style: none;
            }
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #F1F4FD;
            }
            img {
                max-width: 100%;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
            }
            .menu {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 20px 0;
            }
            .logo {
                color: #000d83;
                font-size: 25px;
                text-transform: uppercase;
                font-weight: 800;
            }
            
            .menu .navbar {
                background: transparent !important;
                border: none;
                box-shadow: none;
                padding: 0;
            }
            
            .navbar-brand {
                display: none !important;
            }
            
            .navbar-toggler {
                border: none;
                padding: 0;
            }
            
            .menu .navbar ul {
                display: flex;
                align-items: center;
                margin: 0;
            }

            .menu .navbar ul li {
                margin: 0 10px;
            }

            .menu .navbar ul li a {
                font-size: 18px;
                padding: 10px 20px;
                color: #000d83;
                display: block;
                font-weight: 600;
                text-decoration: none;
                background: transparent;
                border-radius: 0px;
                transition: all 0.3s ease;
                border-bottom: 3px solid transparent;
            }
            
            .menu .navbar ul li a:hover {
                color: #3ec4ff;
                background-color: rgba(62, 196, 255, 0.1);
            }
            
            .menu .navbar ul li a.activo {
                color: #3ec4ff;
                border-bottom: 3px solid #3ec4ff;
                background-color: rgba(62, 196, 255, 0.1);
            }
            
            .custom-select {
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                background: transparent;
                border: none;
                font-size: 18px;
                font-weight: 600;
                color: #000d83;
                padding: 10px 30px 10px 20px;
                border-radius: 0px;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
                outline: none;
                min-width: 140px;
                text-align: center;
            }
            
            .custom-select:hover {
                color: #3ec4ff;
                background-color: rgba(62, 196, 255, 0.1);
            }
            
            .custom-select:focus {
                color: #3ec4ff;
                background-color: rgba(62, 196, 255, 0.1);
            }
            
            .select-wrapper {
                position: relative;
                display: inline-block;
            }
            
            .select-wrapper::after {
                content: '▼';
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                color: #000d83;
                pointer-events: none;
                font-size: 12px;
                transition: all 0.3s ease;
            }
            
            .select-wrapper:hover::after {
                color: #3ec4ff;
            }
            
            #menu {
                display: none;
            }
            .menu-icono {
                width: 25px;
            }
            .menu label {
                cursor: pointer;
                display: none;
            }

            /* Estilos específicos para el contenido principal */
            .main-content {
                padding: 80px 0;
                min-height: calc(100vh - 200px);
            }

            .form-container {
                background-color: #ffffff;
                padding: 50px;
                border-radius: 25px;
                box-shadow: 0 15px 20px rgba(33, 40, 105, 0.2);
                max-width: 600px;
                margin: 0 auto;
            }

            .form-title {
                font-size: 40px;
                line-height: 1;
                color: #000d83;
                margin-bottom: 30px;
                text-align: center;
                font-weight: 700;
            }

            .form-subtitle {
                font-size: 18px;
                color: #2c39aa;
                margin-bottom: 40px;
                text-align: center;
            }

            .form-label {
                font-size: 16px;
                color: #000d83;
                font-weight: 600;
                margin-bottom: 8px;
                display: block;
            }

            .form-control {
                background-color: #fbfcfe;
                border: 2px solid #e8ecf4;
                border-radius: 10px;
                padding: 15px;
                font-size: 16px;
                color: #000d83;
                transition: all 0.3s ease;
                margin-bottom: 20px;
            }

            .form-control:focus {
                border-color: #3ec4ff;
                box-shadow: 0 0 0 0.2rem rgba(62, 196, 255, 0.25);
                background-color: #ffffff;
            }

            .btn-consultar {
                display: inline-block;
                padding: 15px 40px;
                background-color: #000d83;
                color: #ffffff;
                text-transform: uppercase;
                font-size: 16px;
                font-weight: 600;
                border: none;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(33, 40, 105, 0.2);
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
            }

            .btn-consultar:hover {
                background-color: #3ec4ff;
                transform: translateY(-2px);
            }

            /* Estilos para los estados */
            .estado-resultado {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 15px;
                margin-top: 30px;
                text-align: center;
                box-shadow: 0 10px 20px rgba(33, 40, 105, 0.1);
            }

            .estado-pendiente {
                border-left: 5px solid #ffc107;
                background-color: #fff9e6;
            }

            .estado-aceptado {
                border-left: 5px solid #28a745;
                background-color: #f0f9f0;
            }

            .estado-rechazado {
                border-left: 5px solid #dc3545;
                background-color: #fff0f0;
            }

            .estado-cancelado {
                border-left: 5px solid #fd7e14;
                background-color: #fff7f0;
            }

            .estado-texto {
                font-size: 18px;
                font-weight: 600;
                margin: 0;
            }

            .estado-pendiente .estado-texto {
                color: #856404;
            }

            .estado-aceptado .estado-texto {
                color: #155724;
            }

            .estado-rechazado .estado-texto {
                color: #721c24;
            }

            .estado-cancelado .estado-texto {
                color: #cc4a00;
            }

            .estado-icon {
                font-size: 30px;
                margin-right: 10px;
            }

            p {
                font-size: 18px;
                color: #2c39aa;
                margin-bottom: 20px;
            }

            /* Footer styles */
            .pie-pagina {
                width: 100%;
                background-color: #0d0541;
                margin-top: 50px;
            }
            .pie-pagina .grupo-1 {
                width: 80%;
                max-width: 1200px;
                margin: auto;
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                grid-gap: 50px;
                padding: 40px 0px;
            }
            .pie-pagina .grupo-1 .box figure {
                width: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .pie-pagina .grupo-1 .box figure img {
                width: 200px;
            }
            .pie-pagina .grupo-1 .box h2 {
                color: #fff;
                margin-bottom: 25px;
                font-size: 20px;
            }
            .pie-pagina .grupo-1 .box p {
                color: #efefef;
                margin-bottom: 10px;
                font-size: 15px;
            }
            .pie-pagina .grupo-1 .red-social a {
                display: inline-block;
                text-decoration: none;
                width: 45px;
                height: 45px;
                line-height: 45px;
                color: #fff;
                margin-right: 10px;
                background-color: #0d2033;
                text-align: center;
                transition: all 300ms ease;
            }
            .pie-pagina .grupo-1 .red-social a:hover {
                color: aqua;
            }
            .pie-pagina .grupo-2 {
                background-color: #0a1a2a;
                padding: 15px 10px;
                text-align: center;
                color: #fff;
            }
            
            /* Responsive */
            @media (max-width: 768px) {
                .menu label {
                    display: block;
                }
                .menu .navbar {
                    display: none;
                }
                #menu:checked ~ .navbar {
                    display: block;
                }
                .form-container {
                    padding: 30px 20px;
                    margin: 20px;
                }
                .form-title {
                    font-size: 30px;
                }
            }
        </style>
    </head>
    <body>
        <header class="header">
            <div class="container">
                <div class="menu">
                    <a href="index.jsp" class="logo">GrupoA1</a>
                    <input type="checkbox" id="menu" />
                    <label for="menu">
                        <img src="img/menu.png" class="menu-icono" alt="">
                    </label>

                    <nav class="navbar navbar-expand-lg">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navMain">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="index.jsp">Inicio</a>
                                </li>

                                <li class="nav-item">
                                    <div class="select-wrapper">
                                        <select class="custom-select"
                                                onchange="if (this.value) window.location.href = this.value;">
                                            <option value="" disabled>Inscripción</option>
                                            <option value="preins.jsp">Pre-inscripción</option>
                                            <option value="estadoPreinscripcion.jsp" selected>Estado de inscripción</option>
                                        </select>
                                    </div>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link" href="login.jsp" target="_blank">Intranet</a>
                                </li>
                                
                                <li class="nav-item">
                                   <a href="servicios.jsp" class="nav-link"><fmt:message key="titulo.servicios" /></a>
                                </li>
                                
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Contacto</a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
        </header>

        <main class="main-content">
            <div class="container">
                <div class="form-container">
                    <h1 class="form-title">Consultar Estado</h1>
                    <p class="form-subtitle">Ingresa tu DNI para conocer el estado de tu pre-inscripción</p>
                    
                    <form action="ConsultarEstadoServlet" method="post">
                        <div class="mb-3">
                            <label for="dni" class="form-label">Documento Nacional de Identidad (DNI)</label>
                            <input id="dni" name="dni" type="text" class="form-control" 
                                   placeholder="Ingresa tu DNI (8 dígitos)" 
                                   pattern="[0-9]{8}" 
                                   maxlength="8" 
                                   required>
                        </div>
                        <button type="submit" class="btn-consultar">
                            <i class="fas fa-search"></i> Consultar Estado
                        </button>
                    </form>

                    <c:if test="${not empty estado}">
                        <div class="estado-resultado 
                             <c:choose>
                                 <c:when test="${estado == 'pendiente'}">estado-pendiente</c:when>
                                 <c:when test="${estado == 'aceptado'}">estado-aceptado</c:when>
                                 <c:when test="${estado == 'rechazado'}">estado-rechazado</c:when>
                                 <c:when test="${estado == 'cancelado'}">estado-cancelado</c:when>
                                 <c:otherwise>estado-pendiente</c:otherwise>
                             </c:choose>">
                            
                            <p class="estado-texto">
                                <c:choose>
                                    <c:when test="${estado == 'pendiente'}">
                                        <span class="estado-icon">⏳</span>
                                        Su solicitud está en revisión
                                        <br><small>Nuestro equipo está evaluando su solicitud. Le notificaremos pronto.</small>
                                    </c:when>
                                    <c:when test="${estado == 'aceptado'}">
                                        <span class="estado-icon">✅</span>
                                        Su solicitud ha sido aceptada
                                        <br><small>¡Felicitaciones! Pronto recibirá información sobre el siguiente paso.</small>
                                    </c:when>
                                    <c:when test="${estado == 'rechazado'}">
                                        <span class="estado-icon">❌</span>
                                        Su solicitud ha sido rechazada
                                        <br><small>Lamentamos informarle que no cumple con los requisitos actuales.</small>
                                    </c:when>
                                    <c:when test="${estado == 'cancelado'}">
                                        <span class="estado-icon">⚠️</span>
                                        Su solicitud fue cancelada
                                        <br><small>La solicitud ha sido cancelada. Puede realizar una nueva inscripción.</small>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="estado-icon">❓</span>
                                        No se encontró su solicitud
                                        <br><small>Verifique que el DNI ingresado sea correcto o realice una nueva inscripción.</small>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>

        <footer class="pie-pagina">
            <div class="grupo-1">
                <div class="box">
                    <figure>
                        <a href="#"><img src="img/logo_2 (1).png" alt="logo academia"></a>
                    </figure>
                </div>
                <div class="box">
                    <h2>SOBRE NOSOTROS</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                </div>
                <div class="box">
                    <h2>SÍGUENOS</h2>
                    <div class="red-social">
                        <a href="https://www.facebook.com/grupodeestudiosa1" class="fa fa-facebook"></a>
                        <a href="https://www.instagram.com/nivela_1/" class="fa-brands fa-instagram"></a>
                        <a href="#" class="fa fa-whatsapp"></a>
                        <a href="#" class="fa fa-twitter"></a>
                    </div>
                </div>
            </div>
            <div class="grupo-2">
                <small>&copy;2024 <b>Academia NivelA1</b> - Todos los derechos Reservados</small>
            </div>
        </footer>

        <!-- Bootstrap JS local -->
        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>