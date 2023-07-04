resource "aws_instance" "example" {
  ami           = "ami-090b049bea4780001"
  instance_type = "t4g.micro"
}

terraform {
  backend "s3" {
    bucket = "blieusong-terraform-up-and-running-state"
    key    = "workspaces-examples/terraform.tfstate"
    region = "eu-west-1"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
