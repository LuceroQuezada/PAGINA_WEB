<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es" />
<%-- <fmt:setLocale value="en" /> --%>

<fmt:setBundle basename="mensajes" />
<%
    request.setAttribute("paginaActual", "inicio");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title><fmt:message key="titulo.index" /> - Academia</title>
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
            
            /* Flecha personalizada para el select */
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
            .header-content {
                display: flex;
                padding: 80px 0 0 0;
            }
            .header-txt {
                flex-basis: 50%;
                padding-right: 30px;
            }
            .header-txt span {
                font-size: 18px;
                text-transform: capitalize;
                color: #ff5d5d;
                font-weight: 600;
                margin-bottom: 15px;
                display: block;
            }
            .header-txt h1 {
                font-size: 70px;
                line-height: 1;
                color: #000d83;
                margin-bottom: 15px;
            }
            p {
                font-size: 18px;
                color: #2c39aa;
                margin-bottom: 50px;
            }
            .btn-1 {
                display: inline-block;
                padding: 14px 25px;
                background-color: #000d83;
                color: #ffffff;
                text-transform: uppercase;
                font-size: 15px;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(33, 40, 105, 0.2);
            }
            .header-img {
                flex-basis: 50%;
            }
            .brands {
                padding: 50px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #ffffff;
                border-radius: 25px;
                box-shadow: 0 15px 20px rgba(33, 40, 105, 0.2);
            }
            .brands-1 {
                flex-basis: calc(33% - 25px);
            }
            .brands-1 p {
                font-size: 25px;
                line-height: 1;
                font-weight: 600;
                color: #000d83;
                margin: 0;
            }
            .brands-1 img {
                width: 150px;
            }
            .centrame {
                padding: 50px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .centrame .img {
                max-width: 70%;
                height: auto;
                border: 10px solid white;
                border-radius: 10px;
                box-shadow: 0 15px 20px rgba(33, 40, 105, 0.2);
            }
            .services {
                padding: 50px 0;
                text-align: center;
            }
            h2 {
                font: 40px;
                line-height: 1;
                color: #000d83;
                margin-bottom: 20px;
            }
            .services-content {
                margin-top: 40px;
                display: flex;
                justify-content: space-between;
            }
            .services-1 {
                flex-basis: calc(33% - 30px);
                background-color: #fbfcfe;
                padding: 40px;
                box-shadow: 0 0 10px rgba(33, 40, 105, 0.2);
                border-radius: 25px;
                color: #000d83;
            }
            .services-1:hover {
                background-color: #000d83;
                color: #ffffff;
                cursor: pointer;
            }
            .services-1:hover p {
                color: #ffffff;
            }
            .services-1 img {
                width: 35px;
                height: 35px;
                margin-bottom: 10px;
            }
            .services-1 h3 {
                font-size: 20px;
                line-height: 1.2;
            }
            .pie-pagina {
                width: 100%;
                height: 50%;
                background-color: #0d0541;
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
            .pie-pagina .grupo-1 .box figure {
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
                padding: 10px 10px;
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
                                    <a class="nav-link activo" href="index.jsp">Inicio</a>
                                </li>

                                <li class="nav-item">
                                    <div class="select-wrapper">
                                        <select class="custom-select"
                                                onchange="if (this.value) window.location.href = this.value;">
                                            <option value="" disabled selected>Inscripción</option>
                                            <option value="preins.jsp">Pre-inscripción</option>
                                            <option value="estadoPreinscripcion.jsp">Estado de inscripción</option>
                                        </select>
                                    </div>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link" href="login.jsp" target="_blank">Intranet</a>
                                </li>
                                
                                <li class="nav-item">
                                   <a href="servicios.jsp" class=""><fmt:message key="titulo.servicios" /></a>
                                </li>
                                
                                
                               
                                
                                
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Contacto</a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>

                <div class="header-content">
                    <div class="header-txt">
                        <span><fmt:message key="inicio.subtitulo" /></span>
                        <h1><fmt:message key="inicio.titulo" /></h1>
                        <p><fmt:message key="inicio.descripcion" /></p>
                        <a href="#" class="btn-1"><fmt:message key="inicio.masinfo" /></a>
                    </div>
                    <div class="header-img">
                        <img src="img/tiburon.png" alt="">
                    </div>
                </div>
            </div>
        </header>

        <section class="brands container">
            <div class="brands-1">
                <p><fmt:message key="inicio.universidades" /></p>
            </div>
            <div class="brands-1">
                <img src="img/udep.png" alt="UDEP">
            </div>
            <div class="brands-1">
                <img src="img/upao.png" alt="UPAO">
            </div>
            <div class="brands-1">
                <img src="img/UTP.png" alt="UTP">
            </div>
        </section>

        <section class="centrame">
            <img src="img/cicloUdep.png" alt="" class="img" />
        </section>

        <main class="services container">
            <h2><fmt:message key="inicio.beneficios.titulo" /></h2>
            <div class="services-content">
                <div class="services-1">
                    <img src="img/servi1.png" alt="">
                    <h3><fmt:message key="inicio.beneficios.1.titulo" /></h3>
                    <p><br><fmt:message key="inicio.beneficios.1.descripcion" /></p>
                </div>
                <div class="services-1">
                    <img src="img/servi2.png" alt="">
                    <h3><fmt:message key="inicio.beneficios.2.titulo" /></h3>
                    <p><br><fmt:message key="inicio.beneficios.2.descripcion" /></p>
                </div>
                <div class="services-1">
                    <img src="img/servi3.png" alt="">
                    <h3><fmt:message key="inicio.beneficios.3.titulo" /></h3>
                    <p><br><fmt:message key="inicio.beneficios.3.descripcion" /></p>
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