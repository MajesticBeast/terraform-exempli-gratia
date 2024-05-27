resource "aws_ecs_cluster" "main" {
  name = var.cluster_name #"streamlist-ecs-cluster"
}

resource "aws_ecs_service" "streamlit" {
  name            = var.service_name #"streamlit-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.streamlit.arn
  desired_count   = var.desired_count #2
  launch_type     = var.launch_type#"FARGATE"

  network_configuration {
    subnets          = var.subnets #["subnet-0175a77f97954926d", "subnet-07a4bc3137422bcd1"]
    security_groups  = var.security_groups#["sg-0d91f7ac7a48248fc"]
    assign_public_ip = var.assign_public_ip#true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.streamlit.arn
    container_name   = var.container_definitions[0].name #"streamlit"
    container_port   = var.container_definitions[0].portMappings[0].containerPort #8501
  }
}

resource "aws_ecs_task_definition" "streamlit" {
  family                   = var.task_family #treamlit-task-definition"
  execution_role_arn         = aws_iam_role.ecsTaskExecutionRole.arn
  network_mode             = var.network_mode#"awsvpc"
  requires_compatibilities = var.requires_compatibilities#["FARGATE"]
  cpu                      = var.task_definition_cpu#"512"
  memory                   = var.task_definition_memory#"2048"
  runtime_platform {
    operating_system_family = var.runtime_platform.operating_system #LINUX
    cpu_architecture = var.runtime_platform.cpu_architecture #ARM64
  }
  container_definitions = jsonencode(var.container_definitions)
}

resource "aws_alb_target_group" "streamlit" {
  name        = var.tg_name#"streamlit-ecs-fargate-tg"
  port        = var.container_definitions[0].portMappings[0].containerPort #8501
  protocol    = var.tg_protocol#"HTTP"
  vpc_id      = var.tg_vpc_id#"vpc-0b6a8182317c74729"
  target_type = var.tg_target_type#"ip"
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = var.role_name#"ecsTaskExecutionRole-TFManaged"
  assume_role_policy = jsonencode(var.assume_role_policy)

  inline_policy {
    name = var.inline_policy_name#"ecsTaskExecutionRolePolicy-TFManaged"
    policy = jsonencode(var.inline_policies)
  }
}

resource "aws_lb" "alb" {
  name               = var.alb_name#"streamlit-ecs-fargate-alb"
  internal           = var.alb_internal#false
  load_balancer_type = var.alb_type#"application"
  security_groups    = var.security_groups
  subnets            = var.subnets#["subnet-0175a77f97954926d", "subnet-07a4bc3137422bcd1"]
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_port#"80"
  protocol          = var.alb_listener_protocol#"HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.streamlit.arn
  }
}