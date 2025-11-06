package Controlador;

import DAO.NotaDAO;
import modelo.Nota;
import modelo.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/Docente/RegistrarNotas")
public class RegistrarNotasServlet extends HttpServlet {
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    int idSeccion = Integer.parseInt(req.getParameter("idSeccion"));
    String[] estudiantes = req.getParameterValues("estudiantes[]");
    NotaDAO dao = new NotaDAO();


    Map<Integer,Nota> existing = dao.listarPorSeccion(idSeccion)
                                    .stream()
                                    .collect(Collectors.toMap(Nota::getIdEstudiante, n->n));

    for (String sid : estudiantes) {
      int idEst = Integer.parseInt(sid);

      double n1 = existing.containsKey(idEst) ? existing.get(idEst).getNota1() : 0;
      double n2 = existing.containsKey(idEst) ? existing.get(idEst).getNota2() : 0;
      double n3 = existing.containsKey(idEst) ? existing.get(idEst).getNota3() : 0;
      double nf = existing.containsKey(idEst) ? existing.get(idEst).getNotaFinal() : 0;

       String p;
      if ((p = req.getParameter("nota1_"+idEst)) != null && !p.isEmpty())
        n1 = Double.parseDouble(p);
      if ((p = req.getParameter("nota2_"+idEst)) != null && !p.isEmpty())
        n2 = Double.parseDouble(p);
      if ((p = req.getParameter("nota3_"+idEst)) != null && !p.isEmpty())
        n3 = Double.parseDouble(p);
      if ((p = req.getParameter("notaF_"+idEst)) != null && !p.isEmpty())
        nf = Double.parseDouble(p);


      n1 = Math.max(0,Math.min(100,n1));
      n2 = Math.max(0,Math.min(100,n2));
      n3 = Math.max(0,Math.min(100,n3));
      nf = Math.max(0,Math.min(100,nf));


      double prom = (n1 + n2 + n3 + nf) / 4.0;


      Nota nota = new Nota();
      nota.setIdSeccion(idSeccion);
      nota.setIdEstudiante(idEst);
      nota.setNota1(n1);
      nota.setNota2(n2);
      nota.setNota3(n3);
      nota.setNotaFinal(nf);
      nota.setPromedio(prom);


      if (existing.containsKey(idEst)) dao.actualizar(nota);
      else                             dao.insertar(nota);
    }

    resp.sendRedirect(req.getContextPath()
      +"/Docente/Calificar?idSeccion="+idSeccion+"&mensaje=exito");
  }
}
