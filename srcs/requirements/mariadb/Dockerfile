# Use Debian 11 as the base image
FROM debian:11

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# COPY my.cnf /etc/mysql/my.cnf

ENV MARIADB_ROOT_PASSWORD=azerty
ENV MARIADB_DATABASE=mariadb_database
ENV MARIADB_USER=ldoppler
ENV MARIADB_PASSWORD=azerty

EXPOSE 3306

CMD ["mysqld"]
