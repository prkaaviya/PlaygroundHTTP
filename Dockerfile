FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y vim && apt-get install -y lynx && \
    apt-get install -y curl && apt-get install -y apache2 && \ 
    apt-get clean 

COPY ./conf/mysite.conf /etc/apache2/sites-available/
RUN mkdir /var/www/html/mysite
COPY ./html/index.html /var/www/html/mysite

RUN a2dissite 000-default.conf
RUN a2ensite mysite.conf

EXPOSE 8080

CMD ["apachectl", "-D", "FOREGROUND"]