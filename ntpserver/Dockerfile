FROM alpine
MAINTAINER Marco Matos marco@marco.ae

ADD ntpd.conf /etc/ntpd.conf

RUN apk update
RUN apk add openntpd

ENTRYPOINT ["ntpd"]

# to run this container: 
# 
#
