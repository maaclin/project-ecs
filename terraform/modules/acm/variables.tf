
variable "domain_name_acm" {
  description = "Domain name for the ACM certificate."
  type        = string
}

variable "validation_method" {
  description = "Validation method for the ACM certificate."
  type        = string
}

variable "acm_ttl" {
  description = "TTL for the ACM certificate validation record."
  type        = number
}

variable "domain_name" {
  description = "Domain name for Route 53."
  type        = string
}