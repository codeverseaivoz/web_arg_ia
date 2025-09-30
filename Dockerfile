FROM node:18-alpine

# Instala Nginx
RUN apk add --no-cache nginx

# Directorios
WORKDIR /app
RUN mkdir -p /run/nginx /usr/share/nginx/html

# Instala dependencias de Node
COPY package*.json ./
RUN npm ci --only=production

# Copia código (server.js, etc.)
COPY . /app

# Copia estáticos al docroot de Nginx (ajusta si tus estáticos viven en /app/public)
# Si todo tu sitio está en la raíz, deja esto; idealmente usa /public para no duplicar.
COPY ./assets /usr/share/nginx/html/assets
COPY ./index.html /usr/share/nginx/html/

# Nginx config (tu archivo)
RUN rm -f /etc/nginx/conf.d/default.conf /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Puertos
EXPOSE 80 3000

# Script de arranque que levanta ambos
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Variables de entorno típicas
ENV PORT=3000 NODE_ENV=production

CMD ["/start.sh"]