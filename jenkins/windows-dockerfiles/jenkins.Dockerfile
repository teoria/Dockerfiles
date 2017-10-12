FROM java

ENV HOME /jenkins  
ENV JENKINS_VERSION 1.589  
RUN mkdir \jenkins  
RUN powershell -Command "wget -Uri http://mirrors.jenkins-ci.org/war/1.589/jenkins.war -UseBasicParsing -OutFile /jenkins/jenkins.war"

EXPOSE 8080  
EXPOSE 50000

CMD [ "java","-jar", "c:\jenkins\jenkins.war" ] 

### run with 
### docker run --name jenkins -p 8080:8080 -p 50000:50000 -d jenkins