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
RUN gem update --no-rdoc --no-ri --system &&\
    gem install                             \
    compass --no-ri --no-rdoc               \
    listen                                  \
    --pre bundler                           \
    --pre sass-css-importer

RUN gem update --no-rdoc --no-ri --system &&\
    gem install  pygments.rb:0.5.0  --no-rdoc --no-ri 

RUN gem update --no-rdoc --no-ri --system &&\
    gem install                           \
    jekyll            --no-rdoc --no-ri   \
    jekyll-sitemap    --no-rdoc --no-ri   \
    jekyll-gist       --no-rdoc --no-ri   \
    jekyll-paginate   --no-rdoc --no-ri   \
    json              --no-rdoc --no-ri   \
    format            --no-rdoc --no-ri  \
    rdiscount         --no-rdoc --no-ri

RUN git clone https://github.com/EarvinKayonga/earvin.git earvin

WORKDIR earvin/blog/
RUN jekyll build

RUN gem uninstall -aIx
RUN apk del
    bash              \
    ruby              \
    ruby-dev          \
    libffi-dev        \
    git               \
    build-base

RUN rm -rf /var/cache/apk/*
