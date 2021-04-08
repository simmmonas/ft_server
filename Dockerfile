FROM debian:buster

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install wget

#NGINX
RUN apt-get -y install nginx
COPY srcs/nginx.conf ./root/

RUN service nginx start
RUN cp /root/nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default


#mySQL
RUN apt-get -y install default-mysql-server
RUN service mysql start

#phpmyadmin
RUN apt-get -y install php php-mysql php-fpm php-cli php-mbstring php-zip php-gd
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
RUN tar -xzvf phpMyAdmin-5.1.0-all-languages.tar.gz
RUN mv phpMyAdmin-5.1.0-all-languages /var/www/html/phpmyadmin && \
	rm -fr phpMyAdmin-5.1.0-all-languages.tar.gz
COPY srcs/config.inc.php /var/www/html/myphpadmin

#wordpress
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN mv wordpress /var/www/html/ && \
	rm -rf latest.tar.gz
COPY srcs/wp-config.php /var/www/html/wordpress

#SSL
RUN wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.3.0/mkcert-v1.3.0-linux-amd64
RUN chmod +x mkcert
RUN mv mkcert /usr/local/bin
RUN mkcert -install
RUN mkcert localhost
RUN mv localhost.pem /etc/nginx/
RUN mv localhost-key.pem /etc/ngin


COPY srcs/init.sh ./

EXPOSE 80 443

CMD bash init.sh && nginx -g 'daemon off;'