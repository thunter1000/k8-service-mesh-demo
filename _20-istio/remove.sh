#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh
source $script_dir/istio-common.sh

b_log "Removing emojivoto, bookinfo & istio-system namespaces."
(
  show_cmds
  kubectl delete ns --now $emojivotoNamespace || true&
  kubectl delete ns --now $bookinfoNamespace || true&
  kubectl delete ns --now istio-system || true&
  wait
)
s_log "Istio demo has been removed from the cluster."