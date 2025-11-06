package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/desbloquearPreinscripcion")
public class DesbloquearPreinscripcionServlet extends HttpServlet {
    private PreinscripcionDAO dao = new PreinscripcionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String dni = req.getParameter("dni");
        if (dni != null && !dni.isBlank()) {

            dao.actualizarEstado(dni, "pendiente");

            dao.resetIntentos(dni);
        }

        resp.sendRedirect("listarRechazados");
    }
}
