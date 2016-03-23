FROM ubuntu:15.04
MAINTAINER Marco Matos docker@corp.mmatos.com

RUN apt-get update && apt-get install
RUN apt-get install -y wget --force-yes

#RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
#	 http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.tar.gz

WORKDIR /
ADD jdk-8u65-linux-x64.tar.gz /
RUN ls /jdk1.8.0_65
	
ENV JRE_HOME /jdk1.8.0_65/jre
ENV JAVA_HOME /jdk1.8.0_65
ENV PATH /jdk1.8.0_65/bin/:$PATH

RUN mkdir -p /opt/sync/as/

ENV AS_FILE sync-as-0.1.2.tar.gz
ENV AS_FOLDER sync-as-0.1.2
ENV AS_URL http://www.syncobjects.com/sync-as-0.1.2.tar.gz
ENV AS_HOME /opt/sync/as/

#RUN curl -L $AS_URL -o $AS_FILE   
#RUN wget -O $AS_FILE $AS_URL

ADD sync-as-0.1.2.tar.gz /opt/

RUN ls /opt