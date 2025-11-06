package Controlador;

import DAO.EstudianteDAO;
import modelo.Asistencia;
import modelo.SeccionInfo;
import modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Estudiante/Asistencia")
public class EstudianteMisAsistenciaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        Usuario est = (Usuario) req.getSession().getAttribute("usuario");
        if (est == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        EstudianteDAO dao = new EstudianteDAO();


        List<SeccionInfo> secciones = dao.listarSeccionesEstudiante(est.getId());
        req.setAttribute("secciones", secciones);


        String secParam = req.getParameter("idSeccion");
        if (secParam != null && !secParam.isEmpty()) {
            int idSeccion = Integer.parseInt(secParam);
            List<Asistencia> asistencias =
                dao.listarAsistenciaEstudiante(idSeccion, est.getId());
            req.setAttribute("asistencias", asistencias);
            req.setAttribute("selectedSeccion", idSeccion);
        }

        req.getRequestDispatcher("/estudiante/mis-asistencia.jsp")
           .forward(req, resp);
    }
}
