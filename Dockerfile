FROM nginx
MAINTAINER Octoblu, Inc. <docker@octoblu.com>

WORKDIR /

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./run.sh /run.sh

CMD ["./run.sh"]
