# Global
account_num = "123456789"
assume_role_name = "OrganizationAccountAccessRole"
region = "us-west-1"

# VPC
vpc_cidr = "10.1.0.0/16"

# Subnet
public_subnet_a_cidr = "10.1.0.0/24"
public_subnet_b_cidr = "10.1.1.0/24"
public_subnet_a_az = "us-west-1a"
public_subnet_b_az = "us-west-1b"

# ALB
alb_name = "my-alb"
alb_port = 80
alb_protocol = "HTTP"

# Security Group
alb_sg_name = "alb-sg"
alb_sg_description = "ALB SG for HTTP traffic"
sg_alb_ingress_description = "Allow HTTP traffic"
sg_alb_ingress_cidr = "0.0.0.0/0"
sg_alb_ingress_from_port = 80
sg_alb_ingress_to_port = 80
sg_alb_ingress_ip_protocol = "tcp"
sg_alb_egress_description = "Allow all traffic"
sg_alb_egress_cidr = "0.0.0.0/0"
sg_alb_egress_ip_protocol = "-1"

# Target Group
tg_name = "my-tg"
tg_port = 80
tg_protocol = "HTTP"

# Auto Scaling Group
asg_name = "my-asg"
max_size = 4
min_size = 1
desired_size = 2

# Launch Template
lt_name_prefix = "my-lt"
lt_instance_type = "t2.micro"
lt_image_id = "ami-0cbe318e714fc9a82"

# EC2 Security Group
ec2_sg_name = "ec2-sg"
ec2_sg_description = "EC2 Web Server"
sg_ec2_ingress_description = "Allow HTTP traffic from ALB"
sg_ec2_ingress_ip_protocol = "-1"
sg_ec2_ingress_from_port = 80
sg_ec2_ingress_to_port = 80
sg_ec2_egress_description = "Allow all traffic"
sg_ec2_egress_ip_protocol = "-1"