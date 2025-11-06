package Controlador;

import DAO.CursoDocenteDAO;
import DAO.MaterialCursoDAO;
import modelo.CursoDocente;
import modelo.MaterialCurso;
import modelo.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/docente/material")
public class MaterialDocenteServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    Usuario docente = (Usuario) req.getSession().getAttribute("usuario");
    if (docente == null || docente.getIdRol() != /* id_rol docente */ 2) {
      resp.sendRedirect(req.getContextPath() + "/login.jsp");
      return;
    }
    

    List<CursoDocente> cursos =
      new CursoDocenteDAO().listarPorDocente(docente.getId());
    req.setAttribute("cursos", cursos);

    String sId = req.getParameter("idCurso");
    if (sId != null && !sId.isEmpty()) {
      int idCurso = Integer.parseInt(sId);
      List<MaterialCurso> mat = 
        new MaterialCursoDAO().listarPorCurso(idCurso);
      req.setAttribute("materiales", mat);
      req.setAttribute("selectedCurso", idCurso);
    }
    

    req.getRequestDispatcher("/docente/material.jsp")
       .forward(req, resp);
  }
}
