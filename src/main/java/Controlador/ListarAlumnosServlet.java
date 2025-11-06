package Controlador;

import DAO.UsuarioDAO;
import DAO.GrupoDAO;
import modelo.Usuario;
import modelo.Grupo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListarAlumnosServlet", urlPatterns = {"/ListarAlumnosServlet"})
public class ListarAlumnosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    private GrupoDAO grupoDAO = new GrupoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("🔍 GET recibido en ListarAlumnosServlet");
        

        String carrera = request.getParameter("carrera");
        System.out.println("📋 Carrera filtrada: " + carrera);
        

        HttpSession session = request.getSession();
        String mensajeExito = (String) session.getAttribute("mensajeExito");
        String mensajeError = (String) session.getAttribute("mensajeError");

        if (mensajeExito != null) {
            request.setAttribute("mensajeExito", mensajeExito);
            session.removeAttribute("mensajeExito");
            System.out.println("✅ Mensaje de éxito recuperado de sesión: " + mensajeExito);
        }
        
        if (mensajeError != null) {
            request.setAttribute("mensajeError", mensajeError);
            session.removeAttribute("mensajeError");
            System.out.println("❌ Mensaje de error recuperado de sesión: " + mensajeError);
        }
        
  
        List<Usuario> alumnos;
        if (carrera != null && !carrera.trim().isEmpty()) {
            System.out.println("🔍 Buscando alumnos sin grupo para carrera: " + carrera);
            alumnos = usuarioDAO.listarAlumnosSinGrupoPorCarrera(carrera);
        } else {
            System.out.println("🔍 Buscando todos los alumnos sin grupo");
            alumnos = usuarioDAO.listarAlumnosSinGrupo();
        }
        
     
        List<Grupo> gruposDisponibles = null;
        if (carrera != null && !carrera.trim().isEmpty()) {
            System.out.println("🔍 Buscando grupos disponibles para carrera: " + carrera);
            gruposDisponibles = grupoDAO.obtenerGruposPorCarrera(carrera);
            System.out.println("📋 Grupos encontrados: " + (gruposDisponibles != null ? gruposDisponibles.size() : 0));
        }
        
        System.out.println("👥 Alumnos SIN grupo encontrados: " + alumnos.size());
        

        request.setAttribute("alumnos", alumnos);
        request.setAttribute("selectedCarrera", carrera);
        request.setAttribute("gruposDisponibles", gruposDisponibles);

        System.out.println("🔄 Forwarding a admin/alumnos.jsp");
        request.getRequestDispatcher("admin/alumnos.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("🔄 POST recibido en ListarAlumnosServlet - Redirigiendo a GET");
        doGet(request, response);
    }
}