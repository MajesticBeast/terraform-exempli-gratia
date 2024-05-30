# Global
account_num = "123456789"
assume_role_name = "OrganizationAccountAccessRole"
region = "us-west-1"

# Cluster
cluster_name = "streamlit-ecs-cluster"

# Service
service_name = "streamlit-service"
desired_count = 2
launch_type = "FARGATE"
subnets = ["subnet-0175a77f97954926d", "subnet-07a4bc3137422bcd1"]
security_groups = ["sg-0d91f7ac7a48248fc"]
assign_public_ip = true

# Task Definition
task_family = "streamlit-task-definition"
task_execution_role_arn = "arn:aws:iam::123456789:role/ecsTaskExecutionRole-TFManaged"
network_mode = "awsvpc"
requires_compatibilities = ["FARGATE"]
task_definition_cpu = "512"
task_definition_memory = "2048"
runtime_platform = {
  operating_system = "LINUX"
  cpu_architecture     = "ARM64"
}
container_definitions = [
  {
    name      = "streamlit"
    image     = "public.ecr.aws/o1k1o9q5/streamlit-example:latest"
    cpu       = 256
    memory    = 1024
    essential = true
    portMappings = [
      {
        name          = "http"
        containerPort = 8501
        hostPort      = null
        protocol      = "tcp"
        appProtocol   = "http"
      }
    ]
  }
]

# Load Balancer
alb_name = "streamlit-ecs-fargate-alb"
alb_internal = false
alb_type = "application"

# Target Group
tg_name = "streamlit-ecs-fargate-tg"
tg_protocol = "HTTP"
tg_vpc_id = "vpc-0b6a8182317c74729"
tg_target_type = "ip"
tg_port = 8501

# IAM Role
role_name = "ecsTaskExecutionRole-TFManaged"
inline_policy_name = "ecsTaskExecutionRolePolicy-TFManaged"
assume_role_policy = {
  Version = "2012-10-17",
  Statement = [
    {
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }
  ]
}

inline_policies = {
  Version = "2012-10-17",
  Statement = [
    {
      Effect = "Allow",
      Action = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "*"
    }
  ]
}

# ALB Listener
alb_listener_port = 80
alb_listener_protocol = "HTTP"

