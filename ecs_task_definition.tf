resource "aws_ecs_task_definition" "app_task" {
  family                   = "fargate-task-definition"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                  = "512"
  execution_role_arn      = "arn:aws:iam::503561421231:role/TerraformEC2Role"

  container_definitions = <<EOF
  [
    {
      "name": "mymvcweb",
      "image": "${var.mymvcweb_image}:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 5000,
          "hostPort": 5000
        }
      ]
    },
    {
      "name": "reverseproxy",
      "image": "${var.reverseproxy_image}:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  EOF
}

data "aws_region" "current" {}