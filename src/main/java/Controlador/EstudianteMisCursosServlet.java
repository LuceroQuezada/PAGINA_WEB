package Controlador;

import DAO.EstudianteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
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

        req.getRequestDispatcher("/estudiante/mis-cursos.jsp").forward(req, resp);
    }
}
