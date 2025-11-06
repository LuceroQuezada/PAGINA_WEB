package DAO;

import SQL.conecct;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Preinscripcion;

public class PreinscripcionDAO {
    
  
public int getIdPorDni(String dni) {
    String sql = "SELECT id FROM preinscripcion WHERE dni = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, dni);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("id");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}


    public boolean existeDuplicado(String dni, String correo, String nombre, String apellido) {
        String sql = "SELECT COUNT(*) FROM preinscripcion " +
                     "WHERE dni=? OR email=? OR (nombre=? AND apellido=?)";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ps.setString(2, correo);
            ps.setString(3, nombre);
            ps.setString(4, apellido);
            ResultSet rs = ps.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
        
        
    }
    

   public void guardar(Preinscripcion p) {
    int idExistente = getIdPorDni(p.getDni());
    try (Connection con = conecct.getConnection()) {
        if (idExistente == 0) {
            // INSERT NUEVO
            String sqlPre = "INSERT INTO preinscripcion "
                + "(nombre, apellido, dni, email, direccion, colegio, carrera, estado) "
                + "VALUES (?,?,?,?,?,?,?, 'pendiente')";
            PreparedStatement ps = con.prepareStatement(sqlPre, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, p.getNombres());
            ps.setString(2, p.getApellidos());
            ps.setString(3, p.getDni());
            ps.setString(4, p.getCorreo());
            ps.setString(5, p.getDireccion());
            ps.setString(6, p.getColegio());
            ps.setString(7, p.getCarrera());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idExistente = rs.getInt(1);
            }
        } else {
            // UPDATE EXISTENTE → vuelve a pendiente
            String sqlUpd = "UPDATE preinscripcion SET "
                + "nombre=?, apellido=?, email=?, direccion=?, colegio=?, carrera=?, estado='pendiente' "
                + "WHERE id = ?";
            PreparedStatement psUpd = con.prepareStatement(sqlUpd);
            psUpd.setString(1, p.getNombres());
            psUpd.setString(2, p.getApellidos());
            psUpd.setString(3, p.getCorreo());
            psUpd.setString(4, p.getDireccion());
            psUpd.setString(5, p.getColegio());
            psUpd.setString(6, p.getCarrera());
            psUpd.setInt(7, idExistente);
            psUpd.executeUpdate();
        }

        // ahora teléfono (siempre upsert también)
        String sqlTelCheck = "SELECT COUNT(*) FROM telefono WHERE id_preinscripcion = ?";
        PreparedStatement psCheck = con.prepareStatement(sqlTelCheck);
        psCheck.setInt(1, idExistente);
        ResultSet rs2 = psCheck.executeQuery();
        boolean telExiste = false;
        if (rs2.next()) telExiste = rs2.getInt(1) > 0;

        if (telExiste) {
            String sqlTelUpd = "UPDATE telefono SET numero = ? WHERE id_preinscripcion = ?";
            PreparedStatement psTelUpd = con.prepareStatement(sqlTelUpd);
            psTelUpd.setString(1, p.getTelefono());
            psTelUpd.setInt(2, idExistente);
            psTelUpd.executeUpdate();
        } else {
            String sqlTelIns = "INSERT INTO telefono (id_preinscripcion, numero) VALUES (?,?)";
            PreparedStatement psTelIns = con.prepareStatement(sqlTelIns);
            psTelIns.setInt(1, idExistente);
            psTelIns.setString(2, p.getTelefono());
            psTelIns.executeUpdate();
        }

    } catch (Exception e) {
        e.printStackTrace();
        throw new RuntimeException(e);
    }
}


    public String obtenerEstadoPorDni(String dni) {
        String sql = "SELECT estado FROM preinscripcion WHERE dni=?";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("estado");
        } catch (Exception e) { e.printStackTrace(); }
        return "no_encontrado";
    }

public List<Preinscripcion> listarPorEstado(String estadoBuscado) {
    List<Preinscripcion> lista = new ArrayList<>();
    String sql = "SELECT * FROM preinscripcion WHERE estado = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, estadoBuscado);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Preinscripcion p = new Preinscripcion();
            p.setId(rs.getInt("id"));
            p.setNombres(rs.getString("nombre"));
            p.setApellidos(rs.getString("apellido"));
            p.setCorreo(rs.getString("email"));
            p.setDni(rs.getString("dni"));
            p.setDireccion(rs.getString("direccion"));
            p.setColegio(rs.getString("colegio"));
            p.setCarrera(rs.getString("carrera"));
            p.setEstado(rs.getString("estado"));
            p.setIntentos(rs.getInt("intentos"));
            lista.add(p);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return lista;
}



public void actualizarEstado(String dni, String nuevoEstado) {
    String sql = "UPDATE preinscripcion SET estado = ? WHERE dni = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, nuevoEstado);
        ps.setString(2, dni);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public int getIntentos(String dni) {
    String sql = "SELECT intentos FROM preinscripcion WHERE dni = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, dni);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt("intentos");
    } catch (Exception e) { e.printStackTrace(); }
    return 0;
}


public void incrementarIntentos(String dni) {
    String sql = "UPDATE preinscripcion SET intentos = intentos + 1 WHERE dni = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, dni);
        ps.executeUpdate();
    } catch (Exception e) { e.printStackTrace(); }
}


public void resetIntentos(String dni) {
    String sql = "UPDATE preinscripcion SET intentos = 0 WHERE dni = ?";
    try (Connection con = conecct.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, dni);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

 public void insertarUsuarioDesdePreinscripcion(Preinscripcion pre, String password) {
        String sql = "INSERT INTO usuarios "
                   + "(correo, password, nombre, apellido, carrera, id_rol, estado) "
                   + "VALUES (?, ?, ?, ?, ?, 3, 1)";
        try (Connection con = conecct.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {


            String correoGenerado = "u" + pre.getDni() + "@academiaA1.com";

            ps.setString(1, correoGenerado);
            ps.setString(2, password);
            ps.setString(3, pre.getNombres());
            ps.setString(4, pre.getApellidos());
            ps.setString(5, pre.getCarrera());
            ps.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error al insertar alumno desde preinscripción: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }


}
