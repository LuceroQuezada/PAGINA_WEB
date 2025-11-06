package DAO;

import modelo.MaterialCurso;
import modelo.Curso;
import SQL.conecct;
import java.sql.*;
import java.util.*;

public class MaterialCursoDAO {
    
    public boolean insertar(MaterialCurso m) {
        String sql =
            "INSERT INTO material_curso " +
            "(id_usuario, id_curso, id_seccion, titulo, descripcion, archivo, tipo) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, m.getIdUsuario());
            
            if (m.getIdCurso() != null) {
                ps.setInt(2, m.getIdCurso());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            
            if (m.getIdSeccion() != null) {
                ps.setInt(3, m.getIdSeccion());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            
            ps.setString(4, m.getTitulo());
            ps.setString(5, m.getDescripcion());
            ps.setString(6, m.getArchivo());
            ps.setString(7, m.getTipo());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<MaterialCurso> listarPorCarrera(String carrera) {
        List<MaterialCurso> lista = new ArrayList<>();
        String sql = 
            "SELECT m.*, c.nombre as curso_nombre, u.nombre as usuario_nombres " +
            "FROM material_curso m " +
            "LEFT JOIN curso c ON m.id_curso = c.id " +
            "LEFT JOIN usuarios u ON m.id_usuario = u.id " +
            "WHERE c.carrera = ? " +
            "ORDER BY m.fecha_subida DESC";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, carrera);
            ResultSet rs = ps.executeQuery();
            
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
                
                m.setCursoNombre(rs.getString("curso_nombre"));
                m.setUsuarioNombres(rs.getString("usuario_nombres"));
                
                lista.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    

    public MaterialCurso obtenerPorId(int id) {
        String sql = "SELECT * FROM material_curso WHERE id = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
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
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    

    public boolean eliminar(int id) {
        String sql = "DELETE FROM material_curso WHERE id = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    

    public List<MaterialCurso> listarPorCurso(int idCurso) {
        List<MaterialCurso> lista = new ArrayList<>();
        String sql = 
            "SELECT m.*, u.nombre as usuario_nombres " +
            "FROM material_curso m " +
            "LEFT JOIN usuarios u ON m.id_usuario = u.id " +
            "WHERE m.id_curso = ? " +
            "ORDER BY m.fecha_subida DESC";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCurso);
            ResultSet rs = ps.executeQuery();
            
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
                m.setUsuarioNombres(rs.getString("usuario_nombres"));
                
                lista.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}