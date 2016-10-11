FROM nginx
MAINTAINER Octoblu, Inc. <docker@octoblu.com>

COPY . /etc/nginx/
RUN ["mv", "/etc/nginx/run.sh", "/run.sh"]

CMD ["./run.sh"]
