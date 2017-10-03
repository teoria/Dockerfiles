FROM httpd:2.4

RUN apt-get update && apt-get install git -y
ENV APP_URL https://github.com/mmatoscom/apache.git
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rfv *
RUN git clone $APP_URL .
EXPOSE 80
