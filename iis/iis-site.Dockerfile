FROM microsoft/iis

MAINTAINER Marco Matos marco@marco.ae


RUN mkdir c:\site

RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
    New-IISSite -Name "Site" -PhysicalPath c:\site -BindingInformation "*:8000:"
    
EXPOSE 8000

ADD content/ /site

# to get container IP:
# docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" my-running-site

