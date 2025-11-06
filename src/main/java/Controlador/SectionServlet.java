
package Controlador;

import DAO.UsuarioDAO;
import modelo.Usuario;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/secciones")
public class SectionServlet extends HttpServlet {
    private UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String carrera = req.getParameter("carrera");
        String numStr  = req.getParameter("numSecciones");
        if (carrera == null || numStr == null) {
            resp.sendRedirect("admin/secciones.jsp?error=param");
            return;
        }

        int num;
        try {
            num = Integer.parseInt(numStr);
            if (num < 1) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            resp.sendRedirect("admin/secciones.jsp?error=num");
            return;
        }


        List<Usuario> alumnos = dao.listarAlumnosPorCarrera(carrera);
        int total = alumnos.size();


        int base = total / num;
        int resto = total % num;
        Map<String,List<Usuario>> secciones = new LinkedHashMap<>();
        int idx = 0;
        char pref = carrera.charAt(0); 

        for (int i = 1; i <= num; i++) {
            int tamaño = base + (i <= resto ? 1 : 0);
            List<Usuario> sub = new ArrayList<>();
            for (int j = 0; j < tamaño && idx < total; j++, idx++) {
                sub.add(alumnos.get(idx));
            }
            secciones.put("" + pref + i, sub);
        }

 
        req.setAttribute("secciones", secciones);
        req.setAttribute("total", total);
        req.setAttribute("carrera", carrera);
        req.getRequestDispatcher("/admin/secciones.jsp").forward(req, resp);
    }
}
