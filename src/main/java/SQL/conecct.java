package SQL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class conecct {

    // 🔹 URL completa hacia tu instancia RDS (SSL desactivado para evitar error del keystore)
    private static final String URL =
        "jdbc:mysql://database-1.cjqokoekaqsn.us-east-2.rds.amazonaws.com:3306/academia_a1"
      + "?sslMode=DISABLED"
      + "&allowPublicKeyRetrieval=true"
      + "&serverTimezone=UTC";

    // 🔹 Credenciales del RDS
    private static final String USER = "admin";
    private static final String PASS = "Hebertjose89";

    // 🔹 Método central de conexión
    public static Connection getConnection() throws SQLException {
        try {
            // Carga del driver JDBC de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Propiedades de conexión
            Properties props = new Properties();
            props.setProperty("user", USER);
            props.setProperty("password", PASS);

            // Intentar conexión
            Connection conn = DriverManager.getConnection(URL, props);
            System.out.println("✅ Conectado correctamente a AWS RDS");
            return conn;

        } catch (ClassNotFoundException e) {
            throw new SQLException("❌ No se encontró el driver MySQL (agrega mysql-connector-j al classpath).", e);

        } catch (SQLException e) {
            // Mostrar detalles completos para diagnóstico
            System.err.println("❌ Error conectando a RDS: " + e.getMessage());
            System.err.println("   SQLState = " + e.getSQLState());
            System.err.println("   Code     = " + e.getErrorCode());
            throw e; // volver a lanzar para que el servlet lo capture si es necesario
        }
    }
}