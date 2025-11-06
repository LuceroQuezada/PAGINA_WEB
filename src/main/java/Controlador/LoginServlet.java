package Controlador;

import DAO.UsuarioDAO;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo").toLowerCase().trim();
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.login(correo, password);

       if (usuario != null) {

    HttpSession session = request.getSession();
    session.setAttribute("usuario", usuario);

    String nombreRol = dao.obtenerNombreRol(usuario.getIdRol());
    session.setAttribute("nombreRol", nombreRol);
    

    switch (nombreRol) {
        case "administrador":
            response.sendRedirect("admin/panel.jsp");
            break;
        case "docente":
            response.sendRedirect("docente/panel.jsp");
            break;
        case "estudiante":
            response.sendRedirect("estudiante/panel.jsp");
            break;
        default:
            session.invalidate();
            response.sendRedirect("login.jsp?error=rol");
    }
}
    }
}
