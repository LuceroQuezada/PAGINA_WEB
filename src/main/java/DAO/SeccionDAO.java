
package DAO;
import SQL.conecct;
import modelo.Seccion;
import java.sql.*; import java.util.*;
import modelo.Usuario;

public class SeccionDAO {
    public List<Seccion> listar() {
        List<Seccion> lista=new ArrayList<>();
        String sql="SELECT s.id, s.id_horario, s.nombre, s.id_grupo, g.nombre AS nombre_grupo "
                  +"FROM seccion s JOIN grupo g ON s.id_grupo=g.id";
        try (Connection con=conecct.getConnection();
             PreparedStatement ps=con.prepareStatement(sql);
             ResultSet rs=ps.executeQuery()){
            while(rs.next()){
                Seccion s=new Seccion();
                s.setId(rs.getInt("id"));
                s.setIdHorario(rs.getInt("id_horario"));
                s.setNombre(rs.getString("nombre"));
                s.setIdGrupo(rs.getInt("id_grupo"));
                s.setNombreGrupo(rs.getString("nombre_grupo"));
                lista.add(s);
            }
        } catch(Exception e){ e.printStackTrace(); }
        return lista;
    }
    public boolean insertar(Seccion s) {
        String sql="INSERT INTO seccion(id_horario,nombre,id_grupo) VALUES(?,?,?)";
        try (Connection con=conecct.getConnection();
             PreparedStatement ps=con.prepareStatement(sql)){
            ps.setInt(1,s.getIdHorario());
            ps.setString(2,s.getNombre());
            ps.setInt(3,s.getIdGrupo());
            ps.executeUpdate();
            return true;
        } catch(Exception e){ e.printStackTrace(); return false; }
    }
    public boolean eliminar(int id) {
        String sql="DELETE FROM seccion WHERE id=?";
        try (Connection con=conecct.getConnection();
             PreparedStatement ps=con.prepareStatement(sql)){
            ps.setInt(1,id); ps.executeUpdate(); return true;
        } catch(Exception e){ e.printStackTrace(); return false; }
    }

    
     public List<Seccion> listarPorGrupo(int idGrupoFiltro) {
        List<Seccion> lista = new ArrayList<>();
        String sql = "SELECT s.id, s.id_horario, s.nombre, s.id_grupo, g.nombre AS nombre_grupo "
                   + "FROM seccion s "
                   + "JOIN grupo g ON s.id_grupo = g.id "
                   + "WHERE s.id_grupo = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idGrupoFiltro);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Seccion s = new Seccion();
                    s.setId(rs.getInt("id"));
                    s.setIdHorario(rs.getInt("id_horario"));
                    s.setNombre(rs.getString("nombre"));
                    s.setIdGrupo(rs.getInt("id_grupo"));
                    s.setNombreGrupo(rs.getString("nombre_grupo"));
                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
     

    public int contarPorHorario(int idHorario) {
        String sql = "SELECT COUNT(*) FROM seccion WHERE id_horario = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idHorario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


    public boolean existeSeccion(int idHorario, String nombre) {
        String sql = "SELECT 1 FROM seccion WHERE id_horario = ? AND nombre = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idHorario);
            ps.setString(2, nombre);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    public List<Usuario> listarEstudiantesPorSeccion(int idSeccion) {
        List<Usuario> lista = new ArrayList<>();
        String sql =
          "SELECT u.id, u.nombre, u.apellido, u.correo, u.carrera " +
          "  FROM seccion s " +
          "  JOIN grupo_estudiante ge ON ge.id_grupo = s.id_grupo " +
          "  JOIN usuarios u ON u.id = ge.id_usuario " +
          " WHERE s.id = ? " +
          " ORDER BY u.apellido, u.nombre";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idSeccion);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setApellido(rs.getString("apellido"));
                    u.setCorreo(rs.getString("correo"));
                    u.setCarrera(rs.getString("carrera"));
                    // no hace falta u.setIdRol ni estado si no se usan
                    lista.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

public Seccion obtenerPorId(int id) {
    String sql =
      "SELECT s.id, s.id_horario, s.nombre, s.id_grupo, g.nombre AS nombre_grupo " +
      "  FROM seccion s JOIN grupo g ON s.id_grupo = g.id " +
      " WHERE s.id = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Seccion s = new Seccion();
                s.setId(rs.getInt("id"));
                s.setIdHorario(rs.getInt("id_horario"));
                s.setNombre(rs.getString("nombre"));
                s.setIdGrupo(rs.getInt("id_grupo"));
                s.setNombreGrupo(rs.getString("nombre_grupo"));
                return s;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

}
