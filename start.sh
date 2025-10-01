#!/bin/sh
# Arranca Nginx en segundo plano
nginx
# Arranca Node.js (Express) en primer plano
exec node /app/server.js