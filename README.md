# 🛠️ ACME Ferreterías - Frontend ERP

Sistema frontend para la gestión de productos en la cadena nacional de ferreterías ACME. Construido con Node.js, Express, HTML y CSS puro.

## 📋 Características

- ✅ Interfaz web moderna y responsiva
- ✅ Formulario para agregar nuevos productos
- ✅ Tabla de productos con información detallada
- ✅ API REST con endpoints GET y POST
- ✅ Conexión a MariaDB a través de red Docker
- ✅ Validación de datos en cliente y servidor
- ✅ Diseño adaptativo para móviles y desktop
- ✅ Mensajes de éxito/error interactivos

## 🏗️ Estructura del Proyecto

```
frontend/
├── Dockerfile              # Configuración Docker
├── package.json           # Dependencias de Node.js
├── server.js              # Servidor Express y API REST
├── .env.example           # Variables de entorno (ejemplo)
├── .gitignore             # Archivos a ignorar en git
├── README.md              # Este archivo
└── public/
    ├── index.html         # Interfaz principal
    └── style.css          # Estilos CSS
```

## 🚀 Requisitos Previos

- **Node.js** v16 o superior
- **npm** o **yarn**
- **Docker** (para ejecutar con MariaDB)
- **MariaDB** servidor (en red Docker: `acme-net`)

## 📦 Instalación Local

### 1. Clonar/Descargar el Proyecto

```bash
cd frontend
```

### 2. Instalar Dependencias

```bash
npm install
```

### 3. Configurar Variables de Entorno

Copiar el archivo `.env.example` a `.env` y ajustar según necesidad:

```bash
cp .env.example .env
```

Contenido del `.env`:
```env
PORT=3000
NODE_ENV=development
DB_HOST=localhost          # O la IP/hostname del servidor MariaDB
DB_PORT=3306
DB_USER=root
DB_PASSWORD=root
DB_NAME=acme_ferreteria
```

### 4. Crear la Base de Datos y Tabla

Conectarse a MariaDB y ejecutar:

```sql
CREATE DATABASE IF NOT EXISTS acme_ferreteria;
USE acme_ferreteria;

CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(100) UNIQUE NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    cantidad INT NOT NULL DEFAULT 0,
    descripcion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 5. Ejecutar el Servidor

**Modo desarrollo** (con auto-reload):
```bash
npm run dev
```

**Modo producción**:
```bash
npm start
```

El servidor estará disponible en: `http://localhost:3000`

## 🐳 Ejecución con Docker

### 1. Construir la Imagen

```bash
docker build -t acme-frontend:1.0 .
```

### 2. Ejecutar el Contenedor

Con red Docker existente:

```bash
docker run -d \
  --name acme-frontend \
  --network acme-net \
  -p 3000:3000 \
  -e DB_HOST=mariadb \
  -e DB_USER=root \
  -e DB_PASSWORD=root \
  -e DB_NAME=acme_ferreteria \
  acme-frontend:1.0
```

### 3. Verificar Logs

```bash
docker logs -f acme-frontend
```

## 🔌 API REST Endpoints

### GET /api/productos

Obtiene el listado de todos los productos.

**Respuesta Exitosa (200)**:
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "nombre": "Martillo de 1kg",
      "codigo": "MAR-001",
      "precio": "45.99",
      "cantidad": 50,
      "descripcion": "Martillo estándar",
      "fecha_registro": "2026-05-09T10:30:00.000Z"
    }
  ],
  "message": "Productos obtenidos exitosamente"
}
```

### POST /api/productos

Crea un nuevo producto en la base de datos.

**Body (JSON)**:
```json
{
  "nombre": "Martillo de 1kg",
  "codigo": "MAR-001",
  "precio": 45.99,
  "cantidad": 50,
  "descripcion": "Martillo estándar"
}
```

**Respuesta Exitosa (201)**:
```json
{
  "success": true,
  "message": "Producto creado exitosamente",
  "data": {
    "id": 1,
    "nombre": "Martillo de 1kg",
    "codigo": "MAR-001",
    "precio": 45.99,
    "cantidad": 50,
    "descripcion": "Martillo estándar"
  }
}
```

**Errores**:
- **400**: Campos requeridos faltantes
- **500**: Error en el servidor

## 🎨 Características de Interfaz

### Formulario de Ingreso
- Campos validados en tiempo real
- Soporte para archivos adjuntos via formulario
- Indicadores visuales de campos requeridos

### Tabla de Productos
- Tabla responsiva con scroll horizontal
- Indicador de stock bajo (rojo/amarillo)
- Búsqueda y filtrado (JavaScript puro)
- Visualización de fecha de registro

### Diseño Responsivo
- Mobile-first approach
- Breakpoints: 768px, 480px
- Optimizado para impresión

## 🔐 Seguridad

- Validación de entrada en cliente y servidor
- Uso de conexiones preparadas para evitar SQL injection
- CORS habilitado para acceso seguro
- Variables de entorno para datos sensibles

## 🐛 Troubleshooting

### Error de Conexión a BD
```
Error al obtener productos: connect ECONNREFUSED
```
**Solución**: Verificar que MariaDB está ejecutándose y accesible en `DB_HOST:DB_PORT`

### Port ya en uso
```
Error: listen EADDRINUSE
```
**Solución**: Cambiar `PORT` en `.env` o liberar el puerto 3000

### Módulos no encontrados
```
Error: Cannot find module 'express'
```
**Solución**: Ejecutar `npm install`

## 📝 Variables de Entorno Disponibles

| Variable | Descripción | Valor Defecto |
|----------|-------------|---------------|
| `PORT` | Puerto del servidor | 3000 |
| `NODE_ENV` | Modo de ejecución | development |
| `DB_HOST` | Host de MariaDB | mariadb |
| `DB_PORT` | Puerto de MariaDB | 3306 |
| `DB_USER` | Usuario de BD | root |
| `DB_PASSWORD` | Contraseña de BD | root |
| `DB_NAME` | Nombre de la BD | acme_ferreteria |

## 📚 Dependencias

- **Express**: Framework web minimalista (v4.18.2)
- **mysql2**: Cliente de MySQL/MariaDB (v3.6.0)
- **CORS**: Middleware para CORS (v2.8.5)
- **dotenv**: Variables de entorno (v16.3.1)
- **nodemon**: Auto-reload en desarrollo (dev)

## 🤝 Contribución

Para contribuir a este proyecto:
1. Crear una rama (`git checkout -b feature/mejora`)
2. Hacer commit de cambios (`git commit -m 'Agregar mejora'`)
3. Push a la rama (`git push origin feature/mejora`)
4. Abrir un Pull Request

## 📜 Licencia

Este proyecto está licenciado bajo la Licencia MIT.

## 📞 Soporte

Para más información o reportar problemas, contactar al equipo de desarrollo ACME.

---

**Versión**: 1.0.0  
**Última actualización**: 9 de mayo de 2026  
**Estado**: ✅ Production Ready
