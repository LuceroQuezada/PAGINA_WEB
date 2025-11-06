package Controlador;

import DAO.PreinscripcionDAO;
import modelo.Preinscripcion;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/listarPendientes")
public class ListarPendientesServlet extends HttpServlet {
    private PreinscripcionDAO dao = new PreinscripcionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Preinscripcion> lista = dao.listarPorEstado("pendiente");
        req.setAttribute("listaPendientes", lista);
        req.getRequestDispatcher("/admin/pendientes.jsp").forward(req, resp);
    }
}
