provider "aws" {
  region = "eu-west-1"
}

module "webserver-cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name           = "webserver-prod"
  db_remote_state_bucket = "blieusong-terraform-up-and-running-state"
  db_remote_state_key    = "prod/services/data-stores/mysql/terraform.tfstate"

  instance_type = "m6g.large"
  min_size      = 2
  max_size      = 10

  custom_tags = {
    owner = "Bill Doors",
    managed_by = "terraform"
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver-cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver-cluster.asg_name
}
