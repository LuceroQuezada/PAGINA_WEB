package Controlador;

import DAO.*;
import modelo.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.*;

@WebServlet("/Docente/Asistencia")
public class ListarAsistenciaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        Usuario docente = (Usuario) req.getSession().getAttribute("usuario");
        if (docente == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }


        List<CursoDocente> cds = new CursoDocenteDAO()
            .listarPorDocente(docente.getId())
            .stream()
            .filter(cd -> cd.getIdSeccion()>0)
            .collect(Collectors.toList());
        req.setAttribute("secciones", cds);

 
        String secParam = req.getParameter("idSeccion");
        String fechaParam = req.getParameter("fecha");
        LocalDate fecha = (fechaParam != null && !fechaParam.isEmpty())
                         ? LocalDate.parse(fechaParam)
                         : LocalDate.now();
        req.setAttribute("fecha", fecha.toString());

        if (secParam != null && !secParam.isEmpty()) {
            int idSeccion = Integer.parseInt(secParam);

            Seccion sec = new SeccionDAO().obtenerPorId(idSeccion);
            List<Usuario> alumnos = new GrupoEstudianteDAO()
                .listarPorGrupo(sec.getIdGrupo());
            req.setAttribute("alumnos", alumnos);

            List<Asistencia> asis = new AsistenciaDAO()
                .listarPorSeccionYFecha(idSeccion, fecha);
            Map<Integer,Boolean> presentMap = asis.stream()
                .collect(Collectors.toMap(Asistencia::getIdEstudiante,
                                           Asistencia::isPresente));
            req.setAttribute("presentMap", presentMap);
            req.setAttribute("selectedSeccion", idSeccion);
        }


        String mensaje = req.getParameter("mensaje");
        if (mensaje != null) req.setAttribute("mensaje", mensaje);

        req.getRequestDispatcher("/docente/asistencia.jsp")
           .forward(req, resp);
    }
}
