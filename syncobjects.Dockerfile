FROM ubuntu:15.04
MAINTAINER Marco Matos docker@corp.mmatos.com
RUN apt-get update && apt-get install
RUN apt-get install -y wget curl --force-yes

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.tar.gz
RUN tar -zxvf jdk-8u65-linux-x64.tar.gz
ENV JRE_HOME /jdk1.8.0_65/jre
ENV JAVA_HOME /jdk1.8.0_65
ENV PATH /jdk1.8.0_65/bin/:$PATH

RUN mkdir -p /opt/sync/as/
ENV AS_HOME /opt/sync/as/
RUN wget http://www.syncobjects.com/as-0.1.0.tar.gz -O -p $AS_HOME/as-0.1.0.tar.gz 
RUN tar -xzvfp $AS_HOME/as-0.1.0.tar.gz 

RUN ls $AS_HOME