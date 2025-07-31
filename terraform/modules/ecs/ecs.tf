

// 2 - ECS Module 

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${var.ecs_cluster_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
  execution_role_arn       = var.iam_role_arn
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
  vpc_id      = var.vpc_id
  description = "Allow HTTP and HTTPS"

  ingress {
    from_port       = var.http
    to_port         = var.http
    protocol        = var.protocol
    security_groups = [var.alb_security_group_id]
  }

  ingress {
    from_port       = var.https
    to_port         = var.https
    protocol        = var.protocol
    security_groups = [var.alb_security_group_id]
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
    subnets          = var.subnet_ids
    security_groups  = [var.alb_security_group_id, aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "${var.ecs_cluster_name}-container"
    container_port   = var.http
  }
  
  depends_on = [var.alb_listener_arn]
}

