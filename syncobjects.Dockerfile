FROM ubuntu:15.04
MAINTAINER Marco Matos docker@corp.mmatos.com
RUN apt-get update && apt-get install
RUN apt-get install -y curl --force-yes

ADD jdk-8u65-linux-x64.tar.gz
RUN tar -zxvf jdk-8u65-linux-x64.tar.gz
ENV JRE_HOME /jdk1.8.0_65/jre
ENV JAVA_HOME /jdk1.8.0_65
ENV PATH /jdk1.8.0_65/bin/:$PATH

RUN mkdir -p /opt/sync/as/

ENV AS_FILE as-0.1.0.tar.gz
ENV AS_FOLDER as-0.1.0
ENV AS_URL http://www.syncobjects.com/as-0.1.0.tar.gz
ENV AS_HOME /opt/sync/as/

RUN curl -L $AS_URL -o $AS_FILE   
RUN tar -xzvfp $AS_FILE
RUN mv $AS_FOLDER $AS_HOME 


RUN ls $AS_HOME