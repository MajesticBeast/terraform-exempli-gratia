# Create an EC2 instance using the default VPC in us-west-1.

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

resource "aws_instance" "this" {
  ami           = "ami-0dd1b7c6ab3da88e7"
  instance_type = "t3.micro"
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

