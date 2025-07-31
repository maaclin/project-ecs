
## VPC Configuration Variables


variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "public_subnet" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for the public subnets."
  type        = list(string)
}

variable "destination_cidr" {
  description = "The destination CIDR block for the public route."
  type        = string
}
variable "http" {
  description = "HTTP port."
  type        = number
}
variable "https" {
  description = "HTTPS port."
  type        = number
}
variable "protocol" {
  description = "Protocol for the security group."
  type        = string
}