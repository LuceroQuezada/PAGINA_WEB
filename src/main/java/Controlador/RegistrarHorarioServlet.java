package Controlador;

import DAO.CursoDocenteDAO;
import DAO.HorarioDAO;
import modelo.CursoDocente;
import modelo.Horario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.*;
import java.util.List;

@WebServlet("/RegistrarHorario")
public class RegistrarHorarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dia         = request.getParameter("dia");
        String inicioParam = request.getParameter("horaInicio");
        String finParam    = request.getParameter("horaFin");
        int idCD           = Integer.parseInt(request.getParameter("idCursoDocente"));

        System.out.println("DEBUG → Intentando asignar horario:");
        System.out.println("   Día: " + dia);
        System.out.println("   Hora Inicio: " + inicioParam);
        System.out.println("   Hora Fin: " + finParam);
        System.out.println("   idCursoDocente: " + idCD);


        LocalTime inicio = LocalTime.parse(inicioParam);
        LocalTime fin    = LocalTime.parse(finParam);


        CursoDocenteDAO cdDao = new CursoDocenteDAO();
        CursoDocente cd       = cdDao.obtenerPorId(idCD);
        if (cd == null) {
            System.out.println("❌ DEBUG → BLOQUEADO: Curso-Docente no existe.");
            request.setAttribute("error", "Asignación inválida: curso-docente no existe.");
            forwardBack(request, response);
            return;
        }


        LocalTime min = LocalTime.of(9, 0), max = LocalTime.of(13, 30);
        if (inicio.isBefore(min) || fin.isAfter(max)) {
            System.out.println("DEBUG → BLOQUEADO: Rango horario fuera de 09:00-13:30");
            request.setAttribute("error", "El horario debe estar entre 09:00 y 13:30.");
            forwardBack(request, response);
            return;
        }

        // ✅ Validar duración exacta de 1.5 h
        long duracion = Duration.between(inicio, fin).toMinutes();
        if (duracion != 90) {
            System.out.println("DEBUG → BLOQUEADO: Duración inválida (" + duracion + " min)");
            request.setAttribute("error", "La clase debe durar exactamente 1 h 30 min.");
            forwardBack(request, response);
            return;
        }

        // ✅ Validar solapamiento (mismo docente y día)
        HorarioDAO hDao = new HorarioDAO();
        List<Horario> todos = hDao.listar();
        for (Horario h : todos) {
            if (!h.getDia().equals(dia)) continue;

            CursoDocente existente = cdDao.obtenerPorId(h.getIdCursoDocente());
            if (existente != null && existente.getIdDocente() == cd.getIdDocente()) {
                LocalTime ei = LocalTime.parse(h.getHoraInicio());
                LocalTime ef = LocalTime.parse(h.getHoraFin());

                if (inicio.isBefore(ef) && ei.isBefore(fin)) {
                    System.out.println("DEBUG → BLOQUEADO: Solapamiento con otro horario:");
                    System.out.println("      Ya existe → " + h.getDia() + " " + ei + "-" + ef);
                    request.setAttribute("error",
                      "Solapamiento: el docente ya tiene clase ese día a esa hora.");
                    forwardBack(request, response);
                    return;
                }
            }
        }

        Horario nuevo = new Horario();
        nuevo.setIdCursoDocente(idCD);
        nuevo.setDia(dia);
        nuevo.setHoraInicio(inicioParam);
        nuevo.setHoraFin(finParam);
        boolean insertado = hDao.insertar(nuevo);

        if (insertado) {
            System.out.println("DEBUG - HORARIO INSERTADO CORRECTAMENTE.");
        } else {
            System.out.println("DEBUG - ERROR al insertar en la BD.");
        }

        response.sendRedirect(request.getContextPath() + "/ListarHorario");
    }

    private void forwardBack(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        System.out.println("DEBUG - Redirigiendo de vuelta con error.");
        new ListarHorarioServlet().doGet(req, res);
    }
}
