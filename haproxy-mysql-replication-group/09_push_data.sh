#!/bin/bash

docker compose exec -T node1 mysql -uroot -proot -e "
CREATE DATABASE IF NOT EXISTS test;
USE test;
CREATE TABLE IF NOT EXISTS usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    edad INT,
    email VARCHAR(100) UNIQUE
);
INSERT IGNORE INTO usuarios (nombre, edad, email) VALUES
('Juan Pérez', 25, 'juan.perez@example.com'),
('María López', 30, 'maria.lopez@example.com'),
('Carlos Rodríguez', 22, 'carlos.rodriguez@example.com');
"


