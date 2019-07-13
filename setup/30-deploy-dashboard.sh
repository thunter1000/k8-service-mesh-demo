#! /bin/sh

script_dir=$(dirname $0)

source "$script_dir/../common.sh"



b_log "Deploying the dashboard"
(
  show_cmds;
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml; # TODO download for offline
)

b_log "Patching the dashboard"
(
  show_cmds;
  kubectl patch deployments kubernetes-dashboard --patch "$(cat $script_dir/_30-deploy-dashboard/kube-dashboard-skip-login-patch.yaml)" -n kube-system
)


b_log "Deploying Heapster for metrics"
(
  show_cmds;
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml; # TODO download for offline
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml; # TODO download for offline
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml; # TODO download for offline
)

b_log "Create kubernetes-dashboard service account"
(
  show_cmds;
  kubectl apply -f "$script_dir/_30-deploy-dashboard/kube-dashboard-service-account.yaml"
)