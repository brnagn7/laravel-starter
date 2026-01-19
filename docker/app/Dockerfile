FROM php:8.2-apache

# Enable Apache rewrite
RUN a2enmod rewrite

# Set correct Laravel document root
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' \
    /etc/apache2/sites-available/*.conf \
    /etc/apache2/apache2.conf

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    default-mysql-client \
    && docker-php-ext-install pdo_mysql mbstring zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy only dependency files first (Docker caching trick)
COPY composer.json composer.lock ./

# Install dependencies in the image (PRO move)
RUN composer install --no-interaction --optimize-autoloader

# Now copy the rest of your app
COPY . .

# Fix Laravel permissions
RUN chown -R www-data:www-data storage bootstrap/cache

EXPOSE 80
