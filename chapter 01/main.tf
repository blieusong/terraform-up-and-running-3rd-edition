provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {
    ami = "ami-090b049bea4780001"
    instance_type = "t4g.micro"

    tags = {
        Name = "terraform-example"
    }
}