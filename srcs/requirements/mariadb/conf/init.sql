CREATE DATABASE IF NOT EXISTS mariadb_database;
CREATE USER IF NOT EXISTS 'ldoppler'@'%' IDENTIFIED BY 'azerty';
GRANT ALL PRIVILEGES ON mariadb_database.* TO 'ldoppler'@'%';
FLUSH PRIVILEGES;

