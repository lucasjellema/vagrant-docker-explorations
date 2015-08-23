FROM ubuntu:14.04

RUN apt-get install -q -y curl

RUN apt-get update
## note the flags -q -y ensure that the packages are installed automatically instead of interactively waiting for user confirmation
# install Open JDK
RUN apt-get install -q -y default-jdk

# https://www.digitalocean.com/community/tutorials/how-to-install-java-on-ubuntu-with-apt-get
# for Oracle Java 8 - use https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile 



COPY /files/services/HelloWorld.java /u01/services/ 

RUN javac /u01/services/HelloWorld.java

RUN java -cp  /u01 services.HelloWorld


