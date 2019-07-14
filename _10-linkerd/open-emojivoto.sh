#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Binding port and opening browser"
(
  show_cmds
  kubectl -n emojivoto port-forward svc/web-svc 8091:80&
  portForward=$!
  sleep 1s
  open_web_browser "http://localhost:8091"
  wait $portForward
)