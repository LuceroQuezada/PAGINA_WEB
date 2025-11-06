package Controlador;

import DAO.SeccionDAO;
import DAO.HorarioDAO;
import DAO.CursoDocenteDAO;
import modelo.Seccion;
import modelo.Horario;
import modelo.CursoDocente;
import modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/EstudiantesSeccion")
public class ListarEstudiantesSeccionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Usuario docente = session != null 
            ? (Usuario) session.getAttribute("usuario") 
            : null;
        if (docente == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }


        List<CursoDocente> cds = new CursoDocenteDAO()
            .listarPorDocente(docente.getId());
        Set<Integer> cdIds = cds.stream()
            .map(CursoDocente::getId)
            .collect(Collectors.toSet());
        List<Horario> horarios = new HorarioDAO().listar();
        // filtramos horarios de este profe
        List<Horario> misHorarios = new ArrayList<>();
        for (Horario h: horarios) {
            if (cdIds.contains(h.getIdCursoDocente())) {
                misHorarios.add(h);
            }
        }

        SeccionDAO secDao = new SeccionDAO();
        List<Seccion> secciones = secDao.listar().stream()
            .filter(s -> misHorarios.stream()
                             .anyMatch(h -> h.getId() == s.getIdHorario()))
            .collect(Collectors.toList());


        String secParam = req.getParameter("idSeccion");
        List<Usuario> alumnos = Collections.emptyList();
        if (secParam != null && !secParam.isEmpty()) {
            try {
                int idSec = Integer.parseInt(secParam);
   
                alumnos = secDao.listarEstudiantesPorSeccion(idSec);
            } catch (NumberFormatException e) {
     
            }
        }


        req.setAttribute("listaSecciones", secciones);
        req.setAttribute("selectedSeccion", secParam);
        req.setAttribute("listaEstudiantes", alumnos);
        req.getRequestDispatcher("/docente/estudiantes_seccion.jsp")
           .forward(req, resp);
    }
}
