# HippoCMS Dockerfile based on Brian Snijders' posts
# java8 and tomcat7 versions / fixed install path issues

# Generic Hippo Docker image
FROM ubuntu:14.04
MAINTAINER Marco Matos <docker@corp.mmatos.com>

# Set environment variables
ENV PATH /srv/hippo/tomcat/bin/:$PATH
ENV HIPPO_FILE HippoCMS-GoGreen-Enterprise-7.9.4.zip
ENV HIPPO_FOLDER HippoCMS-GoGreen-Enterprise-7.9.4
ENV HIPPO_URL http://download.demo.onehippo.com/7.9.4/HippoCMS-GoGreen-Enterprise-7.9.4.zip

# Create the work directory for Hippo
RUN mkdir -p /srv/hippo

# Add Oracle Java Repositories
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:webupd8team/java
RUN DEBIAN_FRONTEND=noninteractive apt-get update

# Approve license conditions for headless operation
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

# Install packages required to install Hippo CMS
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-set-default
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y dos2unix
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y unzip

# Install Hippo CMS, retrieving the GoGreen demonstration from the $HIPPO_URL and putting it under $HIPPO_FOLDER
RUN curl -L $HIPPO_URL -o $HIPPO_FILE
RUN unzip $HIPPO_FILE
RUN mv /$HIPPO_FOLDER/* /srv/hippo/
RUN chmod 700 /srv/hippo/* -R

# Replace DOS line breaks on Apache Tomcat scripts, to properly load JAVA_OPTS
RUN dos2unix /srv/hippo/tomcat/bin/setenv.sh
RUN dos2unix /srv/hippo/tomcat/bin/catalina.sh

# Expose ports
EXPOSE 8080

# Start Hippo
WORKDIR /srv/hippo/tomcat/bin/
CMD ["catalina.sh", "run"]
