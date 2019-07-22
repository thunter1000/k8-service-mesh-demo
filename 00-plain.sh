#! /bin/bash
script_dir=$(dirname $0)
source $script_dir/common.sh
source $script_dir/_00-plain/plain-common.sh

b_log "Creating namespace and deploying emojivoto"
(
  show_cmds
  kubectl create ns $emojivotoNamespace || true
  kubectl apply -n $emojivotoNamespace -f $script_dir/_emojivoto/deploy-emojivoto.yaml || true
)
s_log "Deployed emojivoto"