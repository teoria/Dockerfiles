FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN apt-get install -y ytalk
RUN apt-get install -y vim 
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#ADD ssh_config /etc/sshd/ssh_config

RUN useradd -ms /bin/bash marco
RUN echo 'marco:screencast' | chpasswd

RUN useradd -ms /bin/bash sri
RUN echo 'sri:screencast' | chpasswd

ADD services /etc/services

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
