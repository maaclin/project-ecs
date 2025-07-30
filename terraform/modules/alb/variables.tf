
# ALB Variables

variable "vpc_id" {
  description = "VPC ID for the ALB."
  type        = string
}

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

variable "http" {
  description = "HTTP port for the ALB."
  type        = number
}

variable "https_port" {
  description = "HTTPS port for the ALB."
  type        = number
}

variable "tcp" {
  description = "TCP protocol for the ALB security group."
  type        = string
}

variable "allow_cidr" {
  description = "CIDR blocks allowed for ALB security group."
  type        = list(string)
}
