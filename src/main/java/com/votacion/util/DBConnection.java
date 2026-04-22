package com.votacion.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utilidad de conexión a MySQL.
 * Ajusta aquí las credenciales según tu entorno local.
 */
public class DBConnection {

    // Valores por defecto alineados con README.
    private static final String DB_URL =
            "jdbc:mysql://127.0.0.1:3306/votacion_db?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("No se pudo cargar el driver de MySQL", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
