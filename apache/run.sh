docker run --name apache -d -v $(pwd)/data/:/usr/local/apache2/htdocs/docker/  -p 80:80 httpd:2.4
