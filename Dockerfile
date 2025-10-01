# Imagen base de Nginx
FROM nginx:alpine

# Eliminamos configuración por defecto
RUN rm /etc/nginx/conf.d/default.conf

# Copiamos nuestra configuración
COPY nginx.conf /etc/nginx/nginx.conf

# Copiamos los archivos de la web
COPY . /usr/share/nginx/html

# Exponemos puertos
EXPOSE 80

# Arrancamos nginx en foreground
CMD ["nginx", "-g", "daemon off;"]
