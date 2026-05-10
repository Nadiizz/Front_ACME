const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Configuración de la conexión a MariaDB
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'mariadb',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'root',
  database: process.env.DB_NAME || 'acme_ferreteria',
  port: process.env.DB_PORT || 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Middlewares
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Rutas de vista (servir HTML)
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// API REST - GET /api/productos (obtener todos los productos)
app.get('/api/productos', async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [rows] = await connection.query('SELECT * FROM productos');
    connection.release();
    
    res.json({
      success: true,
      data: rows,
      message: 'Productos obtenidos exitosamente'
    });
  } catch (error) {
    console.error('Error al obtener productos:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener productos',
      error: error.message
    });
  }
});

// API REST - POST /api/productos (crear nuevo producto)
app.post('/api/productos', async (req, res) => {
  const { nombre, codigo, precio, cantidad, descripcion } = req.body;

  // Validación básica
  if (!nombre || !codigo || !precio || !cantidad) {
    return res.status(400).json({
      success: false,
      message: 'Campos requeridos: nombre, codigo, precio, cantidad'
    });
  }

  try {
    const connection = await pool.getConnection();
    
    const query = 'INSERT INTO productos (nombre, codigo, precio, cantidad, descripcion) VALUES (?, ?, ?, ?, ?)';
    const [result] = await connection.execute(query, [nombre, codigo, precio, cantidad, descripcion || null]);
    
    connection.release();

    res.status(201).json({
      success: true,
      message: 'Producto creado exitosamente',
      data: {
        id: result.insertId,
        nombre,
        codigo,
        precio,
        cantidad,
        descripcion
      }
    });
  } catch (error) {
    console.error('Error al crear producto:', error);
    res.status(500).json({
      success: false,
      message: 'Error al crear producto',
      error: error.message
    });
  }
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`✓ Servidor Frontend ACME ejecutándose en http://localhost:${PORT}`);
  console.log(`✓ Conectando a MariaDB en ${process.env.DB_HOST || 'mariadb'}:${process.env.DB_PORT || 3306}`);
});

// Manejo de errores no capturados
process.on('unhandledRejection', (err) => {
  console.error('Error no controlado:', err);
});
