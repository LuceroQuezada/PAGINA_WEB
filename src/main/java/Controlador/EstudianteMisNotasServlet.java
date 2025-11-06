package Controlador;

import DAO.EstudianteDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import modelo.Usuario;

@WebServlet("/Estudiante/MisNotas")
public class EstudianteMisNotasServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Usuario est = (Usuario) req.getSession().getAttribute("usuario");
        if (est == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        EstudianteDAO dao = new EstudianteDAO();
        List<Map<String,Object>> secciones = 
            dao.listarSeccionesConNotas(est.getId());
        req.setAttribute("secciones", secciones);

        req.getRequestDispatcher("/estudiante/mis-notas.jsp")
           .forward(req, resp);
    }
}
