resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_service" "streamlit" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.streamlit.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.streamlit.arn
    container_name   = var.container_definitions[0].name
    container_port   = var.container_definitions[0].portMappings[0].containerPort
  }
}

resource "aws_ecs_task_definition" "streamlit" {
  family                   = var.task_family
  execution_role_arn         = aws_iam_role.ecsTaskExecutionRole.arn
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  runtime_platform {
    operating_system_family = var.runtime_platform.operating_system
    cpu_architecture = var.runtime_platform.cpu_architecture
  }
  container_definitions = jsonencode(var.container_definitions)
}

resource "aws_alb_target_group" "streamlit" {
  name        = var.tg_name
  port        = var.container_definitions[0].portMappings[0].containerPort
  protocol    = var.tg_protocol
  vpc_id      = var.tg_vpc_id
  target_type = var.tg_target_type
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = var.role_name
  assume_role_policy = jsonencode(var.assume_role_policy)

  inline_policy {
    name = var.inline_policy_name
    policy = jsonencode(var.inline_policies)
  }
}

resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  security_groups    = var.security_groups
  subnets            = var.subnets
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.streamlit.arn
  }
}