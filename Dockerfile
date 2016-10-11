FROM nginx
MAINTAINER Octoblu, Inc. <docker@octoblu.com>

COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh .

CMD ["./run.sh"]
