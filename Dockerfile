FROM node:18-alpine

# Instala Nginx
RUN apk add --no-cache nginx

# Crea directorios
WORKDIR /app
RUN mkdir -p /run/nginx /usr/share/nginx/html

# Instala dependencias de Node
COPY package*.json ./
RUN npm ci --only=production

# Copia tu código (server.js, etc.)
COPY . /app

# Copia estáticos al docroot de Nginx
COPY ./index.html /usr/share/nginx/html/

# Configuración de Nginx
RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Puertos expuestos
EXPOSE 80 3000

# Script de arranque
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV PORT=3000 NODE_ENV=production

CMD ["/start.sh"]
