FROM debian:11

RUN apt-get update && \ 
	apt-get upgrade -y && \
	apt-get install -y nginx && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* 

COPY conf/nginx.crt /etc/nginx/certs/nginx.crt
COPY conf/nginx.key /etc/nginx/certs/nginx.key
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

