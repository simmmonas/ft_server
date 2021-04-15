#!/bin/bash

service php7.3-fpm start
service mysql start
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root  --skip-password
echo "GRANT ALL ON wordpress.* TO 'root'@'localhost';" | mysql -u root  --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root  --skip-password
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
service mysql restart


