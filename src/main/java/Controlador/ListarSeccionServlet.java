package Controlador;

import DAO.GrupoDAO;
import DAO.HorarioDAO;
import DAO.SeccionDAO;
import modelo.Grupo;
import modelo.Horario;
import modelo.Seccion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListarSeccion")
public class ListarSeccionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SeccionDAO sDao = new SeccionDAO();
        List<Seccion> listaS;
        String filtro = request.getParameter("filtroGrupo");
        if (filtro != null && !filtro.isEmpty()) {
            int idGrupoFiltro = Integer.parseInt(filtro);
            listaS = sDao.listarPorGrupo(idGrupoFiltro);
            request.setAttribute("selectedGrupo", idGrupoFiltro);
        } else {
            listaS = sDao.listar();
        }

        HorarioDAO hDao = new HorarioDAO();
        List<Horario> listaH = hDao.listar();

        GrupoDAO gDao = new GrupoDAO();
        List<Grupo> listaG = gDao.listarGrupos();

        request.setAttribute("listaS", listaS);
        request.setAttribute("listaH", listaH);
        request.setAttribute("listaG", listaG);

        request.getRequestDispatcher("/admin/seccion.jsp")
               .forward(request, response);
    }
}
