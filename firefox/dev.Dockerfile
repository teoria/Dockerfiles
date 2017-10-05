FROM ubuntu
LABEL maintainer M Matos marco@marco.ae

    RUN apt update && apt install bzip2 sudo libcanberra-gtk3-dev -y

# Replace 1000 with your user / group id
    RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

    USER developer
    ENV HOME /home/developer
    COPY firefox-57.0b5.tar.bz2 .
    RUN sudo bunzip2 firefox-57.0b5.tar.bz2 
    RUN sudo tar xvfp firefox-57.0b5.tar 
    RUN sudo mv /firefox/ /usr/local/bin/
    CMD /usr/local/bin/firefox/firefox 
