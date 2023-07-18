variable "server_port" {
  description = "Port the server will use for http requests"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "Name to use for all the cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "Name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "Path for the database's remote state in S3"
  type        = string
}

variable "instance_type" {
  description = "type of EC2 instance to run (e.g. t4g.micro)"
  type        = string
}

variable "min_size" {
  description = "Minimum number of EC2 instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum number of EC2 instances in the ASG"
  type        = number
}
