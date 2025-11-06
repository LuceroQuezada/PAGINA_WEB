package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;
import java.util.List;

@WebServlet("/ListarAdministradoresServlet")
public class ListarAdministradoresServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> listaAdministradores = dao.obtenerPorRol(1); // 1 = Administrador

        request.setAttribute("listaAdministradores", listaAdministradores);

        String mensaje = request.getParameter("mensaje");
        if (mensaje != null) {
            request.setAttribute("mensaje", mensaje);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/administradores.jsp");
        dispatcher.forward(request, response);
    }
}

