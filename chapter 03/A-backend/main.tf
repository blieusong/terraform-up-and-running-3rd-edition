provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "blieusong-terraform-up-and-running-state"

  # prevent accidentl deletion of this s3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# explicitely block all public access to the s3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  # looks like we can't use variables here
  backend "s3" {
    key = "global/s3/terraform.state"
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "ARN of the terraform state S3 bucket"
}

output "dynamo_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "Name of the DynamoDB table"
}
