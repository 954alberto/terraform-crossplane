data "aws_iam_policy_document" "policy_eks_crossplane" {
  statement {
    sid    = "RDS"
    effect = "Allow"
    actions = [
      "rds:*",
    ]

    resources = ["arn:aws:rds:::*"]
  }
}

data "aws_iam_policy_document" "policy_crossplane_k8s_assume_role_policy" {

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"
      values = [
        "system:serviceaccount:crossplane-system:crossplane"
      ]
    }

    principals {
      identifiers = [module.eks.oidc_provider_arn]
      type        = "Federated"
    }
  }
}