#! /bin/sh
script_dir=$(dirname $0)
source "$script_dir/common.sh"

b_log "Installing linkerd"
(
  show_cmds;
  linkerd install | kubectl apply -f -
)

b_log "Checking linkerd is installed correctly"
(
  show_cmds;
  linkerd check
)

b_log "Installing demo application"
(
  show_cmds;
  linkerd inject "$script_dir/_emojivoto/deploy-emojivoto.yaml" | kubectl apply -f -
)

b_log "Checking deployment of example application"
(
  show_cmds;
  linkerd -n emojivoto check --proxy;
)