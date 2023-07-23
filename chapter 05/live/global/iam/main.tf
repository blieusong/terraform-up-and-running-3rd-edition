provider "aws" {
  region = "eu-west-1"
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["tony", "steve", "bruce"]
}

# resource "aws_iam_user" "example" {
#   for_each = toset(var.user_names)
#   name     = each.value
# }

# output "all_users" {
#   value = values(aws_iam_user.example)[*].arn
# }

module "users" {
  source = "../../../modules/landing-zone/iam-user"

  for_each  = toset(var.user_names)
  user_name = each.value
}

output "user_arns" {
  value       = values(module.users)[*].user_arn
  description = "ARN of the created IAM users"
}
