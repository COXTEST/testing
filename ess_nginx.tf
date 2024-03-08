provider "aws" {
  region = "your_aws_region"
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      name  = "nginx"
      image = "nginx:latest"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx-service"
  cluster         = "your_ecs_cluster"
  task_definition = aws_ecs_task_definition.nginx.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets = ["your_subnet_ids"]
    security_groups = ["your_security_group_id"]
  }
}

data "aws_lb" "nginx_lb" {
  for_each = aws_ecs_service.nginx
  name    = each.value.load_balancer.first_name
}

output "nginx_url" {
  value = "http://${data.aws_lb.nginx_lb[0].dns_name}"
}
