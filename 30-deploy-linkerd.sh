function finish {
  echo $'\n➡️ Remove emojivoto, linkerd namespaces\n'
  kubectl delete namespace emojivoto &
  kubectl delete namespace linkerd &

  sleep 1
}
trap finish EXIT

echo $'\n➡️ Installing linkerd\n'
linkerd install | kubectl apply -f -

echo $'\n➡️ Checking linkerd is installed correctly\n'
linkerd check

echo $'\n➡️ Installing demo application\n'

linkerd inject _30-deploy-linkerd/linkerd-demo-app.yml | kubectl apply -f -

echo $'\n➡️ Checking deployment of example application\n'

linkerd -n emojivoto check --proxy

echo $'\n➡️ Binding port for example application'

kubectl -n emojivoto port-forward svc/web-svc 8080:80 &

echo $'\n➡️ Starting dashboard\n'
linkerd dashboard &
python -m webbrowser "http://127.0.0.1:8080" &

wait