package DAO;

import SQL.conecct;
import modelo.Curso;
import java.sql.*;
import java.util.*;


public class CursoDAO {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public List<Curso> listar() {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT * FROM curso";
        try {
            con = conecct.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Curso c = new Curso();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
                c.setCarrera(rs.getString("carrera"));
                lista.add(c);
            }
        } catch (Exception e) {
            System.out.println("Error al listar cursos: " + e.getMessage());
        }
        return lista;
    }

    public boolean insertar(Curso c) {
        String sql = "INSERT INTO curso(nombre, carrera) VALUES (?,?)";
        try {
            con = conecct.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getCarrera());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Error al insertar curso: " + e.getMessage());
            return false;
        }
    }
    
    
    
    
  public List<Curso> listarPorCarrera(String carrera) {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT * FROM curso WHERE carrera = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, carrera);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Curso c = new Curso();
                    c.setId(rs.getInt("id"));
                    c.setNombre(rs.getString("nombre"));
                    c.setCarrera(rs.getString("carrera"));
                    lista.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
  
  
}
    

