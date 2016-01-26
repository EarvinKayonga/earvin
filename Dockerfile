FROM node:4.2.1
MAINTAINER Earvin Kayonga <earvin.kayonga@gmail.com>

ENV BOWER_VERSION 1.7.1

RUN apt-get update \
	&& apt-get install -y locales \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

#
# Note: npm is v2.14.7
RUN npm install -g bower@$BOWER_VERSION
RUN npm install -g forever


RUN npm install && bower install --allow-root

RUN chmod +x launch.sh

# run forever on container start
ENTRYPOINT ["./launch.sh"]
EXPOSE 4200 49152
CMD ["echo started"]
