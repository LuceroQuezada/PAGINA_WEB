
package Controlador;

import DAO.CursoDocenteDAO;
import modelo.CursoDocente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegistrarCursoDocente")
public class RegistrarCursoDocenteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        int idCurso    = Integer.parseInt(request.getParameter("idCurso"));
        int idDocente  = Integer.parseInt(request.getParameter("idDocente"));
        String filtro  = request.getParameter("filtroCarrera");

        CursoDocenteDAO dao = new CursoDocenteDAO();

        
        int asignados = dao.contarPorDocente(idDocente);
        if (asignados >= 3) {
            request.setAttribute("error",
              "Este docente ya tiene asignados " + asignados + " cursos (máximo 3).");
            forwardConDatos(request, response);
            return;
        }

       
        if (dao.existeAsignacion(idCurso, idDocente)) {
            request.setAttribute("error",
              "Este curso ya está asignado a este docente.");
            forwardConDatos(request, response);
            return;
        }

       
        CursoDocente cd = new CursoDocente();
        cd.setIdCurso(idCurso);
        cd.setIdDocente(idDocente);
        dao.insertar(cd);

        
        String redirect = "ListarCursoDocente";
        if (filtro != null && !filtro.trim().isEmpty()) {
            redirect += "?filtroCarrera=" + filtro;
        }
        response.sendRedirect(request.getContextPath() + "/" + redirect);
    }

   
    private void forwardConDatos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        new ListarCursoDocenteServlet().doGet(request, response);
    }
}

