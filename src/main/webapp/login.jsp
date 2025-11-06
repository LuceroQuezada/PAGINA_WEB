<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="es" /> 
<fmt:setBundle basename="mensajes" />
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title><fmt:message key="titulo.intranet" /></title>
    <link rel="icon" type="image/png" href="img/LOGOS.png" />
    <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #e8f0ff 0%, #f0f4ff 100%);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        
        .main-container {
            display: flex;
            min-height: 100vh;
            align-items: center;
            justify-content: center;
            padding: 20px;
            gap: 60px;
        }
        
        .left-section {
            flex: 1;
            max-width: 600px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
        }
        
        .right-section {
            width: 550px;
            padding: 50px 50px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
        }
        
        .illustration {
            max-width: 100%;
            height: auto;
            margin-bottom: 30px;
        }
        
        .brand-logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            justify-content: center;
        }
        
        .brand-logo .logo-box {
            background: #000;
            color: white;
            padding: 8px 12px;
            border-radius: 6px;
            font-weight: bold;
            font-size: 18px;
            margin-right: 8px;
        }
        
        .brand-logo .plus-class {
            color: #ff1744;
            font-weight: bold;
            font-size: 18px;
        }
        
        .brand-title {
            font-size: 26px;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 8px;
            text-align: center;
        }
        
        .brand-subtitle {
            color: #666;
            font-size: 16px;
            margin-bottom: 40px;
            text-align: center;
        }
        
        .login-prompt {
            color: #666;
            margin-bottom: 8px;
            font-size: 14px;
            text-align: center;
        }
        
        .login-prompt a {
            color: #1976d2;
            text-decoration: none;
        }
        
        .form-label {
            color: #333;
            font-weight: 500;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 16px 20px;
            font-size: 15px;
            width: 100%;
            margin-bottom: 4px;
            transition: border-color 0.2s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #1976d2;
            box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
        }
        
        .user-example {
            display: flex;
            align-items: center;
            color: #666;
            font-size: 12px;
            margin-bottom: 24px;
        }
        
        .user-example i {
            margin-right: 6px;
            font-size: 14px;
        }
        
        .password-field {
            position: relative;
            margin-bottom: 16px;
        }
        
        .password-toggle {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #666;
            cursor: pointer;
            padding: 0;
            font-size: 16px;
        }
        
        .forgot-password {
            text-align: right;
            margin-bottom: 32px;
        }
        
        .forgot-password a {
            color: #1976d2;
            text-decoration: none;
            font-size: 14px;
        }
        
        .btn-login {
            background: #1976d2;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 16px;
            font-size: 16px;
            font-weight: 500;
            width: 100%;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .btn-login:hover {
            background: #1565c0;
        }
        
        .alert {
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 20px;
            border: none;
        }
        
        .alert-danger {
            background: #ffebee;
            color: #c62828;
        }
        
        .alert-warning {
            background: #fff8e1;
            color: #f57c00;
        }
        
        @media (max-width: 1024px) {
            .main-container {
                gap: 40px;
            }
            
            .right-section {
                width: 480px;
            }
        }
        
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                gap: 20px;
            }
            
            .left-section {
                padding: 20px;
                max-width: 100%;
            }
            
            .right-section {
                width: 100%;
                max-width: 450px;
                margin: 0;
                padding: 40px 30px;
            }
        }
        
        @media (max-width: 480px) {
            .right-section {
                padding: 30px 20px;
            }
            
            .brand-title {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="left-section">

            <img src="img/login.jpg" alt="Ilustración de estudiantes" class="illustration">
        </div>
        
        <div class="right-section">
            <div class="brand-logo">
                <span class="logo-box">ACADEMIA</span>
                <span class="plus-class">A1</span>
            </div>
            
            <h1 class="brand-title">La nueva experiencia digital de aprendizaje</h1>
            <p class="brand-subtitle">Cercana, dinámica y flexible</p>
            
            <c:if test="${param.error == 'credenciales'}">
                <div class="alert alert-danger">
                    <fmt:message key="error.credenciales" />
                </div>
            </c:if>
            <c:if test="${param.error == 'rol'}">
                <div class="alert alert-warning">
                    <fmt:message key="error.rol" />
                </div>
            </c:if>
            
            <p class="login-prompt">Ingresa tus datos para <a href="#">iniciar sesión</a>.</p>
            
            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo</label>
                    <input type="email" class="form-control" id="correo" name="correo" required placeholder="Ingresa tu usuario" />
                    <div class="user-example">
                        <i class="fas fa-info-circle"></i>
                       
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Contraseña</label>
                    <div class="password-field">
                        <input type="password" class="form-control" id="password" name="password" required placeholder="Ingresa tu contraseña" />
                        <button type="button" class="password-toggle" onclick="togglePassword()">
                            <i class="fas fa-eye" id="passwordIcon"></i>
                        </button>
                    </div>
                </div>
                
            
                
                <button type="submit" class="btn-login">
                    Iniciar sesión
                </button>
            </form>
        </div>
    </div>
    
    <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const passwordIcon = document.getElementById('passwordIcon');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                passwordIcon.className = 'fas fa-eye-slash';
            } else {
                passwordField.type = 'password';
                passwordIcon.className = 'fas fa-eye';
            }
        }
    </script>
</body>
</html>