FROM       nginx:1.11.5-alpine
MAINTAINER Earvin Kayonga <earvin@earvinkayonga.com>
ENV JEKYLL_ENV production
ENV LANG en_US.utf8

# FUCKING equivalent to build-essential
RUN apk add --update build-base

RUN echo "ipv6" >> /etc/modules \
    echo "http://dl-1.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-2.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-6.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories;


# Install ruby & ruby-dev
RUN apk add --no-cache  --update\
    python-dev                  \
    ruby-dev                    \
    libffi-dev                  \
    ruby                        \
    python                      \
    git                         \
    tree                        \
    nodejs


# Install Ruby Gems
RUN gem sources --add https://rubygems.org/
RUN gem update --no-rdoc --no-ri --system &&\
    gem install                             \
    compass --no-ri --no-rdoc               \
    --pre bundler                           \
    --pre sass-css-importer

RUN gem update --no-rdoc --no-ri --system &&\
    gem uninstall pygments.rb             &&\
    gem install  pygments.rb:0.5.0  --no-rdoc --no-ri

RUN gem update --no-rdoc --no-ri --system &&\
    gem install                           \
    jekyll            --no-rdoc --no-ri   \
    jekyll-sitemap    --no-rdoc --no-ri   \
    jekyll-gist       --no-rdoc --no-ri   \
    jekyll-paginate   --no-rdoc --no-ri   \
    json              --no-rdoc --no-ri   \
    format            --no-rdoc --no-ri   \
    jekyll-minifier   --no-rdoc --no-ri   \
    jekyll-seo-tag    --no-rdoc --no-ri   \
    rdiscount         --no-rdoc --no-ri




RUN git clone https://github.com/EarvinKayonga/earvin.git earvin
RUN git clone -b jekyll https://github.com/EarvinKayonga/vitae.git resume

RUN jekyll build --trace  --profile --source earvin/blog/ --destination Blog
RUN jekyll build --trace  --profile --source resume --destination vitae

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

RUN rm -rf /var/cache/apk/*     \
RUN rm -rf /usr/local/lib/ruby  \
    rm -rf /usr/lib/ruby        \
    rm -f /usr/local/bin/ruby   \
    rm -f /usr/bin/ruby         \
    rm -f /usr/local/bin/irb    \
    rm -f /usr/bin/irb          \
    rm -f /usr/local/bin/gem    \
    rm -f /usr/bin/gem          \
    rm -f /usr/bin/node         \
    rm -f /lib/node_modules

RUN rm -rf /earvin               \
    rm -rf /resume

RUN mv    Blog/*        /usr/share/nginx/html
RUN cp -r vitae       /usr/share/nginx/html/

WORKDIR /usr/share/nginx/html
RUN     tree
