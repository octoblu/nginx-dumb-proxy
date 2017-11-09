#!/bin/bash

alter_the_conf(){
  local target_protocol="$1"
  local target_hostname="$2"
  local resolvers="$3"

  # using delimiter '|' instead of '/' to prevent problems with
  # path delimiter 'foo.com/whatever'
  sed \
    --in-place='' \
    --expression="s|target_protocol|$target_protocol|g" \
    /etc/nginx/nginx.conf

  sed \
    --in-place='' \
    --expression="s|target_hostname|$target_hostname|g" \
    /etc/nginx/nginx.conf

  sed \
    --in-place='' \
    --expression="s|# RESOLVERS_HOOK|$resolvers|g" \
    /etc/nginx/nginx.conf
}

assert_env(){
  if [ -z "$NGINX_DUMB_PROXY_TARGET_HOSTNAME" -a -z "$TARGET_HOSTNAME" ]; then
    echo 'Missing required env: NGINX_DUMB_PROXY_TARGET_HOSTNAME' 2>&1
    exit 1
  fi
}

get_resolvers() {
  cat /etc/resolv.conf \
  | grep '^nameserver' \
  | awk '{print "resolver "$2";"}'
}

run_the_server(){
  nginx -g "daemon off;"
  exit $?
}

main(){
  assert_env

  local resolvers target_hostname target_protocol target_url

  resolvers="$(get_resolvers)"
  target_hostname="${NGINX_DUMB_PROXY_TARGET_HOSTNAME:-$TARGET_HOSTNAME}"
  target_protocol="${NGINX_DUMB_PROXY_TARGET_PROTOCOL:-${TARGET_PROTOCOL:-https}}"
  target_url="${target_protocol}://${target_hostname}"

  echo "Redirecting all traffic to '$target_url'"

  alter_the_conf "$target_protocol" "$target_hostname" "${resolvers[@]}" \
  && run_the_server
}
main "$@"
