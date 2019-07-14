#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Binding port and opening browser"
(
  show_cmds
  kubectl -n istio-system port-forward svc/kiali 20001&
  portForward=$!
  sleep 1s
  open_web_browser "http://localhost:20001"
  wait $portForward
)