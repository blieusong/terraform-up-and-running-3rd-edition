output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "Domain name of the load balancer"
}

output "default_subnets_ids" {
  value       = data.aws_subnets.default.ids
  description = "List of default subnets"
}

output "asg_name" {
  value = aws_autoscaling_group.example.name
  description = "Name of the Auto Scaling Group"
}

output "alb_security_group_id" {
  value = aws_security_group.alb.id
  description = "ID of the security group attached to the load balancer"
}

output "instance_security_group_id" {
  value = aws_security_group.instance.id
  description = "ID of the security group for the instance"
}