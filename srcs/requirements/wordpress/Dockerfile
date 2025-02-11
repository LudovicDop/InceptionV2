# Use Debian 11 as the base image
FROM debian:11

# Install necessary packages
RUN apt-get update && \
    apt-get install -y php-fpm php-mysql wget tar curl && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /var/www/html /run/php

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz && \
    tar -xzf /tmp/latest.tar.gz -C /var/www/html --strip-components=1 && \
    chown -R www-data:www-data /var/www/html && \
    rm /tmp/latest.tar.gz

    # Download and install WP-CLI
    RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp
# Copy wp-setup.sh into the container
COPY ./conf/wp-setup.sh /usr/local/bin/wp-setup.sh 

# # Ensure wp-setup.sh is executable
RUN chmod +x /usr/local/bin/wp-setup.sh



# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7.4", "-F"]
