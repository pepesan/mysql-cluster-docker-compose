-- 1. Crear la Base de Datos
CREATE DATABASE IF NOT EXISTS tienda_online;
USE tienda_online;

-- 2. Crear una tabla de ejemplo
-- Nota: En InnoDB Cluster es obligatorio que las tablas tengan Primary Key
CREATE TABLE IF NOT EXISTS usuarios (
                                        id INT AUTO_INCREMENT PRIMARY KEY,
                                        nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;

-- 3. Insertar datos de prueba
INSERT INTO usuarios (nombre, email) VALUES
                                         ('Alejandro Magno', 'alejandro@ejemplo.com'),
                                         ('Beatriz Kiddo', 'beatriz@ejemplo.com'),
                                         ('Carlos Santana', 'carlos@ejemplo.com');

-- 4. Verificar los datos
SELECT * FROM usuarios;