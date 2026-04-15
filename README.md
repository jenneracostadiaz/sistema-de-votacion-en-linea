# Sistema de Votación en Línea

## Objetivo
Aplicación web desarrollada con Jakarta EE que permite a los usuarios
registrar votos en encuestas y consultar resultados en tiempo real,
con persistencia en base de datos relacional.

## Tecnologías utilizadas
- Java 17 + Jakarta EE 10
- Apache Tomcat 10
- MySQL 8
- JDBC (sin ORM)
- JSP / HTML
- Maven

## Estructura del proyecto
src/
main/
java/
com.votacion/
servlet/   → Servlets (VotacionServlet, ResultadosServlet)
dao/       → Acceso a base de datos
model/     → Clases POJO
util/      → DBConnection
webapp/
index.jsp
resultados.jsp
WEB-INF/web.xml

## Pasos de ejecución
1. Importar el proyecto en IntelliJ como proyecto Maven
2. Ejecutar el script `db/schema.sql` en MySQL
3. Configurar credenciales en `util/DBConnection.java`
4. Desplegar en Tomcat 10 desde IntelliJ
5. Acceder a http://localhost:8080/votacion/

## Evidencia de ejecución
[Agregar captura de pantalla de la app corriendo aquí]

## Avance actual
- [x] Estructura del proyecto
- [x] Configuración de Tomcat
- [ ] Servlets básicos
- [ ] JSP de votación y resultados
- [ ] Conexión JDBC inicial
- [ ] CRUD completo (Avance 2)