FROM       alpine:latest as builder
MAINTAINER Earvin Kayonga <earvin@earvinkayonga.com>
ENV JEKYLL_ENV production
ENV LANG    en_US.utf8


# FUCKING equivalent to build-essential
RUN apk add --update build-base openssh git tree

RUN echo "ipv6" >> /etc/modules \
    echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories;

RUN apk add --upgrade apk-tools

RUN apk add --no-cache  --update\
    ruby-dev=2.5.0-r0   			  \
    ruby=2.5.0-r0               \
    libffi-dev                  \
    python-dev                  \
    python                      \
    zlib                        \
    zlib-dev                    \
    curl                        \
    wget                        \
    nodejs


# Install Ruby Gems
RUN gem sources --add https://rubygems.org/
RUN gem update --no-rdoc --no-ri --system &&\
    gem install io-console --no-rdoc --no-ri\
    bigdecimal

RUN git clone https://github.com/EarvinKayonga/earvin.git earvin
RUN git clone -b jekyll https://github.com/EarvinKayonga/vitae.git resume

RUN bundle install --gemfile earvin/Gemfile
RUN jekyll build --trace  --profile  --incremental --source earvin/blog/ --destination Blog
RUN jekyll build --trace  --profile  --incremental --source resume --destination vitae

RUN gem uninstall -aIx
RUN apk del           \
    bash              \
    ruby              \
    ruby-dev          \
    libffi-dev        \
    git               \
    python            \
    python-dev        \
    nodejs            \
    build-base

RUN mkdir build
RUN mv    Blog/*        build/
RUN cp -r vitae         build/

WORKDIR /usr/share/nginx/html
RUN     tree

FROM       nginx:1.13-alpine
COPY --from=builder /build /usr/share/nginx/html
