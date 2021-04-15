FROM debian:buster

ENV AUTOINDEX on

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install nginx mariadb-server wget php-json php-mbstring php-fpm php-mysql php-xml

#SSL
RUN mkdir ~/mkcert && cd ~/mkcert && \
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64 && \
	mv mkcert-v1.4.1-linux-amd64 mkcert && chmod +x mkcert && \
	./mkcert -install && ./mkcert localhost

#NGINX
COPY /srcs/*.conf /root/
# RUN	mv /root/nginx.conf /etc/nginx/sites-available/localhost
# RUN	ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

#phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
RUN tar -xzvf phpMyAdmin-5.1.0-all-languages.tar.gz
RUN mv phpMyAdmin-5.1.0-all-languages /var/www/html/phpmyadmin && \
	rm -fr phpMyAdmin-5.1.0-all-languages.tar.gz
COPY srcs/config.inc.php /var/www/html/phpmyadmin

#wordpress
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN mv wordpress /var/www/html/ && \
	rm -rf latest.tar.gz
COPY srcs/wp-config.php /var/www/html/wordpress

RUN	chown -R www-data:www-data /var/www/html/*

COPY srcs/*.sh ./ 

EXPOSE 80 443

CMD bash init.sh && nginx -g 'daemon off;'