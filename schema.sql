-- ======================================
-- Script de Creación de BD para ACME
-- Sistema ERP - Ferreterías ACME
-- ======================================

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS acme_ferreteria;
USE acme_ferreteria;

-- Tabla de productos
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID único del producto',
    nombre VARCHAR(255) NOT NULL COMMENT 'Nombre del producto',
    codigo VARCHAR(100) UNIQUE NOT NULL COMMENT 'Código único del producto',
    precio DECIMAL(10, 2) NOT NULL COMMENT 'Precio unitario',
    cantidad INT NOT NULL DEFAULT 0 COMMENT 'Cantidad en stock',
    descripcion TEXT COMMENT 'Descripción detallada del producto',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de registro del producto',
    INDEX idx_codigo (codigo),
    INDEX idx_nombre (nombre),
    INDEX idx_fecha (fecha_registro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de productos del ERP ACME';

-- Insertar productos de ejemplo (opcional)
INSERT INTO productos (nombre, codigo, precio, cantidad, descripcion) VALUES
('Martillo 1kg', 'MAR-001', 45.99, 150, 'Martillo de acero templado para trabajos generales'),
('Destornillador Phillips', 'DES-001', 12.50, 300, 'Destornillador Phillips tamaño mediano'),
('Llave Inglesa 8"', 'LLA-001', 25.00, 80, 'Llave inglesa ajustable de 8 pulgadas'),
('Clavos 2"', 'CLA-001', 5.99, 500, 'Clavos de acero de 2 pulgadas (caja de 100)'),
('Tuerca M10', 'TUE-001', 1.50, 1000, 'Tuerca métrica M10 grado 8.8'),
('Lámpara LED 40W', 'LAM-001', 89.99, 45, 'Lámpara LED blanca fría 40W equivalentes'),
('Cable THWN 12 AWG', 'CAB-001', 0.75, 5000, 'Cable THWN calibre 12 AWG por pie'),
('Pernos 3/8" x 2"', 'PER-001', 2.25, 750, 'Pernos de acero con cabeza hexagonal');

-- Mostrar la estructura de la tabla
DESCRIBE productos;

-- Contar registros creados
SELECT COUNT(*) as total_productos FROM productos;
