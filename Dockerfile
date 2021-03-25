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
#must I? 
RUN rm /etc/nginx/sites-enabled/default

#mySQL
RUN apt-get -y install default-mysql-server
RUN service mysql start

#phpmyadmin


#CMD service nginx restart