Eres un evaluador técnico senior de aplicaciones Java EE. Necesito que revises el código de un proyecto y lo evalúes contra una rúbrica académica específica.

## Contexto del proyecto:

Sistema de votación en línea
Jakarta EE 10, Apache Tomcat 10, MySQL 8, JDBC sin ORM, JSP con JSTL, Maven

## Rúbrica de evaluación:
Evalúa cada criterio de forma independiente con la escala del 1 al 5 según estas descripciones:

### Estructura del proyecto y configuración del entorno (peso 20%)

* 5: Proyecto ordenado por paquetes o capas, servidor configurado correctamente, despliegue exitoso, evidencias claras de ejecución
* 4: Estructura funcional y despliegue correcto, con pequeños desajustes de organización
* 3: Proyecto ejecuta parcialmente, pero con orden técnico limitado o dependencias confusas
* 2: Entorno incompleto o despliegue inestable
* 1: No logra ejecutarse o no presenta estructura técnica reconocible


### Implementación de Servlets y manejo de solicitudes (peso 25%)

* 5: Servlet funcional, procesa parámetros correctamente, diferencia flujo GET/POST y responde de manera consistente
* 4: Servlet funcional con mínimos errores de implementación
* 3: Recibe datos pero con lógica parcial o errores de flujo
* 2: Servlet incompleto o poco funcional
* 1: No implementa servlet operativo


### Uso de JSP y presentación de resultados (peso 20%)

* 5: JSP funcional, bien integrada al servlet, muestra datos y mensajes de forma clara
* 4: Vista funcional con detalles menores de presentación o integración
* 3: JSP básica con salida limitada o poco clara
* 2: Vista incompleta o desconectada del flujo
* 1: No presenta JSP funcional


### Conexión inicial a base de datos (peso 20%)

* 5: Conexión estable, configuración correcta, prueba funcional de consulta o inserción simple
* 4: Conexión funcional con detalles menores de configuración o manejo de errores
* 3: Conexión parcial o poco estable
* 2: Intento de conexión sin funcionamiento real
* 1: No existe conexión a base de datos


### Documentación técnica básica del avance (README) (peso 15%)

* 5: Documentación clara, ordenada y suficiente para comprender y ejecutar el proyecto
* 4: Documentación útil pero incompleta en uno o dos apartados
* 3: Documentación superficial
* 2: Documentación mínima y poco clara
* 1: No presenta documentación



Lo que necesito que entregues:
Para cada criterio:

Nota del 1 al 5 con su justificación concreta basada en el código revisado
Lista de fortalezas observadas
Lista de debilidades o puntos de mejora específicos con la línea o archivo donde se detecta el problema

Al final:

Nota ponderada final sobre 20 calculada así: (C1×0.20 + C2×0.25 + C3×0.20 + C4×0.20 + C5×0.15) × 4
Nivel general obtenido: Excelente (18-20), Bueno (15-17), Regular (12-14), Deficiente (10-11) o Insuficiente (menos de 10)
Lista priorizada de las tres correcciones más urgentes antes de entregar

Restricciones:

Basa cada observación únicamente en el código proporcionado, no en suposiciones
Si un archivo no es proporcionado, indica que ese criterio no puede evaluarse completamente y descuenta según corresponda
Sé específico y técnico en las observaciones, no des retroalimentación genérica