# Kubernetes Service Mesh Demos.
- Traffic sniffing on a cluster.
- Linkerd Service Mesh.
- Istio Service Mesh.

# Required Applications.
- [Python](https://www.python.org/downloads/).
- [Helm](https://helm.sh/docs/using_helm/#installing-helm).
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
- [Linkerd](https://linkerd.io/2/getting-started/).

# Scripts.
- `00-plain.sh` - Deploys Linkerd's example without a service mesh.
  - `_00-plain/open-emojivoto.sh` - Port forward the port for emojivoto and open a web browser.
   - `_00-plain/remove.sh` - Remove the deployment from the cluster.
- `10-linkerd.sh` - Deploys Linkerd's example with the Linkerd service mesh.
  - `_10-linkerd/open-emojivoto.sh` - Port forward the port for emojivoto and open a web browser.
  - `_10-linkerd/remove.sh` - Remove the deployment from the cluster.
- `20-istio.sh` - Deploys Linekrd's example and Istio's example with Istio's service mesh.
  - `_20-istio/open-emojivoto.sh` - Port forward the port for emojivoto and open a web browser.
  - `_20-istio/open-bookinfo.sh` - Open Istio's bookinfo demo. [Documentation here](https://istio.io/docs/examples/bookinfo/).
  - `_20-istio/open-kiali.sh` - Open Kiali dashboard (Username: admin Password: admin). [Website here](https://www.kiali.io).
  - `_20-istio/open-jaeger-query.sh` - Open Jaeger (open tracing) [Website Here](https://www.jaegertracing.io).
  - `_20-istio/remove.sh` - Remove the deployment from the cluster.
- `30-traffic-sniffing.sh` - Deploys a pod which logs the traffic within the cluster.
  - `_30-traffic-sniffing/show-logs.sh` - Output's a live view of the logs collected by the pod.
  - `_30-traffic-sniffing/remove.sh` - Remove deployment from the cluster.