FROM ubuntu:15.04

MAINTAINER Marco Matos docker@corp.mmatos.com

RUN apt-get update && apt-get install
RUN apt-get install -y --force-yes \
	wget \ 
	curl \  
	unzip 

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.tar.gz
RUN wget http://www.eu.apache.org/dist/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz -O apache-tomcat-8.0.32.tar.gz
RUN tar -zxvf apache-tomcat-8.0.32.tar.gz
RUN tar -zxvf jdk-8u65-linux-x64.tar.gz
ENV CATALINA_HOME /apache-tomcat-8.0.32
ENV JRE_HOME /jdk1.8.0_65/jre
ENV JAVA_HOME /jdk1.8.0_65
ENV PATH /jdk1.8.0_65/bin/:$PATH
ENV PATH $CATALINA_HOME/bin:$PATH

# Define volume for jks / crl file
# VOLUME  ["/var/lib/keystore"]

#SSL setup
ENV KEYSTORE_PATH /path/to/keystore.jks
ENV KEYSTORE_PASSWORD password
ENV TRUSTSTORE_PATH /path/to/truststore.jks  
ENV TRUSTSTORE_PASSWORD password
RUN mkdir /var/lib/truststore/
ADD truststore.jks $TRUSTSTORE_PATH
RUN mkdir /var/lib/keystore/
ADD keystore.jks $KEYSTORE_PATH
ADD truststore.jks /root/.truststore
ADD keystore.jks /root/.keystore

ADD cert.crt /root/cert.crt
ENV crt=/root/cert.crt
ADD cert.key /root/cert.key
ENV key=/root/cert.key
		
#Indicates keystore location
ENV JAVA_OPTS="$JAVA_OPTS -Drepo.config=file:///apache-tomcat-8.0.32/conf/repository.xml -Djava.security.auth.login.config==$CATALINA_BASE/conf/jaas.conf -Dhttps.protocols=TLSv1 -Djavax.net.ssl.keyStore=$KEYSTORE_PATH -Djavax.net.ssl.keyStorePassword=$KEYSTORE_PASSWORD -Djavax.net.ssl.trustStore=$TRUSTSTORE_PATH -Djavax.net.ssl.trustStorePassword=$TRUSTSTORE_PASSWORD"

#Repository
ADD repository.xml $CATALINA_HOME/conf/

#Keycloak
RUN wget http://central.maven.org/maven2/org/keycloak/keycloak-saml-tomcat8-adapter/1.9.0.Final/keycloak-saml-tomcat8-adapter-1.9.0.Final.jar -O keycloak-saml-tomcat8-adapter-1.9.0.Final.jar
RUN wget http://central.maven.org/maven2/org/keycloak/keycloak-core/1.1.0.Final/keycloak-core-1.1.0.Final.jar -O keycloak-core-1.1.0.Final.jar 

#Download jar's
RUN wget http://search.maven.org/remotecontent?filepath=org/apache/geronimo/specs/geronimo-jta_1.1_spec/1.1/geronimo-jta_1.1_spec-1.1.jar -O geronimo-jta_1.1_spec-1.1.jar
RUN wget http://search.maven.org/remotecontent?filepath=javax/mail/mail/1.4.7/mail-1.4.7.jar -O mail-1.4.7.jar
RUN wget http://search.maven.org/remotecontent?filepath=javax/jcr/jcr/2.0/jcr-2.0.jar -O jcr-2.0.jar

#JDBC Connector and DB stuff
RUN wget http://search.maven.org/remotecontent?filepath=org/apache/tomcat/tomcat-jdbc/9.0.0.M3/tomcat-jdbc-9.0.0.M3.jar -O tomcat-jdbc-9.0.0.M3.jar
RUN wget https://jdbc.postgresql.org/download/postgresql-9.4.1207.jre6.jar -O postgresql-9.4.1207.jre6.jar

#Saving jar's in tomcat libs
RUN mv *.jar $CATALINA_HOME/lib/

#Updating tomcat conf
ADD catalina.policy $CATALINA_HOME/conf/
ADD catalina.properties $CATALINA_HOME/conf/
ADD context.xml $CATALINA_HOME/conf/
ADD server.xml $CATALINA_HOME/conf/
ADD repository.xml $CATALINA_HOME/conf/


#Updating JAAS conf
ADD hst-config.properties $CATALINA_HOME/webapps/WEB-INF/


ENV CATALINA_TMPDIR /apache-tomcat-8.0.32/temp
RUN mkdir $CATALINA_HOME/common/
RUN mkdir $CATALINA_HOME/common/lib/
ADD shared.tar $CATALINA_HOME/common/lib/

#Adding war files
ADD cms.war /apache-tomcat-8.0.32/webapps/
ADD site.war /apache-tomcat-8.0.32/webapps/
ADD essentials.war /apache-tomcat-8.0.32/webapps/

EXPOSE 8080 8443 9095

WORKDIR $CATALINA_HOME/bin/
CMD ["/apache-tomcat-8.0.32/bin/catalina.sh","run"]