package Controlador;

import DAO.CursoDocenteDAO;
import modelo.CursoDocente;
import modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/MiHorario")
public class ListarMiHorarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
      
        Usuario docente = (Usuario) req.getSession().getAttribute("usuario");
        if (docente == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
       
        List<CursoDocente> horario = new CursoDocenteDAO()
            .listarPorDocente(docente.getId());
        req.setAttribute("listaHorario", horario);
     
        req.getRequestDispatcher("/docente/mi_horario.jsp")
           .forward(req, resp);
    }
}
