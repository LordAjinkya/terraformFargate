variable "vpc_id" {}

data "aws_security_group" "alb_sg" {
  name   = "alb-sg-fargate" # Unique name
  vpc_id = var.vpc_id
}

data "aws_security_group" "ecs_task_sg" {
  name   = "ecs-task-sg"
  vpc_id = var.vpc_id
}

output "alb_sg_id" {
  value = data.aws_security_group.alb_sg.id
}

output "ecs_task_sg_id" {
  value = data.aws_security_group.ecs_task_sg.id
}