FROM       nginx:1.11.0-alpine
MAINTAINER Earvin Kayonga <earvin@earvinkayonga.com>

ENV LANG en_US.utf8

# Install ruby & ruby-dev
RUN apk add  --update \
    bash              \
    ruby              \
    ruby-dev          \
    libffi-dev        \
    git               \
    build-base

RUN gem sources --add https://rubygems.org/
RUN gem update --no-rdoc --no-ri --system
RUN gem install       \
    compass --no-ri --no-rdoc \
    listen            \
    --pre sass-css-importer

RUN rm -rf /var/cache/apk/*

RUN gem update --no-rdoc --no-ri --system &&\
    gem install    --no-rdoc --no-ri   \
    jekyll            \
    jekyll-sitemap    \
    jekyll-gist

RUN git clone git@github.com:EarvinKayonga/earvin.git earvin

WORKDIR earvin/blog/

RUN bundle install && jekyll build
