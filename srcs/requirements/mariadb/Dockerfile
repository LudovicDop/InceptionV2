# Use Debian 11 as the base image
FROM debian:11

# Install MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Expose MariaDB port
EXPOSE 3306

# Create MySQL directory for data persistence
VOLUME /var/lib/mysql

COPY ./conf/init.sql /docker-entrypoint-initdb.d/
# COPY ./conf/create_usr.sh ./usr/local/bin/create_usr.sh
# RUN chmod +x ./usr/local/bin/create_usr.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy custom MySQL configuration if needed (optional)
# COPY my.cnf /etc/mysql/my.cnf

# Initialize database and start MariaDB
CMD ["bash", "-c", "mysqld_safe --init-file=/docker-entrypoint-initdb.d/init.sql"]
