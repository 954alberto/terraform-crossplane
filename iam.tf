resource "aws_iam_role" "role_eks_crossplane" {
  name               = "role-eks-crossplane"
  assume_role_policy = data.aws_iam_policy_document.policy_crossplane_k8s_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "role_eks_crossplane" {
  role       = aws_iam_role.role_eks_crossplane.name
  policy_arn = aws_iam_policy.policy_eks_crossplane.arn
}

resource "aws_iam_policy" "policy_eks_crossplane" {
  name        = "policy-eks-crossplane"
  path        = "/"
  description = "Crossplane"
  policy      = data.aws_iam_policy_document.policy_eks_crossplane.json
}
