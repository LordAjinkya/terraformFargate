variable "public_subnet_1_id" {}
variable "public_subnet_2_id" {}
variable "cluster_id" {}
variable "task_definition_arn" {}
variable "ecs_task_sg_id" {}
variable "target_group_arn" {}  # Add this line

resource "aws_ecs_service" "app_service" {
  name                = "fargate-service"
  cluster             = var.cluster_id
  task_definition     = var.task_definition_arn
  desired_count       = 2
  launch_type         = "FARGATE"

  network_configuration {
    subnets         = [var.public_subnet_1_id, var.public_subnet_2_id]
    security_groups = [var.ecs_task_sg_id]
  }

  load_balancer {
    target_group_arn = var.target_group_arn  # Change this line
    container_name   = "reverseproxy"
    container_port   = 80
  }
}