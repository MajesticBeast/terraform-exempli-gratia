resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.public_subnet_a_az
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.public_subnet_b_az
  map_public_ip_on_launch = true
}

resource "aws_lb" "alb" {
  name = var.alb_name
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_port
  protocol          = var.alb_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_security_group" "alb" {
  name        = var.alb_sg_name
  description = var.alb_sg_description
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "alb" {
  security_group_id = aws_security_group.alb.id
  description = var.sg_alb_ingress_description
  cidr_ipv4 = var.sg_alb_ingress_cidr
  from_port = var.sg_alb_ingress_from_port
  to_port = var.sg_alb_ingress_to_port
  ip_protocol = var.sg_alb_ingress_ip_protocol
}

resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = aws_security_group.alb.id
  description = var.sg_alb_egress_description
  cidr_ipv4 = var.sg_alb_egress_cidr
  ip_protocol = var.sg_alb_egress_ip_protocol
}

resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = aws_vpc.main.id
}

resource "aws_autoscaling_group" "asg" {
  name                 = var.asg_name
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_size
  vpc_zone_identifier  = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  launch_template {
    id = aws_launch_template.lt.id
  }
  target_group_arns    = [aws_lb_target_group.tg.arn]
}

resource "aws_launch_template" "lt" {
  name_prefix   = var.lt_name_prefix
  image_id      = var.lt_image_id
  instance_type = var.lt_instance_type
}

resource "aws_security_group" "ec2" {
  name        = var.ec2_sg_name
  description = var.ec2_sg_description
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "ec2" {
  security_group_id = aws_security_group.ec2.id
  referenced_security_group_id = aws_security_group.alb.id
  description = var.sg_ec2_ingress_description
  from_port = var.sg_ec2_ingress_from_port
  to_port = var.sg_ec2_ingress_to_port
  ip_protocol = var.sg_ec2_ingress_ip_protocol
}

resource "aws_vpc_security_group_egress_rule" "ec2" {
  security_group_id = aws_security_group.ec2.id
  referenced_security_group_id = aws_security_group.alb.id
  description = var.sg_ec2_egress_description
  ip_protocol = var.sg_ec2_egress_ip_protocol
}

