#!/bin/sh

# Run wp-cli to configure WordPress
# wp config create --allow-root \
#                  --dbname=$SQL_DATABASE \
#                  --dbuser=$SQL_USER \
#                  --dbpass=$SQL_PASSWORD \
#                  --dbhost=mariadb:3306 \
#                  --path='/var/www/html' --force
# sleep 10
cd && wp config create --allow-root \
                 --dbname=wordpress \
                 --dbuser=ldoppler \
                 --dbpass=needcoffee \
                 --dbhost=mariadb:3306 \
                 --path='/var/www/html' --force


 wp core install    --url="https://localhost:4430"    \
                    --title="Inception - Home"         \
                    --admin_user="ldoppler"           \
                    --admin_password="espresso"       \
                    --admin_email="ludovicdop@gmail.com" \
                    --skip-email \
                    --path="/var/www/html" \
                    --allow-root

wp theme install twentytwentyfour --activate --allow-root


echo "WordPress configuration created successfully!"

php-fpm7.4 -F
