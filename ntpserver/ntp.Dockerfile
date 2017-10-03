FROM alpine
MAINTAINER Marco Matos marco@marco.ae

ADD ntpd.conf /etc/ntpd.conf

RUN apk update
RUN apk add openntpd

ENTRYPOINT ["ntpd"]


# USAGE:
# 1) first save the Dockerfile and ntpd.conf under same folder
# 2) build the image: 
#    docker build -t ntpd .
# 3) then run the container:
#    docker run --privileged -v /var/empty --name ntpd --restart=always -d ntp -d -f /etc/ntpd.conf -s
