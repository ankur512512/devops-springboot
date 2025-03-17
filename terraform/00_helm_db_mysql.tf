resource "helm_release" "mysql" {

  depends_on = [module.gke]

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
