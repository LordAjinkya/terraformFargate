resource "aws_ecs_cluster" "app_cluster" {
  name = "aspcorefargatecluster"
}

resource "aws_ecs_service" "app_service" {
  name            = "fargate-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    security_groups = [data.aws_security_group.ecs_task_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "reverseproxy"
    container_port   = 80
  }
}