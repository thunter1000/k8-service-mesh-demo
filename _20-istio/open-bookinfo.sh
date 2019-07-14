#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Binding port and opening browser"
(
  show_cmds
  kubectl -n bookinfo port-forward svc/productpage 9080&
  portForward=$!
  sleep 1s
  open_web_browser "http://localhost:9080"
  wait $portForward
)