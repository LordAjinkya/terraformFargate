variable "iam_role_arn" {
  default = "arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/YOUR_ECS_TASK_EXECUTION_ROLE_NAME"
}

variable "mymvcweb_image" {
  default = "YOUR_MYMVCWEB_IMAGE_URI"
}

variable "reverseproxy_image" {
  default = "YOUR_REVERSEPROXY_IMAGE_URI"
}

variable "log_group_name" {
  default = "YOUR_LOG_GROUP_NAME"
}

resource "aws_ecs_task_definition" "app_task" {
  family = "fargate-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = "arn:aws:iam::503561421231:role/TerraformEC2Role"

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
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.log_group_name}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "ecs"
      }
    }
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
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.log_group_name}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
EOF
}

data "aws_region" "current" {}

output "task_definition_arn" {
  value = aws_ecs_task_definition.app_task.arn
}