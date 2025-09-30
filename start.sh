#!/bin/sh
# Arranca Nginx en background
nginx
# Arranca Node en foreground (mantiene vivo el contenedor)
exec node /app/server.js