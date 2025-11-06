package DAO;

import modelo.Usuario;
import SQL.conecct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class UsuarioDAO {
    

public List<Usuario> obtenerAlumnosNoAsignadosPorCarrera(String carrera) {
    List<Usuario> lista = new ArrayList<>();
    String sql = "SELECT * FROM usuarios " +
                 "WHERE id_rol = 3 AND carrera = ? " +
                 "  AND (asignado_grupo = FALSE OR asignado_grupo IS NULL) " +
                 "ORDER BY nombre, apellido";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, carrera);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setNombre(rs.getString("nombre"));
            u.setApellido(rs.getString("apellido"));
            u.setCorreo(rs.getString("correo"));
            u.setCarrera(rs.getString("carrera"));
            u.setPassword(rs.getString("password"));
            u.setEstado(rs.getInt("estado"));
            lista.add(u);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}

    public Usuario login(String correo, String password) {
    Usuario usuario = null;
    try {
        try (Connection conn = conecct.getConnection()) {
            String sql = "SELECT u.*, r.nombre as rol_nombre FROM usuarios u " +
                        "INNER JOIN rol r ON u.id_rol = r.id " +
                        "WHERE u.correo = ? AND u.password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setCarrera(rs.getString("carrera")); 
                usuario.setIdRol(rs.getInt("id_rol"));
                usuario.setPassword(rs.getString("password"));
            }
        }
    } catch (SQLException e) {
        System.err.println("Error al realizar login: " + e.getMessage());
        e.printStackTrace();
    }
    return usuario;
}
    
  public void insertar(Usuario usuario) {
        String sql = "INSERT INTO usuarios (correo, password, nombre, apellido, carrera, id_rol) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario.getCorreo());
            ps.setString(2, usuario.getPassword());
            ps.setString(3, usuario.getNombre());
            ps.setString(4, usuario.getApellido());
            ps.setString(5, usuario.getCarrera()); 
            ps.setInt(6, usuario.getIdRol());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al insertar usuario: " + e.getMessage());
        }
    }

 
   public List<Usuario> obtenerPorRol(int idRol) {
    List<Usuario> lista = new ArrayList<>();
    String sql = "SELECT u.*, r.nombre as rol_nombre FROM usuarios u " +
                "INNER JOIN rol r ON u.id_rol = r.id " +
                "WHERE u.id_rol = ?";

    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, idRol);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setCorreo(rs.getString("correo"));
            u.setPassword(rs.getString("password"));
            u.setNombre(rs.getString("nombre"));
            u.setApellido(rs.getString("apellido"));
            u.setCarrera(rs.getString("carrera")); 
            u.setIdRol(rs.getInt("id_rol"));
            u.setEstado(rs.getInt("estado"));

            lista.add(u);
        }
    } catch (SQLException e) {
        System.err.println("Error al obtener usuarios por rol: " + e.getMessage());
    }

    return lista;
}
    
    public Usuario obtenerPorId(int id) {
    Usuario u = null;
    String sql = "SELECT u.*, r.nombre as rol_nombre FROM usuarios u " +
                "INNER JOIN rol r ON u.id_rol = r.id " +
                "WHERE u.id = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setCorreo(rs.getString("correo"));
            u.setPassword(rs.getString("password"));
            u.setNombre(rs.getString("nombre"));
            u.setApellido(rs.getString("apellido"));
            u.setCarrera(rs.getString("carrera")); 
            u.setIdRol(rs.getInt("id_rol"));
        }
    } catch (SQLException e) {
        System.err.println("Error al obtener usuario por ID: " + e.getMessage());
    }
    return u;
}


    public void actualizar(Usuario u) {
        String sql = "UPDATE usuarios SET correo=?, password=?, nombre=?, apellido=?, carrera=?, id_rol=? WHERE id=?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getCorreo());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getNombre());
            ps.setString(4, u.getApellido());
            ps.setString(5, u.getCarrera());
            ps.setInt(6, u.getIdRol());
            ps.setInt(7, u.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario: " + e.getMessage());
        }
    }

    public void eliminar(int id) {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
        }
    }
    

    public String obtenerNombreRol(int idRol) {
        String nombreRol = null;
        String sql = "SELECT nombre FROM rol WHERE id = ?";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idRol);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nombreRol = rs.getString("nombre");
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener nombre del rol: " + e.getMessage());
        }
        
        return nombreRol;
    }
    
    public boolean existeCorreo(String correo) {
    String sql = "SELECT COUNT(*) FROM usuarios WHERE correo = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, correo);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (SQLException e) {
        System.err.println("Error al verificar existencia de correo: " + e.getMessage());
    }
    return false;
}


public List<Usuario> obtenerEstudiantesAsignadosADocente(int idDocente) {
    List<Usuario> lista = new ArrayList<>();
    String sql = "SELECT DISTINCT u.id, u.nombre, u.apellido, u.correo " +
                 "FROM usuarios u " +
                 "INNER JOIN curso_estudiante ce ON u.id = ce.id_usuario " +
                 "INNER JOIN curso_docente cd ON ce.id_curso = cd.id_curso " +
                 "WHERE cd.id_usuario = ? AND u.id_rol = 3 " +
                 "ORDER BY u.nombre, u.apellido";

    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, idDocente);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Usuario estudiante = new Usuario();
            estudiante.setId(rs.getInt("id"));
            estudiante.setNombre(rs.getString("nombre"));
            estudiante.setApellido(rs.getString("apellido"));
            estudiante.setCorreo(rs.getString("correo"));
            lista.add(estudiante);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return lista;
}

public boolean cambiarEstado(int id, int nuevoEstado) {
    String sql = "UPDATE usuarios SET estado = ? WHERE id = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, nuevoEstado);
        ps.setInt(2, id);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        System.err.println("Error al cambiar estado de usuario: " + e.getMessage());
        return false;
    }
}


  public List<Usuario> listarAlumnos() {
    List<Usuario> lista = new ArrayList<>();
    String sql = "SELECT * FROM usuarios WHERE id_rol = 3";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setCorreo(rs.getString("correo"));
            u.setPassword(rs.getString("password"));
            u.setNombre(rs.getString("nombre"));
            u.setApellido(rs.getString("apellido"));
            u.setCarrera(rs.getString("carrera"));
            u.setIdRol(rs.getInt("id_rol")); // ✅ FALTABA ESTA LÍNEA
            u.setEstado(rs.getInt("estado"));
            lista.add(u);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}


   public List<Usuario> listarAlumnosPorCarrera(String carrera) {
    List<Usuario> lista = new ArrayList<>();
    String sql = "SELECT * FROM usuarios WHERE id_rol = 3 AND carrera = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, carrera);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setCorreo(rs.getString("correo"));
            u.setPassword(rs.getString("password"));
            u.setNombre(rs.getString("nombre"));
            u.setApellido(rs.getString("apellido"));
            u.setCarrera(rs.getString("carrera"));
            u.setIdRol(rs.getInt("id_rol")); // 
            u.setEstado(rs.getInt("estado"));
            lista.add(u);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}


public boolean asignarGrupo(List<Integer> ids, String grupo) {
    String sql = "UPDATE usuarios SET grupo = ? WHERE id = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        for (int id : ids) {
            ps.setString(1, grupo);
            ps.setInt(2, id);
            ps.addBatch();
        }
        ps.executeBatch();
        return true;
    } catch (SQLException e) {
        System.err.println("Error al asignar grupo: " + e.getMessage());
        return false;
    }
}


public List<Usuario> listarAlumnosSinGrupo(String carrera) {
    List<Usuario> alumnos = new ArrayList<>();
    String sql = "SELECT u.id, u.correo, u.nombre, u.apellido, u.carrera " +
                "FROM usuarios u " +
                "WHERE u.id_rol = 3 AND u.carrera = ? " +
                "AND u.id NOT IN (SELECT ge.id_usuario FROM grupo_estudiante ge)";
    
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setString(1, carrera);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario alumno = new Usuario();
                alumno.setId(rs.getInt("id"));
                alumno.setCorreo(rs.getString("correo"));
                alumno.setNombre(rs.getString("nombre"));
                alumno.setApellido(rs.getString("apellido"));
                alumno.setCarrera(rs.getString("carrera"));
                alumnos.add(alumno);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return alumnos;
}











// AGREGAR estos métodos a tu UsuarioDAO existente

/**
 * Lista alumnos SIN grupo asignado por carrera
 */
public List<Usuario> listarAlumnosSinGrupoPorCarrera(String carrera) {
    List<Usuario> alumnos = new ArrayList<>();
    String sql = "SELECT u.id, u.correo, u.password, u.nombre, u.apellido, u.carrera " +
                "FROM usuarios u " +
                "WHERE u.id_rol = 3 AND u.estado = 1 AND u.carrera = ? " +
                "AND u.id NOT IN (SELECT ge.id_usuario FROM grupo_estudiante ge) " +
                "ORDER BY u.apellido, u.nombre";
    
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setString(1, carrera);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario alumno = new Usuario();
                alumno.setId(rs.getInt("id"));
                alumno.setCorreo(rs.getString("correo"));
                alumno.setPassword(rs.getString("password"));
                alumno.setNombre(rs.getString("nombre"));
                alumno.setApellido(rs.getString("apellido"));
                alumno.setCarrera(rs.getString("carrera"));
                alumno.setIdRol(3);
                alumno.setEstado(1);
                alumnos.add(alumno);
            }
        }
        
        System.out.println("📋 Alumnos SIN grupo encontrados para " + carrera + ": " + alumnos.size());
        
    } catch (SQLException e) {
        System.out.println("❌ Error al listar alumnos sin grupo: " + e.getMessage());
        e.printStackTrace();
    }
    
    return alumnos;
}

/**
 * Lista TODOS los alumnos SIN grupo asignado
 */
public List<Usuario> listarAlumnosSinGrupo() {
    List<Usuario> alumnos = new ArrayList<>();
    String sql = "SELECT u.id, u.correo, u.password, u.nombre, u.apellido, u.carrera " +
                "FROM usuarios u " +
                "WHERE u.id_rol = 3 AND u.estado = 1 " +
                "AND u.id NOT IN (SELECT ge.id_usuario FROM grupo_estudiante ge) " +
                "ORDER BY u.carrera, u.apellido, u.nombre";
    
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Usuario alumno = new Usuario();
            alumno.setId(rs.getInt("id"));
            alumno.setCorreo(rs.getString("correo"));
            alumno.setPassword(rs.getString("password"));
            alumno.setNombre(rs.getString("nombre"));
            alumno.setApellido(rs.getString("apellido"));
            alumno.setCarrera(rs.getString("carrera"));
            alumno.setIdRol(3);
            alumno.setEstado(1);
            alumnos.add(alumno);
        }
        
        System.out.println("📋 Total alumnos SIN grupo encontrados: " + alumnos.size());
        
    } catch (SQLException e) {
        System.out.println("❌ Error al listar alumnos sin grupo: " + e.getMessage());
        e.printStackTrace();
    }
    
    return alumnos;
}





// ✅ Nuevo método: asignar varios estudiantes de golpe a un grupo
public boolean asignarEstudiantesAGrupoBulk(int idGrupo, List<Integer> idsEstudiantes) {
    String sql = "INSERT INTO grupo_estudiante (id_grupo, id_usuario) VALUES (?, ?)";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        for (int id : idsEstudiantes) {
            ps.setInt(1, idGrupo);
            ps.setInt(2, id);
            ps.addBatch();
        }
        ps.executeBatch();
        return true;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}



}