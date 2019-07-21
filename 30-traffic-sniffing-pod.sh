#! /bin/sh

script_dir=$(dirname $0)
source "$script_dir/common.sh"

namespace='traffic-sniffing'
dockerImage='traffic-sniffing-container'

b_log "Creating '$namespace' namespace"
(
  show_cmds;
  kubectl create namespace $namespace || true
)

if [ -z $(docker image ls $dockerImage -q) ]
then
  b_log "Building $dockerImage"
  sh $script_dir/_30-traffic-sniffing-pod/build.sh
  s_log "Built $dockerImage"
fi

b_log "Deploy traffic sniffing pod"
(
  show_cmds;
  kubectl -n $namespace apply -f $script_dir/_30-traffic-sniffing-pod/deployment.yaml
)
s_log "Traffic sniffing pod has been deployed to the cluster"

b_log "Wait for deployments"

kubectl wait --for=condition=available deploy -n $namespace --all --timeout=30m