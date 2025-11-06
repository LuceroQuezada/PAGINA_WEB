package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/ConsultarEstadoServlet")
public class ConsultarEstadoServlet extends HttpServlet {
    private PreinscripcionDAO dao = new PreinscripcionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dni    = request.getParameter("dni");
        String estado = dao.obtenerEstadoPorDni(dni);
        request.setAttribute("estado", estado);
        request.getRequestDispatcher("estadoPreinscripcion.jsp").forward(request, response);
    }
}
