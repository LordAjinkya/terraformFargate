resource "aws_lb_target_group" "target_group" {
  name     = "fargate-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id # Directly reference the VPC ID
  target_type = "ip"
}

resource "aws_lb" "alb" {
  name               = "aspnetcorefargatealb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}