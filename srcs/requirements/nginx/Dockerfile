FROM debian:11

RUN apt-get update && \ 
	apt-get upgrade -y && \
	apt-get install -y nginx && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
 
RUN apt update && apt install -y openssl

#COPY conf/nginx.crt /etc/nginx/certs/nginx.crt
#COPY conf/nginx.key /etc/nginx/certs/nginx.key
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /etc/nginx/certs/

#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt -subj "/CN=localhost"

RUN openssl req -x509 -nodes -out /etc/nginx/certs/nginx.crt -keyout /etc/nginx/certs/nginx.key -subj "/C=FR/ST=Haut-Rhin/L=Mulhouse/O=42Mulhouse/OU=42Mulhouse/CN=ldoppler.42mulhouse.fr/UID=ldoppler" 

#EXPOSE 443 443

CMD ["nginx", "-g", "daemon off;"]

