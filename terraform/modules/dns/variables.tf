
variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "route53_record_ns_name" {
  description = "Name for the Route 53 record."
  type        = string
}

variable "route53_record_type" {
  description = "Type of the Route 53 record."
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB."
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the ALB."
  type        = string
}