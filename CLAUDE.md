# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Online voting system (Sistema de Votación en Línea) — a Jakarta EE web app for registering votes in polls and viewing results in real time. Course project for "Desarrollo Web Integrado." Currently in early stages: scaffolding + hello-world servlet exist; servlets, JSPs, JDBC layer, and database are yet to be built.

## Tech Stack

- Java 8 (compiler target) on Jakarta EE 10 (Servlet 6.1)
- JSP for views, plain JDBC for persistence (no ORM)
- MySQL 8 database
- Apache Tomcat 10 as the application server
- Maven (wrapper included: `./mvnw`)
- JUnit 5 for tests
- Packaged as a WAR

## Build & Run Commands

```bash
./mvnw clean package          # Build WAR (output: target/OnlineVoting-1.0-SNAPSHOT.war)
./mvnw test                   # Run all tests
./mvnw test -Dtest=ClassName  # Run a single test class
```

Deploy the WAR to Tomcat 10. In IntelliJ, use the Tomcat run configuration. App URL: `http://localhost:8080/votacion/`

## Architecture (Target)

The README describes the intended package layout under `com.votacion`:

- **servlet/** — HTTP servlets (VotacionServlet, ResultadosServlet)
- **dao/** — Data access objects using plain JDBC
- **model/** — POJOs (domain entities)
- **util/** — `DBConnection` utility (DB credentials configured here)

Currently the code lives under `com.example.onlinevoting` with only a placeholder `HelloServlet`. The package will need to be restructured to match the target layout.

## Database

- MySQL 8 — schema script expected at `db/schema.sql` (not yet created)
- DB credentials configured in `util/DBConnection.java` (not yet created)

## Key Notes

- WAR packaging — no embedded server; requires external Tomcat 10
- No Spring, no ORM — raw servlets + JDBC by design (course requirement)
- `pom.xml` targets Java 8 but README says Java 17; Tomcat 10 + Jakarta EE 10 require Java 11+. Resolve to Java 17 when updating.
