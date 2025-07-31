
# ECS Variables

variable "ecr_uri" {
  description = "The URI of the ECS image."
  type        = string
}
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "app_dname" {
  description = "Domain name for the application."
  type        = string
}
variable "ecs_cpu" {
  description = "CPU units for the ECS task."
  type        = number
}
variable "ecs_memory" {
  description = "Memory in MiB for the ECS task."
  type        = number
}

variable "http" {
  description = "HTTP port."
  type        = number
}

variable "destination_cidr" {
  description = "The destination CIDR block for the public route."
  type        = string
}

variable "ecs_sg" {
  description = "Name of the security group."
  type        = string
}

variable "https" {
  description = "HTTPS port."
  type        = number
}

variable "protocol" {
  description = "Protocol for the security group."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ALB Security Group ID"
  type        = string
}

variable "iam_role_arn" {
  description = "ECS Task Execution Role ARN"
  type        = string
}

variable "alb_target_group_arn" {
  description = "Name of the ALB target group."
  type        = string
}

variable "alb_listener_arn" {
  description = "ARN of the ALB listener."
  type        = string
}