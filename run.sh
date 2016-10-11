#!/bin/bash

alter_the_conf(){
  local target_hostname="$1"

  sed \
    --in-place='' \
    --expression="s/proxy-target.bikes/$target_hostname/g" \
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

  alter_the_conf "$target_hostname" \
  && run_the_server
}
main "$@"
