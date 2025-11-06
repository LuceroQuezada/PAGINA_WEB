package DAO;

import modelo.Rol;
import SQL.conecct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RolDAO {
    

    public List<Rol> obtenerTodos() {
        List<Rol> roles = new ArrayList<>();
        String sql = "SELECT * FROM rol";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Rol rol = new Rol();
                rol.setId(rs.getInt("id"));
                rol.setNombre(rs.getString("nombre"));
                roles.add(rol);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener roles: " + e.getMessage());
        }
        
        return roles;
    }
    

    public Rol obtenerPorId(int id) {
        Rol rol = null;
        String sql = "SELECT * FROM rol WHERE id = ?";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                rol = new Rol();
                rol.setId(rs.getInt("id"));
                rol.setNombre(rs.getString("nombre"));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener rol por ID: " + e.getMessage());
        }
        
        return rol;
    }
    

    public Rol obtenerPorNombre(String nombre) {
        Rol rol = null;
        String sql = "SELECT * FROM rol WHERE nombre = ?";
        
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nombre);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                rol = new Rol();
                rol.setId(rs.getInt("id"));
                rol.setNombre(rs.getString("nombre"));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener rol por nombre: " + e.getMessage());
        }
        
        return rol;
    }
}