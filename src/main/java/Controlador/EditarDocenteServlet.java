/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import modelo.Usuario;

/**
 *
 * @author c-can
 */
@WebServlet("/EditarDocenteServlet")
public class EditarDocenteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        UsuarioDAO dao = new UsuarioDAO();
        Usuario docente = dao.obtenerPorId(id);
        request.setAttribute("docente", docente);
        request.getRequestDispatcher("admin/editarDocente.jsp").forward(request, response);
    }
}

