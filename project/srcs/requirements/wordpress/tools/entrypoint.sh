#!/bin/sh
set -e

echo "[wordpress] Vérification contenu /var/www"
if [ ! -f /var/www/index.php ]; then
    echo "[wordpress] Volume vide -> copie initiale"
    cp -a /wp-cache/* /var/www/
fi

echo "[wordpress] Attente MariaDB..."
i=0
while ! nc -z mariadb 3306 2>/dev/null; do
  i=$((i+1))
  [ $i -gt 40 ] && echo "MariaDB indisponible" && exit 1
  sleep 1
done

if [ ! -f /var/www/wp-config.php ]; then
  echo "[wordpress] Génération wp-config.php"
  /usr/local/bin/wp-config-create.sh
fi

echo "[wordpress] Démarrage PHP-FPM"
exec "$@"