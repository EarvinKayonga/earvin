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
    echo "http://dl-5.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories;


RUN apk add --no-cache  --update\
    ruby-dev  			            \
    ruby                        \
    libffi-dev                  \
    python-dev                  \
    python                      \
    git                         \
    tree                        \
    zlib                        \
    zlib-dev                    \
    curl                        \
    wget                        \
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
    gem install io-console bundler
                              \




RUN git clone https://github.com/EarvinKayonga/earvin.git earvin
RUN git clone -b jekyll https://github.com/EarvinKayonga/vitae.git resume

RUN gem cleanup --dryrun
RUN gem uninstall addressable -aIx
RUN gem install addressable:2.4.0 --no-rdoc --no-ri
RUN gem install sawyer:0.7.0 --no-rdoc --no-ri
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
    #rm -rf /usr/lib/ruby      	\
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
