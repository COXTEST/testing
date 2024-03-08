# Provider configuration
provider "aws" {
  region = "us-east-1" # Set your desired AWS region
}

# ECS cluster
resource "aws_ecs_cluster" "nginx_cluster" {
  name = "nginx-cluster"
}

# ECS task definition
resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-task"
  container_definitions    = jsonencode([
    {
      name  = "nginx-container"
      image = "nginx:latest"
      cpu   = 256 # CPU units
      memory = 512 # Memory in MiB
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}

# ECS service
resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.nginx_cluster.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    assign_public_ip = true
    security_groups = [aws_security_group.nginx_sg.id]
  }

  depends_on = [aws_ecs_task_definition.nginx_task]
}

# Security group
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Security group for nginx"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output the public-facing URL
output "nginx_url" {
  value = "${aws_ecs_service.nginx_service.name}.${aws_ecs_cluster.nginx_cluster.id}.${var.vpc_id}.${data.aws_region.current.name}.elb.amazonaws.com"
}
