
variable "ecs_task_execution_role" {
  description = "ARN of the ECS task execution role."
  type        = string
}
variable "ecs_task_role_policy_arn" {
  description = "ARN of the ECS task role policy."
  type        = string
}

variable "year_version" {
  description = "Version of the policy."
  type        = string
}

variable "policy_action" {
  description = "Action for the IAM policy."
  type        = string
}

variable "policy_effect" {
  description = "Effect of the IAM policy."
  type        = string
}

variable "policy_principal" {
  description = "Principal for the IAM policy."
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}