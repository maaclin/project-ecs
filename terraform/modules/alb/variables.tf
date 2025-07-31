

variable "lb_type" {
  description = "Type of the load balancer."
  type        = string
}

variable "ssl_policy" {
  description = "SSL policy for the ALB listener."
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
}

variable "http_port" {
  description = "HTTP port for the ALB."
  type        = number
}

variable "https_port" {
  description = "HTTPS port for the ALB."
  type        = number
}

variable "http_protocol" {
  description = "HTTP protocol for the ALB."
  type        = string
}

variable "https_protocol" {
  description = "HTTPS protocol for the ALB."
  type        = string
}

variable "tcp" {
  description = "TCP protocol for the ALB security group."
  type        = string
}

variable "allow_cidr" {
  description = "CIDR blocks allowed for ALB security group."
  type        = list(any)
}

variable "target_type" {
  description = "Target type for the ALB target group."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for ALB"
  type        = list(string)
}

variable "acm_certificate_arn" {
  description = "ARN of the SSL certificate for the ALB."
  type        = string
}