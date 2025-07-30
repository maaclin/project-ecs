# # VPC

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

# # Subnets + Security Groups
# # Route Table + Route Table Association
# # Internet Gateway

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = var.vpc_name }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = 2
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = { Name = "${var.vpc_name}-igw" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.destination_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.vpc_name}-public-rt" }

}

resource "aws_route_table_association" "public_rta" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

// 2 - ECS Module 

# ECS Cluster, Task Definition, Service, and Load Balancer

# module "ecs" {
#   source = ".modules/ecs"
#   ecr_uri = var.ecr_uri
#   ecs_cluster_name = var.ecs_cluster_name
#   subnet_ids = module.vpc.aws_subnet.public_subnet[*].id
#   security_group_ids = [aws_security_group.ecs_sg.id]
# }

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${var.ecs_cluster_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "${var.ecs_cluster_name}-container"
      image     = var.ecr_uri
      cpu       = var.ecs_cpu
      memory    = var.ecs_memory
      essential = true

      portMappings = [
        {
          containerPort = var.http
          hostPort      = var.http
        }
      ]
    }
  ])
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.ecs_cluster_name}-sg"
  vpc_id      = aws_vpc.vpc.id
  description = "Allow HTTP and HTTPS"

  ingress {
    from_port       = var.http
    to_port         = var.http
    protocol        = var.protocol
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port       = var.https
    to_port         = var.https
    protocol        = var.protocol
    security_groups = [aws_security_group.alb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "ecs-sg" }
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public[*].id
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    container_name   = "${var.ecs_cluster_name}-container"
    container_port   = var.http
  }
  depends_on = [aws_lb_listener.ecs_listener]

}


# 3 - ALB Module
# Load Balancer, Target Group, Security Groups and Listener

# module "alb" {
#   source = ".modules/alb"
#   vpc_name = var.vpc_name
#   ecs_sg = aws_security_group.ecs_sg.id
#   http = var.http
#   cert_arn = var.cert_arn
# }

resource "aws_lb" "alb" {
  name               = "${var.vpc_name}-alb"
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public[*].id

  tags = {
    Name = "${var.vpc_name}-alb"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.vpc_name}-alb-sg"
  description = "ALB SG Allow incoming HTTPS/HTTP traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = var.http
    to_port     = var.http
    protocol    = var.tcp
    cidr_blocks = var.allow_cidr
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.tcp
    cidr_blocks = var.allow_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_lb_target_group" "alb_tg" {
  name        = "${var.vpc_name}-tg"
  port        = var.http_port
  protocol    = var.http_protocol
  vpc_id      = aws_vpc.vpc.id
  target_type = var.target_type

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
  Name = "${var.vpc_name}-tg" }
}

resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.https_port
  protocol          = var.https_protocol
  certificate_arn   = aws_acm_certificate_validation.ysolom.certificate_arn
  ssl_policy        = var.ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
  depends_on = [aws_lb_target_group.alb_tg]
}

# 4 - DNS Module 

# Route 53 DNS Zone and Record

# module "dns" {
#   source = ".modules/dns"
#   domain_name = var.domain_name
#   alb_dns_name = aws_lb.alb.dns_name
#   alb_zone_id = aws_lb.alb.zone_id
# }

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "lb" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.route53_record_ns_name
  type    = var.route53_record_type

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

# 5 - ACM Module

#  module "acm" {
#   source = ".modules/acm"
#   cert_arn = var.cert_arn
#   domain_name = var.domain_name

resource "aws_acm_certificate" "ysolom" {
  domain_name       = var.domain_name_acm
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_valid" {
  zone_id = data.aws_route53_zone.main.zone_id

  for_each = {
    for dvo in aws_acm_certificate.ysolom.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.acm_ttl
  type            = each.value.type
}

resource "aws_acm_certificate_validation" "ysolom" {
  certificate_arn         = aws_acm_certificate.ysolom.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_valid : record.fqdn]

  timeouts { create = "5m" }

}


# 6 - IAM Module 

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.ecs_cluster_name}-task-execution-role"

  assume_role_policy = jsonencode({
    Version = var.year_version
    Statement = [
      {
        Action = var.policy_action
        Effect = var.policy_effect
        Principal = {
          Service = var.policy_principal
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = var.ecs_task_role_policy_arn
}