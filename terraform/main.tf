
# - VPC Module 

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  public_subnet = var.public_subnet
  availability_zones = var.availability_zones
  destination_cidr = var.destination_cidr
  http = var.http
  https = var.https
  protocol = var.protocol
}

# - IAM Module

module "iam" {
  source = "./modules/iam"
  ecs_task_execution_role = var.ecs_task_execution_role
  ecs_task_role_policy_arn = var.ecs_task_role_policy_arn
  year_version = var.year_version
  policy_action = var.policy_action
  policy_effect = var.policy_effect
  policy_principal = var.policy_principal
  ecs_cluster_name = var.ecs_cluster_name
}

# - ACM Module

module "acm" {
  source = "./modules/acm"
  domain_name = var.domain_name
  domain_name_acm = var.domain_name_acm
  validation_method = var.validation_method
  acm_ttl = var.acm_ttl
}

# - ALB Module

module "alb" {
  source = "./modules/alb"
  lb_type = var.lb_type
  ssl_policy = var.ssl_policy
  vpc_name = var.vpc_name
  http_port = var.http_port
  https_port = var.https_port
  http_protocol = var.http_protocol
  https_protocol = var.https_protocol
  tcp = var.tcp
  allow_cidr = var.allow_cidr
  target_type = var.target_type
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet
  acm_certificate_arn = module.acm.acm_cert_arn
}

# - ECS Module 

module "ecs" {
  source = "./modules/ecs"
  ecr_uri = var.ecr_uri
  ecs_cluster_name = var.ecs_cluster_name
  app_dname = var.app_dname
  ecs_cpu = var.ecs_cpu
  ecs_memory = var.ecs_memory
  http = var.http
  destination_cidr = var.destination_cidr
  ecs_sg = var.ecs_sg
  https = var.https
  protocol = var.protocol
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet
  alb_security_group_id = module.alb.alb_sg
  iam_role_arn = module.iam.ecs_task_execution_role_arn
  alb_target_group_arn = module.alb.alb_target
  alb_listener_arn = module.alb.alb_listener
}

#  - DNS Module 

module "dns" {
  source = "./modules/dns"
  domain_name = var.domain_name
  route53_record_ns_name = var.route53_record_ns_name
  route53_record_type = var.route53_record_type
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
} 