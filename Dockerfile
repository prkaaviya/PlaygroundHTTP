FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y vim && apt-get install -y lynx && \
    apt-get install -y curl && apt-get install -y apache2 && \ 
    apt-get clean 

COPY ./conf/mysite.conf /etc/apache2/sites-available/
COPY ./conf/mysite-ssl.conf /etc/apache2/sites-available/

RUN mkdir /var/www/html/mysite
COPY ./html/index.html /var/www/html/mysite

COPY ./ssl/key.pem /etc/ssl/private
COPY ./ssl/cert.pem /etc/ssl/certs

RUN a2dissite 000-default.conf
RUN a2ensite mysite.conf
RUN a2ensite mysite-ssl.conf
RUN a2enmod proxy_http
RUN a2enmod headers
RUN a2enmod ssl

EXPOSE 80
EXPOSE 443

CMD ["apachectl", "-D", "FOREGROUND"]