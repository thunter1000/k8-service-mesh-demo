#! /bin/bash
script_dir=$(dirname $0)
source $script_dir/../common.sh
source $script_dir/plain-common.sh

b_log "Removing emojivoto"
(
  show_cmds
  kubectl delete ns $emojivotoNamespace
)
s_log "Removed emojivoto"