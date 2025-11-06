/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import DAO.EstudianteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.SeccionInfo;
import modelo.Usuario;

/**
 *
 * @author c-can
 */
@WebServlet("/Estudiante/Horario")
public class EstudianteHorarioServlet extends HttpServlet {
  @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    Usuario u = (Usuario)req.getSession().getAttribute("usuario");
    if (u==null) { resp.sendRedirect("login.jsp"); return; }

    List<SeccionInfo> horario =
      new EstudianteDAO().listarSeccionesEstudiante(u.getId());
    req.setAttribute("horario", horario);

    req.getRequestDispatcher("/estudiante/horario.jsp")
       .forward(req, resp);
  }
}
