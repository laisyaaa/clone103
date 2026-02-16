# Pakai PHP CLI + Composer
FROM php:8.2-cli

# Set working directory
WORKDIR /var/www

# Install dependencies sistem + PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git curl \
    && docker-php-ext-install pdo_mysql zip

# Copy semua file project ke container
COPY . .

# Install Composer dan dependencies Laravel
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader

# Buka port yang akan dipakai Render
EXPOSE 10000

# Jalankan Laravel server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]
