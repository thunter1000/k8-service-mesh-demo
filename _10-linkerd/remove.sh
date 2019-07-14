#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Removing emojivoto, linkerd namespaces"
(
  show_cmds
  kubectl delete ns --now emojivoto linkerd
)
s_log "Linkerd demo has been removed from the cluster."