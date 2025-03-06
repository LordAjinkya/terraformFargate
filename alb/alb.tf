variable "vpc_id" {}
variable "public_subnet_1_id" {}
variable "public_subnet_2_id" {}
variable "alb_sg_id" {}

resource "aws_lb_target_group" "target_group" {
  name        = "fargate-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb" "alb" {
  name               = "aspnetcorefargatealb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.public_subnet_1_id, var.public_subnet_2_id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port                = "80"
  protocol            = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}