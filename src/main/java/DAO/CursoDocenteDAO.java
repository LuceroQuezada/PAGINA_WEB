// DAO/CursoDocenteDAO.java
package DAO;
import SQL.conecct;
import modelo.CursoDocente;
import java.sql.*; import java.util.*;
import modelo.Curso;

public class CursoDocenteDAO {
    public List<CursoDocente> listar() {
    List<CursoDocente> lista = new ArrayList<>();
    String sql = ""
      + "SELECT cd.id, cd.id_curso, cd.id_docente, "
      + "       c.nombre AS nombre_curso, c.carrera AS carrera, "
      + "       CONCAT(u.nombre,' ',u.apellido) AS nombre_docente "
      + "  FROM curso_docente cd "
      + "  JOIN curso c ON cd.id_curso = c.id "
      + "  JOIN usuarios u ON cd.id_docente = u.id";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            CursoDocente cd = new CursoDocente();
            cd.setId(rs.getInt("id"));
            cd.setIdCurso(rs.getInt("id_curso"));
            cd.setIdDocente(rs.getInt("id_docente"));
            cd.setNombreCurso(rs.getString("nombre_curso"));
            cd.setNombreDocente(rs.getString("nombre_docente"));
            cd.setCarrera(rs.getString("carrera"));    // ← seteamos
            lista.add(cd);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}

    public boolean insertar(CursoDocente cd) {
        String sql="INSERT INTO curso_docente(id_curso,id_docente) VALUES(?,?)";
        try (Connection con=conecct.getConnection();
             PreparedStatement ps=con.prepareStatement(sql)) {
            ps.setInt(1,cd.getIdCurso());
            ps.setInt(2,cd.getIdDocente());
            ps.executeUpdate();
            return true;
        } catch(Exception e){ e.printStackTrace(); return false; }
    }
    public boolean eliminar(int id) {
        String sql="DELETE FROM curso_docente WHERE id=?";
        try (Connection con=conecct.getConnection();
             PreparedStatement ps=con.prepareStatement(sql)) {
            ps.setInt(1,id); ps.executeUpdate(); return true;
        } catch(Exception e){ e.printStackTrace(); return false; }
    }
    

public List<CursoDocente> listarPorCarrera(String carrera) {
    List<CursoDocente> lista = new ArrayList<>();
    String sql = ""
      + "SELECT cd.id, cd.id_curso, cd.id_docente, "
      + "       c.nombre AS nombre_curso, c.carrera AS carrera, "
      + "       CONCAT(u.nombre,' ',u.apellido) AS nombre_docente "
      + "  FROM curso_docente cd "
      + "  JOIN curso c ON cd.id_curso = c.id "
      + "  JOIN usuarios u ON cd.id_docente = u.id "
      + " WHERE c.carrera = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, carrera);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CursoDocente cd = new CursoDocente();
                cd.setId(rs.getInt("id"));
                cd.setIdCurso(rs.getInt("id_curso"));
                cd.setIdDocente(rs.getInt("id_docente"));
                cd.setNombreCurso(rs.getString("nombre_curso"));
                cd.setNombreDocente(rs.getString("nombre_docente"));
                cd.setCarrera(rs.getString("carrera"));
                lista.add(cd);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}



public CursoDocente obtenerPorId(int id) {
    String sql =
        "SELECT cd.id, cd.id_curso, cd.id_docente, " +
        "       c.nombre AS nombre_curso, c.carrera, " +
        "       CONCAT(u.nombre,' ',u.apellido) AS nombre_docente " +
        "  FROM curso_docente cd " +
        "  JOIN curso c ON cd.id_curso = c.id " +
        "  JOIN usuarios u ON cd.id_docente = u.id " +
        " WHERE cd.id = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                CursoDocente cd = new CursoDocente();
                cd.setId(rs.getInt("id"));
                cd.setIdCurso(rs.getInt("id_curso"));
                cd.setIdDocente(rs.getInt("id_docente"));
                cd.setNombreCurso(rs.getString("nombre_curso"));
                cd.setNombreDocente(rs.getString("nombre_docente"));
                cd.setCarrera(rs.getString("carrera"));
                return cd;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}


public int contarPorDocente(int idDocente) {
    String sql = "SELECT COUNT(*) FROM curso_docente WHERE id_docente = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, idDocente);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

public boolean existeAsignacion(int idCurso, int idDocente) {
    String sql = "SELECT 1 FROM curso_docente WHERE id_curso = ? AND id_docente = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, idCurso);
        ps.setInt(2, idDocente);
        try (ResultSet rs = ps.executeQuery()) {
            return rs.next();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

public List<CursoDocente> listarPorDocente(int idDocente) {
    List<CursoDocente> lista = new ArrayList<>();
    String sql =
      "SELECT cd.id      AS id_cd, " +
      "       c.id       AS id_curso, c.nombre AS nombre_curso, c.carrera, " +
      "       CONCAT(u.nombre,' ',u.apellido) AS nombre_docente, " +
      "       s.id       AS id_seccion, s.nombre AS seccion, " +
      "       g.nombre   AS grupo, " +
      "       h.dia, h.hora_inicio, h.hora_fin " +
      "  FROM curso_docente cd " +
      "  JOIN curso c ON cd.id_curso = c.id " +
      "  JOIN usuarios u ON cd.id_docente = u.id " +
      "  LEFT JOIN horario h ON h.id_curso_docente = cd.id " +
      "  LEFT JOIN seccion s ON s.id_horario = h.id " +
      "  LEFT JOIN grupo g   ON s.id_grupo   = g.id " +
      " WHERE cd.id_docente = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, idDocente);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CursoDocente cd = new CursoDocente();
                cd.setId(rs.getInt("id_cd"));
                cd.setIdCurso(rs.getInt("id_curso"));
                cd.setNombreCurso(rs.getString("nombre_curso"));
                cd.setCarrera(rs.getString("carrera"));
                cd.setNombreDocente(rs.getString("nombre_docente"));
                cd.setIdSeccion(rs.getInt("id_seccion"));
                cd.setSeccion(rs.getString("seccion"));
                cd.setGrupo(rs.getString("grupo"));
                cd.setDia(rs.getString("dia"));
                cd.setHoraInicio(rs.getString("hora_inicio"));
                cd.setHoraFin(rs.getString("hora_fin"));
                lista.add(cd);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}


}
