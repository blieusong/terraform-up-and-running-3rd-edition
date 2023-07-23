resource "aws_iam_user" "example" {
  name = var.user_name
}

variable "user_name" {
  description = "User name to use"
  type        = string
}

output "user_arn" {
  value       = aws_iam_user.example.arn
  description = "ARN of the created ARN user"
}
