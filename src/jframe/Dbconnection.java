package jframe;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Dbconnection {
    private static Connection con;

    // Database connection details (replace with yours)
    private static final String url = "jdbc:mysql://localhost:4306/librairy";
    private static final String username = "root";
    private static final String password = "";

    static {
        try {
            // Register JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        if (con == null || con.isClosed()) {
            con = DriverManager.getConnection(url, username, password);
        }
        return con;
    }

    public static void closeConnection() {
        if (con != null) {
            try {
                con.close();
                System.out.println("Connexion à la base de données fermée.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    static {
        // Add a shutdown hook to close the connection when the program exits
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            closeConnection();
        }));
    }
}

