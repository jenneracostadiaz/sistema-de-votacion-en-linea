# Resumen Técnico — Sistema de Votación en Línea

## ¿Qué es?
Aplicación web Java EE que permite a usuarios emitir votos en una encuesta y ver los resultados en tiempo real. Desarrollada como proyecto del curso "Desarrollo Web Integrado".

---

## Stack Tecnológico

| Capa | Tecnología |
| :--- | :--- |
| **Lenguaje** | Java 17 |
| **Plataforma** | Jakarta EE 10 (Servlet 6.1) |
| **Servidor** | Apache Tomcat 10 |
| **Vistas** | JSP + JSTL |
| **Persistencia** | JDBC puro (sin ORM) |
| **Base de datos** | MySQL 8 |
| **Build** | Maven (WAR packaging) |
| **Frontend** | CSS3 + JavaScript vanilla |

---

## Arquitectura: MVC

```text
Browser
│
▼
[ Servlet ]  ──►  [ DAO ]  ──►  [ MySQL ]
│                │
│            [ Model ]
▼
[ JSP ]
```

El proyecto sigue el patrón **Model-View-Controller** clásico de Java EE:

* **Model:** `Voto.java` — POJO que representa un voto.
* **View:** `index.jsp`, `resultados.jsp` — Vistas renderizadas en el servidor.
* **Controller:** `VotacionServlet`, `ResultadosServlet` — Reciben requests HTTP y orquestan la lógica.
* **DAO:** `VotoDAO`, `ResultadosDAO` — Capa de acceso a datos con JDBC.

---

## Estructura de Paquetes

```text
com.votacion/
├── servlet/
│   ├── VotacionServlet.java      # POST /votar
│   └── ResultadosServlet.java    # GET  /resultados
├── dao/
│   ├── VotoDAO.java              # INSERT voto
│   └── ResultadosDAO.java        # SELECT conteo agrupado
├── model/
│   └── Voto.java                 # Entidad de dominio
└── util/
    └── DBConnection.java         # Gestión de conexión MySQL
```

---

## Base de Datos

El sistema utiliza dos tablas con relación **FK**:

1.  **`encuesta`**: `(id, titulo, descripcion, fecha_creacion)`
2.  **`votos`**: `(id, encuesta_id, opcion, nombre_votante, fecha)`

* `encuesta` almacena la pregunta de la votación.
* `votos` registra cada voto con su opción y nombre opcional del votante.
* La **FK** garantiza la integridad referencial.

---

## Flujo de la Aplicación

### Emitir un voto
1.  El usuario abre `GET /votacion/`.
2.  `index.jsp` renderiza el formulario con 4 opciones.
3.  El usuario selecciona una opción (botón habilitado por JavaScript).
4.  Se envía el formulario `POST /votar`.
5.  `VotacionServlet` valida que la opción haya llegado.
6.  Construye el objeto `Voto` y llama a `VotoDAO.registrar()`.
7.  `VotoDAO` ejecuta el `INSERT` con `PreparedStatement`.
8.  Redirección a `/resultados` (patrón **PRG**).

### Ver resultados
1.  `GET /resultados`.
2.  `ResultadosServlet` llama a `ResultadosDAO.obtenerConteo()`.
3.  El DAO ejecuta un `SELECT` con `GROUP BY opcion ORDER BY total DESC`.
4.  El Servlet pone el `Map<String,Integer>` en el request.
5.  `resultados.jsp` renderiza barras de progreso animadas.

---

## Decisiones Técnicas Destacables

* **PreparedStatement:** Utilizado en todos los DAOs para prevenir SQL Injection; los parámetros nunca se concatenan al SQL.
* **Try-with-resources:** Asegura que `Connection`, `PreparedStatement` y `ResultSet` se cierren automáticamente, evitando *memory leaks*.
* **Redirect tras POST (PRG):** Se utiliza `sendRedirect()` en lugar de `forward` tras votar, evitando el reenvío del formulario al refrescar el navegador.
* **LinkedHashMap en resultados:** Preserva el orden devuelto por la BD (`ORDER BY total DESC`), garantizando que la JSP muestre los resultados de mayor a menor votos.
* **Bloque static para el driver:** `Class.forName()` se ejecuta una sola vez al cargar la clase, no en cada conexión.

---

## Frontend

* **CSS Custom Properties:** Colores y radios definidos como variables reutilizables.
* **Tarjetas clickeables:** El radio button está oculto; toda la tarjeta actúa como selector.
* **Botón deshabilitado:** JavaScript vanilla deshabilita el *submit* hasta que se selecciona una opción, evitando envíos vacíos.
* **Barras de progreso animadas:** Uso de `requestAnimationFrame` + transición CSS para el efecto de llenado.
* **Diseño responsive:** `@media queries` para móvil (640px y 400px).
* **Accesibilidad:** Uso de atributos `aria-label`, `role="alert"`, `role="progressbar"`, `aria-valuenow`.

---

## URLs de la Aplicación

| URL | Método | Descripción |
| :--- | :--- | :--- |
| `/votacion/` | `GET` | Formulario de votación |
| `/votacion/votar` | `POST` | Registrar voto |
| `/votacion/resultados` | `GET` | Ver resultados |

---

## Lo que el proyecto demuestra
1.  Ciclo completo HTTP request → servlet → DAO → BD → JSP.
2.  Separación de responsabilidades (MVC sin frameworks).
3.  Acceso a datos con JDBC y buenas prácticas de gestión de recursos.
4.  Renderizado dinámico *server-side* con JSTL/EL.
5.  Frontend funcional sin librerías externas.