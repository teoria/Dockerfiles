FROM ubuntu
MAINTAINER M Matos marco.matos@emaratech.MAINTAINER

ENV REGISTRATION_TOKEN bDpi7KUXg3iNrjr6GfD4

RUN apt-get update
RUN apt-get install gitlab-ci-multi-runner -y

RUN sudo gitlab-ci-multi-runner register -n \
  --url https://git.emaratech.ae \
  --registration-token $REGISTRATION_TOKEN \
  --executor shell \
  --description "Docker runner"

