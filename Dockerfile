# Gunakan PHP dengan Alpine
FROM php:8.3-fpm-alpine

# Install ekstensi yang dibutuhkan Laravel
RUN apk add --no-cache \
    libpng-dev libjpeg-turbo-dev freetype-dev \
    zip unzip curl sqlite sqlite-dev \
    && docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-install gd pdo pdo_sqlite

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy seluruh project Laravel ke dalam container
COPY . .

# Beri izin agar Laravel bisa menulis file
RUN chmod -R 777 storage bootstrap/cache

# Jalankan composer install
RUN composer install --no-dev --optimize-autoloader

# Jalankan PHP-FPM
CMD ["php-fpm"]
