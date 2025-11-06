package Controlador;
import DAO.CursoDAO;
import DAO.CursoDocenteDAO;
import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.Curso;
import modelo.CursoDocente;
import modelo.Usuario;

@WebServlet("/ListarCursoDocente")
public class ListarCursoDocenteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filtroCarrera = request.getParameter("filtroCarrera");


        CursoDAO cursoDao = new CursoDAO();
        List<Curso> listaCursos;
        if (filtroCarrera != null && !filtroCarrera.trim().isEmpty()) {
            listaCursos = cursoDao.listarPorCarrera(filtroCarrera);
        } else {
            listaCursos = cursoDao.listar();
        }


        CursoDocenteDAO cdDao = new CursoDocenteDAO();
        List<CursoDocente> listaCD = cdDao.listar();
        UsuarioDAO usuarioDao = new UsuarioDAO();
        List<Usuario> listaDocentes = usuarioDao.obtenerPorRol(2);


        request.setAttribute("selectedCarrera", filtroCarrera);
        request.setAttribute("listaCursos", listaCursos);
        request.setAttribute("listaDocentes", listaDocentes);
        request.setAttribute("listaCD", listaCD);

        request.getRequestDispatcher("/admin/curso_docente.jsp")
               .forward(request, response);
    }
}
