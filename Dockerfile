FROM ruby:3.2.1-alpine

ARG RAILS_ENV

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV RAILS_ENV=$RAILS_ENV

RUN apk add --update --no-cache \
    bash \
    curl \
    git \
    postgresql-client \
    && apk add --no-cache --virtual .build-deps \
    build-base \
    cmake \
    postgresql-dev

WORKDIR /app

COPY Gemfile* ./

RUN gem install bundler -v 2.4.12 \
    && bundle config --global frozen 1 \
    && bundle config set --global without "development test" \
    && bundle install --jobs $(nproc --ignore=1) --retry 5

RUN apk del .build-deps

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
