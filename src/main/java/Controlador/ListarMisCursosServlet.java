package Controlador;

import DAO.CursoDocenteDAO;
import modelo.CursoDocente;
import modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/MisCursos")
public class ListarMisCursosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Usuario user = (Usuario) req.getSession().getAttribute("usuario");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
       
        List<CursoDocente> lista = new CursoDocenteDAO()
            .listarPorDocente(user.getId());
        req.setAttribute("listaMisCursos", lista);
        req.getRequestDispatcher("/docente/mis_cursos.jsp")
           .forward(req, resp);
    }
}
