package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;

@WebServlet("/EditarAdministradorServlet")
public class EditarAdministradorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        UsuarioDAO dao = new UsuarioDAO();
        Usuario admin = dao.obtenerPorId(id);

        request.setAttribute("admin", admin);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/editarAdministrador.jsp");
        dispatcher.forward(request, response);
    }
}
