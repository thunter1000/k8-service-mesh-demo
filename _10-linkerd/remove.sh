#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh
source $script_dir/linkerd-common.sh

b_log "Removing $emojivotoNamespace, linkerd namespaces"
(
  show_cmds
  kubectl delete ns --now $emojivotoNamespace || true &
  kubectl delete ns --now linkerd || true &
  wait
)
s_log "Linkerd demo has been removed from the cluster."