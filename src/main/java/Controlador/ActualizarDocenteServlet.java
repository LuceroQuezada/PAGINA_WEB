package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import modelo.Usuario;
import java.io.IOException;

@WebServlet("/ActualizarDocenteServlet")
public class ActualizarDocenteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Usuario docente = new Usuario();
        docente.setId(id);
        docente.setCorreo(request.getParameter("correo"));
        docente.setPassword(request.getParameter("password"));
        docente.setNombre(request.getParameter("nombre"));
        docente.setApellido(request.getParameter("apellido"));
        docente.setIdRol(2);

        UsuarioDAO dao = new UsuarioDAO();
        dao.actualizar(docente);
        response.sendRedirect("ListarDocentesServlet");
    }
}
