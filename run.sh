#!/bin/bash

alter_the_conf(){
  local target_url="$1"

  # using delimiter '|' instead of '/' to prevent problems with
  # protocol delimiter 'https://'
  sed \
    --in-place='' \
    --expression="s|replace-me|$target_url|g" \
    /etc/nginx/nginx.conf
}

assert_env(){
  if [ -z "$TARGET_HOSTNAME" ]; then
    echo 'Missing required env: TARGET_HOSTNAME' 2>&1
    exit 1
  fi
}

run_the_server(){
  nginx -g "daemon off;"
  exit $?
}

main(){
  assert_env

  local target_hostname="$TARGET_HOSTNAME"
  local target_protocol="${TARGET_PROTOCOL:-https}"
  local target_url="${target_protocol}://${target_hostname}"

  echo "Redirecting all traffic to '$target_url'"

  alter_the_conf "$target_url" \
  && run_the_server
}
main "$@"
