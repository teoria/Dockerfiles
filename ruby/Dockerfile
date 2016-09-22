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
ENV APP_URL https://github.com/rackerlabs/rax_rails_tutorial.git
RUN git clone $APP_URL .

RUN sed -i -e 's/2.0.0/2.3.1/g' Gemfile
RUN bundle config git.allow_insecure true
RUN gem install bundler && bundle install

WORKDIR $APP_HOME
RUN cd $APP_HOME
RUN ls -l .

RUN bundle exec rake db:create

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
