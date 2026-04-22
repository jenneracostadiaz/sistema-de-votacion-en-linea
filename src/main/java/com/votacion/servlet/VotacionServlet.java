package com.votacion.servlet;

import com.votacion.dao.VotoDAO;
import com.votacion.model.Voto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet que recibe y registra un voto de encuesta.
 */
@WebServlet(name = "VotacionServlet", urlPatterns = {"/votar"})
public class VotacionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Extraer parámetros del formulario
        String opcion = request.getParameter("opcion");
        String nombre = request.getParameter("nombre");

        // 2. Validar que la opción no sea nula ni vacía
        if (opcion == null || opcion.trim().isEmpty()) {
            request.setAttribute("error", "Debes seleccionar una opción");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        try {
            // 3. Construir el objeto Voto con los datos recibidos
            Voto voto = new Voto(opcion.trim(), nombre);

            // 4. Delegar la persistencia al DAO
            VotoDAO dao = new VotoDAO();
            dao.registrar(voto);

            // 5. Redirigir a la página de resultados tras éxito
            response.sendRedirect(request.getContextPath() + "/resultados");

        } catch (Exception e) {
            // 6. En caso de error, volver al formulario con mensaje
            getServletContext().log("VotacionServlet error al registrar voto", e);
            request.setAttribute("error", "Error al registrar el voto, intenta de nuevo");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
