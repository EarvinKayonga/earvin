FROM       nginx:1.11.0-alpine
MAINTAINER Earvin Kayonga <earvin@earvinkayonga.com>

ENV LANG en_US.utf8

# Install ruby & ruby-dev
RUN apk add  --update \
    bash              \
    ruby              \
    ruby-dev          \
    python            \
    python-dev        \
    libffi-dev        \
    git               \
    tree              \
    build-base

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
    format            --no-rdoc --no-ri  \
    rdiscount         --no-rdoc --no-ri




RUN git clone https://github.com/EarvinKayonga/earvin.git earvin
RUN git clone -b jekyll https://github.com/EarvinKayonga/vitae.git resume

RUN jekyll build --trace  --source earvin/blog/ --destination Blog
RUN jekyll build --trace  --source resume --destination vitae

RUN gem uninstall -aIx
RUN apk del           \
    bash              \
    ruby              \
    ruby-dev          \
    libffi-dev        \
    git               \
    python            \
    python-dev        \
    build-base

RUN rm -rf /var/cache/apk/*     \
RUN rm -rf /usr/local/lib/ruby  \
    rm -rf /usr/lib/ruby        \
    rm -f /usr/local/bin/ruby   \
    rm -f /usr/bin/ruby         \
    rm -f /usr/local/bin/irb    \
    rm -f /usr/bin/irb          \
    rm -f /usr/local/bin/gem    \
    rm -f /usr/bin/gem

RUN rm -rf /earvin               \
    rm -rf /resume

RUN mv    Blog/*        /usr/share/nginx/html
RUN cp -r vitae       /usr/share/nginx/html/

WORKDIR /usr/share/nginx/html
RUN     tree
