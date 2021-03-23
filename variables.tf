variable "region" {
  default = "eu-west-1"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "777777777777",
    "888888888888",
  ]
}

# variable "map_roles" {
#   description = "Additional IAM roles to add to the aws-auth configmap."
#   type = list(object({
#     rolearn  = string
#     username = string
#     groups   = list(string)
#   }))

#   default = [
#     {
#       rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/role1"
#       username = "role1"
#       groups   = ["system:masters"]
#     },
#   ]
# }

# variable "map_users" {
#   description = "Additional IAM users to add to the aws-auth configmap."
#   type = list(object({
#     userarn  = string
#     username = string
#     groups   = list(string)
#   }))

#   default = [
#     {
#       userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/user1"
#       username = "user1"
#       groups   = ["system:masters"]
#     },
#     {
#       userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/user2"
#       username = "user2"
#       groups   = ["system:masters"]
#     },
#   ]
# }

locals {
  map_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}
locals {
  map_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}
