
# # ECS Variables

# variable "ecr_uri" {
#   description = "The URI of the ECS image."
#   type        = string
# }
# variable "ecs_cluster_name" {
#   description = "The name of the ECS cluster."
#   type        = string
# }
# variable "subnet_ids" {
#   description = "List of subnet IDs for the ECS service."
#   type        = list(string)
# }
# variable "security_group_ids" {
#   description = "List of security group IDs for the ECS service."
#   type        = list(string)
# }

# variable "app_dname" {
#   description = "Domain name for the application."
#   type        = string
# }

# variable "http" {
#   description = "HTTP port."
#   type        = number
# }

# variable "destination_cidr" {
#   description = "The destination CIDR block for the public route."
#   type        = string
# }

# variable "ecs_sg" {
#   description = "Name of the security group."
#   type        = string
# }

# variable "https" {
#   description = "HTTPS port."
#   type        = number
# }

# variable "protocol" {
#   description = "Protocol for the security group."
#   type        = string
# }