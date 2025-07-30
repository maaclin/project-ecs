

# # 1 - VPC Module 

# # module "vpc" {
# #   source = ".modules/vpc"
# #   vpc_cidr_block = var.vpc_cidr_block
# #   vpc_name = var.vpc_name
# #   public_subnets = var.public_subnets 
# #   availability_zones = var.availability_zones
# #   destination_cidr = var.destination_cidr
# #   ecs_sg = var.ecs_sg
# # }

# # VPC
# # Subnets + Security Groups
# # Route Table + Route Table Association
# # Internet Gateway

# resource "aws_vpc" "vpc" {
#   cidr_block           = var.vpc_cidr_block
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = { Name = var.vpc_name }
# }

# resource "aws_subnet" "public" {

#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.public_subnets
#   availability_zone       = var.availability_zones
#   map_public_ip_on_launch = true
#   tags                    = { Name = var.vpc_name }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc.id

#   tags = { Name = "${var.vpc_name}-igw" }
# }

# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.vpc.id
#   route {
#     cidr_block = var.destination_cidr
#     gateway_id = aws_internet_gateway.igw.id
#   }
#   tags = { Name = "${var.vpc_name}-public-rt" }

# }

# resource "aws_route_table_association" "public_rta" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }
