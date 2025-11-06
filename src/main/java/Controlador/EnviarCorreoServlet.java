package Controlador;

import util.EmailUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/enviarCorreo")
public class EnviarCorreoServlet extends HttpServlet {
    private final String ASUNTO = "Tu preinscripción ha sido aceptada";
    private final String CUERPO  =
        "¡Felicidades!\n\n" +
        "Tu solicitud de preinscripción ha sido ACEPTADA. En breve nos pondremos en contacto contigo.\n\n" +
        "Saludos,\nAcademia NivelA1";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        if (email != null && !email.isBlank()) {
            try {
                EmailUtil.sendEmail(email, ASUNTO, CUERPO);
                resp.sendRedirect("listarAceptados?mensaje=enviado");
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect("listarAceptados?mensaje=error_envio");
            }
        } else {
            resp.sendRedirect("listarAceptados?mensaje=email_invalido");
        }
    }
}
