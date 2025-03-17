resource "helm_release" "argo_cd" {

  depends_on = [module.gke]

  name             = "my-argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.8.11"
  namespace        = "argocd"
  create_namespace = true

}
