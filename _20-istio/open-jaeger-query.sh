#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh
source $script_dir/istio-common.sh

b_log "Binding port and opening browser"
(
  show_cmds
  kubectl -n istio-system port-forward svc/jaeger-query 16686&
  portForward=$!
  sleep 1s
  open_web_browser "http://localhost:16686"
  wait $portForward
)