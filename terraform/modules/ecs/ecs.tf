

// 2 - ECS Module 
# ECS Cluster, Task Definition, Service, and Load Balancer
# module "ecs" {
#   source = ".modules/ecs"
#   ecr_uri = var.ecr_uri
#   ecs_cluster_name = var.ecs_cluster_name
#   subnet_ids = module.vpc.aws_subnet.public_subnet[*].id
#   security_group_ids = [aws_security_group.ecs_sg.id]
# # }

# resource "aws_ecs_cluster" "ecs_cluster" {
#   name = var.ecs_cluster_name
# }

# resource "aws_ecs_task_definition" "ecs_task" {
#   family = "${var.ecs_cluster_name}-task" 
#   container_definitions = jsonencode([
#     {
#       name      = "${var.ecs_cluster_name}-container"
#       image     = var.ecr_uri
#       cpu       = 256
#       memory    = 512
#       essential = true
      
#       portMappings = [
#         {
#           containerPort = var.http
#           hostPort      = var.http
#         }
#       ]
#     }
#   ])
# }

# resource "aws_security_group" "ecs_sg" {
#   name        = var.ecs_sg
#   vpc_id      = aws_vpc.vpc.id
#   description = "Allow HTTP and HTTPS"

#   ingress {
#     description = "Allow HTTP"
#     from_port   = var.http
#     to_port     = var.http
#     protocol    = var.protocol
#     cidr_blocks = [var.destination_cidr]
#   }

#   ingress {
#     description = "Allow HTTPS"
#     from_port   = var.https
#     to_port     = var.https
#     protocol    = var.protocol
#     cidr_blocks = [var.destination_cidr]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = [var.destination_cidr]
#   }

#   tags = { Name = "ecs-sg" }
# }

# resource "aws_ecs_service" "ecs_service" {
#   name            = "${var.ecs_cluster_name}-service"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.ecs_task.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets          = var.subnet_ids
#     security_groups  = var.security_group_ids
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.ecs_target_group.arn
#     container_name   = "${var.ecs_cluster_name}-container"
#     container_port   = var.http
#   }
#   depends_on = [aws_lb_listener.ecs_listener]
  
# }
