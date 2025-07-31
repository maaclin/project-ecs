# Project ECS 

# VPC Variables

vpc_cidr           = "10.0.0.0/16"
vpc_name           = "project-ecs-vpc"
public_subnet      = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones = ["eu-west-2a", "eu-west-2b"]
destination_cidr   = "0.0.0.0/0"
http               = 80
https              = 443
protocol           = "tcp"

# ECS Variables
ecr_uri          = "354918400698.dkr.ecr.eu-west-2.amazonaws.com/yossiefs/ecs-project"
ecs_cluster_name = "project-ecs-cluster"
ecs_sg           = "ecs-sg"
app_dname        = "ysolomprojects.co.uk"
ecs_cpu          = 256
ecs_memory       = 512

# ACM Variables
domain_name_acm   = "ecs.ysolomprojects.co.uk"
validation_method = "DNS"
acm_ttl           = 60

# IAM Variables
ecs_task_execution_role  = "arn:aws:iam::354918400698:role/ecsTaskExecutionRole"
ecs_task_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
year_version             = "2012-10-17"
policy_action            = "sts:AssumeRole"
policy_principal         = "ecs-tasks.amazonaws.com"
policy_effect            = "Allow"

# DNS Variables

route53_record_ns_name = "ecs"
route53_record_type    = "A"
domain_name            = "ysolomprojects.co.uk"

# ALB Variables

lb_type        = "application"
ssl_policy     = "ELBSecurityPolicy-TLS-1-2-2017-01"
http_port      = 80
https_port     = 443
http_protocol  = "HTTP"
https_protocol = "HTTPS"
tcp            = "tcp"
allow_cidr     = ["0.0.0.0/0"]
target_type    = "ip"