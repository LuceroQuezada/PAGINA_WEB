<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es" />
<fmt:setBundle basename="mensajes" />

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Pre-inscripción - Academia</title>
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

            /* Estilos específicos para pre-inscripción */
            .preins-info {
                padding: 80px 10px 100px;
                display: flex;
                align-items: center;
                justify-content: space-around;
                flex-wrap: wrap;
                gap: 40px;
            }

            .container-img {
                flex-basis: 45%;
                display: flex;
                justify-content: center;
            }

            .container-img img {
                width: 100%;
                max-width: 600px;
                height: auto;
                object-fit: contain;
                border-radius: 25px;
                box-shadow: 0 15px 20px rgba(33, 40, 105, 0.2);
            }

            .container-txt {
                flex-basis: 50%;
                text-align: center;
                background-color: #ffffff;
                padding: 40px;
                border-radius: 25px;
                box-shadow: 0 15px 20px rgba(33, 40, 105, 0.2);
            }

            .container-txt h2 {
                color: #000d83;
                font-size: 32px;
                margin-bottom: 30px;
                font-family: 'Bebas Neue', sans-serif;
                letter-spacing: 1px;
            }

            /* Formulario */
            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }

            .form-group label {
                display: block;
                color: #000d83;
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 14px;
            }

            input, select {
                width: 100%;
                padding: 12px 18px;
                border-radius: 22px;
                background-color: #F8F9FA;
                border: 2px solid #E9ECEF;
                margin-bottom: 15px;
                color: #000d83;
                font-size: 16px;
                font-family: 'Poppins', sans-serif;
                transition: all 0.3s ease;
            }

            input:focus, select:focus {
                outline: none;
                border-color: #3ec4ff;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(62, 196, 255, 0.2);
            }

            select {
                cursor: pointer;
            }

            .btn {
                width: 100%;
                padding: 15px;
                border-radius: 22px;
                background-color: #000d83;
                border: none;
                cursor: pointer;
                color: #fff;
                font-weight: 600;
                font-size: 16px;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(13, 5, 65, 0.3);
            }

            .btn:hover {
                background-color: #1d145b;
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(13, 5, 65, 0.4);
            }

            /* Mensajes de estado */
            .mensaje {
                padding: 15px 20px;
                border-radius: 12px;
                margin-bottom: 25px;
                font-weight: 500;
                font-size: 16px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .mensaje.exito {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .mensaje.reinscrito {
                background-color: #cce7ff;
                color: #004085;
                border: 1px solid #99d6ff;
            }

            .mensaje.revision {
                background-color: #fff3cd;
                color: #856404;
                border: 1px solid #ffeaa7;
            }

            .mensaje.aceptado {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .mensaje.existe {
                background-color: #ffeaa7;
                color: #856404;
                border: 1px solid #ffd93d;
            }

            .mensaje.bloqueado {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f1b0b7;
            }

            /* Footer */
            .pie-pagina {
                width: 100%;
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
                
                .preins-info {
                    flex-direction: column;
                    padding: 40px 10px;
                }
                
                .container-img {
                    flex-basis: 100%;
                    margin-bottom: 30px;
                }
                
                .container-txt {
                    flex-basis: 100%;
                    padding: 30px 20px;
                }
                
                .container-txt h2 {
                    font-size: 28px;
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
                                    <a class="nav-link" href="servicios.jsp">Servicios</a>
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

        <section class="preins-info">
            <div class="container-img">
                <img src="img/ciclo.png" alt="ciclo">
            </div>
            <div class="container-txt">
                <h2>Pre-inscripción</h2>

                <!-- BLOQUE DE MENSAJES -->
                <c:choose>
                    <c:when test="${param.mensaje=='exito'}">
                        <div class="mensaje exito">
                            ✅ Tu solicitud fue enviada. En ~3 días podrás ver tu estado.
                        </div>
                    </c:when>
                    <c:when test="${param.mensaje=='reinscrito'}">
                        <div class="mensaje reinscrito">
                            ℹ️ Te has vuelto a inscribir. Ahora estás de nuevo en revisión.
                        </div>
                    </c:when>
                    <c:when test="${param.mensaje=='ya_en_revision'}">
                        <div class="mensaje revision">
                            ⚠️ Tu solicitud ya está en revisión. Por favor, espera el resultado.
                        </div>
                    </c:when>
                    <c:when test="${param.mensaje=='ya_aceptado'}">
                        <div class="mensaje aceptado">
                            ✅ Ya fuiste aceptado. ¡Bienvenido a bordo!
                        </div>
                    </c:when>
                    <c:when test="${param.mensaje=='existe'}">
                        <div class="mensaje existe">
                            ⚠️ Ya existe una solicitud con ese DNI o correo.
                        </div>
                    </c:when>
                    <c:when test="${param.mensaje=='bloqueado'}">
                        <div class="mensaje bloqueado">
                            🚫 Has superado el número de intentos. Debes esperar la próxima convocatoria.
                        </div>
                    </c:when>
                </c:choose>
                <!-- FIN BLOQUE DE MENSAJES -->

                <form action="RegistrarPreinscripcionServlet" method="POST">
                    <div class="form-group">
                        <label for="nombres">Nombres *</label>
                        <input type="text" id="nombres" name="nombres" placeholder="Ingresa tus nombres" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="apellidos">Apellidos *</label>
                        <input type="text" id="apellidos" name="apellidos" placeholder="Ingresa tus apellidos" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="dni">DNI *</label>
                        <input type="text" id="dni" name="dni" placeholder="Ingresa tu DNI" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="correo">Correo electrónico *</label>
                        <input type="email" id="correo" name="correo" placeholder="Ingresa tu correo" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="telefono">Teléfono *</label>
                        <input type="text" id="telefono" name="telefono" placeholder="Ingresa tu teléfono" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="direccion">Dirección</label>
                        <input type="text" id="direccion" name="direccion" placeholder="Ingresa tu dirección">
                    </div>
                    
                    <div class="form-group">
                        <label for="colegio">Colegio de procedencia</label>
                        <input type="text" id="colegio" name="colegio" placeholder="Ingresa tu colegio">
                    </div>
                    
                    <div class="form-group">
                        <label for="carrera">Carrera de interés *</label>
                        <select id="carrera" name="carrera" required>
                            <option value="">Seleccione carrera</option>
                            <option value="Ingenieria">Ingeniería</option>
                            <option value="Medicina">Medicina</option>
                            <option value="Derecho">Derecho</option>
                        </select>
                    </div>
                    
                    <input type="submit" value="Enviar solicitud" class="btn">
                </form>
            </div>
        </section>

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