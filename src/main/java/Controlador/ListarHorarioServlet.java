// Controlador/ListarHorarioServlet.java
package Controlador;

import DAO.CursoDocenteDAO;
import DAO.HorarioDAO;
import modelo.CursoDocente;
import modelo.Horario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/ListarHorario")
public class ListarHorarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

  
        String filtroCarrera = request.getParameter("filtroCarrera");


        CursoDocenteDAO cdDao = new CursoDocenteDAO();
        List<CursoDocente> listaCD;
        if (filtroCarrera != null && !filtroCarrera.isEmpty()) {
            listaCD = cdDao.listarPorCarrera(filtroCarrera);
        } else {
            listaCD = cdDao.listar();
        }


        HorarioDAO hDao = new HorarioDAO();
        List<Horario> listaH = hDao.listar();


        request.setAttribute("selectedCarrera", filtroCarrera);
        request.setAttribute("listaCD", listaCD);
        request.setAttribute("listaH", listaH);
        request.getRequestDispatcher("/admin/horario.jsp")
               .forward(request, response);
    }
}

