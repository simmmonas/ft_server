FROM debian:buster

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install wget

COPY srcs/nginx.conf ./root/

#NGINX
RUN apt-get -y install nginx
RUN cp /root/nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default

#CMD service nginx start -g 'daemon off;'