FROM java:8
MAINTAINER Marco Matos marco@marco.ae

ADD apache-archiva-2.2.3-bin.tar.gz / 

ENV ARCHIVA_BASE /apache-archiva-2.2.3/
WORKDIR /apache-archiva-2.2.3

RUN mkdir /archiva-data
RUN ln -s /archiva-data /apache-archiva-2.2.3/data
VOLUME /archiva-data

EXPOSE 8080
CMD ["bin/archiva", "console"]
