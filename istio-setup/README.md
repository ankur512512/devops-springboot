# Instructions to setup k3d cluster with Istio side-car mode with gateways, kube-prometheus-stack and kiali dashboard


## Create k3d cluster
k3d cluster create --api-port 6550 -p '80:80@loadbalancer' -p '443:443@loadbalancer' --agents 2 --k3s-arg '--disable=traefik@server:*'


### Install Istio Base components like CRDs and cluster roles
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm install istio-base istio/base -n istio-system --create-namespace --wait

### Install Istiod Control plane node that will manage proxies
helm install istiod istio/istiod -n istio-system --wait

### Install Ingress gateway
helm install istio-ingressgateway istio/gateway -n istio-system --create-namespace --wait

### Label default namespace to include in Istio mesh
kubectl label namespace default istio-injection=enabled


## Kiali
helm repo add kiali https://kiali.org/helm-charts
helm upgrade --install --namespace kiali-operator --create-namespace kiali-operator kiali/kiali-operator --values kiali/values.yaml


## Kube-prometheus-stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm upgrade --install -n monitoring kube-prometheus-stack prometheus-community/kube-prometheus-stack --create-namespace --values kube-prometheus-stack/values.yaml
