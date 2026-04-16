package com.votacion.servlet;

import com.votacion.dao.ResultadosDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

/**
 * Servlet que consulta y muestra los resultados de la encuesta.
 */
@WebServlet(name = "ResultadosServlet", urlPatterns = {"/resultados"})
public class ResultadosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Obtener el conteo de votos por opción desde el DAO
            ResultadosDAO dao = new ResultadosDAO();
            Map<String, Integer> resultados = dao.obtenerConteo();

            // 2. Guardar el mapa como atributo del request
            request.setAttribute("resultados", resultados);

            // 3. Si no hay votos, señalarlo para que la JSP lo maneje
            if (resultados == null || resultados.isEmpty()) {
                request.setAttribute("sinVotos", true);
            }

        } catch (Exception e) {
            // 4. En caso de error, pasar mensaje a la JSP
            request.setAttribute("error", "No se pudieron cargar los resultados");
        }

        // 5. Hacer forward a la vista de resultados
        request.getRequestDispatcher("resultados.jsp").forward(request, response);
    }
}
