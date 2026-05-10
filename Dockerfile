# Usar imagen base oficial de Node.js
FROM node:18-alpine

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm install --production

# Copiar el código de la aplicación
COPY server.js .
COPY public ./public

# Exponer el puerto
EXPOSE 3000

# Variable de entorno para el modo de producción
ENV NODE_ENV=production

# Comando para iniciar la aplicación
CMD ["npm", "start"]
