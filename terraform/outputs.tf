# VPC Module Outputs

# output "vpc_id" {
#   value = aws_vpc.vpc.id
# }

# output "public_subnet" {
#   value = [aws_subnet.public[*].id]
# }

# ECS Module Outputs


# IAM Module Outputs

# output "ecs_task_execution_role_arn" {
#   value = aws_iam_role.ecs_task_execution_role.arn
# }

# DNS Module Outputs

# output "zone_id" {
#   value = aws_route53_zone.ysolom.zone_id
# }

# ACM Module Outputs

# output "acm_cert_arn" {
#   value = aws_acm_certificate.ysolom.arn
# }


# ALB Module Outputs 

# output "alb_target_group" {
#   value = aws_lb_target_group.alb_tg.arn
# }

# output "alb_dns_name" {
#   value = aws_lb.alb.dns_name
# }

# output "alb_zone_id" {
#   value = aws_lb.alb.zone_id
# }

# output "alb_listener_arn" {
#   value = aws_lb_listener.ecs_listener.arn
# }

# output "alb_security_group_id" {
#   value = aws_security_group.alb_sg.id
# }