resource "github_repository" "gitops" {
  name        = "gitops"
  description = "My awesome codebase"
  auto_init   = true
  visibility  = "private"
}
# resource "github_branch" "main" {
#   repository = github_repository.gitops.name
#   branch     = "main"
# }
# Add a deploy key
resource "github_repository_deploy_key" "gitops_repository_deploy_key" {
  depends_on = [github_repository.gitops]
  title      = "gitops"
  repository = "gitops"
  key        = tls_private_key.gitops_repo.public_key_openssh
  read_only  = "false"
}

resource "github_repository_file" "cluster" {
  repository          = github_repository.gitops.name
  branch              = "main"
  file                = "cluster.yaml"
  content             = file("${path.module}/gitops/cluster.yaml")
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

resource "github_repository_file" "helm-operator" {
  repository          = github_repository.gitops.name
  branch              = "main"
  file                = "helm-operator.yaml"
  content             = file("${path.module}/gitops/helm-operator.yaml")
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

resource "github_repository_file" "helm-operator-crd" {
  repository          = github_repository.gitops.name
  branch              = "main"
  file                = "helm-operator-crd.yaml"
  content             = file("${path.module}/gitops/helm-operator-crd.yaml")
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

resource "github_repository_file" "crossplane" {
  repository          = github_repository.gitops.name
  branch              = "main"
  file                = "cronssplane.yaml"
  content             = file("${path.module}/gitops/crossplane.yaml")
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}
