# Gunakan image PHP dengan Alpine
FROM php:8.3-fpm-alpine

# Install dependensi yang dibutuhkan
RUN apk add --no-cache \
    bash \
    sqlite \
    sqlite-dev \
    oniguruma-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    unzip \
    curl \
    git \
    nodejs \
    npm \
    supervisor

# Install ekstensi PHP yang dibutuhkan
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo pdo_sqlite mbstring gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy file Laravel ke dalam container
COPY . .

# Set permission
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port untuk PHP-FPM
EXPOSE 9000

# Jalankan supervisor sebagai proses utama
CMD ["php-fpm"]
