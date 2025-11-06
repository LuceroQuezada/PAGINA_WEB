package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;

@WebServlet("/descargar")
public class DownloadServlet extends HttpServlet {
    private static final int BUFFER_SIZE = 8192;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        
        System.out.println("=== DEBUG DESCARGA ===");

        String fileName = req.getParameter("file");
        System.out.println("Parámetro file: " + fileName);
        
        if (fileName == null || fileName.isBlank()) {
            System.out.println("ERROR: Parámetro 'file' vacío o nulo");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta parámetro 'file'");
            return;
        }
        
        if (fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            System.out.println("ERROR: Nombre de archivo no seguro: " + fileName);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Nombre de archivo no válido");
            return;
        }

        String userHome = System.getProperty("user.home");
        String uploadsDir = userHome + File.separator + "uploads" + File.separator + "material";
        System.out.println("Directorio uploads: " + uploadsDir);
        
        File file = new File(uploadsDir, fileName);
        String fullPath = file.getAbsolutePath();
        System.out.println("Ruta completa del archivo: " + fullPath);
        System.out.println("¿Existe el archivo? " + file.exists());
        System.out.println("¿Es un archivo? " + file.isFile());
        System.out.println("¿Es legible? " + file.canRead());
        System.out.println("Tamaño del archivo: " + file.length() + " bytes");
        
        if (!file.exists() || !file.isFile()) {
            System.out.println("ERROR: Archivo no encontrado o no es un archivo válido");
            

            File dir = new File(uploadsDir);
            if (dir.exists() && dir.isDirectory()) {
                System.out.println("Archivos en el directorio:");
                String[] files = dir.list();
                if (files != null) {
                    for (String f : files) {
                        System.out.println("  - " + f);
                    }
                } else {
                    System.out.println("  No se pudo listar el contenido del directorio");
                }
            } else {
                System.out.println("El directorio no existe: " + uploadsDir);
            }
            
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Archivo no encontrado: " + fileName);
            return;
        }
        
        String mime = getServletContext().getMimeType(file.getName());
        if (mime == null) {
            mime = "application/octet-stream";
        }
        System.out.println("Tipo MIME detectado: " + mime);
        
        resp.setContentType(mime);
        resp.setContentLengthLong(file.length());
        

        String originalName = fileName;
        int idx = fileName.indexOf("_");
        if (idx != -1) {
            originalName = fileName.substring(idx + 1);
        }
        System.out.println("Nombre original: " + originalName);
        
        originalName = originalName.replace("\"", "\\\"");
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + originalName + "\"");
        
        System.out.println("Iniciando descarga...");
        

        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
             BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream())) {
            
            byte[] buffer = new byte[BUFFER_SIZE];
            int bytesRead;
            long totalBytes = 0;
            
            while ((bytesRead = in.read(buffer)) > 0) {
                out.write(buffer, 0, bytesRead);
                totalBytes += bytesRead;
            }
            
            System.out.println("Descarga completada. Bytes transferidos: " + totalBytes);
            
        } catch (IOException e) {
            System.out.println("ERROR durante la descarga:");
            e.printStackTrace();
            
            if (!resp.isCommitted()) {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                              "Error al descargar el archivo");
            }
        }
        
        System.out.println("=== FIN DEBUG DESCARGA ===");
    }
}