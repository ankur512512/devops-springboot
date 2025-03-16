resource "helm_release" "argo_cd" {

  depends_on = [google_container_cluster.primary, google_container_node_pool.primary_nodes]

  name             = "my-argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.8.11"
  namespace        = "argocd"
  create_namespace = true

  values = [
    <<-EOT
    # Add any custom values here if needed
    EOT
  ]
}
