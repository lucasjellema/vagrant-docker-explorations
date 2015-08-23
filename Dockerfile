FROM ubuntu:14.04

RUN mkdir /u01 && \ 
    chmod a+xr /u01 
RUN	mkdir /u01/services && \
    chmod a+xr /u01/services 
COPY /files/readme.txt /u01/

# Install dev tools: jdk, git etc...
RUN apt-get update

RUN  apt-get install -q -y apache2

EXPOSE 80 

COPY /web-site/ /var/www/html/ 

