#!/bin/sh

mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/ttaquet.42.fr.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/ttaquet.42.fr.key \
        -out /etc/nginx/ssl/ttaquet.42.fr.crt \
        -subj "/C=FR/ST=State/L=City/O=Organization/CN=ttaquet.42.fr"
fi
# Lancer Nginx en foreground
nginx -g "daemon off;"