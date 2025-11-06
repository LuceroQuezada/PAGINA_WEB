
package Controlador;

import DAO.SeccionDAO;
import modelo.Seccion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegistrarSeccion")
public class RegistrarSeccionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idHParam = req.getParameter("idHorario");
        String nombre   = req.getParameter("nombre");
        String idGParam = req.getParameter("idGrupo");
        String filtro   = req.getParameter("filtroGrupo");

        // 1) Validar no nulos ni vacíos
        if (idHParam == null || idHParam.trim().isEmpty() ||
            nombre   == null || nombre.trim().isEmpty()   ||
            idGParam == null || idGParam.trim().isEmpty()) {
            errorYForward(req, resp, filtro, "Todos los campos son requeridos.");
            return;
        }

        int idHorario, idGrupo;
        try {
            idHorario = Integer.parseInt(idHParam);
            idGrupo   = Integer.parseInt(idGParam);
        } catch (NumberFormatException ex) {
            errorYForward(req, resp, filtro, "IDs inválidos.");
            return;
        }


        SeccionDAO dao = new SeccionDAO();
        if (!"A".equals(nombre) && !"B".equals(nombre)) {
            errorYForward(req, resp, filtro, "Sección inválida (solo A/B).");
            return;
        }
        if (dao.existeSeccion(idHorario, nombre)) {
            errorYForward(req, resp, filtro,
                "Ya existe la sección " + nombre + " para ese horario.");
            return;
        }
        if (dao.contarPorHorario(idHorario) >= 2) {
            errorYForward(req, resp, filtro,
                "Sólo puede haber 2 secciones (A y B) por horario.");
            return;
        }

        // Inserción
        Seccion s = new Seccion();
        s.setIdHorario(idHorario);
        s.setNombre(nombre);
        s.setIdGrupo(idGrupo);
        dao.insertar(s);

        String redirect = req.getContextPath() + "/ListarSeccion";
        if (filtro != null && !filtro.isEmpty()) {
            redirect += "?filtroGrupo=" + filtro;
        }
        resp.sendRedirect(redirect);
    }

    private void errorYForward(HttpServletRequest req, HttpServletResponse resp,
                               String filtro, String msg)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        if (filtro != null && !filtro.isEmpty()) {
            req.setAttribute("selectedGrupo", Integer.valueOf(filtro));
        }
        new ListarSeccionServlet().doGet(req, resp);
    }
}
