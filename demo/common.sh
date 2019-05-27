set -e

trap "kill 0" EXIT

function b_log() {
  echo "
➡️  $1
"
}

function s_log() {
  echo "
✅ $1
"
}

function f_log() {
  echo "
❌ $1
"
}

function show_cmds() {
  set -x
}

function open_web_browser() {
  python -m webbrowser $1
}

function show_kube_dashboard() {
  (
    kubectl proxy &
    open_web_browser "http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/node?namespace=kube-system" &
    wait
  )
}