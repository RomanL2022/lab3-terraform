#!/bin/bash
# Оновлення та встановлення Apache
apt-get update
apt-get install -y apache2

# Налаштування кастомного порту
sed -i "s/Listen 80/Listen ${web_port}/" /etc/apache2/ports.conf

# Створення DocumentRoot та надання прав
mkdir -p ${doc_root}
chown -R www-data:www-data ${doc_root}
chmod -R 755 ${doc_root}

# Створення головної сторінки
echo "<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Lab 3</title></head><body><h1>Лабораторна 3 (Terraform) - Лопушинський Роман, Варіант 11</h1><p>Сервер: ${server_name}</p></body></html>" > ${doc_root}/index.html

# Налаштування VirtualHost
cat <<EOF > /etc/apache2/sites-available/site_custom.conf
<VirtualHost *:${web_port}>
    ServerName ${server_name}
    DocumentRoot ${doc_root}
    <Directory ${doc_root}>
        Require all granted
        AllowOverride All
    </Directory>
</VirtualHost>
EOF

# Модифікація глобальної конфігурації для уникнення 403 Forbidden
sed -i 's/Require all denied/Require all granted/' /etc/apache2/apache2.conf

# Активація сайту та перезапуск Apache
a2ensite site_custom.conf
a2dissite 000-default.conf
systemctl restart apache2