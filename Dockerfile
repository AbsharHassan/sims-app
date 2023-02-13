# Use the official PHP 8.0.2 image as the base
FROM php:8.1-cli

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install necessary PHP extensions and other dependencies
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    git \
    nodejs \
    npm \
    && docker-php-ext-install \
    bcmath \
    pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Set permissions for user
RUN chown -R www-data:www-data /app

# Install Composer dependencies
RUN composer install --no-dev

# # Install npm
# RUN curl -L https://npmjs.org/install.sh | sh

# # Install npm dependencies
# RUN npm install

# # Build the Vue.js frontend
# RUN npm run development

EXPOSE 8000

# Start the PHP built-in web server
CMD ["tail", "-f", "/dev/null"]
# CMD [ "php", "artisan", "serve", "--host=0.0.0.0", "--port=8080" ]
