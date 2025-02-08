CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'ldoppler'@'%' IDENTIFIED BY 'needcoffee';
GRANT ALL PRIVILEGES ON wordpress.* TO 'ldoppler'@'%';
FLUSH PRIVILEGES;

