package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;

@WebServlet("/RegistrarDocenteServlet")
public class RegistrarDocenteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();

        if (dao.existeCorreo(correo)) {
       
            response.sendRedirect("ListarDocentesServlet?mensaje=existe");
        } else {
            try {
                Usuario docente = new Usuario();
                docente.setNombre(nombre);
                docente.setApellido(apellido);
                docente.setCorreo(correo);
                docente.setPassword(password);
                docente.setIdRol(2); // Rol 2 = Docente

                dao.insertar(docente);
              
                response.sendRedirect("ListarDocentesServlet?mensaje=exito");
            } catch (Exception e) {
                response.sendRedirect("ListarDocentesServlet?mensaje=error");
            }
        }
    }
}


