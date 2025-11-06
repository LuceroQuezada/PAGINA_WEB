package SQL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author c-can
 */
public class conecct {

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/academia_grupoa1?useSSL=false&allowPublicKeyRetrieval=true",
                    "root", "123456"
            );
        } catch (ClassNotFoundException | SQLException e) { 
                  throw new SQLException("Driver MySQL no disponible", e);
        }
    }

}
