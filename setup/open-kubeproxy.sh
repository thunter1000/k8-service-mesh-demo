#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Binding port and opening browser"
(
  show_cmds
  kubectl proxy&
  portForward=$!
  sleep 1s
  open_web_browser "http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"
  wait $portForward
)