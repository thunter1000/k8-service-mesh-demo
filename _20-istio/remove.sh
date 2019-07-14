#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Removing emojivoto, bookinfo & istio-system namespaces."
(
  show_cmds
  kubectl delete ns --now emojivoto bookinfo istio-system
)
s_log "Istio has been removed from the cluster."