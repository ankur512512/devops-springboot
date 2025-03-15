resource "helm_release" "kube_prometheus_stack" {

  depends_on = [google_container_cluster.primary, google_container_node_pool.primary_nodes]

  name             = "monitoring"
  namespace        = "monitoring"
  create_namespace = true
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "45.0.0"
}
