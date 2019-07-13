#! /bin/sh
script_dir=$(dirname $0)
source "$script_dir/common.sh"

function finish {
  b_log "Remove emojivoto, linkerd namespaces"
  kubectl delete namespace emojivoto &
  kubectl delete namespace linkerd &

  sleep 1
}
trap finish EXIT

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

b_log "Binding port for example application"
(
  show_cmds;
  kubectl -n emojivoto port-forward svc/web-svc 8080:80 &
)

b_log "Starting dashboard"
(
  show_cmds;
  linkerd dashboard &
  show_kube_dashboard &
  open_web_browser "http://127.0.0.1:8080" &
  wait;
)
