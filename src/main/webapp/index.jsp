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
        <div class="header-stack">
            <span class="badge badge-success">Encuesta activa</span>
            <h1>Sistema de Votación</h1>
            <p class="lead">Selecciona tu opción favorita y emite tu voto de forma rápida y segura.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alerta" role="alert">
                <svg class="alert-icon" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M12 2 1 21h22L12 2zm0 5.8 7.1 12.2H4.9L12 7.8zm-1 3.2v4h2v-4h-2zm0 5.5v2h2v-2h-2z"/>
                </svg>
                <span><c:out value="${error}"/></span>
            </div>
        </c:if>

        <form method="POST" action="${pageContext.request.contextPath}/votar" class="votacion-form">
            <div class="options-list" role="radiogroup" aria-label="Selecciona una opción">
                <label class="opcion-card" for="opcionA">
                    <input id="opcionA" type="radio" name="opcion" value="Opcion A" aria-required="true">
                    <span class="opcion-title">Opción A</span>
                </label>

                <label class="opcion-card" for="opcionB">
                    <input id="opcionB" type="radio" name="opcion" value="Opcion B" aria-required="true">
                    <span class="opcion-title">Opción B</span>
                </label>

                <label class="opcion-card" for="opcionC">
                    <input id="opcionC" type="radio" name="opcion" value="Opcion C" aria-required="true">
                    <span class="opcion-title">Opción C</span>
                </label>

                <label class="opcion-card" for="opcionD">
                    <input id="opcionD" type="radio" name="opcion" value="Opcion D" aria-required="true">
                    <span class="opcion-title">Opción D</span>
                </label>
            </div>

            <div class="field-group">
                <label for="nombre">Nombre del votante</label>
                <div class="input-wrap">
                    <svg class="input-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 12a5 5 0 1 0-5-5 5 5 0 0 0 5 5zm0 2c-4.3 0-8 2.2-8 5v1h16v-1c0-2.8-3.7-5-8-5z"/>
                    </svg>
                    <input type="text" id="nombre" name="nombre" placeholder="Tu nombre (opcional)">
                </div>
                <p class="hint">Tu identidad no será publicada</p>
            </div>

            <button id="submitVoto" type="submit" disabled>Emitir voto</button>
        </form>

        <p class="footer-note">Voto seguro · Token único por sesión</p>
    </section>
</main>
<script>
    (function () {
        const cards = Array.from(document.querySelectorAll('.opcion-card'));
        const radios = Array.from(document.querySelectorAll('input[name="opcion"]'));
        const submitButton = document.getElementById('submitVoto');

        function syncSelection() {
            let hasChecked = false;
            cards.forEach((card) => {
                const radio = card.querySelector('input[type="radio"]');
                const selected = !!radio && radio.checked;
                card.classList.toggle('selected', selected);
                if (selected) {
                    hasChecked = true;
                }
            });
            submitButton.disabled = !hasChecked;
        }

        radios.forEach((radio) => {
            radio.addEventListener('change', syncSelection);
        });

        cards.forEach((card) => {
            card.addEventListener('click', function () {
                const radio = card.querySelector('input[type="radio"]');
                if (radio) {
                    radio.checked = true;
                    radio.dispatchEvent(new Event('change', { bubbles: true }));
                }
            });
        });

        syncSelection();
    })();
</script>
</body>
</html>
