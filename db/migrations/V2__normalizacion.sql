USE votacion_db;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('admin','votante') NOT NULL DEFAULT 'votante',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_usuarios_email (email)
) ENGINE=InnoDB;

ALTER TABLE encuesta
    ADD COLUMN IF NOT EXISTS tipo_votacion ENUM('unica','multiple') NOT NULL DEFAULT 'unica',
    ADD COLUMN IF NOT EXISTS estado ENUM('borrador','activa','cerrada','archivada') NOT NULL DEFAULT 'activa',
    ADD COLUMN IF NOT EXISTS creado_por INT NULL,
    ADD COLUMN IF NOT EXISTS fecha_inicio TIMESTAMP NULL,
    ADD COLUMN IF NOT EXISTS fecha_fin TIMESTAMP NULL;

CREATE TABLE IF NOT EXISTS opciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    encuesta_id INT NOT NULL,
    texto VARCHAR(200) NOT NULL,
    descripcion VARCHAR(500) NULL,
    orden TINYINT NOT NULL DEFAULT 0,
    KEY idx_opciones_encuesta (encuesta_id),
    UNIQUE KEY uk_opciones_encuesta_texto (encuesta_id, texto)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS sesiones_votacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    encuesta_id INT NOT NULL,
    usuario_id INT NULL,
    token VARCHAR(64) NOT NULL,
    ha_votado BOOLEAN NOT NULL DEFAULT FALSE,
    expira_en TIMESTAMP NULL,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_sesiones_token (token),
    KEY idx_sesiones_encuesta (encuesta_id),
    KEY idx_sesiones_usuario (usuario_id)
) ENGINE=InnoDB;

ALTER TABLE votos
    MODIFY COLUMN opcion VARCHAR(100) NULL,
    ADD COLUMN IF NOT EXISTS opcion_id INT NULL,
    ADD COLUMN IF NOT EXISTS usuario_id INT NULL,
    ADD COLUMN IF NOT EXISTS token_sesion VARCHAR(64) NULL,
    ADD COLUMN IF NOT EXISTS ip_votante VARCHAR(45) NULL;

CREATE INDEX IF NOT EXISTS idx_votos_opcion_id ON votos(opcion_id);
CREATE INDEX IF NOT EXISTS idx_votos_usuario_id ON votos(usuario_id);
CREATE INDEX IF NOT EXISTS idx_votos_token_sesion ON votos(token_sesion);

CREATE TABLE IF NOT EXISTS auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NULL,
    accion VARCHAR(100) NOT NULL,
    tabla_afectada VARCHAR(50) NOT NULL,
    registro_id INT NULL,
    datos_anteriores JSON NULL,
    ip VARCHAR(45) NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_auditoria_usuario (usuario_id),
    KEY idx_auditoria_tabla_registro (tabla_afectada, registro_id)
) ENGINE=InnoDB;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_add_fk_if_missing $$
CREATE PROCEDURE sp_add_fk_if_missing(
    IN p_table VARCHAR(64),
    IN p_fk_name VARCHAR(64),
    IN p_alter_sql TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.TABLE_CONSTRAINTS tc
        WHERE tc.CONSTRAINT_SCHEMA = DATABASE()
          AND tc.TABLE_NAME = p_table
          AND tc.CONSTRAINT_NAME = p_fk_name
          AND tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
    ) THEN
        SET @sql = p_alter_sql;
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$

DELIMITER ;

CALL sp_add_fk_if_missing(
    'encuesta',
    'fk_encuesta_creado_por',
    'ALTER TABLE encuesta ADD CONSTRAINT fk_encuesta_creado_por FOREIGN KEY (creado_por) REFERENCES usuarios(id)'
);

CALL sp_add_fk_if_missing(
    'opciones',
    'fk_opciones_encuesta',
    'ALTER TABLE opciones ADD CONSTRAINT fk_opciones_encuesta FOREIGN KEY (encuesta_id) REFERENCES encuesta(id) ON DELETE CASCADE'
);

CALL sp_add_fk_if_missing(
    'sesiones_votacion',
    'fk_sesiones_encuesta',
    'ALTER TABLE sesiones_votacion ADD CONSTRAINT fk_sesiones_encuesta FOREIGN KEY (encuesta_id) REFERENCES encuesta(id) ON DELETE CASCADE'
);

CALL sp_add_fk_if_missing(
    'sesiones_votacion',
    'fk_sesiones_usuario',
    'ALTER TABLE sesiones_votacion ADD CONSTRAINT fk_sesiones_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)'
);

CALL sp_add_fk_if_missing(
    'votos',
    'fk_votos_opcion',
    'ALTER TABLE votos ADD CONSTRAINT fk_votos_opcion FOREIGN KEY (opcion_id) REFERENCES opciones(id)'
);

CALL sp_add_fk_if_missing(
    'votos',
    'fk_votos_usuario',
    'ALTER TABLE votos ADD CONSTRAINT fk_votos_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)'
);

CALL sp_add_fk_if_missing(
    'auditoria',
    'fk_auditoria_usuario',
    'ALTER TABLE auditoria ADD CONSTRAINT fk_auditoria_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)'
);

DROP PROCEDURE IF EXISTS sp_add_fk_if_missing;

INSERT INTO usuarios (nombre, email, password_hash, rol, activo)
SELECT 'Administrador', 'admin@votacion.local', 'cambiar_este_hash', 'admin', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM usuarios WHERE email = 'admin@votacion.local'
);

UPDATE encuesta e
JOIN usuarios u ON u.email = 'admin@votacion.local'
SET e.creado_por = u.id
WHERE e.creado_por IS NULL;

INSERT INTO opciones (encuesta_id, texto, descripcion, orden)
SELECT 1, 'Opcion A', NULL, 1
WHERE NOT EXISTS (
    SELECT 1 FROM opciones WHERE encuesta_id = 1 AND texto = 'Opcion A'
);

INSERT INTO opciones (encuesta_id, texto, descripcion, orden)
SELECT 1, 'Opcion B', NULL, 2
WHERE NOT EXISTS (
    SELECT 1 FROM opciones WHERE encuesta_id = 1 AND texto = 'Opcion B'
);

INSERT INTO opciones (encuesta_id, texto, descripcion, orden)
SELECT 1, 'Opcion C', NULL, 3
WHERE NOT EXISTS (
    SELECT 1 FROM opciones WHERE encuesta_id = 1 AND texto = 'Opcion C'
);

INSERT INTO opciones (encuesta_id, texto, descripcion, orden)
SELECT 1, 'Opcion D', NULL, 4
WHERE NOT EXISTS (
    SELECT 1 FROM opciones WHERE encuesta_id = 1 AND texto = 'Opcion D'
);

INSERT INTO opciones (encuesta_id, texto, orden)
SELECT DISTINCT v.encuesta_id, v.opcion, 0
FROM votos v
LEFT JOIN opciones o
    ON o.encuesta_id = v.encuesta_id
   AND o.texto = v.opcion
WHERE v.opcion IS NOT NULL
  AND TRIM(v.opcion) <> ''
  AND o.id IS NULL;

UPDATE votos v
JOIN opciones o
  ON o.encuesta_id = v.encuesta_id
 AND o.texto = v.opcion
SET v.opcion_id = o.id
WHERE v.opcion_id IS NULL
  AND v.opcion IS NOT NULL
  AND TRIM(v.opcion) <> '';
