FROM ubuntu
MAINTAINER M Matos marco@marco.ae

ENV REGISTRATION_TOKEN <your.token.here>

RUN apt-get update
RUN apt-get install gitlab-ci-multi-runner -y

RUN sudo gitlab-ci-multi-runner register -n \
  --url https://git.emaratech.ae \
  --registration-token $REGISTRATION_TOKEN \
  --executor shell \
  --description "Docker runner"

