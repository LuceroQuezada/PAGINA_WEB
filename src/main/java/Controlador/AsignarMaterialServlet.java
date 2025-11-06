package Controlador;

import DAO.CursoDAO;
import DAO.MaterialCursoDAO;
import modelo.Curso;
import modelo.MaterialCurso;
import modelo.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.text.Normalizer;

@WebServlet("/admin/AsignarMaterial")
@MultipartConfig(
  fileSizeThreshold = 1024 * 1024,
  maxFileSize       = 1024 * 1024 * 10,
  maxRequestSize    = 1024 * 1024 * 50
)
public class AsignarMaterialServlet extends HttpServlet {
    

    private String limpiarNombreArchivo(String nombre) {
        String normalizado = Normalizer.normalize(nombre, Normalizer.Form.NFD)
                                       .replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        return normalizado.replaceAll("[^a-zA-Z0-9._-]", "_");
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Usuario admin = (Usuario) req.getSession().getAttribute("usuario");
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }


        List<String> carreras = List.of("Ingenieria", "Medicina", "Derecho");
        req.setAttribute("carreras", carreras);


        String sel = req.getParameter("carrera");
        req.setAttribute("selectedCarrera", sel);

        if (sel != null && !sel.isEmpty()) {
            List<Curso> cursos = new CursoDAO().listarPorCarrera(sel);
            req.setAttribute("cursos", cursos);

            List<MaterialCurso> materiales = new MaterialCursoDAO().listarPorCarrera(sel);
            req.setAttribute("materiales", materiales);
        }


        String msg = req.getParameter("mensaje");
        if (msg != null) {
            req.setAttribute("mensaje", msg);
        }

        req.getRequestDispatcher("/admin/asignarMaterial.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Usuario admin = (Usuario) req.getSession().getAttribute("usuario");
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String carrera = req.getParameter("carrera");
        String idCurso = req.getParameter("idCurso");
        String titulo = req.getParameter("titulo");
        String desc = req.getParameter("descripcion");
        Part filePart = req.getPart("archivo");


        if (carrera == null || carrera.isEmpty() ||
            idCurso == null || idCurso.isEmpty() ||
            titulo == null || titulo.isEmpty() ||
            filePart == null || filePart.getSize() == 0) {

            resp.sendRedirect(req.getContextPath() +
                "/admin/AsignarMaterial?carrera=" + carrera + "&mensaje=error");
            return;
        }

        try {

            String uploadsDir = System.getProperty("user.home")
                    + File.separator + "uploads" + File.separator + "material";
            Files.createDirectories(Paths.get(uploadsDir));

            String cleanName = limpiarNombreArchivo(filePart.getSubmittedFileName());
            String fileName = UUID.randomUUID() + "_" + cleanName;
            Files.copy(filePart.getInputStream(),
                    Paths.get(uploadsDir, fileName),
                    StandardCopyOption.REPLACE_EXISTING);

            MaterialCurso m = new MaterialCurso();
            m.setIdUsuario(admin.getId());
            m.setIdCurso(Integer.parseInt(idCurso));
            m.setIdSeccion(null);
            m.setTitulo(titulo);
            m.setDescripcion(desc);
            m.setArchivo(fileName);

            String ext = cleanName.substring(cleanName.lastIndexOf('.') + 1).toLowerCase();
            if (ext.contains("pdf")) {
                m.setTipo("PDF");
            } else if (ext.contains("doc") || ext.contains("docx")) {
                m.setTipo("DOC");
            } else if (ext.contains("jpg") || ext.contains("jpeg") || ext.contains("png")) {
                m.setTipo("IMG");
            } else if (ext.contains("mp4") || ext.contains("avi")) {
                m.setTipo("VIDEO");
            } else if (ext.contains("zip") || ext.contains("rar")) {
                m.setTipo("ZIP");
            } else {
                m.setTipo("OTRO");
            }

            boolean insertado = new MaterialCursoDAO().insertar(m);

            if (!insertado) {
                Files.deleteIfExists(Paths.get(uploadsDir, fileName));
                resp.sendRedirect(req.getContextPath() +
                        "/admin/AsignarMaterial?carrera=" + carrera + "&mensaje=error_bd");
                return;
            }

            resp.sendRedirect(req.getContextPath() +
                    "/admin/AsignarMaterial?carrera=" + carrera + "&mensaje=exito");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() +
                    "/admin/AsignarMaterial?carrera=" + carrera + "&mensaje=error_excepcion");
        }
    }
}
