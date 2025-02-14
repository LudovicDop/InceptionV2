FROM debian:11

RUN apt-get update && \ 
	apt-get upgrade -y && \
	apt-get install -y nginx openssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
 
RUN mkdir -p /etc/nginx/certs/

COPY ./conf/website /etc/nginx/sites-avaible/website
RUN ln -s /etc/nginx/sites-avaible/website /etc/nginx/sites-enabled/

# COPY conf/nginx.crt /etc/nginx/certs/nginx.crt
# COPY conf/nginx.key /etc/nginx/certs/nginx.key
COPY conf/nginx.conf /etc/nginx/nginx.conf
# RUN chmod 644 /etc/nginx/nginx.conf

#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt -subj "/CN=localhost"

RUN openssl req -x509 -nodes \
-out /etc/nginx/certs/nginx.crt \
-keyout /etc/nginx/certs/nginx.key \
-subj "/C=FR/ST=Haut-Rhin/L=Mulhouse/O=42Mulhouse/OU=42Mulhouse/CN=localhost/UID=ldoppler" 

RUN chmod 600 /etc/nginx/certs/nginx.*
# RUN mv /var/www/html/index.nginx-debian.html /var/www/html/index.html
RUN rm /var/www/html/index.nginx-debian.html

EXPOSE 4430

CMD ["nginx", "-g", "daemon off;"]

