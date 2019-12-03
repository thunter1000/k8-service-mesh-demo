#! /bin/sh

script_dir=$(dirname $0)

source "$script_dir/common.sh"
source "$script_dir/_20-istio/istio-common.sh"

b_log "Creating 'istio-system' namespace"
(
  show_cmds;
  kubectl create ns istio-system || true
)


b_log "Configure istio service accounts"
(
  show_cmds;
  helm template "$script_dir/_20-istio/istio-charts/istio-init" --namespace istio-system | kubectl apply -f -
  kubectl wait --for=condition=complete job -n istio-system --all --timeout=30m
)
s_log "Istio service accounts created"



b_log "Deploy istio"
(
  show_cmds;
  helm template \
    --set kiali.enabled=true \
    --set kiali.createDemoSecret=true \
    --set grafana.enabled=true \
    --set tracing.enabled=true \
    "$script_dir/_20-istio/istio-charts/istio" \
    --namespace istio-system | kubectl apply -f -
  kubectl wait --for=condition=available deploy -n istio-system --all --timeout=30m
)
s_log "Istio has been deployed to the cluster"

b_log "Deploy bookinfo example"
(
  show_cmds;
  kubectl create ns $bookinfoNamespace || true
  kubectl label ns $bookinfoNamespace istio-injection=enabled --overwrite
  kubectl -n $bookinfoNamespace apply -f "$script_dir/_20-istio/bookinfo/deploy.yaml"
  kubectl -n $bookinfoNamespace apply -f "$script_dir/_20-istio/bookinfo/gateway.yaml"
)
s_log "Bookinfo example deployed"

b_log "Deploying Linkerd example (emojivoto)"
(
  show_cmds;
  kubectl create ns $emojivotoNamespace || true
  kubectl label ns $emojivotoNamespace istio-injection=enabled --overwrite
  kubectl -n $emojivotoNamespace apply -f "$script_dir/_emojivoto/deploy-emojivoto.yaml"
)
s_log "Linkerd (emojivoto) deployed."

b_log "Wait for deployments"
(
  show_cmds
  kubectl wait --for=condition=available deploy -n $bookinfoNamespace --all --timeout=30m
  kubectl wait --for=condition=available deploy -n $emojivotoNamespace --all --timeout=30m
)