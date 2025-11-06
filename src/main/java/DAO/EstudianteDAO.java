package DAO;

import modelo.SeccionInfo;
import modelo.MaterialCurso;
import SQL.conecct;
import java.sql.*;
import java.util.*;
import modelo.Asistencia;
import modelo.Nota;

public class EstudianteDAO {

    public List<Map<String,Object>> listarAsistenciasPorEstudiante(int idEstudiante) {
        List<Map<String,Object>> lista = new ArrayList<>();
        String sql =
          "SELECT " +
          "  c.nombre           AS nombreCurso, " +
          "  s.nombre           AS nombreSeccion, " +
          "  a.fecha, " +
          "  a.presente " +
          "FROM grupo_estudiante ge " +
          "JOIN grupo g            ON ge.id_grupo       = g.id " +
          "JOIN seccion s          ON s.id_grupo        = g.id " +
          "JOIN horario h          ON s.id_horario      = h.id " +
          "JOIN curso_docente cd   ON h.id_curso_docente= cd.id " +
          "JOIN curso c            ON cd.id_curso       = c.id " +
          "JOIN asistencia a       ON a.id_seccion      = s.id " +
          "                      AND a.id_estudiante   = ? " +
          "WHERE ge.id_usuario = ? " +
          "ORDER BY c.nombre, s.nombre, a.fecha";

        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idEstudiante);
            ps.setInt(2, idEstudiante);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String,Object> fila = new HashMap<>();
                    fila.put("nombreCurso",   rs.getString("nombreCurso"));
                    fila.put("nombreSeccion", rs.getString("nombreSeccion"));
                    fila.put("fecha",         rs.getDate("fecha").toLocalDate());
                    fila.put("presente",      rs.getBoolean("presente"));
                    lista.add(fila);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    public List<Asistencia> listarAsistenciaEstudiante(int idSeccion, int idEstudiante) {
        List<Asistencia> lista = new ArrayList<>();
        String sql =
          "SELECT fecha, presente " +
          "  FROM asistencia " +
          " WHERE id_seccion = ? AND id_estudiante = ? " +
          " ORDER BY fecha";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idSeccion);
            ps.setInt(2, idEstudiante);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Asistencia a = new Asistencia();
                    a.setFecha(rs.getDate("fecha").toLocalDate());
                    a.setPresente(rs.getBoolean("presente"));
                    lista.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<SeccionInfo> listarSeccionesEstudiante(int idEstudiante) {
        String sql =
            "SELECT s.id AS id, " +
            "       c.nombre AS curso, " +
            "       c.carrera AS carrera, " +
            "       CONCAT(u.nombre,' ',u.apellido) AS profesor, " +
            "       g.nombre AS grupo, " +
            "       s.nombre AS seccion, " +
            "       h.dia, h.hora_inicio, h.hora_fin " +
            "FROM grupo_estudiante ge " +
            "JOIN grupo g ON ge.id_grupo = g.id " +
            "JOIN seccion s ON s.id_grupo = g.id " +
            "JOIN horario h ON s.id_horario = h.id " +
            "JOIN curso_docente cd ON h.id_curso_docente = cd.id " +
            "JOIN curso c ON cd.id_curso = c.id " +
            "JOIN usuarios u ON cd.id_docente = u.id " +
            "WHERE ge.id_usuario = ? " +
            "ORDER BY c.nombre, h.dia, h.hora_inicio";

        List<SeccionInfo> lista = new ArrayList<>();
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idEstudiante);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SeccionInfo si = new SeccionInfo();
                    si.setId(rs.getInt("id"));
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<MaterialCurso> listarMaterialesPorSeccion(int idSeccion) {
        String sql =
            "SELECT * FROM material_curso " +
            "WHERE id_seccion = ? OR id_seccion IS NULL " +
            "ORDER BY fecha_subida DESC";

        List<MaterialCurso> mats = new ArrayList<>();
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idSeccion);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MaterialCurso m = new MaterialCurso();
                    m.setId(rs.getInt("id"));
                    m.setIdUsuario(rs.getInt("id_usuario"));
                    m.setIdCurso(rs.getObject("id_curso", Integer.class));
                    m.setIdSeccion(rs.getObject("id_seccion", Integer.class));
                    m.setTitulo(rs.getString("titulo"));
                    m.setDescripcion(rs.getString("descripcion"));
                    m.setArchivo(rs.getString("archivo"));
                    m.setTipo(rs.getString("tipo"));
                    m.setFechaSubida(rs.getTimestamp("fecha_subida"));
                    mats.add(m);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mats;
    }
      public List<Map<String,Object>> listarSeccionesConNotas(int idEstudiante) {
        List<Map<String,Object>> lista = new ArrayList<>();
        String sql =
          "SELECT " +
          "  s.id               AS idSeccion, " +
          "  c.nombre           AS nombreCurso, " +
          "  s.nombre           AS nombreSeccion, " +
          "  n.nota1, n.nota2, n.nota3, n.nota_final AS notaFinal, n.promedio " +
          "FROM grupo_estudiante ge " +
          "JOIN grupo g            ON ge.id_grupo     = g.id " +
          "JOIN seccion s          ON s.id_grupo      = g.id " +
          "JOIN horario h          ON s.id_horario    = h.id " +
          "JOIN curso_docente cd   ON h.id_curso_docente = cd.id " +
          "JOIN curso c            ON cd.id_curso     = c.id " +
          "LEFT JOIN nota n        ON n.id_seccion = s.id " +
          "                     AND n.id_estudiante = ? " +
          "WHERE ge.id_usuario = ? " +
          "ORDER BY c.nombre, s.nombre";

        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idEstudiante);
            ps.setInt(2, idEstudiante);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String,Object> fila = new HashMap<>();
                    fila.put("idSeccion",     rs.getInt("idSeccion"));
                    fila.put("nombreCurso",   rs.getString("nombreCurso"));
                    fila.put("nombreSeccion", rs.getString("nombreSeccion"));
                    // pueden venir null si no hay nota
                    fila.put("nota1",         rs.getObject("nota1"));
                    fila.put("nota2",         rs.getObject("nota2"));
                    fila.put("nota3",         rs.getObject("nota3"));
                    fila.put("notaFinal",     rs.getObject("notaFinal"));
                    fila.put("promedio",      rs.getObject("promedio"));
                    lista.add(fila);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}



    

