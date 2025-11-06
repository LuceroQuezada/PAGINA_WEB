
package Controlador;
import DAO.PreinscripcionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.Preinscripcion;




@WebServlet("/listarAceptados")
public class ListarAceptadosServlet extends HttpServlet {
    private PreinscripcionDAO dao = new PreinscripcionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Preinscripcion> lista = dao.listarPorEstado("aceptado");
        req.setAttribute("listaAceptados", lista);
        req.getRequestDispatcher("/admin/aceptados.jsp").forward(req, resp);
    }
}
