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

echo "WordPress configuration created successfully!"

sleep infinite