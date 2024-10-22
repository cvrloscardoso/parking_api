FROM ruby:3.2.1-alpine

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV BUNDLE_PATH=/gems

RUN apk add --update --no-cache \
    bash \
    build-base \
    cmake \
    curl \
    git \
    postgresql-dev \
    postgresql-client \
    && rm -rf /var/cache/apk/*

WORKDIR /app

COPY Gemfile* ./

COPY . .

RUN gem install bundler -v 2.4.12 \
    && bundle install

EXPOSE 3000
