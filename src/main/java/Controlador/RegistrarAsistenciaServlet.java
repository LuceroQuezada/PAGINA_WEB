package Controlador;

import DAO.AsistenciaDAO;
import modelo.Asistencia;
import modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Arrays;

@WebServlet("/Docente/RegistrarAsistencia")
public class RegistrarAsistenciaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        Usuario docente = (Usuario) req.getSession().getAttribute("usuario");
        if (docente == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String idSecParam = req.getParameter("idSeccion");
        String fechaParam = req.getParameter("fecha");
        if (idSecParam == null || idSecParam.isEmpty() ||
            fechaParam == null || fechaParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/Docente/Asistencia?mensaje=ParametrosInvalidos");
            return;
        }

        int idSeccion = Integer.parseInt(idSecParam);
        LocalDate fecha = LocalDate.parse(fechaParam);
        LocalDate hoy = LocalDate.now();

      
        if (fecha.isBefore(hoy) || fecha.isAfter(hoy)) {
            resp.sendRedirect(req.getContextPath()
                + "/Docente/Asistencia?idSeccion=" + idSeccion
                + "&fecha=" + hoy.toString()
                + "&mensaje=FechaInvalida");
            return;
        }

        String[] estudiantes = req.getParameterValues("estudiantes[]");
        if (estudiantes == null || estudiantes.length == 0) {
            resp.sendRedirect(req.getContextPath()
                + "/Docente/Asistencia?idSeccion=" + idSeccion
                + "&fecha=" + fecha.toString()
                + "&mensaje=NoHayEstudiantes");
            return;
        }

        AsistenciaDAO dao = new AsistenciaDAO();
        Arrays.stream(estudiantes).forEach(sid -> {
            int idEst = Integer.parseInt(sid);
            boolean pres = req.getParameter("asist_" + idEst) != null;

            System.out.println("✔ Guardando asistencia → Est: " + idEst + " Presente: " + pres);

            Asistencia a = new Asistencia();
            a.setIdSeccion(idSeccion);
            a.setIdEstudiante(idEst);
            a.setFecha(fecha);
            a.setPresente(pres);

            dao.listarPorSeccionYFecha(idSeccion, fecha)
               .stream()
               .filter(x -> x.getIdEstudiante()==idEst)
               .findFirst()
               .ifPresentOrElse(
                  existing -> dao.actualizar(a),
                  ()       -> dao.insertar(a)
               );
        });

        resp.sendRedirect(req.getContextPath()
            + "/Docente/Asistencia?idSeccion=" + idSeccion
            + "&fecha=" + fecha.toString()
            + "&mensaje=exito");
    }
}
