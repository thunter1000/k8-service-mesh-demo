source ./common.sh

function finish {
  kind delete cluster --name cluster > /dev/null &

  sleep 1
}
trap finish EXIT

# Used to demo cluster creation, not the cluster being used in the demo.

(
  show_cmds;
  kind create cluster --config _10-create-cluster/kind-config.yaml --name cluster;
)