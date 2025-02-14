#!/bin/sh

echo "\033[0;32mMariaDB is ready.\033[m\n\033[0;31mProceeding with WordPress setup...\033[m"
echo "Database Name: "$SQL_DATABASE""
sleep 10
# Create wp-config.php
cd "$WP_PATH" && wp config create --allow-root \
    --dbname="$SQL_DATABASE" \
    --dbuser="$SQL_USER" \
    --dbpass="$SQL_PASSWORD" \
    --dbhost="$SQL_HOST" \
    --path="$WP_PATH" --force

sleep 10
# Install WordPress
cd "$WP_PATH" && wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASS" \
    --admin_email="$WP_EMAIL" \
    --skip-email \
    --path="$WP_PATH" \
    --allow-root

# Install and activate the Twenty Twenty-Four theme
wp theme install twentytwentyfour --activate --path="$WP_PATH" --allow-root

echo "\033[0;32mWordPress configuration created successfully!\033[m"
# Start PHP-FPM
php-fpm7.4 -F

