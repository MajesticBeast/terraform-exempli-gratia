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

# cluster
variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

# task definition
variable "task_family" {
  description = "The family of the ECS task definition"
  type        = string
}

variable "task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

variable "network_mode" {
  description = "The network mode of the ECS task definition"
  type        = string
}

variable "requires_compatibilities" {
  description = "The compatibility requirements of the ECS task definition"
  type        = list(string)
}

variable "task_definition_cpu" {
  description = "The CPU units of the ECS task definition"
  type        = string
}

variable "task_definition_memory" {
  description = "The memory of the ECS task definition"
  type        = string
}

variable "runtime_platform" {
  description = "The runtime platform of the ECS task definition (operating system and CPU architecture)"
  type        = map(string)
}

variable "container_definitions" {
  description = "The container definitions of the ECS task definition"
  type = list(object({
    name      = string
    image     = string
    cpu       = number
    memory    = number
    essential = bool
    portMappings = list(object({
      name          = string
      containerPort = number
      hostPort      = number
      protocol      = string
      appProtocol   = string
    }))
  }))
}

# service
variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "The desired count of the ECS service"
  type        = number
}

variable "launch_type" {
  description = "The launch type of the ECS service"
  type        = string
}

variable "subnets" {
  description = "The subnets of the ECS service"
  type        = list(string)
}

variable "security_groups" {
  description = "The security groups of the ECS service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the ECS service"
  type        = bool
}

# target group
variable "tg_name" {
  description = "The name of the target group"
  type        = string
}

variable "tg_port" {
  description = "The port of the target group"
  type        = number
}

variable "tg_protocol" {
  description = "The protocol of the target group"
  type        = string
}

variable "tg_vpc_id" {
  description = "The VPC ID of the target group"
  type        = string
}

variable "tg_target_type" {
  description = "The target type of the target group"
  type        = string
}

# IAM role
variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "The assume role policy for the IAM role"
  type = object({
    Version = string
    Statement = list(object({
      Effect    = string
      Principal = object({
        Service = string
      })
      Action = string
    }))
  })
}

variable "inline_policy_name" {
  description = "The name of the inline policy"
  type        = string
}

variable "inline_policies" {
  description = "The inline policies of the IAM role"
  type = object({
    Version = string
    Statement = list(object({
      Effect   = string
      Action   = list(string)
      Resource = string
    }))
  })
}

# ALB
variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "alb_internal" {
  description = "Whether the ALB is internal"
  type        = bool
}

variable "alb_type" {
  description = "The type of the ALB"
  type        = string
}

variable "alb_listener_port" {
  description = "The port of the ALB listener"
  type        = string
}

variable "alb_listener_protocol" {
  description = "The protocol of the ALB listener"
  type        = string
}