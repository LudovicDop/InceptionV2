#!/bin/sh
echo "\033[0;31mCreation of the database in progress...\033[m\n"

# Start MariaDB service
service mariadb start

# Wait until the database is available
while ! mysqladmin ping --silent; do
    sleep 2
done

# Execute SQL commands
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
echo "\033[0;33mbefore\033[m\n"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

echo "\033[0;35mokok\033[m\n"

# Shutdown MariaDB cleanly before starting it again
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# Start MariaDB safely
exec mysqld_safe
echo "\033[0;32mDone.\033[m\n"
