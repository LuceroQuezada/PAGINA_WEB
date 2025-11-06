package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CambiarEstadoAlumnoServlet")
public class CambiarEstadoAlumnoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int estado = Integer.parseInt(request.getParameter("estado")); // 0 o 1

        UsuarioDAO dao = new UsuarioDAO();
        boolean exito = dao.cambiarEstado(id, estado);

        if (exito) {
            response.sendRedirect("ListarAlumnosServlet?mensaje=estado_cambiado");
        } else {
            response.sendRedirect("ListarAlumnosServlet?mensaje=error_estado");
        }
    }
}
