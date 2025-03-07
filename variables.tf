variable "aws_region" {
  default = "us-east-1"
}

variable "iam_role_arn" {
  default = "arn:aws:iam::509399591430:role/ECS"
}

variable "mymvcweb_image" {
  default = "509399591430.dkr.ecr.us-east-1.amazonaws.com/mymvcweb-repo"
}

variable "reverseproxy_image" {
  default = "509399591430.dkr.ecr.us-east-1.amazonaws.com/reverseproxy-repo"
}