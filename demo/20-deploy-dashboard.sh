#! /bin/sh
source ./common.sh

b_log "Deploying the dashboard"
(
  show_cmds;
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml;
)

b_log "Patching the dashboard"
(
  show_cmds;
  kubectl patch deployments kubernetes-dashboard --patch "$(cat _20-deploy-dashboard/kube-dashboard-skip-login-patch.yaml)" -n kube-system;
)


b_log "Deploying Heapster for metrics"
(
  show_cmds;
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml;
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml;
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml;
)

b_log "Create kubernetes-dashboard service account"
(
  show_cmds;
  kubectl apply -f _20-deploy-dashboard/kube-dashboard-service-account.yaml;
)


(
  s_log "Dashboard deployed"
  show_kube_dashboard &
  wait;
)