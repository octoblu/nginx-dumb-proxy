#!/bin/bash

alter_the_conf(){
  local target_host="$1"

  sed \
    --in-place='' \
    --expression="s/proxy-target.bikes/$target_host/g" \
    /etc/nginx/nginx.conf
}

assert_env(){
  if [ -z "$TARGET_HOST" ]; then
    echo 'Missing required env: TARGET_HOST' 2>&1
    exit 1
  fi
}

run_the_server(){
  nginx -g "daemon off;"
  exit $?
}

main(){
  assert_env

  local target_host="$TARGET_HOST"

  alter_the_conf "$target_host" \
  && run_the_server
}
main "$@"
