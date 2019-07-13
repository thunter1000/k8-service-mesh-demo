#! /bin/sh

script_dir=$(dirname $0)

source "$script_dir/common.sh"

b_log "Creating 'istio-system' namespace"
(
  show_cmds;
  kubectl create ns istio-system || true
)


b_log "Configure istio service accounts"
(
  show_cmds;
  helm template "$script_dir/_50-deploy-istio/istio-charts/istio-init" --name istio-init --namespace istio-system | kubectl apply -f -
  kubectl wait --for=condition=complete job -n istio-system --all --timeout=30m
)
s_log "Istio service accounts created"



b_log "Deploy istio"
(
  show_cmds;
  helm template \
    --set kiali.enabled=true \
    --set kiali.createDemoSecret=true \
    "$script_dir/_50-deploy-istio/istio-charts/istio" \
    --name istio --namespace istio-system | kubectl apply -f -
  kubectl wait --for=condition=available deploy -n istio-system --all --timeout=30m
)
s_log "Istio has been deployed to the cluster"