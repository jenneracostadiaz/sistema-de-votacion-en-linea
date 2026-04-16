package com.votacion.dao;

import com.votacion.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Acceso a datos para resultados de encuestas.
 */
public class ResultadosDAO {

    // Devuelve el conteo de votos agrupado por opción
    public Map<String, Integer> obtenerConteo() throws Exception {
        String sql = "SELECT opcion, COUNT(*) AS total FROM votos WHERE encuesta_id = 1 GROUP BY opcion ORDER BY total DESC";
        Map<String, Integer> resultados = new LinkedHashMap<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                resultados.put(rs.getString("opcion"), rs.getInt("total"));
            }
        }

        return resultados;
    }
}
