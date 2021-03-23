
variable "flux_namespace" {
  default = "flux"
}

resource "kubernetes_namespace" "flux" {
  depends_on = [null_resource.wait_for_eks_cluster]
  metadata {
    name = var.flux_namespace
  }
}

resource "kubernetes_secret" "flux-ssh" {
  depends_on = [kubernetes_namespace.flux]
  metadata {
    name      = "flux-ssh"
    namespace = var.flux_namespace
  }

  data = {
    identity = tls_private_key.gitops_repo.private_key_pem
  }
}

resource "helm_release" "flux" {
  depends_on       = [kubernetes_secret.flux-ssh]
  name             = "flux"
  namespace        = var.flux_namespace
  create_namespace = true
  repository       = "https://charts.fluxcd.io"
  chart            = "flux"
  version          = "1.5.0"

  set {
    name  = "syncGarbageCollection.enabled"
    value = "true"
  }

  set {
    name  = "registry.disableScanning"
    value = "true"
  }

  set {
    name  = "git.secretName"
    value = "flux-ssh"
  }

  set {
    name  = "git.url"
    value = github_repository.gitops.ssh_clone_url
  }

  set {
    name  = "git.branch"
    value = "main"
  }
}

# resource "helm_release" "helm_operator" {
#   depends_on       = [helm_release.flux]
#   name             = "helm-operator"
#   namespace        = var.flux_namespace
#   create_namespace = true
#   repository       = "https://charts.fluxcd.io"
#   chart            = "helm-operator"
#   version          = "1.2.0"
#   set {
#     name  = "git.ssh.secretName"
#     value = "flux-ssh"
#   }
#   set {
#     name  = "helm.versions"
#     value = "v3"
#   }
# }
