
package Controlador;

import DAO.CursoDocenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/EliminarCursoDocente")
public class EliminarCursoDocenteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String idParam = request.getParameter("id");
        String filtro  = request.getParameter("filtroCarrera");  // <-- filtro opcional

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                new CursoDocenteDAO().eliminar(id);
            } catch (NumberFormatException e) {
               
            }
        }

     
        String redirect = request.getContextPath() + "/ListarCursoDocente";
        if (filtro != null && !filtro.trim().isEmpty()) {
            redirect += "?filtroCarrera=" + filtro;
        }
        response.sendRedirect(redirect);
    }
}
