package DAO;

import modelo.Nota;
import SQL.conecct;
import java.sql.*;
import java.util.*;

public class NotaDAO {
    /** Lista todas las notas de una sección */
    public List<Nota> listarPorSeccion(int idSeccion) {
        List<Nota> lista = new ArrayList<>();
        String sql =
            "SELECT id, id_seccion, id_estudiante, nota1, nota2, nota3, nota_final, promedio "
          + "FROM nota "
          + "WHERE id_seccion = ?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idSeccion);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Nota n = new Nota();
                    n.setId(rs.getInt("id"));
                    n.setIdSeccion(rs.getInt("id_seccion"));
                    n.setIdEstudiante(rs.getInt("id_estudiante"));
                    n.setNota1(rs.getDouble("nota1"));
                    n.setNota2(rs.getDouble("nota2"));
                    n.setNota3(rs.getDouble("nota3"));
                    n.setNotaFinal(rs.getDouble("nota_final"));
                    n.setPromedio(rs.getDouble("promedio"));
                    lista.add(n);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /** Inserta nuevas notas */
    public void insertar(Nota n) {
        String sql =
            "INSERT INTO nota "
          + "(id_seccion, id_estudiante, nota1, nota2, nota3, nota_final, promedio) "
          + "VALUES (?,?,?,?,?,?,?)";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, n.getIdSeccion());
            ps.setInt(2, n.getIdEstudiante());
            ps.setDouble(3, n.getNota1());
            ps.setDouble(4, n.getNota2());
            ps.setDouble(5, n.getNota3());
            ps.setDouble(6, n.getNotaFinal());
            ps.setDouble(7, n.getPromedio());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void actualizar(Nota n) {
        String sql =
            "UPDATE nota "
          + "SET nota1=?, nota2=?, nota3=?, nota_final=?, promedio=? "
          + "WHERE id_seccion=? AND id_estudiante=?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDouble(1, n.getNota1());
            ps.setDouble(2, n.getNota2());
            ps.setDouble(3, n.getNota3());
            ps.setDouble(4, n.getNotaFinal());
            ps.setDouble(5, n.getPromedio());
            ps.setInt(6, n.getIdSeccion());
            ps.setInt(7, n.getIdEstudiante());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
