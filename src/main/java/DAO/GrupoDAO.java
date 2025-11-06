package DAO;

import SQL.conecct;
import modelo.Grupo;
import modelo.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GrupoDAO {
  
    public boolean asignarEstudianteAGrupo(int idGrupo, int idEstudiante) {
      
        if (estudianteYaTieneGrupo(idEstudiante)) {
            System.out.println(" El estudiante ya está asignado a un grupo");
            return false;
        }
        
        String sql = "INSERT INTO grupo_estudiante(id_grupo, id_usuario) VALUES (?, ?)";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idGrupo);
            ps.setInt(2, idEstudiante);
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Estudiante " + idEstudiante + " asignado al grupo " + idGrupo);
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println(" Error al asignar estudiante: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
   
    private boolean estudianteYaTieneGrupo(int idEstudiante) {
        String sql = "SELECT COUNT(*) FROM grupo_estudiante WHERE id_usuario = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idEstudiante);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println(" Error verificando grupo del estudiante: " + e.getMessage());
        }
        return false;
    }
    
  
    public List<Grupo> obtenerGruposPorCarrera(String carrera) {
        List<Grupo> grupos = new ArrayList<>();
        String sql = "SELECT id, nombre, carrera FROM grupo WHERE carrera = ? ORDER BY nombre";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, carrera);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Grupo grupo = new Grupo();
                    grupo.setId(rs.getInt("id"));
                    grupo.setNombre(rs.getString("nombre"));
                    grupo.setCarrera(rs.getString("carrera"));
                    
                  
                    grupo.setEstudiantes(obtenerEstudiantesDelGrupo(grupo.getId()));
                    
                    grupos.add(grupo);
                }
            }
        } catch (SQLException e) {
            System.out.println(" Error al obtener grupos por carrera: " + e.getMessage());
            e.printStackTrace();
        }
        
        return grupos;
    }
    
   
    public List<Grupo> listarGrupos() {
        List<Grupo> grupos = new ArrayList<>();
        String sql = "SELECT g.id, g.nombre, g.carrera FROM grupo g ORDER BY g.carrera, g.nombre";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Grupo grupo = new Grupo();
                grupo.setId(rs.getInt("id"));
                grupo.setNombre(rs.getString("nombre"));
                grupo.setCarrera(rs.getString("carrera"));
                
             
                grupo.setEstudiantes(obtenerEstudiantesDelGrupo(grupo.getId()));
                
                grupos.add(grupo);
                System.out.println("Grupo encontrado: " + grupo.getNombre() + " con " + grupo.getEstudiantes().size() + " estudiantes");
            }
            
            System.out.println("Total de grupos encontrados: " + grupos.size());
        } catch (SQLException e) {
            System.out.println("Error al listar grupos: " + e.getMessage());
            e.printStackTrace();
        }
        
        return grupos;
    }
    

    public List<Grupo> listarGruposPorCarrera(String carrera) {
        return obtenerGruposPorCarrera(carrera);
    }
    
 
    public List<Usuario> obtenerEstudiantesDelGrupo(int idGrupo) {
        List<Usuario> estudiantes = new ArrayList<>();
        String sql = "SELECT u.id, u.nombre, u.apellido, u.correo, u.carrera " +
                    "FROM usuarios u " +
                    "INNER JOIN grupo_estudiante ge ON u.id = ge.id_usuario " +
                    "WHERE ge.id_grupo = ? ORDER BY u.apellido, u.nombre";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idGrupo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Usuario estudiante = new Usuario();
                    estudiante.setId(rs.getInt("id"));
                    estudiante.setNombre(rs.getString("nombre"));
                    estudiante.setApellido(rs.getString("apellido"));
                    estudiante.setCorreo(rs.getString("correo"));
                    estudiante.setCarrera(rs.getString("carrera"));
                    estudiantes.add(estudiante);
                }
            }
        } catch (SQLException e) {
            System.out.println(" Error al obtener estudiantes del grupo " + idGrupo + ": " + e.getMessage());
            e.printStackTrace();
        }
        
        return estudiantes;
    }
    
 
    public boolean removerEstudianteDeGrupo(int idEstudiante) {
        String sql = "DELETE FROM grupo_estudiante WHERE id_usuario = ?";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idEstudiante);
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Estudiante " + idEstudiante + " removido de su grupo");
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println(" Error al remover estudiante del grupo: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
   
    public void testConexion() {
        String sql = "SELECT COUNT(*) as total FROM grupo";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                int total = rs.getInt("total");
                System.out.println("Total de grupos en BD: " + total);
            }
        } catch (SQLException e) {
            System.out.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
        }
    }
    

public boolean eliminarGrupo(int idGrupo) {
    Connection con = null;
    try {
        con = conecct.getConnection();
        con.setAutoCommit(false);  
        
   
        String sqlEstudiantes = "DELETE FROM grupo_estudiante WHERE id_grupo = ?";
        try (PreparedStatement ps1 = con.prepareStatement(sqlEstudiantes)) {
            ps1.setInt(1, idGrupo);
            int estudiantesEliminados = ps1.executeUpdate();
            System.out.println("Eliminadas " + estudiantesEliminados + " asignaciones de estudiantes");
        }
        

        String sqlGrupo = "DELETE FROM grupo WHERE id = ?";
        try (PreparedStatement ps2 = con.prepareStatement(sqlGrupo)) {
            ps2.setInt(1, idGrupo);
            int gruposEliminados = ps2.executeUpdate();
            
            if (gruposEliminados > 0) {
                con.commit(); // Confirmar transacción
                System.out.println(" Grupo " + idGrupo + " eliminado exitosamente");
                return true;
            } else {
                con.rollback(); // Revertir si no se eliminó el grupo
                System.out.println(" No se encontró el grupo " + idGrupo);
                return false;
            }
        }
        
    } catch (SQLException e) {
        try {
            if (con != null) {
                con.rollback(); 
            }
        } catch (SQLException rollbackEx) {
            System.out.println(" Error en rollback: " + rollbackEx.getMessage());
        }
        System.out.println("Error al eliminar grupo: " + e.getMessage());
        e.printStackTrace();
        return false;
    } finally {
        try {
            if (con != null) {
                con.setAutoCommit(true); 
                con.close();
            }
        } catch (SQLException e) {
            System.out.println(" Error al cerrar conexión: " + e.getMessage());
        }
    }
}


public boolean actualizarNombreGrupo(int idGrupo, String nuevoNombre) {
    String sql = "UPDATE grupo SET nombre = ? WHERE id = ?";
    
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setString(1, nuevoNombre);
        ps.setInt(2, idGrupo);
        int rowsAffected = ps.executeUpdate();
        
        if (rowsAffected > 0) {
            System.out.println("Nombre del grupo " + idGrupo + " actualizado a: " + nuevoNombre);
            return true;
        }
        
    } catch (SQLException e) {
        System.out.println("Error al actualizar nombre del grupo: " + e.getMessage());
        e.printStackTrace();
    }
    
    return false;
}


public Grupo obtenerGrupoPorId(int idGrupo) {
    Grupo grupo = null;
    String sql = "SELECT id, nombre, carrera FROM grupo WHERE id = ?";
    
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setInt(1, idGrupo);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                grupo = new Grupo();
                grupo.setId(rs.getInt("id"));
                grupo.setNombre(rs.getString("nombre"));
                grupo.setCarrera(rs.getString("carrera"));
                

                grupo.setEstudiantes(obtenerEstudiantesDelGrupo(grupo.getId()));
            }
        }
    } catch (SQLException e) {
        System.out.println(" Error al obtener grupo por ID: " + e.getMessage());
        e.printStackTrace();
    }
    
    return grupo;
}


public int contarGruposPorCarrera(String carrera) {
    String sql = "SELECT COUNT(*) FROM grupo WHERE carrera = ?";
    
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setString(1, carrera);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
    } catch (SQLException e) {
        System.out.println(" Error al contar grupos por carrera: " + e.getMessage());
    }
    
    return 0;
}
}