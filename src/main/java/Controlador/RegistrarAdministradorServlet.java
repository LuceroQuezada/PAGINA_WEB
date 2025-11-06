package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;

@WebServlet("/RegistrarAdministradorServlet")
public class RegistrarAdministradorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();

        if (dao.existeCorreo(correo)) {
           
            response.sendRedirect("ListarAdministradoresServlet?mensaje=existe");
        } else {
            try {
                Usuario admin = new Usuario();
                admin.setNombre(nombre);
                admin.setApellido(apellido);
                admin.setCorreo(correo);
                admin.setPassword(password);
                admin.setIdRol(1); 

                dao.insertar(admin);
                response.sendRedirect("ListarAdministradoresServlet?mensaje=exito");
            } catch (Exception e) {
                response.sendRedirect("ListarAdministradoresServlet?mensaje=error");
            }
        }
    }
}
