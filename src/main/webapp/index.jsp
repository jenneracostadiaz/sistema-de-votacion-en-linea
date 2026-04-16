<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Votación en Línea</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<h1>Sistema de Votación</h1>

<!-- Mensaje de error si el servlet lo envió -->
<c:if test="${not empty error}">
    <p class="alerta"><c:out value="${error}"/></p>
</c:if>

<form method="POST" action="${pageContext.request.contextPath}/votar">

    <fieldset>
        <legend>Selecciona una opción</legend>

        <div class="opcion">
            <label>
                <input type="radio" name="opcion" value="Opcion A"> Opción A
            </label>
        </div>
        <div class="opcion">
            <label>
                <input type="radio" name="opcion" value="Opcion B"> Opción B
            </label>
        </div>
        <div class="opcion">
            <label>
                <input type="radio" name="opcion" value="Opcion C"> Opción C
            </label>
        </div>
        <div class="opcion">
            <label>
                <input type="radio" name="opcion" value="Opcion D"> Opción D
            </label>
        </div>
    </fieldset>

    <div>
        <label for="nombre">Nombre del votante</label>
        <input type="text" id="nombre" name="nombre" placeholder="Tu nombre (opcional)">
    </div>

    <br>

    <button type="submit">Votar</button>

</form>

</body>
</html>
