
package DAO;

import modelo.Usuario;
import SQL.conecct;
import java.sql.*;
import java.util.*;

public class GrupoEstudianteDAO {
    public List<Usuario> listarPorGrupo(int idGrupo) {
        List<Usuario> lista = new ArrayList<>();
        String sql =
          "SELECT u.id,u.nombre,u.apellido,u.correo,u.carrera,  u.password " +
          "  FROM usuarios u " +
          "  JOIN grupo_estudiante ge ON u.id = ge.id_usuario " +
          " WHERE ge.id_grupo = ? " +
          "   AND u.id_rol = 3 " +
          " ORDER BY u.apellido, u.nombre";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idGrupo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setApellido(rs.getString("apellido"));
                    u.setCorreo(rs.getString("correo"));
                    u.setCarrera(rs.getString("carrera"));
                     u.setPassword(rs.getString("password"));  
                    lista.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    
}
