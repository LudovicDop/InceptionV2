# Define variables
PROJECT_NAME = inception
NETWORK = wordpress_network
WORDPRESS_IMAGE = wordpress-test
NGINX_IMAGE = nginx-test
DB_IMAGE = mariadb:latest

# Default target: build all images
all: network build

# Create a custom Docker network
network:
	docker network create $(NETWORK) || true

# Build container images
build:
	docker build -t $(WORDPRESS_IMAGE) -f ./srcs/requirements/wordpress/Dockerfile ./srcs/requirements/wordpress
	docker build -t $(NGINX_IMAGE) -f ./srcs/requirements/nginx/Dockerfile ./srcs/requirements/nginx

# Run containers manually
run: network
	docker run -d --name wordpress --network $(NETWORK) -v wordpress_data:/var/www/html -e WORDPRESS_DB_HOST=db -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=rootpass -e WORDPRESS_DB_NAME=wordpress $(WORDPRESS_IMAGE)
	docker run -d --name nginx --network $(NETWORK) -p 80:80 -p 443:443 -v wordpress_data:/var/www/html -v $(PWD)/nginx.conf:/etc/nginx/nginx.conf:ro $(NGINX_IMAGE)
	docker run -d --name db --network $(NETWORK) -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_DATABASE=wordpress -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wppass $(DB_IMAGE)

# Stop containers
stop:
	docker stop wordpress nginx db || true

# Remove containers
clean: stop
	docker rm -f wordpress nginx db || true
	docker network rm $(NETWORK) || true

# Remove Docker images
purge: clean
	docker rmi -f $(WORDPRESS_IMAGE) $(NGINX_IMAGE) $(DB_IMAGE) || true
	docker volume rm wordpress_data || true

# Show running containers
status:
	docker ps -a

# Show logs
logs:
	docker logs -f nginx
