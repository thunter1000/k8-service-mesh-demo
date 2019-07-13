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

b_log "Deploy bookinfo example"
(
  show_cmds;
  kubectl create ns bookinfo || true
  kubectl label ns bookinfo istio-injection=enabled --overwrite
  kubectl -n bookinfo apply -f "$script_dir/_50-deploy-istio/bookinfo/deploy.yaml"
  kubectl -n bookinfo apply -f "$script_dir/_50-deploy-istio/bookinfo/gateway.yaml"
)
s_log "Bookinfo example deployed"

b_log "Deploying Linkerd example (emojivoto)"
(
  show_cmds;
  kubectl create ns emojivoto || true
  kubectl label ns emojivoto istio-injection=enabled --overwrite
  kubectl -n emojivoto apply -f "$script_dir/_30-deploy-demo-application/demo-app.yaml"
)
s_log "Linkerd (emojivoto) deployed."

b_log "Wait for deployments"

kubectl wait --for=condition=available deploy -n bookinfo --all --timeout=30m
kubectl wait --for=condition=available deploy -n emojivoto --all --timeout=30m