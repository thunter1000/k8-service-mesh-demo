#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Binding port and opening browser"
(
  show_cmds
  kubectl -n linkerd port-forward svc/linkerd-web 8084&
  portForward=$!
  sleep 1s
  open_web_browser "http://localhost:8084"
  wait $portForward
)