# docker/php/Dockerfile

# Gunakan image PHP dengan Alpine Linux
FROM php:8.2-fpm-alpine

# Install dependensi yang diperlukan
RUN apk add --no-cache \
    nginx \
    supervisor \
    sqlite \
    curl \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev

# Install ekstensi PHP yang diperlukan
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_sqlite zip mbstring exif pcntl bcmath ctype fileinfo json tokenizer xml

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy file composer.json dan composer.lock
COPY composer.json composer.lock ./

# Install dependencies Composer
RUN composer install --no-scripts --no-autoloader --no-dev

# Copy seluruh aplikasi Laravel
COPY . .

# Generate autoload files
RUN composer dump-autoload --optimize

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 9000 untuk PHP-FPM
EXPOSE 9000

# Copy konfigurasi supervisor
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start supervisor
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]