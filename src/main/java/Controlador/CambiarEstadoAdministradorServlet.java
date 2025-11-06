package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/CambiarEstadoAdministradorServlet")
public class CambiarEstadoAdministradorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int estadoActual = Integer.parseInt(request.getParameter("estado")); 
        // 1 = act, 0 = bloqu

        UsuarioDAO dao = new UsuarioDAO();
        int nuevoEstado = (estadoActual == 1) ? 0 : 1;

        if (dao.cambiarEstado(id, nuevoEstado)) {
            response.sendRedirect("ListarAdministradoresServlet?mensaje=estado_cambiado");
        } else {
            response.sendRedirect("ListarAdministradoresServlet?mensaje=error_estado");
        }
    }
}
