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

# RUN bundle install \
#     && rm -rf /gems/cache/*.gem

COPY . .

EXPOSE 3000
