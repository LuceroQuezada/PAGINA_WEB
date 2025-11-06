package Controlador;

import DAO.EstudianteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import modelo.MaterialCurso;
import modelo.SeccionInfo;
import modelo.Usuario;

@WebServlet("/Estudiante/Cursos")
public class EstudianteMisCursosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Usuario u = (Usuario) req.getSession().getAttribute("usuario");
        if (u == null) {
            resp.sendRedirect("../login.jsp");
            return;
        }

        EstudianteDAO dao = new EstudianteDAO();
        List<SeccionInfo> secciones = dao.listarSeccionesEstudiante(u.getId());
        req.setAttribute("secciones", secciones);

        String sec = req.getParameter("idSeccion"); 
        if (sec != null && !sec.isEmpty()) {
            int idSec = Integer.parseInt(sec);
            List<MaterialCurso> mats = dao.listarMaterialesPorSeccion(idSec);
            req.setAttribute("materiales", mats);
            req.setAttribute("selectedSeccion", idSec);
        }

        req.getRequestDispatcher("/estudiante/mis-cursos.jsp").forward(req, resp);
    }
}
