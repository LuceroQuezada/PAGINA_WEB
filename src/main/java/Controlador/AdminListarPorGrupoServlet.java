package Controlador;

import DAO.AdminSeccionDAO;
import DAO.GrupoEstudianteDAO;
import modelo.SeccionInfo;
import modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/admin/EstudiantesPorGrupo")
public class AdminListarPorGrupoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
        // 1) Validar sesión Admin (igual que antes)
        Usuario admin = (Usuario) req.getSession().getAttribute("usuario");
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<modelo.Grupo> grupos = new DAO.GrupoDAO().listarGrupos();
        req.setAttribute("grupos", grupos);
        String gparam = req.getParameter("idGrupo");
        if (gparam != null && !gparam.isEmpty()) {
            int idGrupo = Integer.parseInt(gparam);


            List<SeccionInfo> secciones = new AdminSeccionDAO()
                .listarSeccionesCompletas()     // trae TODO
                .stream()
                .filter(s -> s.getIdGrupo()==idGrupo)
                .toList();
            req.setAttribute("secciones", secciones);

            List<Usuario> alumnos = new GrupoEstudianteDAO()
                .listarPorGrupo(idGrupo);
            req.setAttribute("alumnos", alumnos);

            req.setAttribute("selectedGrupo", idGrupo);
        }

        req.getRequestDispatcher("/admin/estudiantes_por_grupo.jsp")
           .forward(req, resp);
    }
}
