package DAO;

import SQL.conecct;
import modelo.SeccionInfo;
import java.sql.*;
import java.util.*;

public class AdminSeccionDAO {
    public List<SeccionInfo> listarSeccionesCompletas() {
        List<SeccionInfo> lista = new ArrayList<>();
        String sql =
          "SELECT "
        + "  s.id              AS id_seccion, "
        + "  s.id_grupo        AS id_grupo, "             
        + "  c.nombre          AS curso, "
        + "  c.carrera         AS carrera, "
        + "  CONCAT(u.nombre,' ',u.apellido) AS profesor, "
        + "  g.nombre          AS grupo, "
        + "  s.nombre          AS seccion, "
        + "  h.dia, "
        + "  h.hora_inicio, "
        + "  h.hora_fin "
        + "FROM seccion s "
        + "JOIN horario h        ON s.id_horario       = h.id "
        + "JOIN curso_docente cd ON h.id_curso_docente  = cd.id "
        + "JOIN curso c          ON cd.id_curso         = c.id "
        + "JOIN usuarios u       ON cd.id_docente       = u.id "
        + "JOIN grupo g          ON s.id_grupo          = g.id "
        + "ORDER BY g.nombre, s.nombre, h.dia, h.hora_inicio";

        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SeccionInfo si = new SeccionInfo();
                si.setId(rs.getInt("id_seccion"));
                si.setIdGrupo(rs.getInt("id_grupo"));          
                si.setCurso(rs.getString("curso"));
                si.setCarrera(rs.getString("carrera"));
                si.setProfesor(rs.getString("profesor"));
                si.setGrupo(rs.getString("grupo"));
                si.setSeccion(rs.getString("seccion"));
                si.setDia(rs.getString("dia"));
                si.setHoraInicio(rs.getString("hora_inicio"));
                si.setHoraFin(rs.getString("hora_fin"));
                lista.add(si);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
