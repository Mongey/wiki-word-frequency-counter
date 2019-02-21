FROM ruby:2.6.1-alpine

WORKDIR /tmp
COPY Gemfile* /tmp/
RUN bundle install

WORKDIR /home
COPY . .
ENTRYPOINT ["/home/bin/run"]
