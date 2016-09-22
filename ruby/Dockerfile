FROM ruby:2.3
MAINTAINER Marco Matos docker@corp.mmatos.com

# updating
RUN apt-get update  && apt-get install -y build-essential libpq-dev git curl apt-utils \
                      autoconf automake bison build-essential curl git-core
# for this app:
RUN apt-get install -y autoconf automake bison \
libc6-dev libltdl-dev libreadline6 libreadline6-dev \
libsqlite3-0 libsqlite3-dev libssl-dev libtool libxml2-dev libxslt-dev \
libxslt1-dev libyaml-dev ncurses-dev nodejs openssl sqlite3 zlib1g zlib1g-dev

RUN apt-get -f install

# for RVM
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -L get.rvm.io | bash -s stable
RUN /usr/local/rvm/bin/rvm -v
RUN gem install rails
RUN rails -v

RUN mkdir -p /app
ENV APP_HOME /app
WORKDIR $APP_HOME
RUN cd $APP_HOME

ENV APP_URL https://github.com/arthur-vieira/sample_twitter.git
RUN git clone $APP_URL .
RUN gem install bundler && bundle install --jobs 20 --retry 5
RUN rake db:migrate

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
