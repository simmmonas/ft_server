#!/bin/bash

if (( $(ps -ef | grep -v grep | grep nginx | wc -l) > 0 ))
then
    if [ "$AUTOINDEX" = "off" ] ;
    then cp /root/nginx_indexoff.conf /etc/nginx/sites-available/default ;
    else cp /root/nginx.conf /etc/nginx/sites-available/default ; fi
service nginx reload
else
    if [ "$AUTOINDEX" = "off" ] ;
    then cp /root/nginx_indexoff.conf /etc/nginx/sites-available/default ;
    else cp /root/nginx.conf /etc/nginx/sites-available/default ; fi
fi