-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS votacion_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE votacion_db;

-- Eliminar tablas en orden inverso a las dependencias
DROP TABLE IF EXISTS votos;
DROP TABLE IF EXISTS encuesta;

-- Tabla de encuestas
CREATE TABLE encuesta (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    titulo      VARCHAR(200) NOT NULL,
    descripcion VARCHAR(500) NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabla de votos (depende de encuesta)
CREATE TABLE votos (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    encuesta_id     INT NOT NULL,
    opcion          VARCHAR(100) NOT NULL,
    nombre_votante  VARCHAR(100) NULL,
    fecha           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (encuesta_id) REFERENCES encuesta(id)
) ENGINE=InnoDB;

-- Encuesta inicial con datos de ejemplo
INSERT INTO encuesta (titulo)
VALUES ('¿Cuál es tu lenguaje de programación favorito?');
