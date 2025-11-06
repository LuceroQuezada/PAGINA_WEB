// DAO/HorarioDAO.java
package DAO;

import SQL.conecct;
import modelo.Horario;
import java.sql.*;
import java.util.*;

public class HorarioDAO {

    public List<Horario> listar() {
        List<Horario> lista = new ArrayList<>();
        String sql = "SELECT * FROM horario";
        try (Connection con = conecct.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Horario h = new Horario();
                h.setId(rs.getInt("id"));
                h.setIdCursoDocente(rs.getInt("id_curso_docente"));
                h.setDia(rs.getString("dia"));
                h.setHoraInicio(rs.getString("hora_inicio"));
                h.setHoraFin(rs.getString("hora_fin"));
                lista.add(h);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
public boolean insertar(Horario h) {
    String sql = "INSERT INTO horario (id_curso_docente, dia, hora_inicio, hora_fin) VALUES (?, ?, ?, ?)";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        System.out.println("DEBUG → Intentando insertar en horario:");
        System.out.println("    id_curso_docente: " + h.getIdCursoDocente());
        System.out.println("    dia: " + h.getDia());
        System.out.println("    hora_inicio: " + h.getHoraInicio());
        System.out.println("    hora_fin: " + h.getHoraFin());

        // ✅ Seteamos los parámetros ANTES de ejecutar
        ps.setInt(1, h.getIdCursoDocente());
        ps.setString(2, h.getDia());
        ps.setString(3, h.getHoraInicio());
        ps.setString(4, h.getHoraFin());

        int filas = ps.executeUpdate();
        System.out.println("DEBUG → Filas insertadas: " + filas);
        return filas > 0;
    } catch (Exception e) {
        System.out.println("❌ DEBUG → Error SQL al insertar:");
        e.printStackTrace();
        return false;
    }
}


    public boolean eliminar(int id) {
        String sql = "DELETE FROM horario WHERE id=?";
        try (Connection con = conecct.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
