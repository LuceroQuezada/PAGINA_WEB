package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;

@WebServlet("/ActualizarAdministradorServlet")
public class ActualizarAdministradorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        Usuario admin = new Usuario();
        admin.setId(id);
        admin.setNombre(nombre);
        admin.setApellido(apellido);
        admin.setCorreo(correo);
        admin.setPassword(password);
        admin.setIdRol(1); 

        UsuarioDAO dao = new UsuarioDAO();
        dao.actualizar(admin);

        response.sendRedirect("ListarAdministradoresServlet");
    }
}
