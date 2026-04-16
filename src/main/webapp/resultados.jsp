<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultados - Votación en Línea</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<h1>Resultados de la Encuesta</h1>

<c:choose>
    <%-- 1. Error al cargar datos --%>
    <c:when test="${not empty error}">
        <p class="alerta"><c:out value="${error}"/></p>
    </c:when>

    <%-- 2. Sin votos registrados --%>
    <c:when test="${sinVotos}">
        <p class="mensaje-info">Aún no hay votos registrados</p>
    </c:when>

    <%-- 3. Tabla de resultados --%>
    <c:otherwise>
        <%-- Calcular el total de votos --%>
        <c:set var="totalVotos" value="${0}" />
        <c:forEach var="entrada" items="${resultados}">
            <c:set var="totalVotos" value="${totalVotos + entrada.value}" />
        </c:forEach>

        <table>
            <thead>
                <tr>
                    <th>Opción</th>
                    <th>Votos</th>
                    <th>Porcentaje</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="entrada" items="${resultados}">
                    <tr>
                        <td><c:out value="${entrada.key}"/></td>
                        <td><c:out value="${entrada.value}"/></td>
                        <td>
                            <fmt:formatNumber value="${entrada.value / totalVotos}"
                                              type="percent"
                                              maxFractionDigits="1" />
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

<p class="enlace-volver">
    <a href="${pageContext.request.contextPath}/">Volver a la encuesta</a>
</p>

</body>
</html>
