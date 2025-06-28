FROM php:8.2-apache

# Установка необходимых модулей
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Включаем mod_rewrite для .htaccess
RUN a2enmod rewrite headers

# Копируем конфиг Apache
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Копируем файлы сайта
COPY gareev /var/www/html

# Рестарт Apache
RUN apachectl restart
