#! /bin/sh

script_dir=$(dirname $0)
source "$script_dir/common.sh"

b_log "Installing demo application"
(
  show_cmds;
  kubectl apply -f "$script_dir/_30-deploy-demo-application/demo-app.yml"
)

s_log "Demo application deployed to the cluster."