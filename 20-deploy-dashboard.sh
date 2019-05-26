

echo $'\n➡️ Deploying the dashboard\n'
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml

echo $'\n➡️ Patching the dashboard\n'
kubectl patch deployments kubernetes-dashboard --patch "$(cat _20-deploy-dashboard/kube-dashboard-skip-login-patch.yaml)" -n kube-system

echo $'\n➡️ Deploying Heapster for metrics\n'
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml

echo $'\n➡️ Create kubernetes-dashboard service account\n'
kubectl apply -f _20-deploy-dashboard/kube-dashboard-service-account.yaml