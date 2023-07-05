output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"
}

output "default_subnets_ids" {
  value       = data.aws_subnets.default.ids
  description = "List of default subnets"
}
