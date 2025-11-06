package DAO;

import SQL.conecct;
import modelo.Asistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;  // ✅ usa sql.Date, no util.Date
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaDAO {
 
    public List<Asistencia> listarPorSeccionYFecha(int idSeccion, LocalDate fecha) {
        List<Asistencia> lista = new ArrayList<>();
        String sql =
          "SELECT id, id_seccion, id_estudiante, fecha, presente " +
          "  FROM asistencia " +
          " WHERE id_seccion = ? AND fecha = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idSeccion);
            ps.setDate(2, Date.valueOf(fecha)); // ✅ sql.Date
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Asistencia a = new Asistencia();
                    a.setId(rs.getInt("id"));
                    a.setIdSeccion(rs.getInt("id_seccion"));
                    a.setIdEstudiante(rs.getInt("id_estudiante"));
                    a.setFecha(rs.getDate("fecha").toLocalDate());
                    a.setPresente(rs.getBoolean("presente"));
                    lista.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error listando asistencias", e);
        }
        return lista;
    }

   
    public void insertar(Asistencia a) {
        String sql =
          "INSERT INTO asistencia(id_seccion,id_estudiante,fecha,presente) VALUES(?,?,?,?)";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, a.getIdSeccion());
            ps.setInt(2, a.getIdEstudiante());
            ps.setDate(3, Date.valueOf(a.getFecha()));
            ps.setBoolean(4, a.isPresente());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error insertando asistencia", e);
        }
    }

   
    public void actualizar(Asistencia a) {
        String sql = "UPDATE asistencia SET presente = ? " +
                     " WHERE id_seccion = ? AND id_estudiante = ? AND fecha = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, a.isPresente());
            ps.setInt(2, a.getIdSeccion());
            ps.setInt(3, a.getIdEstudiante());
            ps.setDate(4, Date.valueOf(a.getFecha()));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error actualizando asistencia", e);
        }
    }
    
    
    
    
}

