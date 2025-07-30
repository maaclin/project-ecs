

# 3 - ALB Module
# Load Balancer, Target Group, Security Groups and Listener

# module "alb" {
#   source = ".modules/alb"
#   vpc_name = var.vpc_name
#   ecs_sg = aws_security_group.ecs_sg.id
#   http = var.http
#   cert_arn = var.cert_arn
# }

# resource "aws_lb" "alb" {
#   name               = "${var.vpc_name}-alb"
#   internal           = false
#   load_balancer_type = var.lb_type
#   security_groups    = [aws_security_group.ecs_sg.id]
#   subnets            = [aws_subnet.public.id]

#   tags = {
#     Name = "${var.vpc_name}-alb"
#   }
# }

# resource "aws_security_group" "alb_sg" {
#     name = "${var.vpc_name}-alb-sg"
#     description = "ALB SG Allow incoming HTTPS/HTTP traffic"
#     vpc_id = var.vpc_id
  
#   ingress{
#     from_port = var.http
#     to_port = var.http
#     protocol = var.tcp
#     cidr_blocks = var.allow_cidr
#   }

#   ingress{
#     from_port = var.https_port
#     to_port = var.https_port
#     protocol = var.tcp
#     cidr_blocks = var.allow_cidr
#   }
# }

# resource "aws_lb_target_group" "alb_tg" {
#   name     = "${var.vpc_name}-tg"
#   port     = var.http
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.vpc.id

#   tags = {
#     Name = "${var.vpc_name}-tg"
#   }
# }

# resource "aws_lb_listener" "ecs_listener" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = var.http
#   protocol          = "HTTP"
#   certificate_arn   = aws_acm_certificate.cert.arn
#   ssl_policy        = var.ssl_policy

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.alb_tg.arn
#   }
# }