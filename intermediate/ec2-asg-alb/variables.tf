variable "account_num" {
  description = "The AWS account number"
  type        = string
}

variable "assume_role_name" {
  description = "The name of the role to assume"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

# VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "The CIDR block for the public subnet in availability zone A"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "The CIDR block for the public subnet in availability zone B"
  type        = string
}

variable "public_subnet_a_az" {
  description = "The availability zone for the public subnet in availability zone A"
  type        = string
}

variable "public_subnet_b_az" {
  description = "The availability zone for the public subnet in availability zone B"
  type        = string
}

# ALB
variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "alb_port" {
  description = "The port for the ALB"
  type        = number
}

variable "alb_protocol" {
  description = "The protocol for the ALB"
  type        = string
}

# ALB Security Group
variable "alb_sg_name" {
  description = "The name of the security group"
  type        = string
}

variable "alb_sg_description" {
  description = "The description of the security group"
  type        = string
}

variable "sg_alb_ingress_description" {
  description = "The description of the ingress rule"
  type        = string
}

variable "sg_alb_ingress_cidr" {
  description = "The CIDR block for the ingress rule"
  type        = string
}

variable "sg_alb_ingress_from_port" {
  description = "The from port for the ingress rule"
  type        = number
}

variable "sg_alb_ingress_to_port" {
  description = "The to port for the ingress rule"
  type        = number
}

variable "sg_alb_ingress_ip_protocol" {
  description = "The IP protocol for the ingress rule"
  type        = string
}

variable "sg_alb_egress_description" {
  description = "The description of the egress rule"
  type        = string
}

variable "sg_alb_egress_cidr" {
  description = "The CIDR block for the egress rule"
  type        = string
}

variable "sg_alb_egress_ip_protocol" {
  description = "The IP protocol for the egress rule"
  type        = string
}

# Target Group
variable "tg_name" {
  description = "The name of the target group"
  type        = string
}

variable "tg_port" {
  description = "The port for the target group"
  type        = number
}

variable "tg_protocol" {
    description = "The protocol for the target group"
    type        = string
}

# ASG
variable "asg_name" {
  description = "The name of the ASG"
  type        = string
}

variable "min_size" {
  description = "The minimum size of the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the ASG"
  type        = number
}

variable "desired_size" {
  description = "The desired capacity of the ASG"
  type        = number
}

# Launch Template
variable "lt_name_prefix" {
  description = "The name of the launch template"
  type        = string
}

variable "lt_image_id" {
  description = "The AMI ID for the launch template"
  type        = string
}

variable "lt_instance_type" {
  description = "The instance type for the launch template"
  type        = string
}

# EC2 Security Group
variable "ec2_sg_name" {
  description = "The name of the security group"
  type        = string
}

variable "ec2_sg_description" {
  description = "The description of the security group"
  type        = string
}

variable "sg_ec2_ingress_description" {
  description = "The description of the ingress rule"
  type        = string
}

variable "sg_ec2_ingress_from_port" {
  description = "The from port for the ingress rule"
  type        = number
}

variable "sg_ec2_ingress_to_port" {
  description = "The to port for the ingress rule"
  type        = number
}

variable "sg_ec2_ingress_ip_protocol" {
  description = "The IP protocol for the ingress rule"
  type        = string
}

variable "sg_ec2_egress_description" {
  description = "The description of the egress rule"
  type        = string
}

variable "sg_ec2_egress_ip_protocol" {
    description = "The protocol for the egress rule"
    type        = string
}