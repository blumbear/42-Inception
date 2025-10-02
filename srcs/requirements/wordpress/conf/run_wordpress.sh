_#!/bin/sh

wp_dir='/var/www/html'

sleep 4

echo "Testing database connection..."
for i in {1..10}; do
	if mysql -h"$DB_HOST" -u"$MYSQL_USER" -p"$(cat /run/secrets/mysql_user_password)" "$MYSQL_DATABASE" -e "SELECT 1;" > /dev/null 2>&1; then
		echo "Database connection successful!"
		break
	else
		echo "Database connection failed, retry $i/10..."
		sleep 5
	fi
done

if [ ! -e "${wp_dir}/wp-config.php" ]
then

	wp config create	--allow-root \
						--dbname=$DB_NAME \
						--dbuser=$DB_USER \
						--dbpass=$DB_PASS \
						--dbhost=mariadb:3306 \
						--path=$wp_dir

	wp core install		--allow-root \
						--url=$WP_URL \
						--title=$WP_TITLE \
						--admin_email=$WP_ADMIN_EMAIL \
						--admin_user=$WP_ADMIN \
						--admin_password=$WP_ADMIN_PASS \
						--path=$wp_dir

    wp user create		--allow-root \
						$WP_USER $WP_USER_EMAIL \
						--user_pass=$WP_USER_PASS \
						--path=$wp_dir

	wp option update comment_moderation 0
	wp option update comment_moderation 0
	wp option update comment_previously_approved 0
	wp option update comment_whitelist 0
	wp option update comment_registration 0
fi

/usr/sbin/php-fpm81 -F