package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import modelo.Usuario;

@WebServlet("/ListarDocentesServlet")
public class ListarDocentesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> docentes = dao.obtenerPorRol(2); 

        request.setAttribute("docentes", docentes);
        request.getRequestDispatcher("admin/docentes.jsp").forward(request, response);
    }
}
