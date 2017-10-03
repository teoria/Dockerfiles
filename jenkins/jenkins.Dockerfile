FROM jenkins
MAINTAINER Marco Matos marco@marco.ae 

USER jenkins

#WORKDIR /var/

#ADD jenkins_home/* jenkins_home/
#ADD plugins.tgz jenkins_home/

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

