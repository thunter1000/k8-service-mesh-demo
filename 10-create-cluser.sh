kind create cluster --config _10-create-cluster/kind-config.yaml

export KUBECONFIG="~/.kube/kind-config-kind"

echo $'\n➡️ K8s cluster created kubernetes configuration set to ~/.kube/kind-config-kind\n'