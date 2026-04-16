package com.votacion.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Utilidad de conexión a MySQL.
 */
public class DBConnection {

    private static final String URL = "jdbc:mysql://127.0.0.1:3306/votacion_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
