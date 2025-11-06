package Controlador;

import DAO.CursoDocenteDAO;
import DAO.GrupoEstudianteDAO;
import DAO.NotaDAO;
import DAO.SeccionDAO;
import modelo.CursoDocente;
import modelo.Nota;
import modelo.Seccion;
import modelo.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.*;

@WebServlet("/Docente/Calificar")
public class ListarNotasServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    Usuario docente = (Usuario) req.getSession().getAttribute("usuario");
    if (docente==null) {
      resp.sendRedirect(req.getContextPath()+"/login.jsp");
      return;
    }

    List<CursoDocente> cds = new CursoDocenteDAO()
        .listarPorDocente(docente.getId());
    req.setAttribute("secciones", cds);    
    String secParam = req.getParameter("idSeccion");
    if (secParam!=null && !secParam.isEmpty()) {
      int idSeccion = Integer.parseInt(secParam);
      Seccion sec = new SeccionDAO().obtenerPorId(idSeccion);  
      List<Usuario> alumnos = new GrupoEstudianteDAO()
          .listarPorGrupo(sec.getIdGrupo());
      req.setAttribute("alumnos", alumnos);      
      List<Nota> notas = new NotaDAO().listarPorSeccion(idSeccion);
      Map<Integer,Nota> mapa = notas.stream()
          .collect(Collectors.toMap(Nota::getIdEstudiante, n->n));
      req.setAttribute("notaMap", mapa);
      req.setAttribute("selectedSeccion", idSeccion);
    }


    String msg = req.getParameter("mensaje");
    if (msg!=null) req.setAttribute("mensaje", msg);

    req.getRequestDispatcher("/docente/calificar.jsp")
       .forward(req, resp);
  }
}
