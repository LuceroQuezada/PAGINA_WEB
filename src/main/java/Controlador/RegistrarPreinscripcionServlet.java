package Controlador;

import DAO.PreinscripcionDAO;
import modelo.Preinscripcion;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegistrarPreinscripcionServlet")
public class RegistrarPreinscripcionServlet extends HttpServlet {
    private PreinscripcionDAO dao = new PreinscripcionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
   
        String nombres   = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String correo    = request.getParameter("correo");
        String dni       = request.getParameter("dni");
        String telefono  = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String colegio   = request.getParameter("colegio");
        String carrera   = request.getParameter("carrera");

       
        String estadoActual = dao.obtenerEstadoPorDni(dni);
      
        int intentos = dao.getIntentos(dni);

   
        switch (estadoActual) {
            case "no_encontrado":
               
                dao.guardar(new Preinscripcion(
                    nombres, apellidos, correo, dni, telefono, direccion, colegio, carrera
                ));
                response.sendRedirect("preins.jsp?mensaje=exito");
                break;

            case "rechazado":
            case "cancelado":
                if (intentos < 2) {
                  
                    dao.guardar(new Preinscripcion(
                        nombres, apellidos, correo, dni, telefono, direccion, colegio, carrera
                    ));
                    dao.incrementarIntentos(dni);  
                    response.sendRedirect("preins.jsp?mensaje=reinscrito");
                } else {
                  
                    response.sendRedirect("preins.jsp?mensaje=bloqueado");
                }
                break;

            case "pendiente":
              
                response.sendRedirect("preins.jsp?mensaje=ya_en_revision");
                break;

            case "aceptado":
              
                response.sendRedirect("preins.jsp?mensaje=ya_aceptado");
                break;

            default:
            
                response.sendRedirect("preins.jsp?mensaje=error");
        }
    }
}
