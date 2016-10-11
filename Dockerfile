FROM nginx
MAINTAINER Octoblu, Inc. <docker@octoblu.com>

COPY run.sh /
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["./run.sh"]
