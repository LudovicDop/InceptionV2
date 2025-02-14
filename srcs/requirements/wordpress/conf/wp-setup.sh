#!/bin/sh

# # Function to check if MariaDB is ready
# mariadb_ready() {
#     mysqladmin ping --host=mariadb --port=3306 --user=ldoppler --password=needcoffee > /dev/null 2>&1
# }

# # Maximum number of attempts
# MAX_ATTEMPTS=10
# # Initial attempt count
# attempt=1

# # Wait until MariaDB is ready or until the maximum number of attempts is reached
# until mariadb_ready; do
#     if [ $attempt -ge $MAX_ATTEMPTS ]; then
#         echo "MariaDB is not ready after $attempt attempts. Exiting."
#         exit 1
#     fi
#     echo "Waiting for MariaDB to be ready... (Attempt $attempt/$MAX_ATTEMPTS)"
#     attempt=$((attempt + 1))
#     sleep 3
# done
echo "\033[0;32mMariaDB is ready.\033[m\n\033[0;31mProceeding with WordPress setup...\033[m"

sleep 10
# Create wp-config.php
cd /var/www/html && wp config create --allow-root \
    --dbname=wordpress \
    --dbuser=ldoppler \
    --dbpass=needcoffee \
    --dbhost=mariadb:3306 \
    --path='/var/www/html' --force

sleep 10
# Install WordPress
cd /var/www/html && wp core install \
    --url="https://192.168.1.76:4430/" \
    --title="Inception - Home" \
    --admin_user="ldoppler" \
    --admin_password="espresso" \
    --admin_email="ludovicdop@gmail.com" \
    --skip-email \
    --path="/var/www/html" \
    --allow-root

# Install and activate the Twenty Twenty-Four theme
wp theme install twentytwentyfour --activate --path="/var/www/html/" --allow-root

echo "\033[0;32mWordPress configuration created successfully!\033[m"
# Start PHP-FPM
php-fpm7.4 -F

