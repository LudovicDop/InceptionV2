# Define variables
PROJECT_NAME = inception
NETWORK = srcs_ohyeah
WORDPRESS_IMAGE = wordpress
NGINX_IMAGE = nginx
MARIADB_IMAGE = mariadb
DB_VOL = srcs_mariadb_data
WP_VOL = srcs_wordpress_data

# Default target: build all images
all: build

# Build container images
build:
	mkdir -p /home/ldoppler/data/
	mkdir -p /home/ldoppler/data/mariadb
	mkdir -p /home/ldoppler/data/wordpress
	docker build -t $(WORDPRESS_IMAGE) -f ./srcs/requirements/wordpress/Dockerfile ./srcs/requirements/wordpress
	docker build -t $(NGINX_IMAGE) -f ./srcs/requirements/nginx/Dockerfile ./srcs/requirements/nginx
	docker build -t $(MARIADB_IMAGE) -f ./srcs/requirements/mariadb/Dockerfile ./srcs/requirements/mariadb
	cd ./srcs && docker compose up -d

# Stop containers
stop:
	docker stop wordpress nginx mariadb || true

# Remove containers
clean: stop
	docker rm -f wordpress nginx mariadb || true
	docker network rm $(NETWORK) || true

# Remove Docker images
purge: clean
	docker rmi -f $(WORDPRESS_IMAGE) $(NGINX_IMAGE) $(MARIADB_IMAGE) $(DB_IMAGE) || true
	docker volume rm  $(DB_VOL) $(WP_VOL) || true
	sudo chown -R ldoppler:ldoppler /home/ldoppler/data/
	rm -rf /home/ldoppler/data/

# Show running containers
status:
	docker ps -a
