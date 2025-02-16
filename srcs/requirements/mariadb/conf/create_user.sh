!/bin/sh
echo "\033[0;31m[Creation of the database in progress...]\033[m"

# Start MariaDB service
service mariadb start

# Wait until the database is available
while ! mysqladmin ping --silent; do
    sleep 2
done

# Execute SQL commands
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
echo "\033[0;32m[Done!]\033[m\n"

echo "\033[0;31m[Creation of user in progress...]\033[m"
# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

echo "\033[0;32m[Done!]\033[m\n"

echo "\033[0;31m[Creation of root user in progress...]\033[m"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
echo "\033[0;32m[Done.]\033[m\n"


# Shutdown MariaDB cleanly before starting it again
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# Start MariaDB safely
echo "\033[1;32mFinish.\033[m\n"
exec mysqld_safe

