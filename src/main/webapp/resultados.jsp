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
<header class="topbar">
    <div class="topbar-inner">
        <div class="brand">
            <svg class="brand-icon" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M3 6a2 2 0 0 1 2-2h10.5a2 2 0 0 1 2 2v1h1.5a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2H8.5a2 2 0 0 1-2-2v-1H5a2 2 0 0 1-2-2V6zm4.5 10.5V18a.5.5 0 0 0 .5.5h11a.5.5 0 0 0 .5-.5V9a.5.5 0 0 0-.5-.5h-1.5V15a2 2 0 0 1-2 2H7.5zm2-6.7v1.9h4.2V13h-4.2v1.7H8V9.8h1.5z"/>
            </svg>
            <span>VotaFácil</span>
        </div>
    </div>
</header>

<main class="page">
    <section class="card">
        <c:set var="totalVotos" value="${0}" />
        <c:forEach var="entrada" items="${resultados}">
            <c:set var="totalVotos" value="${totalVotos + entrada.value}" />
        </c:forEach>

        <div class="header-row">
            <h1>Resultados</h1>
            <span class="badge badge-neutral">${totalVotos} votos</span>
        </div>

        <c:choose>
            <c:when test="${not empty error}">
                <div class="alerta" role="alert">
                    <svg class="alert-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 2 1 21h22L12 2zm0 5.8 7.1 12.2H4.9L12 7.8zm-1 3.2v4h2v-4h-2zm0 5.5v2h2v-2h-2z"/>
                    </svg>
                    <span><c:out value="${error}"/></span>
                </div>
            </c:when>

            <c:when test="${sinVotos}">
                <div class="estado-vacio">
                    <svg class="empty-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 2a10 10 0 1 0 10 10A10 10 0 0 0 12 2zm0 17a7 7 0 0 1-7-7h14a7 7 0 0 1-7 7zm-3-9a1.5 1.5 0 1 1 1.5-1.5A1.5 1.5 0 0 1 9 10zm6 0a1.5 1.5 0 1 1 1.5-1.5A1.5 1.5 0 0 1 15 10z"/>
                    </svg>
                    <p>Aún no hay votos registrados. Sé el primero en participar.</p>
                </div>
            </c:when>

            <c:otherwise>
                <c:set var="maxVotos" value="0"/>
                <c:forEach var="entrada" items="${resultados}">
                    <c:if test="${entrada.value > maxVotos}">
                        <c:set var="maxVotos" value="${entrada.value}"/>
                        <c:set var="ganador" value="${entrada.key}"/>
                    </c:if>
                </c:forEach>

                <div class="results-list">
                    <c:forEach var="entrada" items="${resultados}">
                        <fmt:formatNumber value="${entrada.value / totalVotos}" type="percent" maxFractionDigits="1" var="porcentajeTexto" />
                        <fmt:formatNumber value="${(entrada.value * 100.0) / totalVotos}" minFractionDigits="0" maxFractionDigits="1" var="porcentajeNumero" />
                        <div class="resultado-card ${entrada.key eq ganador ? 'lider' : ''}">
                            <div class="resultado-top">
                                <div class="opcion-nombre">
                                    <c:out value="${entrada.key}"/>
                                    <c:if test="${entrada.key eq ganador}">
                                        <span class="badge badge-leader">Líder</span>
                                    </c:if>
                                </div>
                                <div class="resultado-meta">
                                    <span><c:out value="${entrada.value}"/> votos</span>
                                    <span><c:out value="${porcentajeTexto}"/></span>
                                </div>
                            </div>
                            <div class="progress-track" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="${porcentajeNumero}">
                                <div class="progress-fill" data-target-width="${porcentajeNumero}%"></div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <p class="enlace-volver">
            <a class="btn-outline" href="${pageContext.request.contextPath}/">Volver a votar</a>
        </p>
    </section>
</main>
<script>
    (function () {
        const fills = Array.from(document.querySelectorAll('.progress-fill'));
        if (!fills.length) {
            return;
        }
        fills.forEach((fill) => {
            fill.style.width = '0%';
        });
        requestAnimationFrame(function () {
            setTimeout(function () {
                fills.forEach((fill) => {
                    const target = fill.getAttribute('data-target-width') || '0%';
                    fill.style.width = target;
                });
            }, 80);
        });
    })();
</script>
</body>
</html>
