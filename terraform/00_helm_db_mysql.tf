resource "helm_release" "mysql" {

  depends_on = [google_container_cluster.primary, google_container_node_pool.primary_nodes]

  name       = "db-mysql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mysql"
  version    = "8.0.0"

  set {
    name  = "image.tag"
    value = "8.0"
  }

  set {
    name  = "auth.rootPassword"
    value = "dev"
  }

  set {
    name  = "auth.database"
    value = "challenge"
  }

  set {
    name  = "primary.persistence.size"
    value = "1Gi"
  }

  set {
    name  = "primary.service.type"
    value = "ClusterIP"
  }
}
