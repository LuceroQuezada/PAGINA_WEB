package Controlador;


import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AsignarGrupoServlet", urlPatterns = {"/AsignarGrupoServlet"})
public class AsignarGrupoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String carrera = request.getParameter("carrera");
        String idGrupoStr = request.getParameter("idGrupo");
        String[] seleccionados = request.getParameterValues("idEstudiantes");

        if (carrera == null || idGrupoStr == null || seleccionados == null) {
            request.setAttribute("mensajeError", "Seleccione estudiantes y un grupo.");
            request.getRequestDispatcher("ListarAlumnosServlet?carrera=" + carrera).forward(request, response);
            return;
        }

        try {
            int idGrupo = Integer.parseInt(idGrupoStr);
            List<Integer> ids = new ArrayList<>();
            for (String s : seleccionados) ids.add(Integer.parseInt(s));

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            boolean asignados = usuarioDAO.asignarEstudiantesAGrupoBulk(idGrupo, ids);

            if (asignados) {
                request.setAttribute("mensajeExito", ids.size() + " estudiantes asignados exitosamente.");
            } else {
                request.setAttribute("mensajeError", "Error al asignar estudiantes.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("mensajeError", "Datos inválidos.");
        }

        request.getRequestDispatcher("ListarAlumnosServlet?carrera=" + carrera).forward(request, response);
    }
}
