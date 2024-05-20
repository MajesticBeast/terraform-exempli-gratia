# Create an ALB using the default VPC in us-west-1.

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.50.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_lb" "this" {
  subnets         = ["subnet-7cb82225", "subnet-a47752c1"]
}

