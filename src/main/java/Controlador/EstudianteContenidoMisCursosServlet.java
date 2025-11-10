package Controlador;

import DAO.EstudianteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import modelo.Asistencia;
import modelo.MaterialCurso;
import modelo.SeccionInfo;
import modelo.Usuario;

@WebServlet("/Estudiante/Cursos/Detalle")
public class EstudianteContenidoMisCursosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Usuario u = (Usuario) req.getSession().getAttribute("usuario");
        if (u == null) {
            resp.sendRedirect("../login.jsp");
            return;
        }

        String secParam = req.getParameter("idSeccion");
        if (secParam == null || secParam.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/Estudiante/Cursos");
            return;
        }

        int idSeccion;
        try {
            idSeccion = Integer.parseInt(secParam);
        } catch (NumberFormatException ex) {
            resp.sendRedirect(req.getContextPath() + "/Estudiante/Cursos");
            return;
        }

        EstudianteDAO dao = new EstudianteDAO();
        List<SeccionInfo> todasSecciones = dao.listarSeccionesEstudiante(u.getId());
        SeccionInfo curso = todasSecciones.stream()
                .filter(s -> s.getId() == idSeccion)
                .findFirst()
                .orElse(null);

        if (curso == null) {
            resp.sendRedirect(req.getContextPath() + "/Estudiante/Cursos");
            return;
        }

        List<MaterialCurso> materiales = dao.listarMaterialesPorSeccion(idSeccion);
        LinkedHashMap<String, List<MaterialCurso>> materialesPorSemana = agruparMaterialesPorSemana(materiales);

        Map<String, Object> notasSeccion = dao.listarSeccionesConNotas(u.getId()).stream()
                .filter(n -> ((Integer) n.get("idSeccion")) == idSeccion)
                .findFirst()
                .orElse(null);

        List<Asistencia> asistencias = dao.listarAsistenciaEstudiante(idSeccion, u.getId());
        List<Map<String, Object>> asistenciasVista = formatearAsistencia(asistencias);

        int progreso = calcularProgresoCurso(materiales, notasSeccion);

        req.setAttribute("cursoSeleccionado", curso);
        req.setAttribute("materiales", materiales);
        req.setAttribute("materialesPorSemana", materialesPorSemana);
        req.setAttribute("notasSeccion", notasSeccion);
        req.setAttribute("asistenciasVista", asistenciasVista);
        req.setAttribute("progresoCurso", progreso);

        req.getRequestDispatcher("/estudiante/curso-detalle.jsp").forward(req, resp);
    }

    private LinkedHashMap<String, List<MaterialCurso>> agruparMaterialesPorSemana(List<MaterialCurso> materiales) {
        LinkedHashMap<String, List<MaterialCurso>> agrupados = new LinkedHashMap<>();
        for (int i = 0; i < materiales.size(); i++) {
            MaterialCurso m = materiales.get(i);
            String titulo = m.getTitulo() != null ? m.getTitulo() : "Material " + (i + 1);
            String[] partes = titulo.split(":", 2);
            String clave = partes[0].trim();
            if (clave.isEmpty()) {
                clave = "Semana " + (i + 1);
            }

            String descripcionSemana = partes.length > 1 ? partes[1].trim() : "";
            if (!descripcionSemana.isEmpty()) {
                clave = clave + ": " + descripcionSemana;
            }

            agrupados.computeIfAbsent(clave, k -> new ArrayList<>()).add(m);
        }

        if (agrupados.isEmpty()) {
            agrupados.put("Semana 1: Contenido general", materiales);
        }
        return agrupados;
    }

    private int calcularProgresoCurso(List<MaterialCurso> materiales, Map<String, Object> notas) {
        int base = Math.min(80, materiales.size() * 10);
        if (notas != null && notas.get("promedio") instanceof Number) {
            base = Math.max(base, ((Number) notas.get("promedio")).intValue());
        }
        return Math.min(100, Math.max(25, base));
    }

    private List<Map<String, Object>> formatearAsistencia(List<Asistencia> asistencias) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, d 'de' MMMM", new Locale("es", "ES"));
        List<Map<String, Object>> vista = new ArrayList<>();
        for (Asistencia a : asistencias) {
            Map<String, Object> fila = new HashMap<>();
            String texto = a.getFecha() != null ? a.getFecha().format(formatter) : "Sin fecha";
            fila.put("fechaTexto", texto.substring(0, 1).toUpperCase() + texto.substring(1));
            fila.put("presente", a.isPresente());
            vista.add(fila);
        }
        return vista;
    }
}
