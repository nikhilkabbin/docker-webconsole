FROM php:7.0-apache

RUN apt-get update && apt-get install -y wget unzip

RUN wget https://github.com/nickola/web-console/releases/download/v0.9.7/webconsole-0.9.7.zip && \
  unzip webconsole-0.9.7.zip -d / && \
  mv /webconsole/* /var/www/html/ && \
  rmdir /webconsole

RUN curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
RUN bash Anaconda3-5.2.0-Linux-x86_64.sh -b
RUN pip install gramex
WORKDIR /var/www/html/

RUN sed -i "s/\$USER \= '';/\$USER \= 'user';/g" webconsole.php && \
  sed -i "s/\$PASSWORD \= '';/\$PASSWORD \= 'password';/g" webconsole.php && \
  mv webconsole.php index.php

# CMD [ "php", "./webconsole.php" ]
