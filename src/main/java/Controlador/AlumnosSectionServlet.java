package Controlador;

import DAO.UsuarioDAO;
import modelo.Usuario;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/AlumnosSectionServlet")
public class AlumnosSectionServlet extends HttpServlet {
  private UsuarioDAO dao = new UsuarioDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    req.getRequestDispatcher("/admin/alumnos.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String carrera = req.getParameter("carrera");
    int secciones = Integer.parseInt(req.getParameter("secciones"));

    List<Usuario> lista = dao.listarAlumnosPorCarrera(carrera);
    int total = lista.size();

    Map<String,List<Usuario>> sectionMap = new LinkedHashMap<>();
    char inicial = carrera.substring(0,1).toUpperCase().charAt(0);
    int base = total / secciones;
    int resto = total % secciones;
    int idx = 0;
    for(int s=1; s<=secciones; s++){
      int count = base + (resto>0 ? 1:0);
      resto = Math.max(0, resto-1);
      List<Usuario> sub = new ArrayList<>();
      for(int j=0;j<count && idx<total;j++){
        sub.add(lista.get(idx++));
      }
      sectionMap.put(inicial+""+s, sub);
    }

    req.setAttribute("alumnos", lista);
    req.setAttribute("carreraSel", carrera);
    req.setAttribute("totalAlumnos", total);
    req.setAttribute("sectionMap", sectionMap);
    req.getRequestDispatcher("/admin/alumnos.jsp").forward(req, resp);
  }
}
