package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/rechazarPreinscripcion")
public class RechazarPreinscripcionServlet extends HttpServlet {
    private PreinscripcionDAO dao = new PreinscripcionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String dni = request.getParameter("dni");
        if (dni != null && !dni.isBlank()) {
            dao.actualizarEstado(dni, "rechazado");
        }

        response.sendRedirect("listarPendientes");
    }
}
