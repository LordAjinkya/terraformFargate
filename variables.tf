variable "aws_region" {
  default = "us-east-1"
}

variable "iam_role_arn" {
  default = "arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/YOUR_ECS_TASK_EXECUTION_ROLE_NAME"
}

variable "mymvcweb_image" {
  default = ""
}

variable "reverseproxy_image" {
  default = ""
}

variable "log_group_name" {
  default = ""
}