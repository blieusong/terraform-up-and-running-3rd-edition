output "alb_dns_name" {
  value = module.webserver-cluster.alb_dns_name
  description = "Domain name of the load balancer"
}